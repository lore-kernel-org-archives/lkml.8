Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB671C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C43C20575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEGQ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:29:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgEGQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:29:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047G2i1Q016174;
        Thu, 7 May 2020 12:29:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30uf8ka3h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 12:29:03 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047GRC0L140811;
        Thu, 7 May 2020 12:29:02 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30uf8ka3gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 12:29:02 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047GQ41m008462;
        Thu, 7 May 2020 16:29:01 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 30s0g736pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 16:29:01 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047GT1fI14090862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 16:29:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07C5B124054;
        Thu,  7 May 2020 16:29:01 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA363124052;
        Thu,  7 May 2020 16:29:00 +0000 (GMT)
Received: from localhost (unknown [9.65.234.211])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 16:29:00 +0000 (GMT)
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au, irogers@google.com
Subject: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Date:   Thu,  7 May 2020 11:28:58 -0500
Message-Id: <1588868938-21933-3-git-send-email-pc@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_10:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul A. Clarke" <pc@us.ibm.com>

Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
- ict_noslot_br_mpred_cpi
- ict_noslot_br_mpred_icmiss_cpi
- ict_noslot_cyc_other_cpi
- ict_noslot_disp_held_cpi
- ict_noslot_disp_held_hb_full_cpi
- ict_noslot_disp_held_issq_cpi
- ict_noslot_disp_held_other_cpi
- ict_noslot_disp_held_sync_cpi
- ict_noslot_disp_held_tbegin_cpi
- ict_noslot_ic_l2_cpi
- ict_noslot_ic_l3_cpi
- ict_noslot_ic_l3miss_cpi
- ict_noslot_ic_miss_cpi

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
 1 file changed, 78 insertions(+), 65 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 811c2a8c1c9e..6169351a72c8 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -207,6 +207,84 @@
         "MetricGroup": "cpi_breakdown",
         "MetricName": "fxu_stall_cpi"
     },
+    {
+        "BriefDescription": "Ict empty for this thread due to branch mispred",
+        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_br_mpred_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
+        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
+    },
+    {
+        "BriefDescription": "ICT other stalls",
+        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_cyc_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_disp_held_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_disp_held_issq_cpi"
+    },
+    {
+        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
+        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_disp_held_other_cpi"
+    },
+    {
+        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_disp_held_sync_cpi"
+    },
+    {
+        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
+    },
+    {
+        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
+        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_ic_l2_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
+        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_ic_l3_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
+        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_ic_l3miss_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to Icache Miss",
+        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ict_noslot_ic_miss_cpi"
+    },
     {
         "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
@@ -1819,71 +1897,6 @@
         "MetricExpr": "PM_FXU_IDLE / PM_CYC",
         "MetricName": "fxu_all_idle"
     },
-    {
-        "BriefDescription": "Ict empty for this thread due to branch mispred",
-        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_br_mpred_cpi"
-    },
-    {
-        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
-        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
-    },
-    {
-        "BriefDescription": "ICT other stalls",
-        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_cyc_other_cpi"
-    },
-    {
-        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
-        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_disp_held_cpi"
-    },
-    {
-        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
-        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
-    },
-    {
-        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
-        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_disp_held_issq_cpi"
-    },
-    {
-        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
-        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_disp_held_other_cpi"
-    },
-    {
-        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
-        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_disp_held_sync_cpi"
-    },
-    {
-        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
-        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
-    },
-    {
-        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
-        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_ic_l2_cpi"
-    },
-    {
-        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
-        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_ic_l3_cpi"
-    },
-    {
-        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
-        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_ic_l3miss_cpi"
-    },
-    {
-        "BriefDescription": "Ict empty for this thread due to Icache Miss",
-        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
-        "MetricName": "ict_noslot_ic_miss_cpi"
-    },
     {
         "BriefDescription": "Rate of IERAT reloads from L2",
         "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
-- 
2.18.2

