Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D410C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C1820717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgGUOtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:49:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbgGUOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:49:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LEgeZj005502;
        Tue, 21 Jul 2020 10:48:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vusb6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:48:55 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LEguap007560;
        Tue, 21 Jul 2020 10:48:55 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vusb6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:48:55 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LEjQsh020289;
        Tue, 21 Jul 2020 14:48:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 32brq93wda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 14:48:54 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LEmsVO40304982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 14:48:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2BFCC6059;
        Tue, 21 Jul 2020 14:48:53 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F19C6057;
        Tue, 21 Jul 2020 14:48:51 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.160.94.217])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Jul 2020 14:48:51 +0000 (GMT)
Date:   Tue, 21 Jul 2020 09:48:48 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Message-ID: <20200721143702.GA15990@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
Subject: Re:  [PATCHv3 00/19] perf metric: Add support to reuse metric
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_09:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007210102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 08:13:01PM +0200, Jiri Olsa wrote:
> hi,
> this patchset is adding the support to reused metric in
> another metric.
> 
> For example, to define IPC by using CPI with change like:
> 
>      {
>          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "MetricExpr": "1/CPI",
>          "MetricGroup": "TopDownL1",
>          "MetricName": "IPC"
>      },
> 
> I won't be able to find all the possible places we could
> use this at, so I wonder you guys (who was asking for this)
> would try it and come up with comments if there's something
> missing or we could already use it at some places.
> 
> It's based on Arnaldo's tmp.perf/core.
> 
> v3 changes:
>   - added some acks
>   - some patches got merged
>   - added missing zalloc include [John Garry]
>   - added ids array outside the egroup object [Ian]
>   - removed wrong m->has_constraint assignment [Ian]
>   - renamed 'list' to 'metric_list' [Ian]
>   - fixed group metric and added test for it [Paul A. Clarke]
>   - fixed memory leak [Arnaldo]
>   - using lowercase keys for metrics in hashmap, because jevents
>     converts metric_expr to lowercase
> 
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/metric

These changes seem to be mostly working for me.

I attempted to exploit the new capability in the metrics definitions in
tools/perf/pmu-events/arch/powerpc/power9/metrics.json.  Those changes
are included below.

The one problem I found is with the "cpi_breakdown" metric group, as it
no longer works:
```
# perf stat --metrics cpi_breakdown ./command
Cannot find metric or group `cpi_breakdown'
```

"cpi_breakdown" does show up in `perf list --metricgroup`, and all of the
(95!) metrics listed in that group are usable, so it's not obvious whether
my changes have a problem, or merely provoke one.

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 80816d6402e9..f8784c608479 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -60,7 +60,7 @@
     },
     {
         "BriefDescription": "Stalls due to short latency decimal floating ops.",
-        "MetricExpr": "(PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_DFLONG)/PM_RUN_INST_CMPL",
+        "MetricExpr": "dfu_stall_cpi - dflong_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "dfu_other_stall_cpi"
     },
@@ -72,7 +72,7 @@
     },
     {
         "BriefDescription": "Completion stall by Dcache miss which resolved off node memory/cache",
-        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_REMOTE)/PM_RUN_INST_CMPL",
+        "MetricExpr": "dmiss_non_local_stall_cpi - dmiss_remote_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "dmiss_distant_stall_cpi"
     },
@@ -90,7 +90,7 @@
     },
     {
         "BriefDescription": "Completion stall due to cache miss that resolves in the L2 or L3 without conflict",
-        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_DMISS_L2L3_CONFLICT)/PM_RUN_INST_CMPL",
+        "MetricExpr": "dmiss_l2l3_stall_cpi - dmiss_l2l3_conflict_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "dmiss_l2l3_noconflict_stall_cpi"
     },
@@ -114,7 +114,7 @@
     },
     {
         "BriefDescription": "Completion stall by Dcache miss which resolved outside of local memory",
-        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM)/PM_RUN_INST_CMPL",
+        "MetricExpr": "dmiss_l3miss_stall_cpi - dmiss_l21_l31_stall_cpi - dmiss_lmem_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "dmiss_non_local_stall_cpi"
     },
@@ -126,7 +126,7 @@
     },
     {
         "BriefDescription": "Stalls due to short latency double precision ops.",
-        "MetricExpr": "(PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DPLONG)/PM_RUN_INST_CMPL",
+        "MetricExpr": "dp_stall_cpi - dplong_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "dp_other_stall_cpi"
     },
@@ -155,7 +155,7 @@
         "MetricName": "emq_full_stall_cpi"
     },
     {
-        "MetricExpr": "(PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL)/PM_RUN_INST_CMPL",
+        "MetricExpr": "erat_miss_stall_cpi + emq_full_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "emq_stall_cpi"
     },
@@ -173,7 +173,7 @@
     },
     {
         "BriefDescription": "Completion stall due to execution units for other reasons.",
-        "MetricExpr": "(PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_PM - PM_CMPLU_STALL_CRYPTO - PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
+        "MetricExpr": "exec_unit_stall_cpi - scalar_stall_cpi - vector_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "exec_unit_other_stall_cpi"
     },
@@ -197,7 +197,7 @@
     },
     {
         "BriefDescription": "Stalls due to short latency integer ops",
-        "MetricExpr": "(PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_FXLONG)/PM_RUN_INST_CMPL",
+        "MetricExpr": "fxu_stall_cpi - fxlong_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "fxu_other_stall_cpi"
     },
@@ -221,7 +221,7 @@
     },
     {
         "BriefDescription": "Instruction Completion Table other stalls",
-        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
+        "MetricExpr": "nothing_dispatched_cpi - ict_noslot_ic_miss_cpi - ict_noslot_br_mpred_icmiss_cpi - ict_noslot_br_mpred_cpi - ict_noslot_disp_held_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_cyc_other_cpi"
     },
@@ -245,7 +245,7 @@
     },
     {
         "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
-        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
+        "MetricExpr": "ict_noslot_disp_held_cpi - ict_noslot_disp_held_hb_full_cpi - ict_noslot_disp_held_sync_cpi - ict_noslot_disp_held_tbegin_cpi - ict_noslot_disp_held_issq_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_disp_held_other_cpi"
     },
@@ -263,7 +263,7 @@
     },
     {
         "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
-        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
+        "MetricExpr": "ict_noslot_ic_miss_cpi - ict_noslot_ic_l3_cpi - ict_noslot_ic_l3miss_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "ict_noslot_ic_l2_cpi"
     },
@@ -286,7 +286,7 @@
         "MetricName": "ict_noslot_ic_miss_cpi"
     },
     {
-        "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
+        "MetricExpr": "ntc_issue_held_darq_full_cpi + ntc_issue_held_arb_cpi + ntc_issue_held_other_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "issue_hold_cpi"
     },
@@ -327,7 +327,7 @@
         "MetricName": "lrq_other_stall_cpi"
     },
     {
-        "MetricExpr": "(PM_CMPLU_STALL_LMQ_FULL + PM_CMPLU_STALL_ST_FWD + PM_CMPLU_STALL_LHS + PM_CMPLU_STALL_LSU_MFSPR + PM_CMPLU_STALL_LARX + PM_CMPLU_STALL_LRQ_OTHER)/PM_RUN_INST_CMPL",
+        "MetricExpr": "lmq_full_stall_cpi + st_fwd_stall_cpi + lhs_stall_cpi + lsu_mfspr_stall_cpi + larx_stall_cpi + lrq_other_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "lrq_stall_cpi"
     },
@@ -338,7 +338,7 @@
         "MetricName": "lsaq_arb_stall_cpi"
     },
     {
-        "MetricExpr": "(PM_CMPLU_STALL_LRQ_FULL + PM_CMPLU_STALL_SRQ_FULL + PM_CMPLU_STALL_LSAQ_ARB)/PM_RUN_INST_CMPL",
+        "MetricExpr": "lrq_full_stall_cpi + srq_full_stall_cpi + lsaq_arb_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "lsaq_stall_cpi"
     },
@@ -362,7 +362,7 @@
     },
     {
         "BriefDescription": "Completion LSU stall for other reasons",
-        "MetricExpr": "(PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_LSU_FIN - PM_CMPLU_STALL_STORE_FINISH - PM_CMPLU_STALL_STORE_DATA - PM_CMPLU_STALL_EIEIO - PM_CMPLU_STALL_STCX - PM_CMPLU_STALL_SLB - PM_CMPLU_STALL_TEND - PM_CMPLU_STALL_PASTE - PM_CMPLU_STALL_TLBIE - PM_CMPLU_STALL_STORE_PIPE_ARB - PM_CMPLU_STALL_STORE_FIN_ARB - PM_CMPLU_STALL_LOAD_FINISH + PM_CMPLU_STALL_DCACHE_MISS - PM_CMPLU_STALL_LMQ_FULL - PM_CMPLU_STALL_ST_FWD - PM_CMPLU_STALL_LHS - PM_CMPLU_STALL_LSU_MFSPR - PM_CMPLU_STALL_LARX - PM_CMPLU_STALL_LRQ_OTHER + PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL - PM_CMPLU_STALL_LRQ_FULL - PM_CMPLU_STALL_SRQ_FULL - PM_CMPLU_STALL_LSAQ_ARB) / PM_RUN_INST_CMPL",
+        "MetricExpr": "lsu_stall_cpi - lsu_fin_stall_cpi - store_finish_stall_cpi - srq_stall_cpi - load_finish_stall_cpi + lsu_stall_dcache_miss_cpi - lrq_stall_cpi + emq_stall_cpi - lsaq_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "lsu_other_stall_cpi"
     },
@@ -434,13 +434,13 @@
     },
     {
         "BriefDescription": "Cycles unaccounted for.",
-        "MetricExpr": "(PM_RUN_CYC - PM_1PLUS_PPC_CMPL - PM_CMPLU_STALL_THRD - PM_CMPLU_STALL - PM_ICT_NOSLOT_CYC)/PM_RUN_INST_CMPL",
+        "MetricExpr": "run_cpi - completion_cpi - thread_block_stall_cpi - stall_cpi - nothing_dispatched_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "other_cpi"
     },
     {
         "BriefDescription": "Completion stall for other reasons",
-        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
+        "MetricExpr": "stall_cpi - ntc_disp_fin_stall_cpi - ntc_flush_stall_cpi - lsu_stall_cpi - exec_unit_stall_cpi - bru_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "other_stall_cpi"
     },
@@ -469,7 +469,7 @@
         "MetricName": "run_cyc_cpi"
     },
     {
-        "MetricExpr": "(PM_CMPLU_STALL_FXU + PM_CMPLU_STALL_DP + PM_CMPLU_STALL_DFU + PM_CMPLU_STALL_PM + PM_CMPLU_STALL_CRYPTO)/PM_RUN_INST_CMPL",
+        "MetricExpr": "fxu_stall_cpi + dp_stall_cpi + dfu_stall_cpi + pm_stall_cpi + crypto_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "scalar_stall_cpi"
     },
@@ -492,7 +492,7 @@
         "MetricName": "srq_full_stall_cpi"
     },
     {
-        "MetricExpr": "(PM_CMPLU_STALL_STORE_DATA + PM_CMPLU_STALL_EIEIO + PM_CMPLU_STALL_STCX + PM_CMPLU_STALL_SLB + PM_CMPLU_STALL_TEND + PM_CMPLU_STALL_PASTE + PM_CMPLU_STALL_TLBIE + PM_CMPLU_STALL_STORE_PIPE_ARB + PM_CMPLU_STALL_STORE_FIN_ARB)/PM_RUN_INST_CMPL",
+        "MetricExpr": "store_data_stall_cpi + eieio_stall_cpi + stcx_stall_cpi + slb_stall_cpi + tend_stall_cpi + paste_stall_cpi + tlbie_stall_cpi + store_pipe_arb_stall_cpi + store_fin_arb_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "srq_stall_cpi"
     },
@@ -558,7 +558,7 @@
     },
     {
         "BriefDescription": "Vector stalls due to small latency double precision ops",
-        "MetricExpr": "(PM_CMPLU_STALL_VDP - PM_CMPLU_STALL_VDPLONG)/PM_RUN_INST_CMPL",
+        "MetricExpr": "vdp_stall_cpi - vdplong_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "vdp_other_stall_cpi"
     },
@@ -575,7 +575,7 @@
         "MetricName": "vdplong_stall_cpi"
     },
     {
-        "MetricExpr": "(PM_CMPLU_STALL_VFXU + PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
+        "MetricExpr": "vfxu_stall_cpi + vdp_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "vector_stall_cpi"
     },
@@ -587,7 +587,7 @@
     },
     {
         "BriefDescription": "Vector stalls due to small latency integer ops",
-        "MetricExpr": "(PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VFXLONG)/PM_RUN_INST_CMPL",
+        "MetricExpr": "vfxu_stall_cpi - vfxlong_stall_cpi",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "vfxu_other_stall_cpi"
     },
@@ -1844,7 +1844,7 @@
     },
     {
         "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
-        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR) * 100 / PM_RUN_INST_CMPL",
+        "MetricExpr": "dl1_reload_from_l31_mod_rate_percent + dl1_reload_from_l31_shr_rate_percent",
         "MetricName": "dl1_reload_from_l31_rate_percent"
     },
     {
@@ -1979,7 +1979,7 @@
     },
     {
         "BriefDescription": "Completion stall because a different thread was using the completion pipe",
-        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_EXCEPTION - PM_CMPLU_STALL_ANY_SYNC - PM_CMPLU_STALL_SYNC_PMU_INT - PM_CMPLU_STALL_SPEC_FINISH - PM_CMPLU_STALL_FLUSH_ANY_THREAD - PM_CMPLU_STALL_LSU_FLUSH_NEXT - PM_CMPLU_STALL_NESTED_TBEGIN - PM_CMPLU_STALL_NESTED_TEND - PM_CMPLU_STALL_MTFPSCR)/PM_RUN_INST_CMPL",
+        "MetricExpr": "thread_block_stall_cpi - exception_stall_cpi - any_sync_stall_cpi - sync_pmu_int_stall_cpi - spec_finish_stall_cpi - flush_any_thread_stall_cpi - lsu_flush_next_stall_cpi - nested_tbegin_stall_cpi - nested_tend_stall_cpi - mtfpscr_stall_cpi",
         "MetricName": "other_thread_cmpl_stall"
     },
     {

PC
