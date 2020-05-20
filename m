Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19413C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7F32075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzFh/92z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgETBoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgETBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:44:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305FC061A0E;
        Tue, 19 May 2020 18:44:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so1357178qts.9;
        Tue, 19 May 2020 18:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOQj5vKq94XNXQVKOuABQxtOp7NPJM18SEuL4BAame8=;
        b=hzFh/92zFyc52JNRYamXFlIsMLrYZrFSYK9fG0bWZKLJqSIAAN54GE+kUIbgF2ITfa
         YUXkqvfy+nbubBLvs+jZxmnYd9gqlb/iwreG5z3tbhRVV+oJIsh4Maw2oiZnjkfUXtCL
         SiVUqogT2qXJ5g0pQc+kWHundOCntqiJhHepk8JzhKJoYJfzKIqRc0XP3J27gpUch1cq
         Iuv/7/88cbO/cUsO4k8eDQqaF2Hc3onHDGpKH1RzHQ+dIFKnwaO4q9xOW7ZxMUoFUrwb
         SqxM9e1o3vUb3eZv8WAJGs4fc05PiudWTDY7szKvGdeiE1IdOETBXv1P5fguhaBBPv8c
         k8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOQj5vKq94XNXQVKOuABQxtOp7NPJM18SEuL4BAame8=;
        b=DQLLzTMYVXwckVYyanSc0NUOcNbxXIFe1Y5ZTk1Oley4YfPrehLubrFMAD9H3uC+77
         prfZuwi40PGT/xJdEInLFS1VEn4RzGuFfbJbLrVEORBSYc5GdYOGG565yG3ArPyhUup6
         im2lbQ5pexnsiUrH63CuFf4NnnwL1p6jZ2R9kZaZ6o4jl3w4QSmmrGYQSq+vhaIRszbV
         GtPLcoxW+Vm34QqPAIjdgObWw24w0LDEGvLCPYrPx53M/Lvqvpv6PZMDmq8zg2pezd5q
         UwFAq8ocCUOtlR4ZlfexCxTkEy1KY4alC7hqpO50whCDUZijGelanfGu9yMcNg3d9YR+
         L5Vw==
X-Gm-Message-State: AOAM531DCsa+s+GxK2SNxdjinUSrBB3+hCB/+B+0cgBmX41ilbCtgsL/
        zt92bpuMcvVf6Nd1MXLQWJc=
X-Google-Smtp-Source: ABdhPJzl7fr2o5PZrN9GrivYbQMpWabRdaUEFP7w/F7LxV0OTqTT1n29nSeDsp1i51otrABfeGjblA==
X-Received: by 2002:aed:3ea1:: with SMTP id n30mr2922036qtf.31.1589939045753;
        Tue, 19 May 2020 18:44:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l184sm1049748qkf.84.2020.05.19.18.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:44:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EEC9F40AFD; Tue, 19 May 2020 22:44:02 -0300 (-03)
Date:   Tue, 19 May 2020 22:44:02 -0300
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH] perf stat: POWER9 metrics: expand "ICT" acronym
Message-ID: <20200520014402.GA32678@kernel.org>
References: <1589915886-22992-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589915886-22992-1-git-send-email-pc@us.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 19, 2020 at 02:18:06PM -0500, Paul A. Clarke escreveu:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> Uses of "ICT" and "Ict" are expanded to "Instruction Completion Table".

Applied,

- Arnaldo
 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  .../arch/powerpc/power9/metrics.json          | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> index f371104dcbe3..80816d6402e9 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -208,19 +208,19 @@
>          "MetricName": "fxu_stall_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to branch mispred",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to branch mispred",
>          "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_br_mpred_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to Icache Miss and branch mispred",
>          "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
>      },
>      {
> -        "BriefDescription": "ICT other stalls",
> +        "BriefDescription": "Instruction Completion Table other stalls",
>          "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_cyc_other_cpi"
> @@ -232,13 +232,13 @@
>          "MetricName": "ict_noslot_disp_held_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
>          "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_disp_held_hb_full_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
>          "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_disp_held_issq_cpi"
> @@ -268,19 +268,19 @@
>          "MetricName": "ict_noslot_ic_l2_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to icache misses that were sourced from the local L3",
>          "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_ic_l3_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
>          "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_ic_l3miss_cpi"
>      },
>      {
> -        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> +        "BriefDescription": "Instruction Completion Table empty for this thread due to Icache Miss",
>          "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "ict_noslot_ic_miss_cpi"
> @@ -391,7 +391,7 @@
>          "MetricName": "nested_tend_stall_cpi"
>      },
>      {
> -        "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread",
> +        "BriefDescription": "Number of cycles the Instruction Completion Table has no itags assigned to this thread",
>          "MetricExpr": "PM_ICT_NOSLOT_CYC/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "nothing_dispatched_cpi"
> @@ -503,7 +503,7 @@
>          "MetricName": "st_fwd_stall_cpi"
>      },
>      {
> -        "BriefDescription": "Nothing completed and ICT not empty",
> +        "BriefDescription": "Nothing completed and Instruction Completion Table not empty",
>          "MetricExpr": "PM_CMPLU_STALL/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "stall_cpi"
> -- 
> 2.18.2
> 

-- 

- Arnaldo
