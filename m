Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE222B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T+PQdPUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgH0NQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:16:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727783AbgH0NLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:11:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RD2vHi055811;
        Thu, 27 Aug 2020 09:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sDhbinly1FIF+6k2Ac+2kNU9+2RhMtPqGLaeIbq+/FQ=;
 b=T+PQdPUZ2wiQvbqllzL0YgFcGdbTXDBzDziANeycePgjXKIhj3ngvnWZHBqnm/q9187T
 yxFQ/2J/sg/CwJa/ls97XoCl6f3OfrP+i9D8LdlIiICjzQ3k1paoDPuFwFkTEP5qWbsa
 ph+FpDAE48YGgZkBVXxcLYXqaKt7TMHd7FUmvNDdMLz/0psgRf7V9jBQvUB+Ar5Fqvel
 /omoH/gEAB8yhJVRZkE+nM2VxjZswvjtxVyOU1EgbmgJ89lFw6RQu2nKJ3d4bOnOPYPj
 sCVYm6dxsXDkmtENAJKbsYhbYVScWx++YAOeTExyQEFtz6sKFcjc2bnyZ58kxTJ8ARlN Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336d508rwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:11:05 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RD32O4056116;
        Thu, 27 Aug 2020 09:11:04 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336d508rvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:11:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RD8qal020355;
        Thu, 27 Aug 2020 13:11:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 332ujjugpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:11:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RDAx8T22348132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:11:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2098A4054;
        Thu, 27 Aug 2020 13:10:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6BE6A405B;
        Thu, 27 Aug 2020 13:10:54 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.210.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 13:10:54 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v6 3/5] perf jevents: Add support for parsing perchip/percore events
Date:   Thu, 27 Aug 2020 18:39:56 +0530
Message-Id: <20200827130958.189146-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827130958.189146-1-kjain@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=1 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270094
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
 tools/perf/pmu-events/jevents.c    | 16 ++++++++++++++++
 tools/perf/pmu-events/pmu-events.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b205cd904a4f..f4ad2d403533 100644
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
@@ -74,6 +76,14 @@ struct json_event {
 	(void)(&_min1 == &_min2);		\
 	_min1 < _min2 ? _min1 : _min2; })
 #endif
+enum aggr_mode_class convert(const char *aggr_mode)
+{
+	if (!strcmp(aggr_mode, "PerCore"))
+		return PerCore;
+	else if (!strcmp(aggr_mode, "PerChip"))
+		return PerChip;
+	return -1;
+}
 
 typedef int (*func)(void *data, struct json_event *je);
 
@@ -368,6 +378,8 @@ static int print_events_table_entry(void *data, struct json_event *je)
 		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
 	if (je->perpkg)
 		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
+	if (je->aggr_mode)
+		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(je->aggr_mode));
 	if (je->metric_expr)
 		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
 	if (je->metric_name)
@@ -392,6 +404,7 @@ struct event_struct {
 	char *pmu;
 	char *unit;
 	char *perpkg;
+	char *aggr_mode;
 	char *metric_expr;
 	char *metric_name;
 	char *metric_group;
@@ -421,6 +434,7 @@ struct event_struct {
 	op(pmu);						\
 	op(unit);						\
 	op(perpkg);						\
+	op(aggr_mode);						\
 	op(metric_expr);					\
 	op(metric_name);					\
 	op(metric_group);					\
@@ -627,6 +641,8 @@ int json_events(const char *fn,
 				addfield(map, &je.unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
 				addfield(map, &je.perpkg, "", "", val);
+			} else if (json_streq(map, field, "AggregationMode")) {
+				addfield(map, &je.aggr_mode, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
 				addfield(map, &je.deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
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

