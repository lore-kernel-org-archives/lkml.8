Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A51C35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 06:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4B72082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 06:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTimFOTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEJG1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbgEJG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 02:27:09 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5EC061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 23:27:09 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id d197so3346512ybh.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlF/34CgxoBxoJLVP8twBsmj16m/IsBbnycut7Kq4CI=;
        b=iTimFOTZMp0DwG2n0e7JIG0yIqdpxGyIX8QZlEgqUrwzh24uDspNqwPJIm2DOkq0fq
         3N5cOc1okdFXlsmA13pxsr2s/6o0aSp9qZiYLk9qZvEhBlqCnrZFTRBsEHTtQRg3Dl3U
         U2vxEBloNQcx3Ji3oEpaIdjHoDY5ezY8rO5TXc9L5w2gzcewe5RHw5e0OmVIlquR7oYK
         Mqx3JdYzMrY820GM71uXm2XXl6LYOasVfjQ/iWxXVMzecX2YbKk9fsuda8mZgA71nNeq
         tQOjE2yooVYlCuzNks4+J07RjlWsnLkU4h84xUxdlNbPXT6N64Zm6ad8lYzXFXkLR7Bh
         Maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlF/34CgxoBxoJLVP8twBsmj16m/IsBbnycut7Kq4CI=;
        b=G8Qenxfrdl62ASSsXK6MccIRtkiX3TZCFa7O52bG2dxrAyY+y/L/jhsUTZm7/AJuX0
         +LZC70/Y9lVREpDCYtzVf0Y/bl4xci/+X9GcbS/TduaqOk6bafnrvGSP2KYlMAnOuj0u
         0M0dlKak1mN8tV7bVfGb03FdM1L9AY8pJnd1fRaaFzgD39BnfGIPUZDe6ZQ5n5skDRqY
         BnFfQW4CMT2aCOgTnf7Fqp18DoQMlNChM8J+dwRyclCqgTmTHpQ2tNV1i8xk0iRsMFFf
         QNDZaT+8recgUgg9GfcS53Byr7NtH4LyPoO1Mwzs9MknjZ20PkfQ3M0JJLuZHHq6mzUG
         0BVg==
X-Gm-Message-State: AGi0PuZXx4pxSRFIqlv0HPIxP2Ip2kWbsU3Tz4xh8nJBVnGBbzZqysXZ
        t+FgortvaiQCnMCCmkNMh48Wt5CPkaiApuxNs2Wo/Q==
X-Google-Smtp-Source: APiQypJmuJSsn9qvIYa6JYZa84ajJNkvV/KNU7dU3JOF+ZlFrbgOobS75gYWVoCxO0XISFM5rrVDVcp1TaRoeujqzag=
X-Received: by 2002:a25:d688:: with SMTP id n130mr16019697ybg.324.1589092027262;
 Sat, 09 May 2020 23:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com> <0b276c65-9c54-c6eb-0381-f56c4ccf5ec2@linux.ibm.com>
In-Reply-To: <0b276c65-9c54-c6eb-0381-f56c4ccf5ec2@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 9 May 2020 23:26:56 -0700
Message-ID: <CAP-5=fV4-m-x6hNLvVGcBHHrL_Z67+4tM=ruxbZJpjn5V6Eqtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
To:     kajoljain <kjain@linux.ibm.com>
Cc:     "Paul A. Clarke" <pc@us.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 12:05 AM kajoljain <kjain@linux.ibm.com> wrote:
> On 5/7/20 9:58 PM, Paul A. Clarke wrote:
> > From: "Paul A. Clarke" <pc@us.ibm.com>
> >
> > Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> > - ict_noslot_br_mpred_cpi
> > - ict_noslot_br_mpred_icmiss_cpi
> > - ict_noslot_cyc_other_cpi
> > - ict_noslot_disp_held_cpi
> > - ict_noslot_disp_held_hb_full_cpi
> > - ict_noslot_disp_held_issq_cpi
> > - ict_noslot_disp_held_other_cpi
> > - ict_noslot_disp_held_sync_cpi
> > - ict_noslot_disp_held_tbegin_cpi
> > - ict_noslot_ic_l2_cpi
> > - ict_noslot_ic_l3_cpi
> > - ict_noslot_ic_l3miss_cpi
> > - ict_noslot_ic_miss_cpi
> >
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

Tested with:
https://lore.kernel.org/lkml/20200508053629.210324-3-irogers@google.com/
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Kajol Jain
> > ---
> >  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
> >  1 file changed, 78 insertions(+), 65 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > index 811c2a8c1c9e..6169351a72c8 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > @@ -207,6 +207,84 @@
> >          "MetricGroup": "cpi_breakdown",
> >          "MetricName": "fxu_stall_cpi"
> >      },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> > +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_br_mpred_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> > +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "ICT other stalls",
> > +        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_cyc_other_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_disp_held_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_disp_held_issq_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > +        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_disp_held_other_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_disp_held_sync_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > +        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_ic_l2_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> > +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_ic_l3_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> > +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_ic_l3miss_cpi"
> > +    },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> > +        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> > +        "MetricGroup": "cpi_breakdown",
> > +        "MetricName": "ict_noslot_ic_miss_cpi"
> > +    },
> >      {
> >          "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
> >          "MetricGroup": "cpi_breakdown",
> > @@ -1819,71 +1897,6 @@
> >          "MetricExpr": "PM_FXU_IDLE / PM_CYC",
> >          "MetricName": "fxu_all_idle"
> >      },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to branch mispred",
> > -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_br_mpred_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> > -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "ICT other stalls",
> > -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_cyc_other_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_disp_held_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_disp_held_issq_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_disp_held_other_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_disp_held_sync_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_ic_l2_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> > -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_ic_l3_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> > -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_ic_l3miss_cpi"
> > -    },
> > -    {
> > -        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> > -        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> > -        "MetricName": "ict_noslot_ic_miss_cpi"
> > -    },
> >      {
> >          "BriefDescription": "Rate of IERAT reloads from L2",
> >          "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
> >
