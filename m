Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B76F20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7d4up3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgHNDnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:43:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C97AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:43:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so6337990wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xEL5rhd2kaNnHx7qKYLgF7/FwWBxVNNFsKbluOZYXqQ=;
        b=Z7d4up3ngGbOFYcF2bf8ZR1FBvi12ZHh3kIKAPPVcJh+eK9cLaVi7cSXwrRjn2Vgwd
         jnHrrGlC2Bkshpq81dUEfy0VK8vb+7gUYqaPdYofeffGCGbKRPynqonLA5aySO9PFeMn
         +t39e8gzfSVgwdwYdgqBROuf4Nn6YCz0IDkQNmnnevfcGJrFvv+/9zT7n2IEJstQfwSx
         Q0DJ7dIQ3J6ELVDLQ7HCug9HlMsDLG7aGI96YUDR6vl2IDzRgpUAC1W52xZoZo68QzBB
         6HUdCiJEMGEqqGTFlQI7VLgOAEZ6JzByMmUX40SuZYM6a5eIuR9XeNiwxfKlrMyps5vo
         08xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEL5rhd2kaNnHx7qKYLgF7/FwWBxVNNFsKbluOZYXqQ=;
        b=EZh9x3A/j/tDMUfr47IMw6PL9ksGRFJdkFqjJrRNuFjdHhjG2ZXflANQWa5eaIblyh
         6vM7IY8YiVdz+ryV6qnPrsnC/+LWtiAPGse4er8B18iSdtebMxxCFKd3fS7F+qHhXsFR
         CZW2LpO6LeepPytDrOvoJ+C/Bcw7PYLLJaLD9K4aJpNmMsHR1AhdtKdItOtgoGFd0rnk
         VynyRLRpTowqo2dhs0eiRoNrXcQsxAeGCE/H8Ioblet9NieGuaf3um7mMRZGAtWmB7Ud
         fAJOcVemaVz9W9TNQqh04RBLGByFLQ+oBhnKA2geoDISdzH9XzJKafxnJuiicRZXKImz
         9tmQ==
X-Gm-Message-State: AOAM531QXp0VdUwgYbc/bHDdyACaPGDuO9SrB26RQ4UMmP5Qmw1K0aM/
        bY0oJM2ano+ZXd/AbBS+BG3Vbd/1eMgBNEoLd+a6Ag==
X-Google-Smtp-Source: ABdhPJzOih8hB0mu7CbFS6KmBIRCwABwYi+38EbMMmRh8QSM9pMsycmtZJMcEqbCzM1SrZ/qZT8PQozr1SXuqOcg/g8=
X-Received: by 2002:a7b:cf0c:: with SMTP id l12mr597187wmg.77.1597376628929;
 Thu, 13 Aug 2020 20:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222155.268183-1-pc@us.ibm.com>
In-Reply-To: <20200813222155.268183-1-pc@us.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Aug 2020 20:43:37 -0700
Message-ID: <CAP-5=fU4P7o1TwVz+PzcrJsBKnrHW4yrNx3R165i9d3BwgP2RQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: update POWER9 metrics to utilize other metrics
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, kajoljain <kjain@linux.ibm.com>,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 3:21 PM Paul A. Clarke <pc@us.ibm.com> wrote:
>
> These changes take advantage of the new capability added in
> merge commit 00e4db51259a5f936fec1424b884f029479d3981
> "Allow using computed metrics in calculating other metrics".
>
> The net is a simplification of the expressions for a handful
> of metrics, but no functional change.
>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>
(Re-sent with plain text enabled to avoid lkml bounce)

Thanks,
Ian


>
> ---
>  .../arch/powerpc/power9/metrics.json          | 48 +++++++++----------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/too=
ls/perf/pmu-events/arch/powerpc/power9/metrics.json
> index 80816d6402e9..f8784c608479 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -60,7 +60,7 @@
>      },
>      {
>          "BriefDescription": "Stalls due to short latency decimal floatin=
g ops.",
> -        "MetricExpr": "(PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_DFLONG)/PM_R=
UN_INST_CMPL",
> +        "MetricExpr": "dfu_stall_cpi - dflong_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "dfu_other_stall_cpi"
>      },
> @@ -72,7 +72,7 @@
>      },
>      {
>          "BriefDescription": "Completion stall by Dcache miss which resol=
ved off node memory/cache",
> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMI=
SS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_REMOTE)/PM_RU=
N_INST_CMPL",
> +        "MetricExpr": "dmiss_non_local_stall_cpi - dmiss_remote_stall_cp=
i",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "dmiss_distant_stall_cpi"
>      },
> @@ -90,7 +90,7 @@
>      },
>      {
>          "BriefDescription": "Completion stall due to cache miss that res=
olves in the L2 or L3 without conflict",
> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_DMISS=
_L2L3_CONFLICT)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "dmiss_l2l3_stall_cpi - dmiss_l2l3_conflict_stall_=
cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "dmiss_l2l3_noconflict_stall_cpi"
>      },
> @@ -114,7 +114,7 @@
>      },
>      {
>          "BriefDescription": "Completion stall by Dcache miss which resol=
ved outside of local memory",
> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMI=
SS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "dmiss_l3miss_stall_cpi - dmiss_l21_l31_stall_cpi =
- dmiss_lmem_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "dmiss_non_local_stall_cpi"
>      },
> @@ -126,7 +126,7 @@
>      },
>      {
>          "BriefDescription": "Stalls due to short latency double precisio=
n ops.",
> -        "MetricExpr": "(PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DPLONG)/PM_RU=
N_INST_CMPL",
> +        "MetricExpr": "dp_stall_cpi - dplong_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "dp_other_stall_cpi"
>      },
> @@ -155,7 +155,7 @@
>          "MetricName": "emq_full_stall_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FU=
LL)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "erat_miss_stall_cpi + emq_full_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "emq_stall_cpi"
>      },
> @@ -173,7 +173,7 @@
>      },
>      {
>          "BriefDescription": "Completion stall due to execution units for=
 other reasons.",
> -        "MetricExpr": "(PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_FXU - =
PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_PM - PM_CMPLU_STALL=
_CRYPTO - PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "exec_unit_stall_cpi - scalar_stall_cpi - vector_s=
tall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "exec_unit_other_stall_cpi"
>      },
> @@ -197,7 +197,7 @@
>      },
>      {
>          "BriefDescription": "Stalls due to short latency integer ops",
> -        "MetricExpr": "(PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_FXLONG)/PM_R=
UN_INST_CMPL",
> +        "MetricExpr": "fxu_stall_cpi - fxlong_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "fxu_other_stall_cpi"
>      },
> @@ -221,7 +221,7 @@
>      },
>      {
>          "BriefDescription": "Instruction Completion Table other stalls",
> -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_I=
CT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HEL=
D)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "nothing_dispatched_cpi - ict_noslot_ic_miss_cpi -=
 ict_noslot_br_mpred_icmiss_cpi - ict_noslot_br_mpred_cpi - ict_noslot_disp=
_held_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_cyc_other_cpi"
>      },
> @@ -245,7 +245,7 @@
>      },
>      {
>          "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HEL=
D_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN -=
 PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "ict_noslot_disp_held_cpi - ict_noslot_disp_held_h=
b_full_cpi - ict_noslot_disp_held_sync_cpi - ict_noslot_disp_held_tbegin_cp=
i - ict_noslot_disp_held_issq_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_disp_held_other_cpi"
>      },
> @@ -263,7 +263,7 @@
>      },
>      {
>          "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM=
_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "ict_noslot_ic_miss_cpi - ict_noslot_ic_l3_cpi - i=
ct_noslot_ic_l3miss_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_ic_l2_cpi"
>      },
> @@ -286,7 +286,7 @@
>          "MetricName": "ict_noslot_ic_miss_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_=
ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "ntc_issue_held_darq_full_cpi + ntc_issue_held_arb=
_cpi + ntc_issue_held_other_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "issue_hold_cpi"
>      },
> @@ -327,7 +327,7 @@
>          "MetricName": "lrq_other_stall_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_CMPLU_STALL_LMQ_FULL + PM_CMPLU_STALL_ST_FWD =
+ PM_CMPLU_STALL_LHS + PM_CMPLU_STALL_LSU_MFSPR + PM_CMPLU_STALL_LARX + PM_=
CMPLU_STALL_LRQ_OTHER)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "lmq_full_stall_cpi + st_fwd_stall_cpi + lhs_stall=
_cpi + lsu_mfspr_stall_cpi + larx_stall_cpi + lrq_other_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "lrq_stall_cpi"
>      },
> @@ -338,7 +338,7 @@
>          "MetricName": "lsaq_arb_stall_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_CMPLU_STALL_LRQ_FULL + PM_CMPLU_STALL_SRQ_FUL=
L + PM_CMPLU_STALL_LSAQ_ARB)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "lrq_full_stall_cpi + srq_full_stall_cpi + lsaq_ar=
b_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "lsaq_stall_cpi"
>      },
> @@ -362,7 +362,7 @@
>      },
>      {
>          "BriefDescription": "Completion LSU stall for other reasons",
> -        "MetricExpr": "(PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_LSU_FIN - PM=
_CMPLU_STALL_STORE_FINISH - PM_CMPLU_STALL_STORE_DATA - PM_CMPLU_STALL_EIEI=
O - PM_CMPLU_STALL_STCX - PM_CMPLU_STALL_SLB - PM_CMPLU_STALL_TEND - PM_CMP=
LU_STALL_PASTE - PM_CMPLU_STALL_TLBIE - PM_CMPLU_STALL_STORE_PIPE_ARB - PM_=
CMPLU_STALL_STORE_FIN_ARB - PM_CMPLU_STALL_LOAD_FINISH + PM_CMPLU_STALL_DCA=
CHE_MISS - PM_CMPLU_STALL_LMQ_FULL - PM_CMPLU_STALL_ST_FWD - PM_CMPLU_STALL=
_LHS - PM_CMPLU_STALL_LSU_MFSPR - PM_CMPLU_STALL_LARX - PM_CMPLU_STALL_LRQ_=
OTHER + PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL - PM_CMPLU_STALL=
_LRQ_FULL - PM_CMPLU_STALL_SRQ_FULL - PM_CMPLU_STALL_LSAQ_ARB) / PM_RUN_INS=
T_CMPL",
> +        "MetricExpr": "lsu_stall_cpi - lsu_fin_stall_cpi - store_finish_=
stall_cpi - srq_stall_cpi - load_finish_stall_cpi + lsu_stall_dcache_miss_c=
pi - lrq_stall_cpi + emq_stall_cpi - lsaq_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "lsu_other_stall_cpi"
>      },
> @@ -434,13 +434,13 @@
>      },
>      {
>          "BriefDescription": "Cycles unaccounted for.",
> -        "MetricExpr": "(PM_RUN_CYC - PM_1PLUS_PPC_CMPL - PM_CMPLU_STALL_=
THRD - PM_CMPLU_STALL - PM_ICT_NOSLOT_CYC)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "run_cpi - completion_cpi - thread_block_stall_cpi=
 - stall_cpi - nothing_dispatched_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "other_cpi"
>      },
>      {
>          "BriefDescription": "Completion stall for other reasons",
> -        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - P=
M_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - P=
M_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "stall_cpi - ntc_disp_fin_stall_cpi - ntc_flush_st=
all_cpi - lsu_stall_cpi - exec_unit_stall_cpi - bru_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "other_stall_cpi"
>      },
> @@ -469,7 +469,7 @@
>          "MetricName": "run_cyc_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_CMPLU_STALL_FXU + PM_CMPLU_STALL_DP + PM_CMPL=
U_STALL_DFU + PM_CMPLU_STALL_PM + PM_CMPLU_STALL_CRYPTO)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "fxu_stall_cpi + dp_stall_cpi + dfu_stall_cpi + pm=
_stall_cpi + crypto_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "scalar_stall_cpi"
>      },
> @@ -492,7 +492,7 @@
>          "MetricName": "srq_full_stall_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_CMPLU_STALL_STORE_DATA + PM_CMPLU_STALL_EIEIO=
 + PM_CMPLU_STALL_STCX + PM_CMPLU_STALL_SLB + PM_CMPLU_STALL_TEND + PM_CMPL=
U_STALL_PASTE + PM_CMPLU_STALL_TLBIE + PM_CMPLU_STALL_STORE_PIPE_ARB + PM_C=
MPLU_STALL_STORE_FIN_ARB)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "store_data_stall_cpi + eieio_stall_cpi + stcx_sta=
ll_cpi + slb_stall_cpi + tend_stall_cpi + paste_stall_cpi + tlbie_stall_cpi=
 + store_pipe_arb_stall_cpi + store_fin_arb_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "srq_stall_cpi"
>      },
> @@ -558,7 +558,7 @@
>      },
>      {
>          "BriefDescription": "Vector stalls due to small latency double p=
recision ops",
> -        "MetricExpr": "(PM_CMPLU_STALL_VDP - PM_CMPLU_STALL_VDPLONG)/PM_=
RUN_INST_CMPL",
> +        "MetricExpr": "vdp_stall_cpi - vdplong_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "vdp_other_stall_cpi"
>      },
> @@ -575,7 +575,7 @@
>          "MetricName": "vdplong_stall_cpi"
>      },
>      {
> -        "MetricExpr": "(PM_CMPLU_STALL_VFXU + PM_CMPLU_STALL_VDP)/PM_RUN=
_INST_CMPL",
> +        "MetricExpr": "vfxu_stall_cpi + vdp_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "vector_stall_cpi"
>      },
> @@ -587,7 +587,7 @@
>      },
>      {
>          "BriefDescription": "Vector stalls due to small latency integer =
ops",
> -        "MetricExpr": "(PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VFXLONG)/PM=
_RUN_INST_CMPL",
> +        "MetricExpr": "vfxu_stall_cpi - vfxlong_stall_cpi",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "vfxu_other_stall_cpi"
>      },
> @@ -1844,7 +1844,7 @@
>      },
>      {
>          "BriefDescription": "% of DL1 reloads from Private L3, other cor=
e per Inst",
> -        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR) * 1=
00 / PM_RUN_INST_CMPL",
> +        "MetricExpr": "dl1_reload_from_l31_mod_rate_percent + dl1_reload=
_from_l31_shr_rate_percent",
>          "MetricName": "dl1_reload_from_l31_rate_percent"
>      },
>      {
> @@ -1979,7 +1979,7 @@
>      },
>      {
>          "BriefDescription": "Completion stall because a different thread=
 was using the completion pipe",
> -        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_EXCEPTION -=
 PM_CMPLU_STALL_ANY_SYNC - PM_CMPLU_STALL_SYNC_PMU_INT - PM_CMPLU_STALL_SPE=
C_FINISH - PM_CMPLU_STALL_FLUSH_ANY_THREAD - PM_CMPLU_STALL_LSU_FLUSH_NEXT =
- PM_CMPLU_STALL_NESTED_TBEGIN - PM_CMPLU_STALL_NESTED_TEND - PM_CMPLU_STAL=
L_MTFPSCR)/PM_RUN_INST_CMPL",
> +        "MetricExpr": "thread_block_stall_cpi - exception_stall_cpi - an=
y_sync_stall_cpi - sync_pmu_int_stall_cpi - spec_finish_stall_cpi - flush_a=
ny_thread_stall_cpi - lsu_flush_next_stall_cpi - nested_tbegin_stall_cpi - =
nested_tend_stall_cpi - mtfpscr_stall_cpi",
>          "MetricName": "other_thread_cmpl_stall"
>      },
>      {
> --
> 2.18.4
>
