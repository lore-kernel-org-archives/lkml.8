Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0663AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD24321556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YcXqd7/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgIGGmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:42:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgIGGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:42:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0876UuH8178302;
        Mon, 7 Sep 2020 02:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZDut/IwYGbPq6wVksUhp8MgeRyWuDh+n4LSkssHR+l0=;
 b=YcXqd7/c22/L8ZNAefSXgqsC/OFrPzV6AU5I4jiP8wvfrs2foPKJTVlix3XRdrc9cGVg
 3n9Ji+CY3M4uh1V69Vz17G2zOMxALZyMSM+ljJFg/sSGPTQu9I9921QKKjcXJqtZ14AE
 rIp4g0O0BiWDTAFyJrTcv5PNubwVJb8W6QxAzFofo1UgZQ6ec2p+2VIxltt4hc9PZSWF
 q85e5H3v2rglLCUQgSCll8nymoBAePcjtXOTRjSTxVp5gNbQODHpB+WdOjjfLyEBoQjs
 rQ2WaV7/nqmYpEuBQ36yXgFps7k6jJTrT9B90qVcDsCvuQr8F8aaDBJqDxhOLV2Zg9fn Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dfg8rh2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:42:07 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0876VoDJ181170;
        Mon, 7 Sep 2020 02:42:07 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dfg8rh1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:42:07 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0876b8S3006530;
        Mon, 7 Sep 2020 06:42:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 33c2a897u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 06:42:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0876g26036503954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 06:42:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E04A404D;
        Mon,  7 Sep 2020 06:42:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2466A4040;
        Mon,  7 Sep 2020 06:41:56 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.49.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 06:41:56 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v9 3/5] perf jevents: Add support for parsing perchip/percore events
Date:   Mon,  7 Sep 2020 12:11:31 +0530
Message-Id: <20200907064133.75090-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907064133.75090-1-kjain@linux.ibm.com>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_01:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=3 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070061
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
---
 tools/perf/pmu-events/jevents.c    | 20 ++++++++++++++++++++
 tools/perf/pmu-events/pmu-events.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index db334b2fd896..b6f0c13ae8c0 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -48,6 +48,7 @@
 #include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
+#include "pmu-events.h"
 
 int verbose;
 char *prog;
@@ -60,6 +61,7 @@ struct json_event {
 	char *pmu;
 	char *unit;
 	char *perpkg;
+	char *aggr_mode;
 	char *metric_expr;
 	char *metric_name;
 	char *metric_group;
@@ -67,6 +69,17 @@ struct json_event {
 	char *metric_constraint;
 };
 
+enum aggr_mode_class convert(const char *aggr_mode)
+{
+	if (!strcmp(aggr_mode, "PerCore"))
+		return PerCore;
+	else if (!strcmp(aggr_mode, "PerChip"))
+		return PerChip;
+
+	pr_err("%s: Wrong AggregationMode value '%s'\n", prog, aggr_mode);
+	return -1;
+}
+
 typedef int (*func)(void *data, struct json_event *je);
 
 int eprintf(int level, int var, const char *fmt, ...)
@@ -355,6 +368,8 @@ static int print_events_table_entry(void *data, struct json_event *je)
 		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
 	if (je->perpkg)
 		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
+	if (je->aggr_mode)
+		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(je->aggr_mode));
 	if (je->metric_expr)
 		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
 	if (je->metric_name)
@@ -379,6 +394,7 @@ struct event_struct {
 	char *pmu;
 	char *unit;
 	char *perpkg;
+	char *aggr_mode;
 	char *metric_expr;
 	char *metric_name;
 	char *metric_group;
@@ -408,6 +424,7 @@ struct event_struct {
 	op(pmu);						\
 	op(unit);						\
 	op(perpkg);						\
+	op(aggr_mode);						\
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
@@ -613,6 +630,8 @@ static int json_events(const char *fn,
 				addfield(map, &je.unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
 				addfield(map, &je.perpkg, "", "", val);
+			} else if (json_streq(map, field, "AggregationMode")) {
+				addfield(map, &je.aggr_mode, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &je.deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
@@ -673,6 +692,7 @@ static int json_events(const char *fn,
 		free(je.pmu);
 		free(filter);
 		free(je.perpkg);
+		free(je.aggr_mode);
 		free(je.deprecated);
 		free(je.unit);
 		free(je.metric_expr);
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c8f306b572f4..7da1a3743b77 100644
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
@@ -14,6 +19,7 @@ struct pmu_event {
 	const char *pmu;
 	const char *unit;
 	const char *perpkg;
+	const char *aggr_mode;
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_group;
-- 
2.26.2

