Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1680C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9993F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFqMfuBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgEKP3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:29:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF6C061A0C;
        Mon, 11 May 2020 08:29:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i68so8264505qtb.5;
        Mon, 11 May 2020 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s950XzK1vBCjY1cIdcDjqAM+vBFS4b/pFLVTaRB5VgI=;
        b=GFqMfuBADt5DitWnhyjVCegMfnkM4Rq87oaGv1ZlQaA2OcrHl5LAvU50c5MCRUvvvZ
         AWhvUWeZS8Qo5hFO71RTMUXC+oA5G229A3YkVytDkUaZXMu2rbnsk1Z2B8gg5OGTeeQf
         slA76kp+ZSE0ZgBaFmn7mX7y40/fmp+V7es6CcQFcktzAUfyItft090+whbFOcF+hd6F
         CIKA98BgGVM2XDkmQD5JI2sdt69BU5HQCzpqLikX4SvKgNSsaxXhQVwWxomxqI33vI1S
         ScKC2ZyiQQFw8PfWn/4xyqi8uP5HBWXREWPUbO6EFOIf3ffsQxNopPJZvTOeq2878I2q
         OCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s950XzK1vBCjY1cIdcDjqAM+vBFS4b/pFLVTaRB5VgI=;
        b=TaZ9hc1pvQje2f13eLKudM+bfv6tVMBZRN4c0qCrjD8RGqaKeTt3WnxH3H0O8KnpkF
         ParGBVetm8xXdkY+ZczLF0dkrbqJs0q4b4bQqGlxvHmohW96PHeRWYyMOOCxrp2P9fov
         k8jRyW4sGqEc4X5TcXZyqIJjIbTXSelf9kRPWHh/4m1B0613ifLMHj1OcJPbq3At6M52
         9K6Rb2oCjZ9+4N10k0sBnxPlUh7SwsycdhzBrqWbEAtQCXr621SpzBcWAWHrpf1Did6/
         +lIl6gfE+Uxvu5lUqKoT+KpaJC/pJacrC5hkLwaoteibLMfffd+pwJsE51H+i2Y0DGDY
         /FFg==
X-Gm-Message-State: AGi0PuYOKpBkWKzVKmCUFiHA806YNxGy73S8wBQ2+psCncugVYzO7BHn
        ZLMaBSf9OOpAeqkqxJHlw8w=
X-Google-Smtp-Source: APiQypJ6S7/oku3N0cM/dX8x6bMq9kK+06my9AXCQqQKcMiRVTODm0ZANb7gniZ4kXdqHt8vjCahig==
X-Received: by 2002:ac8:66c6:: with SMTP id m6mr17292166qtp.25.1589210958294;
        Mon, 11 May 2020 08:29:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m1sm4390507qtf.72.2020.05.11.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:29:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3649B40AFD; Mon, 11 May 2020 12:29:15 -0300 (-03)
Date:   Mon, 11 May 2020 12:29:15 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     kajoljain <kjain@linux.ibm.com>, "Paul A. Clarke" <pc@us.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Message-ID: <20200511152915.GC28888@kernel.org>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com>
 <0b276c65-9c54-c6eb-0381-f56c4ccf5ec2@linux.ibm.com>
 <CAP-5=fV4-m-x6hNLvVGcBHHrL_Z67+4tM=ruxbZJpjn5V6Eqtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV4-m-x6hNLvVGcBHHrL_Z67+4tM=ruxbZJpjn5V6Eqtg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 09, 2020 at 11:26:56PM -0700, Ian Rogers escreveu:
> On Fri, May 8, 2020 at 12:05 AM kajoljain <kjain@linux.ibm.com> wrote:
> > On 5/7/20 9:58 PM, Paul A. Clarke wrote:
> > > From: "Paul A. Clarke" <pc@us.ibm.com>
> > >
> > > Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> > > - ict_noslot_br_mpred_cpi
> > > - ict_noslot_br_mpred_icmiss_cpi
> > > - ict_noslot_cyc_other_cpi
> > > - ict_noslot_disp_held_cpi
> > > - ict_noslot_disp_held_hb_full_cpi
> > > - ict_noslot_disp_held_issq_cpi
> > > - ict_noslot_disp_held_other_cpi
> > > - ict_noslot_disp_held_sync_cpi
> > > - ict_noslot_disp_held_tbegin_cpi
> > > - ict_noslot_ic_l2_cpi
> > > - ict_noslot_ic_l3_cpi
> > > - ict_noslot_ic_l3miss_cpi
> > > - ict_noslot_ic_miss_cpi
> > >
> > > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> >
> > Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> 
> Tested with:
> https://lore.kernel.org/lkml/20200508053629.210324-3-irogers@google.com/
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, looking up that series now,

- Arnaldo
 
> Thanks,
> Ian
> 
> > Thanks,
> > Kajol Jain
> > > ---
> > >  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
> > >  1 file changed, 78 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > > index 811c2a8c1c9e..6169351a72c8 100644
> > > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > > @@ -207,6 +207,84 @@
> > >          "MetricGroup": "cpi_breakdown",
> > >          "MetricName": "fxu_stall_cpi"
> > >      },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_br_mpred_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "ICT other stalls",
> > > +        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_cyc_other_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_issq_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > > +        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_other_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_sync_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > > +        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_l2_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_l3_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_l3miss_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_miss_cpi"
> > > +    },
> > >      {
> > >          "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
> > >          "MetricGroup": "cpi_breakdown",
> > > @@ -1819,71 +1897,6 @@
> > >          "MetricExpr": "PM_FXU_IDLE / PM_CYC",
> > >          "MetricName": "fxu_all_idle"
> > >      },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to branch mispred",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_br_mpred_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "ICT other stalls",
> > > -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_cyc_other_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_issq_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > > -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_other_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_sync_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > > -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_l2_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_l3_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_l3miss_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_miss_cpi"
> > > -    },
> > >      {
> > >          "BriefDescription": "Rate of IERAT reloads from L2",
> > >          "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
> > >

-- 

- Arnaldo
