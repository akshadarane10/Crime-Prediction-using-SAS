%LET _CLIENTTASKLABEL='Program';
%LET _CLIENTPROCESSFLOWNAME='Process Flow';
%LET _CLIENTPROJECTPATH='C:\Users\GIM\Desktop\akshu_sas\Assignment\Asignmentcode.egp';
%LET _CLIENTPROJECTPATHHOST='BDA-6';
%LET _CLIENTPROJECTNAME='Asignmentcode.egp';
%LET _SASPROGRAMFILE='';
%LET _SASPROGRAMFILEHOST='';

proc print data=Crime(obs=5) ;
run;

/*Q1pre-procesing- converting crime and murder into percent*/;
PROC SQL;
update Crime set crime=(crime/100000)*100;
QUIT;

PROC SQL;
update Crime set murder=(murder/1000000)*100;
QUIT;

/*dealing with null values*/
Proc Means Data = Crime N NMISS;
Run;

proc means data=Crime;
var crime pctmetro pctwhite pcths single poverty murder;
run;

/*imputing with mean*/
data Crime ;
set Crime;
if crime=. then crime=0.62;
if pctmetro=. then pctmetro=67.55;
if pctwhite=. then pctwhite=84.46;
if pcths=. then pcths=76.22;
if single=. then single=11.31;
if poverty=. then poverty=14.29;
if murder=. then murder=0.00088;
run;

/*checking for outliers*/
proc univariate data=crime plot;
  var crime ;
run;

proc univariate data=crime plot;
  var pctmetro;
run;

proc univariate data=crime plot;
  var pctwhite;
run;

proc univariate data=crime plot;
  var pcths;
run;

proc univariate data=crime plot;
  var poverty;
run;

proc univariate data=crime plot;
  var single;
run;

proc univariate data=crime plot;
  var murder;
run;

/*not treated outliers since it will change the data fir specific state*/

/*Linear Regression Assumptions test: linearity test positive*/
proc reg data=Crime;
  model Crime = murder pctmetro pctwhite pcths poverty single ;
  plot residual. *predicted.;
run;
/* no pattern: linear relationship exist & independence of error terms*/

/*normality test*/
proc reg data=Crime;
 model Crime = murder pctmetro pctwhite pcths poverty single ;
 output out=elemres (keep= r rs fv) residual=r rstudent=rs predicted=fv;
run;
quit;

proc univariate data=elemres normal;
var r;
qqplot r / normal (mu=est sigma=est);
run;
/*  residuals points are normally distributed*/

/*homoscedascity*/
proc reg data=Crime;
 model Crime = murder pctmetro pctwhite pcths poverty single ;
 plot rstudent. *predicted.;
 run;

 /*it is equally distributed, therefore showing homoscedascity;*/

 proc reg data=Crime;
 model Crime = murder pctmetro single ;
 plot rstudent. *predicted.;
 run;

/* spliting into testing and training*/

data training testing;
set Crime nobs=nobs;
/*if _n_<=.70*nobs then output training;*/
if rand('uniform') <= 0.3
then output testing;
else output training;
run;

proc corr data=Crime;
var Crime murder pctmetro pctwhite pcths poverty single;
run;
/* Crime & Murder variables are highly correlated*/


/****models****/
/*regression*/
/*model1*/
proc reg data=training outest=model1;
  model Crime = murder;
  plot Crime * murder/pred;
run;

/*model2*/
proc reg data=training outest=model2;
  model Crime = murder pctmetro ;
run;

/* model3*/
proc reg data=training outest=model3;
  model Crime = murder pctmetro pctwhite ;
run;

/*model4*/
proc reg data=training outest=model4;
  model Crime = murder pctmetro pctwhite pcths ;
run;

/*model5*/
proc reg data=training outest=model5;
  model Crime = murder pctmetro pctwhite pcths single ;
run;

proc reg data=training outest=model6;
  model Crime = murder pctmetro single pctwhite pcths poverty ;
run;

/*will exclude pctwhite, pcths, poverty*/

proc reg data=training outest=modelF;
  model Crime = murder pctmetro single;
run;

/*testig*/
proc score data = testing score=modelF
out=scoreF type=parms;
var murder pctmetro single;
run;
proc print data=scoreF;
run;

data scoreF;
set scoreF;
errorsq = (model1-crime)*(model1-crime);
run;

proc sql;
select sqrt(sum(errorsq)/15) as RMSE from scoreF;
run;

proc glmselect;
   model crime=murder pctmetro pctwhite pcths poverty single/selection=forward(stop=CV) cvMethod=split(50);
run;






































%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROCESSFLOWNAME=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTPATHHOST=;
%LET _CLIENTPROJECTNAME=;
%LET _SASPROGRAMFILE=;
%LET _SASPROGRAMFILEHOST=;

/*Akshada Rane Roll No: B2022009 */;


