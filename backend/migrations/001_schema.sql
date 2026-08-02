CREATE TABLE IF NOT EXISTS app_users(
  id BIGSERIAL PRIMARY KEY,email TEXT UNIQUE NOT NULL,name TEXT NOT NULL,role TEXT NOT NULL,password_hash TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS workflow_cases(
  id BIGSERIAL PRIMARY KEY,workflow_id TEXT NOT NULL,reference TEXT UNIQUE NOT NULL,subject TEXT NOT NULL,owner TEXT NOT NULL,state TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,payload JSONB NOT NULL DEFAULT '{}'::jsonb,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS audit_events(
  id BIGSERIAL PRIMARY KEY,event_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),actor TEXT NOT NULL,action TEXT NOT NULL,object_type TEXT NOT NULL,object_reference TEXT NOT NULL,detail TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS saved_analyses(
  id BIGSERIAL PRIMARY KEY,workflow_id TEXT NOT NULL,actor TEXT NOT NULL,analysis_type TEXT NOT NULL,inputs JSONB NOT NULL,result JSONB NOT NULL,provider TEXT NOT NULL,model TEXT,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS integration_state(
  id TEXT PRIMARY KEY,name TEXT NOT NULL,category TEXT NOT NULL,mode TEXT NOT NULL,status TEXT NOT NULL,last_tested TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_workflow_cases_workflow ON workflow_cases(workflow_id);
CREATE INDEX IF NOT EXISTS idx_workflow_cases_due ON workflow_cases(due_date);
CREATE INDEX IF NOT EXISTS idx_audit_events_time ON audit_events(event_time DESC);

CREATE TABLE IF NOT EXISTS "op_project_qualify"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_businessComponent" TEXT NOT NULL,
  "data_technicalUncertainty" TEXT NOT NULL,
  "data_experimentation" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_project_qualify_due ON "op_project_qualify"(due_date);

CREATE TABLE IF NOT EXISTS "op_wage_allocation"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_employee" TEXT NOT NULL,
  "data_role" TEXT NOT NULL,
  "data_project" TEXT NOT NULL,
  "data_qualifiedPercent" NUMERIC(16,2) NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_wage_allocation_due ON "op_wage_allocation"(due_date);

CREATE TABLE IF NOT EXISTS "op_contract_research"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_contractor" TEXT NOT NULL,
  "data_agreement" TEXT NOT NULL,
  "data_contractAmount" NUMERIC(16,2) NOT NULL,
  "data_rightsAndRisk" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_contract_research_due ON "op_contract_research"(due_date);

CREATE TABLE IF NOT EXISTS "op_supply_cost"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_vendor" TEXT NOT NULL,
  "data_costType" TEXT NOT NULL,
  "data_amount" NUMERIC(16,2) NOT NULL,
  "data_researchUse" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_supply_cost_due ON "op_supply_cost"(due_date);

CREATE TABLE IF NOT EXISTS "op_174a"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_costCenter" TEXT NOT NULL,
  "data_location" TEXT NOT NULL,
  "data_amount" NUMERIC(16,2) NOT NULL,
  "data_treatment" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_174a_due ON "op_174a"(due_date);

CREATE TABLE IF NOT EXISTS "op_evidence"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_project" TEXT NOT NULL,
  "data_evidenceType" TEXT NOT NULL,
  "data_period" TEXT NOT NULL,
  "data_evidenceSummary" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_evidence_due ON "op_evidence"(due_date);

CREATE TABLE IF NOT EXISTS "op_credit_calc"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_entity" TEXT NOT NULL,
  "data_taxYear" NUMERIC(16,2) NOT NULL,
  "data_qreAmount" NUMERIC(16,2) NOT NULL,
  "data_calculationMethod" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_credit_calc_due ON "op_credit_calc"(due_date);

CREATE TABLE IF NOT EXISTS "op_exam_ready"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_taxYear" NUMERIC(16,2) NOT NULL,
  "data_creditAmount" NUMERIC(16,2) NOT NULL,
  "data_evidenceCoverage" NUMERIC(16,2) NOT NULL,
  "data_readinessGap" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_exam_ready_due ON "op_exam_ready"(due_date);

CREATE TABLE IF NOT EXISTS "op_tax_entities"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_entity" TEXT NOT NULL,
  "data_ein" TEXT NOT NULL,
  "data_jurisdiction" TEXT NOT NULL,
  "data_filingGroup" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_tax_entities_due ON "op_tax_entities"(due_date);

CREATE TABLE IF NOT EXISTS "op_research_personnel"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_employee" TEXT NOT NULL,
  "data_role" TEXT NOT NULL,
  "data_department" TEXT NOT NULL,
  "data_qualifiedPercent" NUMERIC(16,2) NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_research_personnel_due ON "op_research_personnel"(due_date);

CREATE TABLE IF NOT EXISTS "op_business_components"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_component" TEXT NOT NULL,
  "data_componentType" TEXT NOT NULL,
  "data_project" TEXT NOT NULL,
  "data_owner" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_business_components_due ON "op_business_components"(due_date);

CREATE TABLE IF NOT EXISTS "op_evidence_sources"(
  id BIGSERIAL PRIMARY KEY,reference TEXT UNIQUE NOT NULL,status TEXT NOT NULL,owner TEXT NOT NULL,risk TEXT NOT NULL,due_date DATE NOT NULL,amount NUMERIC(16,2) NOT NULL DEFAULT 0,
  "data_source" TEXT NOT NULL,
  "data_system" TEXT NOT NULL,
  "data_retentionYears" NUMERIC(16,2) NOT NULL,
  "data_coverageNotes" TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_op_evidence_sources_due ON "op_evidence_sources"(due_date);
