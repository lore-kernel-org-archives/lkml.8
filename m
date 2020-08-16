Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F409A20674
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ULcqHbXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHPJH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 05:07:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgHPJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 05:07:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07G92ZRx035409;
        Sun, 16 Aug 2020 05:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iK17mGWE/hGeAjWT8iWBSy1ymeEBYnEu3UBZ0gkouIg=;
 b=ULcqHbXSSC1JARTfiNzjwONZWRGyikJdMFOAAqSs2uovFvteXSkgpNc3UP4+YcU4z5gh
 bpSqBDVvfZZ5lJwnPtcID3+iFTNu9Uhm+YXSdLMbeh/0vQmX7skAvKQsPDuUm8fT2eMS
 6G4IWHKnEHGKHhCNEhEM4+LI2wSbCHwUmZ+SIC4PHw1bwshy1G6Sg4C0hj9ZYqs548C5
 cKvEK7LHbmvdCoiTPFwlawLy1mERCdwrJ+ixVVyHhBi/StYZPEucLEphF4W3z4aP5s6n
 gnmU0r0OdVsTxkG1WMmGCQ/oJtSAKLLtqpBMHSxC6CaIxHe3IvIQr1IuSaranhRVIovh yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y0n61b3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:07:43 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07G92gQ5035916;
        Sun, 16 Aug 2020 05:07:43 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y0n61b3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:07:42 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07G95XgD003104;
        Sun, 16 Aug 2020 09:07:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 32x7b80npw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 09:07:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07G97bwe32571814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 09:07:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48EEE4C040;
        Sun, 16 Aug 2020 09:07:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 733CC4C044;
        Sun, 16 Aug 2020 09:07:32 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.90.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Aug 2020 09:07:32 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com, kjain@linux.ibm.com
Subject: [PATCH v5 1/3] perf jevents: Add support for parsing perchip/percore events
Date:   Sun, 16 Aug 2020 14:37:17 +0530
Message-Id: <20200816090719.72018-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200816090719.72018-1-kjain@linux.ibm.com>
References: <20200816090719.72018-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_02:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=3
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, every time we want to add new terms like chip, core thread etc,
we need to create corrsponding fields in pmu_events and event struct.
This patch adds an enum called 'aggr_mode_class' which store all these
aggregation like perchip/percore. It also adds new field 'aggr_mode'
to capture these terms.
Now, if user wants to add any new term, they just need to add it in
the enum defined.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c    | 32 +++++++++++++++++++++++-------
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  6 ++++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..f97394dac1db 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -49,10 +49,20 @@
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
+#include "pmu-events.h"
 
 int verbose;
 char *prog;
 
+enum aggr_mode_class convert(const char *aggr_mode)
+{
+	if (!strcmp(aggr_mode, "PerCore"))
+		return PerCore;
+	else if (!strcmp(aggr_mode, "PerChip"))
+		return PerChip;
+	return -1;
+}
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -321,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 static int print_events_table_entry(void *data, char *name, char *event,
 				    char *desc, char *long_desc,
 				    char *pmu, char *unit, char *perpkg,
-				    char *metric_expr,
+				    char *metric_expr, char *aggr_mode,
 				    char *metric_name, char *metric_group,
 				    char *deprecated, char *metric_constraint)
 {
@@ -345,6 +355,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
 	if (pmu)
 		fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
+	if (aggr_mode)
+		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(aggr_mode));
 	if (unit)
 		fprintf(outfp, "\t.unit = \"%s\",\n", unit);
 	if (perpkg)
@@ -372,6 +384,7 @@ struct event_struct {
 	char *long_desc;
 	char *pmu;
 	char *unit;
+	char *aggr_mode;
 	char *perpkg;
 	char *metric_expr;
 	char *metric_name;
@@ -402,6 +415,7 @@ struct event_struct {
 	op(pmu);						\
 	op(unit);						\
 	op(perpkg);						\
+	op(aggr_mode);						\
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
@@ -424,7 +438,7 @@ static void free_arch_std_events(void)
 static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
+				char *aggr_mode, char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint)
 {
 	struct event_struct *es;
@@ -487,8 +501,8 @@ static char *real_event(const char *name, char *event)
 static int
 try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
-	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
-	  char **metric_group, unsigned long long eventcode,
+	  char **perpkg, char **unit, char **metric_expr, char **aggr_mode,
+	  char **metric_name, char **metric_group, unsigned long long eventcode,
 	  char **deprecated, char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
@@ -516,7 +530,7 @@ int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
-		      char *metric_expr,
+		      char *metric_expr, char *aggr_mode,
 		      char *metric_name, char *metric_group,
 		      char *deprecated, char *metric_constraint),
 	  void *data)
@@ -543,6 +557,7 @@ int json_events(const char *fn,
 		char *pmu = NULL;
 		char *filter = NULL;
 		char *perpkg = NULL;
+		char *aggr_mode = NULL;
 		char *unit = NULL;
 		char *metric_expr = NULL;
 		char *metric_name = NULL;
@@ -627,6 +642,8 @@ int json_events(const char *fn,
 				addfield(map, &unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
 				addfield(map, &perpkg, "", "", val);
+			} else if (json_streq(map, field, "AggregationMode")) {
+				addfield(map, &aggr_mode, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
@@ -674,14 +691,14 @@ int json_events(const char *fn,
 			 */
 			err = try_fixup(fn, arch_std, &event, &desc, &name,
 					&long_desc, &pmu, &filter, &perpkg,
-					&unit, &metric_expr, &metric_name,
+					&unit, &metric_expr, &aggr_mode, &metric_name,
 					&metric_group, eventcode,
 					&deprecated, &metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
+			   pmu, unit, perpkg, metric_expr, aggr_mode, metric_name,
 			   metric_group, deprecated, metric_constraint);
 free_strings:
 		free(event);
@@ -692,6 +709,7 @@ int json_events(const char *fn,
 		free(pmu);
 		free(filter);
 		free(perpkg);
+		free(aggr_mode);
 		free(deprecated);
 		free(unit);
 		free(metric_expr);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..f64d6ebb245f 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -7,7 +7,7 @@ int json_events(const char *fn,
 				char *long_desc,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
+				char *aggr_mode, char *metric_name, char *metric_group,
 				char *deprecated, char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..e84496527611 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,11 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+enum aggr_mode_class {
+	PerChip = 1,
+	PerCore
+};
+
 /*
  * Describe each PMU event. Each CPU has a table of PMU events.
  */
@@ -15,6 +20,7 @@ struct pmu_event {
 	const char *unit;
 	const char *perpkg;
 	const char *metric_expr;
+	const char *aggr_mode;
 	const char *metric_name;
 	const char *metric_group;
 	const char *deprecated;
-- 
2.26.2

