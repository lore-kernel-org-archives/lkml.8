Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FDC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FABC21744
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbgDAUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:35:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733069AbgDAUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:35:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031KYsuW110338
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 16:34:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 305165hdnw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:34:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Wed, 1 Apr 2020 21:34:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 21:34:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031KYaSW58720474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 20:34:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A1BA405B;
        Wed,  1 Apr 2020 20:34:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 845F1A4054;
        Wed,  1 Apr 2020 20:34:30 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.38.236])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 20:34:30 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v8 3/7] perf/tools: Refactoring metricgroup__add_metric function
Date:   Thu,  2 Apr 2020 02:03:36 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200401203340.31402-1-kjain@linux.ibm.com>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040120-0028-0000-0000-000003F03C02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040120-0029-0000-0000-000024B5C373
Message-Id: <20200401203340.31402-4-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactor metricgroup__add_metric function where
some part of it move to function metricgroup__add_metric_param.
No logic change.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 60 ++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 926449a7cdbf..7ad81c8177ea 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -485,6 +485,39 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
 	return false;
 }
 
+static int __metricgroup__add_metric(struct strbuf *events,
+			struct list_head *group_list, struct pmu_event *pe)
+{
+
+	const char **ids;
+	int idnum;
+	struct egroup *eg;
+
+	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
+		return -EINVAL;
+
+	if (events->len > 0)
+		strbuf_addf(events, ",");
+
+	if (metricgroup__has_constraint(pe))
+		metricgroup__add_metric_non_group(events, ids, idnum);
+	else
+		metricgroup__add_metric_weak_group(events, ids, idnum);
+
+	eg = malloc(sizeof(*eg));
+	if (!eg)
+		return -ENOMEM;
+
+	eg->ids = ids;
+	eg->idnum = idnum;
+	eg->metric_name = pe->metric_name;
+	eg->metric_expr = pe->metric_expr;
+	eg->metric_unit = pe->unit;
+	list_add_tail(&eg->nd, group_list);
+
+	return 0;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -504,35 +537,12 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
 		    match_metric(pe->metric_name, metric)) {
-			const char **ids;
-			int idnum;
-			struct egroup *eg;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
-			if (expr__find_other(pe->metric_expr,
-					     NULL, &ids, &idnum) < 0)
-				continue;
-			if (events->len > 0)
-				strbuf_addf(events, ",");
-
-			if (metricgroup__has_constraint(pe))
-				metricgroup__add_metric_non_group(events, ids, idnum);
-			else
-				metricgroup__add_metric_weak_group(events, ids, idnum);
-
-			eg = malloc(sizeof(struct egroup));
-			if (!eg) {
-				ret = -ENOMEM;
+			ret = __metricgroup__add_metric(events,	group_list, pe);
+			if (ret == -ENOMEM)
 				break;
-			}
-			eg->ids = ids;
-			eg->idnum = idnum;
-			eg->metric_name = pe->metric_name;
-			eg->metric_expr = pe->metric_expr;
-			eg->metric_unit = pe->unit;
-			list_add_tail(&eg->nd, group_list);
-			ret = 0;
 		}
 	}
 	return ret;
-- 
2.21.0

