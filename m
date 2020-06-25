Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0342076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbgFYLs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:48:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404220AbgFYLs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:48:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PBVSBo125033;
        Thu, 25 Jun 2020 07:47:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ux0059uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 07:47:50 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PBWSu1128867;
        Thu, 25 Jun 2020 07:47:49 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ux0059tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 07:47:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PBiq9w010916;
        Thu, 25 Jun 2020 11:47:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31uus71rye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 11:47:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PBliZx28377324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 11:47:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CCF84203F;
        Thu, 25 Jun 2020 11:47:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7414742045;
        Thu, 25 Jun 2020 11:47:40 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.77.196.238])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 11:47:40 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        kjain@linux.ibm.com
Subject: [RFC 1/3] perf jevents: Add support for parsing perchip/percore events
Date:   Thu, 25 Jun 2020 17:17:16 +0530
Message-Id: <20200625114718.229911-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625114718.229911-1-kjain@linux.ibm.com>
References: <20200625114718.229911-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_04:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=3
 clxscore=1011 bulkscore=0 cotscore=-2147483648 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up the "PerChip" field  so that perf knows they are
per chip events.

Set up the "PerCore" field  so that perf knows they are
per core events and add these fields to pmu_event structure.

Similar to the way we had "PerPkg field
to specify perpkg events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.c    | 34 ++++++++++++++++++++++++------
 tools/perf/pmu-events/jevents.h    |  3 ++-
 tools/perf/pmu-events/pmu-events.h |  2 ++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..21fd7990ded5 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -323,7 +323,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 				    char *pmu, char *unit, char *perpkg,
 				    char *metric_expr,
 				    char *metric_name, char *metric_group,
-				    char *deprecated, char *metric_constraint)
+				    char *deprecated, char *perchip, char *percore,
+				    char *metric_constraint)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -357,6 +358,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
 		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
 	if (deprecated)
 		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
+	if (perchip)
+		fprintf(outfp, "\t.perchip = \"%s\",\n", perchip);
+	if (percore)
+		fprintf(outfp, "\t.percore = \"%s\",\n", percore);
 	if (metric_constraint)
 		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
 	fprintf(outfp, "},\n");
@@ -378,6 +383,8 @@ struct event_struct {
 	char *metric_group;
 	char *deprecated;
 	char *metric_constraint;
+	char *perchip;
+	char *percore;
 };
 
 #define ADD_EVENT_FIELD(field) do { if (field) {		\
@@ -406,6 +413,8 @@ struct event_struct {
 	op(metric_name);					\
 	op(metric_group);					\
 	op(deprecated);						\
+	op(perchip);						\
+	op(percore);						\
 } while (0)
 
 static LIST_HEAD(arch_std_events);
@@ -425,7 +434,8 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *desc, char *long_desc, char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint)
+				char *deprecated, char *perchip, char *percore,
+				char *metric_constraint)
 {
 	struct event_struct *es;
 
@@ -489,7 +499,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 	  char **name, char **long_desc, char **pmu, char **filter,
 	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
 	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated, char **metric_constraint)
+	  char **deprecated, char **perchip, char **percore,
+	  char **metric_constraint)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -518,7 +529,8 @@ int json_events(const char *fn,
 		      char *pmu, char *unit, char *perpkg,
 		      char *metric_expr,
 		      char *metric_name, char *metric_group,
-		      char *deprecated, char *metric_constraint),
+		      char *deprecated, char *perchip, char *percore,
+		      char *metric_constraint),
 	  void *data)
 {
 	int err;
@@ -548,6 +560,8 @@ int json_events(const char *fn,
 		char *metric_name = NULL;
 		char *metric_group = NULL;
 		char *deprecated = NULL;
+		char *perchip = NULL;
+		char *percore = NULL;
 		char *metric_constraint = NULL;
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
@@ -629,6 +643,10 @@ int json_events(const char *fn,
 				addfield(map, &perpkg, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &deprecated, "", "", val);
+			} else if (json_streq(map, field, "PerChip")) {
+				addfield(map, &perchip, "", "", val);
+			} else if (json_streq(map, field, "PerCore")) {
+				addfield(map, &percore, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
 				addfield(map, &metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
@@ -676,13 +694,15 @@ int json_events(const char *fn,
 					&long_desc, &pmu, &filter, &perpkg,
 					&unit, &metric_expr, &metric_name,
 					&metric_group, eventcode,
-					&deprecated, &metric_constraint);
+					&deprecated, &perchip, &percore,
+					&metric_constraint);
 			if (err)
 				goto free_strings;
 		}
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+			   metric_group, deprecated, perchip, percore,
+			   metric_constraint);
 free_strings:
 		free(event);
 		free(desc);
@@ -693,6 +713,8 @@ int json_events(const char *fn,
 		free(filter);
 		free(perpkg);
 		free(deprecated);
+		free(perchip);
+		free(percore);
 		free(unit);
 		free(metric_expr);
 		free(metric_name);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 2afc8304529e..3c439ecdac7c 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -8,7 +8,8 @@ int json_events(const char *fn,
 				char *pmu,
 				char *unit, char *perpkg, char *metric_expr,
 				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint),
+				char *deprecated, char *perchip, char *percore,
+				char *metric_constraint),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..13d96b732963 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -19,6 +19,8 @@ struct pmu_event {
 	const char *metric_group;
 	const char *deprecated;
 	const char *metric_constraint;
+	const char *perchip;
+	const char *percore;
 };
 
 /*
-- 
2.26.2

