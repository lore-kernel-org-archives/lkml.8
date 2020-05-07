Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736EAC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C08208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2k+rCyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEGQ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:57:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF483C05BD43;
        Thu,  7 May 2020 09:57:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c10so1403673qka.4;
        Thu, 07 May 2020 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tUJajxIGVv5jxgVRXN117q77ZGYl7n4txNiJb/e5Gcg=;
        b=B2k+rCyCQRH+Yldaq+by6w6MXj9LORTXLhJjaKfBUPYCBkEzZqetrNBMybHdw3EpKr
         VBv8gtU7z58IibBjDgB5k4CYrV9vkqoHqf7abG91Tenu6AgoYvTgG6V7Uxjub7WkW+ZA
         Axsrot89rAi0v+bxwnrwbrMCNWTZwx4L6OVfitJW20xPTje6UQRiXiMhxEf/zKKAPfLx
         Te0h/a1n7vpvlnKrvb12oLxrbuYAdX4V7wUb9UdOEYal6lwTge8PlfI+9xUDvOh/fOpr
         BRykDp4qRTdzecqvZaBq+mDQWeVvDFiD3ktj3RGOzq5NjIqsWjLsaVIS617Qyl+dYYSF
         ehJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tUJajxIGVv5jxgVRXN117q77ZGYl7n4txNiJb/e5Gcg=;
        b=ZickS1BVSrRB+P8mo+1EFqUHxQpkydWWHgfbrS5Cz3aUmyBLR/ZxNed7T5L3L9GBt0
         c58rDC+c9BYLuTZO5qGJKjfA1E3wyVU/O4uaZmkO6p81/sEI36GrKqa2lA7+oNzza/D1
         IX3ULW4ieWJ7hrBHuEgBMSJf6F3/NjjtJWyeuJtQGz+QLvPTDVUawpsvBLc9uXDsRcIh
         drkDrfh0yQkCMaLzhXmTHvMghjalEOWn45jWr6cjvrD7ONmV9fBAHe4y33oityv1X746
         vk62enuKyE7Cmr7j2E/Cwj0t2KOG5i+6ZFjyXTzYM8KnR6SeG5aYW4R+0uvFAqsKuswo
         yVpw==
X-Gm-Message-State: AGi0PuZyoZfghvirDJbR1QL/8AvqeB8zlNa1ofT1X+LbDyunpmn3f2jz
        FG0+b71u4wj3RXgkGXzdQYA=
X-Google-Smtp-Source: APiQypL0yWoyhvi6A6v+6Jc33hrgrB+z1H8fItJVn1kQRtN9xb4FAaRceHNeHyXE3CsNSyh5ULq8cA==
X-Received: by 2002:a37:96c4:: with SMTP id y187mr15758005qkd.126.1588870664992;
        Thu, 07 May 2020 09:57:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id b11sm4448187qti.50.2020.05.07.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:57:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA60E40AFD; Thu,  7 May 2020 13:57:40 -0300 (-03)
Date:   Thu, 7 May 2020 13:57:40 -0300
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au, irogers@google.com
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Message-ID: <20200507165740.GF31109@kernel.org>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588868938-21933-3-git-send-email-pc@us.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 11:28:58AM -0500, Paul A. Clarke escreveu:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> - ict_noslot_br_mpred_cpi
> - ict_noslot_br_mpred_icmiss_cpi
> - ict_noslot_cyc_other_cpi
> - ict_noslot_disp_held_cpi
> - ict_noslot_disp_held_hb_full_cpi
> - ict_noslot_disp_held_issq_cpi
> - ict_noslot_disp_held_other_cpi
> - ict_noslot_disp_held_sync_cpi
> - ict_noslot_disp_held_tbegin_cpi
> - ict_noslot_ic_l2_cpi
> - ict_noslot_ic_l3_cpi
> - ict_noslot_ic_l3miss_cpi
> - ict_noslot_ic_miss_cpi

Can folks provide Acked-by or Reviewed-by? Thanks,

- Arnaldo
 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
>  1 file changed, 78 insertions(+), 65 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> index 811c2a8c1c9e..6169351a72c8 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -207,6 +207,84 @@
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "fxu_stall_cpi"
>      },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_br_mpred_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> +    },
> +    {
> +        "BriefDescription": "ICT other stalls",
> +        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_cyc_other_cpi"
> +    },
> +    {
> +        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_issq_cpi"
> +    },
> +    {
> +        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> +        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_other_cpi"
> +    },
> +    {
> +        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_sync_cpi"
> +    },
> +    {
> +        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> +    },
> +    {
> +        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> +        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_l2_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_l3_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_l3miss_cpi"
> +    },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> +        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> +        "MetricGroup": "cpi_breakdown",
> +        "MetricName": "ict_noslot_ic_miss_cpi"
> +    },
>      {
>          "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
>          "MetricGroup": "cpi_breakdown",
> @@ -1819,71 +1897,6 @@
>          "MetricExpr": "PM_FXU_IDLE / PM_CYC",
>          "MetricName": "fxu_all_idle"
>      },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to branch mispred",
> -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_br_mpred_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> -    },
> -    {
> -        "BriefDescription": "ICT other stalls",
> -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_cyc_other_cpi"
> -    },
> -    {
> -        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_issq_cpi"
> -    },
> -    {
> -        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_other_cpi"
> -    },
> -    {
> -        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_sync_cpi"
> -    },
> -    {
> -        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> -    },
> -    {
> -        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_l2_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_l3_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_l3miss_cpi"
> -    },
> -    {
> -        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> -        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> -        "MetricName": "ict_noslot_ic_miss_cpi"
> -    },
>      {
>          "BriefDescription": "Rate of IERAT reloads from L2",
>          "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
> -- 
> 2.18.2
> 

-- 

- Arnaldo
