Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2A82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhKz4wKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgG1M1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1M1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:27:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DA0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:27:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so2668234pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+TEGIPXgZrrcbsx1XNFhg6MOu1dRHr4d7tkCewZWDk=;
        b=rhKz4wKx/8lsr6mEaErf+ONcyzFHjW9RMLVQsP8hyw8vOmj1xKC0rBKIQ6fy5pVmB+
         JOXdWnSUYy2CyomYUPche2OM09/eH0f/pGn0GpzI1r7KmCxDTz9+3luGIRm8kQSsqSkF
         MQleJUlHtxhUluC7GAazF3ATEpBgtaF9ubI+EQEAjb3ZIUuAXsLV3Bq1d/67+zt73/s2
         haVPtF7EF9PbcPzSKDM1b76nRivkoRR++ibLoMtqMhfeV8vHkdAVdi//6PKk7CSvau+A
         t4UTW7IpLRK2aJE+Flwz2zZ2gEVdSsK73tD2Lo9yy7k+dkEQqAl9gYeZsbBx0Dx0n9gW
         G80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+TEGIPXgZrrcbsx1XNFhg6MOu1dRHr4d7tkCewZWDk=;
        b=H4hEPaQCRZw23DdnKf/+1GaEerRV7njwm/PA0UNuO5w4Q/itkEVOslYOPhNrUdcLEj
         tjk1qspanYj5sqQd4K8bYNnjQw7OL/XR0jsrns2fUIZBJK8JGKvyH7wcaS1pCbXZ4DAj
         CmzXUmGU9j2HjWnnjcyWoUSfJockv0BfI4SLkiordMbQ+AT9eZ+j5Rq5AO7b/intslKQ
         uPatAfORkaCvWk+gj/v2mzKzFA/azw9NDYCqy3OMXlayKUUxQlDjYQeYE6fR17yd4Ptg
         uYSKTsp3iLV9fE2G1WnXzrEV3BjzDW0w2ijIC31qSlSDhBe+Im3KBQmN5qoRRLI5tPLA
         Pb0Q==
X-Gm-Message-State: AOAM532A0K5kO8yGHMI+Vgn1Hivx0D3WlztUYZjVTkreoX03FxGnrUjn
        nCW58mi5fnGlRULBmEqhtxYQ4g==
X-Google-Smtp-Source: ABdhPJyQxAlZ5+xrrP00MP0fRlb7O2Jy/vq7y2qOWfq/8x/bFz65cPxc71oG73GFgBjrIR807pGUyQ==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr221618plr.116.1595939270932;
        Tue, 28 Jul 2020 05:27:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id h23sm18602677pfo.166.2020.07.28.05.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 05:27:50 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:27:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20200728122742.GB4343@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091607.41903-2-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Fri, Jul 24, 2020 at 05:16:04PM +0800, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>   using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>   packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>   and filtering on these events using PMSEVFR_EL1.
> 
> Update the check of pmsevfr for empty/partial predicated SVE and
> alignment event in kernel driver.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/include/asm/sysreg.h |  4 +++-
>  drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 463175f80341..be4c44ccdb56 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -281,7 +281,6 @@
>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>  
>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
>  
>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> @@ -769,6 +768,9 @@
>  #define ID_AA64DFR0_PMUVER_8_5		0x6
>  #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>  
> +#define ID_AA64DFR0_PMSVER_8_2		0x1
> +#define ID_AA64DFR0_PMSVER_8_3		0x2
> +
>  #define ID_DFR0_PERFMON_SHIFT		24
>  
>  #define ID_DFR0_PERFMON_8_1		0x4
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index e51ddb6d63ed..5ec7ee0c8fa1 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>  	struct hlist_node			hotplug_node;
>  
>  	int					irq; /* PPI */
> -
> +	int					pmuver;

Since the version number is only 4 bits width, 'u16' would be enough
to record SPE version number.

>  	u16					min_period;
>  	u16					counter_sz;
>  
> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>  /* Keep track of our dynamic hotplug state */
>  static enum cpuhp_state arm_spe_pmu_online;
>  
> +static u64 sys_pmsevfr_el1_mask[] = {
> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> +		BIT_ULL(1),
> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> +};

Seems to me, the definitions for Aarch64 system registers should be
placed into the file 'arch/arm64/include/asm/sysreg.h'.  Like below
two macros:

  #define SYS_PMSEVFR_EL1_RES0_8_2		0x0000ffff00ff0f55UL
  #define SYS_PMSEVFR_EL1_RES0_8_3		...

Let's wait for Will or Mark Rutland's comments for this, in case I
mislead for this.

> +
>  enum arm_spe_pmu_buf_fault_action {
>  	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
>  	SPE_PMU_BUF_FAULT_ACT_FATAL,
> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>  		return -ENOENT;
>  
> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
>  		return -EOPNOTSUPP;
>  
>  	if (attr->exclude_idle)
> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  			fld, smp_processor_id());
>  		return;
>  	}
> +	spe_pmu->pmuver = fld;
>  
>  	/* Read PMBIDR first to determine whether or not we have access */
>  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
> @@ -1027,8 +1037,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  	}
>  
>  	dev_info(dev,
> -		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> -		 cpumask_pr_args(&spe_pmu->supported_cpus),
> +		 "v%d probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",

Let's output explict info, like:

  "probed for CPUs %*pbl [pmuver %d, max_record_sz %u, align %u, features 0x%llx]\n",

Thanks,
Leo

> +		 spe_pmu->pmuver, cpumask_pr_args(&spe_pmu->supported_cpus),
>  		 spe_pmu->max_record_sz, spe_pmu->align, spe_pmu->features);
>  
>  	spe_pmu->features |= SPE_PMU_FEAT_DEV_PROBED;
> -- 
> 2.17.1
> 
