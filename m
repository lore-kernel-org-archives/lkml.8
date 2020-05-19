Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED081C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C227320829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgESTSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:18:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726671AbgESTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:18:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JJ4P5f121600;
        Tue, 19 May 2020 15:18:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 314m0mjfjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 15:18:10 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04JJ4gj7122959;
        Tue, 19 May 2020 15:18:10 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 314m0mjfj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 15:18:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JJFjU0027350;
        Tue, 19 May 2020 19:18:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 313whar1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 19:18:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JJI7LA26149202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 19:18:07 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E4C778060;
        Tue, 19 May 2020 19:18:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E4E78064;
        Tue, 19 May 2020 19:18:07 +0000 (GMT)
Received: from localhost (unknown [9.160.42.118])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 May 2020 19:18:07 +0000 (GMT)
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org
Cc:     mpe@ellerman.id.au, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, irogers@google.com
Subject: [PATCH] perf stat: POWER9 metrics: expand "ICT" acronym
Date:   Tue, 19 May 2020 14:18:06 -0500
Message-Id: <1589915886-22992-1-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_08:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

Uses of "ICT" and "Ict" are expanded to "Instruction Completion Table".

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index f371104dcbe3..80816d6402e9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -208,19 +208,19 @@
         "MetricName": "fxu_stall_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to branch mispred",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to branch mispred",
         "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_br_mpred_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to Icache Miss and branch mispred",
         "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
     },
     {
-        "BriefDescription": "ICT other stalls",
+        "BriefDescription": "Instruction Completion Table other stalls",
         "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_cyc_other_cpi"
@@ -232,13 +232,13 @@
         "MetricName": "ict_noslot_disp_held_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
         "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_disp_held_hb_full_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
         "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_disp_held_issq_cpi"
@@ -268,19 +268,19 @@
         "MetricName": "ict_noslot_ic_l2_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to icache misses that were sourced from the local L3",
         "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_l3_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
         "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_l3miss_cpi"
     },
     {
-        "BriefDescription": "Ict empty for this thread due to Icache Miss",
+        "BriefDescription": "Instruction Completion Table empty for this thread due to Icache Miss",
         "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_miss_cpi"
@@ -391,7 +391,7 @@
         "MetricName": "nested_tend_stall_cpi"
     },
     {
-        "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread",
+        "BriefDescription": "Number of cycles the Instruction Completion Table has no itags assigned to this thread",
         "MetricExpr": "PM_ICT_NOSLOT_CYC/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "nothing_dispatched_cpi"
@@ -503,7 +503,7 @@
         "MetricName": "st_fwd_stall_cpi"
     },
     {
-        "BriefDescription": "Nothing completed and ICT not empty",
+        "BriefDescription": "Nothing completed and Instruction Completion Table not empty",
         "MetricExpr": "PM_CMPLU_STALL/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "stall_cpi"
-- 
2.18.2

