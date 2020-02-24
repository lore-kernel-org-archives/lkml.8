Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA68C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C7920CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBXWAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:00:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:22327 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgBXWAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:00:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="284477344"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 14:00:35 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/5] perf jevents: Support metric constraint
Date:   Mon, 24 Feb 2020 13:59:20 -0800
Message-Id: <1582581564-184429-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new field "MetricConstraint" is introduced in JSON event list.

Extend jevents to parse the field and save the value in
metric_constraint.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c    | 19 +++++++++++++------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 079c77b..6d0f61f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -323,7 +323,7 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
-				    char *deprecated)
+				    char *deprecated, char *metric_constraint)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -357,6 +357,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
 	if (deprecated)
 		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
+	if (metric_constraint)
+		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -375,6 +377,7 @@ struct event_struct {
 	char *metric_name;
 	char *metric_group;
 	char *deprecated;
+	char *metric_constraint;
 };
 
 #define ADD_EVENT_FIELD(field) do { if (field) {		\
@@ -422,7 +425,7 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated)
+				char *deprecated, char *metric_constraint)
 {
 	struct event_struct *es;
 
@@ -486,7 +489,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
 	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated)
+	  char **deprecated, char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -515,7 +518,7 @@ int json_events(const char *fn,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
-		      char *deprecated),
+		      char *deprecated, char *metric_constraint),
 	  void *data)
 {
 	int err;
@@ -545,6 +548,7 @@ int json_events(const char *fn,
 		char *metric_name = NULL;
 		char *metric_group = NULL;
 		char *deprecated = NULL;
+		char *metric_constraint = NULL;
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
@@ -629,6 +633,8 @@ int json_events(const char *fn,
 				addfield(map, &metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
 				addfield(map, &metric_group, "", "", val);
+			} else if (json_streq(map, field, "MetricConstraint")) {
+				addfield(map, &metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
 				addfield(map, &metric_expr, "", "", val);
 				for (s = metric_expr; *s; s++)
@@ -670,13 +676,13 @@ int json_events(const char *fn,
 					&long_desc, &pmu, &filter, &perpkg,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
-					&deprecated);
+					&deprecated, &metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated);
+			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
 		free(desc);
@@ -691,6 +697,7 @@ int json_events(const char *fn,
 		free(metric_expr);
 		free(metric_name);
 		free(metric_group);
+		free(metric_constraint);
 		free(arch_std);
 
 		if (err)
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 5cda49a4..2afc830 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -8,7 +8,7 @@ int json_events(const char *fn,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated),
+				char *deprecated, char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index caeb577..53e76d5 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -18,6 +18,7 @@ struct pmu_event {
 	const char *metric_name;
 	const char *metric_group;
 	const char *deprecated;
+	const char *metric_constraint;
 };
 
 /*
-- 
2.7.4

