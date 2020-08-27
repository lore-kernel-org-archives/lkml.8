Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33F22054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SaXID+tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgH0Oyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:54:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7940 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbgH0NLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:11:32 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RD48rO123607;
        Thu, 27 Aug 2020 09:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Rq0eGwEdAf1ECdTf14R493jfYbgNZOdiOttdjWCUcE4=;
 b=SaXID+tmm2QrplxyVdrBAtWRC7cV7+V6Du+dOomushoYkRRkiwtyUy6XuNzHvphPEyIP
 kObZq4T7dNkYbjpNRujQxEXYD4mTEfm7I6+lEY2K3r/Apux2R3fs2svD7badnb5OC78i
 z2+WAx7FqL1jSxd4Tn2qE2FKr+LJql4hNM+Z6V8mnsQG0n44PDbSDrN4JflHDoOxNk+d
 iwXsPyc73c5+9C+jiq2vAvPpAi9Mtu6HSOzbOVc6XyrnLPy1JZIYFztIKM6YMljM/Osl
 yuMXJcNA+1w2/gO2yaJotut2zu3xTBJLzc4AWewc5GU2ptb+dwmqVmjMtBQIbpWzm6J2 Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336d3ggp5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:11:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RD4c33124966;
        Thu, 27 Aug 2020 09:11:00 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336d3ggp4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:11:00 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RD8Wun016646;
        Thu, 27 Aug 2020 13:10:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 335a2t95mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:10:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RDAsRC29163862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:10:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A57CA4065;
        Thu, 27 Aug 2020 13:10:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD025A4054;
        Thu, 27 Aug 2020 13:10:49 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.210.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 13:10:49 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v6 2/5] perf/jevents: Add new structure to pass json fields.
Date:   Thu, 27 Aug 2020 18:39:55 +0530
Message-Id: <20200827130958.189146-3-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827130958.189146-1-kjain@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=4 adultscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new structure called 'json_event' inside jevents.h
file to improve the callback prototype inside jevent files.
Initially, whenever user want to add new field, they need to update
in all function callback which make it more and more complex with
increased number of parmeters.
With this change, we just need to add it in new structure 'json_event'.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/pmu-events/jevents.c | 222 +++++++++++++++-----------------
 1 file changed, 105 insertions(+), 117 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1c55cc754b5a..b205cd904a4f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -52,6 +52,21 @@
 int verbose;
 char *prog;
 
+struct json_event {
+	char *name;
+	char *event;
+	char *desc;
+	char *long_desc;
+	char *pmu;
+	char *unit;
+	char *perpkg;
+	char *metric_expr;
+	char *metric_name;
+	char *metric_group;
+	char *deprecated;
+	char *metric_constraint;
+};
+
 #ifndef min
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
@@ -60,6 +75,8 @@ char *prog;
 	_min1 < _min2 ? _min1 : _min2; })
 #endif
 
+typedef int (*func)(void *data, struct json_event *je);
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -325,12 +342,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 	close_table = 1;
 }
 
-static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc, char *long_desc,
-				    char *pmu, char *unit, char *perpkg,
-				    char *metric_expr,
-				    char *metric_name, char *metric_group,
-				    char *deprecated, char *metric_constraint)
+static int print_events_table_entry(void *data, struct json_event *je)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -342,30 +354,30 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	 */
 	fprintf(outfp, "{\n");
 
-	if (name)
-		fprintf(outfp, "\t.name = \"%s\",\n", name);
-	if (event)
-		fprintf(outfp, "\t.event = \"%s\",\n", event);
-	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
+	if (je->name)
+		fprintf(outfp, "\t.name = \"%s\",\n", je->name);
+	if (je->event)
+		fprintf(outfp, "\t.event = \"%s\",\n", je->event);
+	fprintf(outfp, "\t.desc = \"%s\",\n", je->desc);
 	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
-	if (long_desc && long_desc[0])
-		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
-	if (pmu)
-		fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
-	if (unit)
-		fprintf(outfp, "\t.unit = \"%s\",\n", unit);
-	if (perpkg)
-		fprintf(outfp, "\t.perpkg = \"%s\",\n", perpkg);
-	if (metric_expr)
-		fprintf(outfp, "\t.metric_expr = \"%s\",\n", metric_expr);
-	if (metric_name)
-		fprintf(outfp, "\t.metric_name = \"%s\",\n", metric_name);
-	if (metric_group)
-		fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
-	if (deprecated)
-		fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
-	if (metric_constraint)
-		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
+	if (je->long_desc && je->long_desc[0])
+		fprintf(outfp, "\t.long_desc = \"%s\",\n", je->long_desc);
+	if (je->pmu)
+		fprintf(outfp, "\t.pmu = \"%s\",\n", je->pmu);
+	if (je->unit)
+		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
+	if (je->perpkg)
+		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
+	if (je->metric_expr)
+		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
+	if (je->metric_name)
+		fprintf(outfp, "\t.metric_name = \"%s\",\n", je->metric_name);
+	if (je->metric_group)
+		fprintf(outfp, "\t.metric_group = \"%s\",\n", je->metric_group);
+	if (je->deprecated)
+		fprintf(outfp, "\t.deprecated = \"%s\",\n", je->deprecated);
+	if (je->metric_constraint)
+		fprintf(outfp, "\t.metric_constraint = \"%s\",\n", je->metric_constraint);
 	fprintf(outfp, "},\n");
 
 	return 0;
@@ -387,17 +399,17 @@ struct event_struct {
 	char *metric_constraint;
 };
 
-#define ADD_EVENT_FIELD(field) do { if (field) {		\
-	es->field = strdup(field);				\
+#define ADD_EVENT_FIELD(field) do { if (je->field) {		\
+	es->field = strdup(je->field);				\
 	if (!es->field)						\
 		goto out_free;					\
 } } while (0)
 
 #define FREE_EVENT_FIELD(field) free(es->field)
 
-#define TRY_FIXUP_FIELD(field) do { if (es->field && !*field) {\
-	*field = strdup(es->field);				\
-	if (!*field)						\
+#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
+	je->field = strdup(es->field);				\
+	if (!je->field)						\
 		return -ENOMEM;					\
 } } while (0)
 
@@ -428,11 +440,7 @@ static void free_arch_std_events(void)
 	}
 }
 
-static int save_arch_std_events(void *data, char *name, char *event,
-				char *desc, char *long_desc, char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint)
+static int save_arch_std_events(void *data, struct json_event *je)
 {
 	struct event_struct *es;
 
@@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
 		return NULL;
 
 	for (i = 0; fixed[i].name; i++)
-		if (!strcasecmp(name, fixed[i].name))
-			return (char *)fixed[i].event;
+		if (!strcasecmp(name, fixed[i].name)) {
+			strcpy(event, fixed[i].event);
+			return event;
+		}
 	return event;
 }
 
 static int
-try_fixup(const char *fn, char *arch_std, char **event, char **desc,
-	  char **name, char **long_desc, char **pmu, char **filter,
-	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
-	  char **metric_group, unsigned long long eventcode,
-	  char **deprecated, char **metric_constraint)
+try_fixup(const char *fn, char *arch_std, unsigned long long eventcode,
+	  struct json_event *je)
 {
 	/* try to find matching event from arch standard values */
 	struct event_struct *es;
@@ -505,8 +512,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 		if (!strcmp(arch_std, es->name)) {
 			if (!eventcode && es->event) {
 				/* allow EventCode to be overridden */
-				free(*event);
-				*event = NULL;
+				free(je->event);
+				je->event = NULL;
 			}
 			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
 			return 0;
@@ -520,13 +527,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc,
-		      char *long_desc,
-		      char *pmu, char *unit, char *perpkg,
-		      char *metric_expr,
-		      char *metric_name, char *metric_group,
-		      char *deprecated, char *metric_constraint),
-	  void *data)
+		int (*func)(void *data, struct json_event *je),
+			void *data)
 {
 	int err;
 	size_t size;
@@ -544,18 +546,9 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
-		char *event = NULL, *desc = NULL, *name = NULL;
-		char *long_desc = NULL;
 		char *extra_desc = NULL;
-		char *pmu = NULL;
 		char *filter = NULL;
-		char *perpkg = NULL;
-		char *unit = NULL;
-		char *metric_expr = NULL;
-		char *metric_name = NULL;
-		char *metric_group = NULL;
-		char *deprecated = NULL;
-		char *metric_constraint = NULL;
+		struct json_event je = {};
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
@@ -577,7 +570,7 @@ int json_events(const char *fn,
 			       "Expected string value");
 
 			nz = !json_streq(map, val, "0");
-			if (match_field(map, field, nz, &event, val)) {
+			if (match_field(map, field, nz, &je.event, val)) {
 				/* ok */
 			} else if (json_streq(map, field, "EventCode")) {
 				char *code = NULL;
@@ -590,14 +583,14 @@ int json_events(const char *fn,
 				eventcode |= strtoul(code, NULL, 0) << 21;
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
-				addfield(map, &name, "", "", val);
+				addfield(map, &je.name, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
-				addfield(map, &desc, "", "", val);
-				fixdesc(desc);
+				addfield(map, &je.desc, "", "", val);
+				fixdesc(je.desc);
 			} else if (json_streq(map, field,
 					     "PublicDescription")) {
-				addfield(map, &long_desc, "", "", val);
-				fixdesc(long_desc);
+				addfield(map, &je.long_desc, "", "", val);
+				fixdesc(je.long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -617,34 +610,34 @@ int json_events(const char *fn,
 
 				ppmu = field_to_perf(unit_to_pmu, map, val);
 				if (ppmu) {
-					pmu = strdup(ppmu);
+					je.pmu = strdup(ppmu);
 				} else {
-					if (!pmu)
-						pmu = strdup("uncore_");
-					addfield(map, &pmu, "", "", val);
-					for (s = pmu; *s; s++)
+					if (!je.pmu)
+						je.pmu = strdup("uncore_");
+					addfield(map, &je.pmu, "", "", val);
+					for (s = je.pmu; *s; s++)
 						*s = tolower(*s);
 				}
-				addfield(map, &desc, ". ", "Unit: ", NULL);
-				addfield(map, &desc, "", pmu, NULL);
-				addfield(map, &desc, "", " ", NULL);
+				addfield(map, &je.desc, ". ", "Unit: ", NULL);
+				addfield(map, &je.desc, "", je.pmu, NULL);
+				addfield(map, &je.desc, "", " ", NULL);
 			} else if (json_streq(map, field, "Filter")) {
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
-				addfield(map, &unit, "", "", val);
+				addfield(map, &je.unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
-				addfield(map, &perpkg, "", "", val);
+				addfield(map, &je.perpkg, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
-				addfield(map, &deprecated, "", "", val);
+				addfield(map, &je.deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
-				addfield(map, &metric_name, "", "", val);
+				addfield(map, &je.metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
-				addfield(map, &metric_group, "", "", val);
+				addfield(map, &je.metric_group, "", "", val);
 			} else if (json_streq(map, field, "MetricConstraint")) {
-				addfield(map, &metric_constraint, "", "", val);
+				addfield(map, &je.metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
-				addfield(map, &metric_expr, "", "", val);
-				for (s = metric_expr; *s; s++)
+				addfield(map, &je.metric_expr, "", "", val);
+				for (s = je.metric_expr; *s; s++)
 					*s = tolower(*s);
 			} else if (json_streq(map, field, "ArchStdEvent")) {
 				addfield(map, &arch_std, "", "", val);
@@ -653,7 +646,7 @@ int json_events(const char *fn,
 			}
 			/* ignore unknown fields */
 		}
-		if (precise && desc && !strstr(desc, "(Precise Event)")) {
+		if (precise && je.desc && !strstr(je.desc, "(Precise Event)")) {
 			if (json_streq(map, precise, "2"))
 				addfield(map, &extra_desc, " ",
 						"(Must be precise)", NULL);
@@ -662,49 +655,44 @@ int json_events(const char *fn,
 						"(Precise event)", NULL);
 		}
 		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
-		addfield(map, &event, ",", buf, NULL);
-		if (desc && extra_desc)
-			addfield(map, &desc, " ", extra_desc, NULL);
-		if (long_desc && extra_desc)
-			addfield(map, &long_desc, " ", extra_desc, NULL);
+		addfield(map, &je.event, ",", buf, NULL);
+		if (je.desc && extra_desc)
+			addfield(map, &je.desc, " ", extra_desc, NULL);
+		if (je.long_desc && extra_desc)
+			addfield(map, &je.long_desc, " ", extra_desc, NULL);
 		if (filter)
-			addfield(map, &event, ",", filter, NULL);
+			addfield(map, &je.event, ",", filter, NULL);
 		if (msr != NULL)
-			addfield(map, &event, ",", msr->pname, msrval);
-		if (name)
-			fixname(name);
+			addfield(map, &je.event, ",", msr->pname, msrval);
+		if (je.name)
+			fixname(je.name);
 
 		if (arch_std) {
 			/*
 			 * An arch standard event is referenced, so try to
 			 * fixup any unassigned values.
 			 */
-			err = try_fixup(fn, arch_std, &event, &desc, &name,
-					&long_desc, &pmu, &filter, &perpkg,
-					&unit, &metric_expr, &metric_name,
-					&metric_group, eventcode,
-					&deprecated, &metric_constraint);
+			err = try_fixup(fn, arch_std, eventcode, &je);
 			if (err)
 				goto free_strings;
 		}
-		err = func(data, name, real_event(name, event), desc, long_desc,
-			   pmu, unit, perpkg, metric_expr, metric_name,
-			   metric_group, deprecated, metric_constraint);
+		je.event = real_event(je.name, je.event);
+		err = func(data, &je);
 free_strings:
-		free(event);
-		free(desc);
-		free(name);
-		free(long_desc);
+		free(je.event);
+		free(je.desc);
+		free(je.name);
+		free(je.long_desc);
 		free(extra_desc);
-		free(pmu);
+		free(je.pmu);
 		free(filter);
-		free(perpkg);
-		free(deprecated);
-		free(unit);
-		free(metric_expr);
-		free(metric_name);
-		free(metric_group);
-		free(metric_constraint);
+		free(je.perpkg);
+		free(je.deprecated);
+		free(je.unit);
+		free(je.metric_expr);
+		free(je.metric_name);
+		free(je.metric_group);
+		free(je.metric_constraint);
 		free(arch_std);
 
 		if (err)
-- 
2.26.2

