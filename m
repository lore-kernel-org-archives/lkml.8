Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B622084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvW/rLi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgG2HJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgG2HJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:09:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDA1C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:09:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l2so6136235pff.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2obqLjys8AeYSVhAJYGRsNrAjNS+DMczZ9/H7mL1HFo=;
        b=wvW/rLi3izA2Xhmlvs6bxFF2t+hckjft3bkzJuxO8hAs5k1q5smDywONrcHFowXXxi
         BkRXBVZGbAKp9KzowuitT+2FZdD7DKUHa+TYO/1MO5hCT5hKgJ+tWcdpn6QwfBWiGOll
         1+sVz8iGFQ4TYrhUCaiAv9SUWUk1Lo1HBDh1XHHCuegSu44GcD46lOyBSbbjQvkiylbY
         l6ksv4NfWTWR4j6hUX5JGViou692sRcvZup/gxwUF5ShFpzSmm2asK+7Zq5awvj2WrLL
         wSvIURVcKP2mzrNf1OI7w/GXQs5zw4GHu3cef+K8Bg42Mp7pDKSqUnzsSF76o6rwFj4H
         Osig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2obqLjys8AeYSVhAJYGRsNrAjNS+DMczZ9/H7mL1HFo=;
        b=Hy2bLR7cxt/5QyHAeZpVlyTdUa8qjEBa7dRcHGly2ix+T1gBy7p/xJ4OH1FvGQ9tAy
         17SRA5+3Xq0wVRH90kxrNgXrnhXxz8L/uoKpnBWV/vJkHucc1NTXBNmBoqUy8vma+emo
         znixf5LT32IPeLwk5CHhRkdmSe/twJ2NCEJu1p7elrGtA4TCP/ivgxPRMpUsX/Tmefno
         8vW7oy9225itwYNIfeWFPSBFbZeJkCnEeE/9K0b+2CDXemtvLVlOk0wjBJrT1lZ4G/hO
         u4axSygHkSDu1rHqKi0NUXhgm5RwlH7jdEwJ+qwg4KTZTpWlKAlSxDLhnXpkCsiQ5dhe
         669A==
X-Gm-Message-State: AOAM533z5ZK0sYjmEwTAnO3+Y9TZqdNeg22DxA/vubpcda5ap0NLbJfG
        ZCT8d9vRt02pGzvFYMV4UvwfDQ==
X-Google-Smtp-Source: ABdhPJzBA6ghqqfikYLCUBQXKEqaYTg6w2z2pyFkR+M88VMWpZUPAcv/psv5HZVaJYNg9uk9UoKXvw==
X-Received: by 2002:aa7:971d:: with SMTP id a29mr18617453pfg.308.1596006547727;
        Wed, 29 Jul 2020 00:09:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id e124sm1075048pfe.176.2020.07.29.00.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 00:09:07 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:08:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "liwei (GF)" <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20200729070855.GG4343@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
 <20200728122742.GB4343@leoy-ThinkPad-X240s>
 <c2ce17a9-bd3a-e828-fe76-769c9feabece@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ce17a9-bd3a-e828-fe76-769c9feabece@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 09:24:42PM +0800, liwei (GF) wrote:

[...]

> >> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> >> index e51ddb6d63ed..5ec7ee0c8fa1 100644
> >> --- a/drivers/perf/arm_spe_pmu.c
> >> +++ b/drivers/perf/arm_spe_pmu.c
> >> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
> >>  	struct hlist_node			hotplug_node;
> >>  
> >>  	int					irq; /* PPI */
> >> -
> >> +	int					pmuver;
> > 
> > Since the version number is only 4 bits width, 'u16' would be enough
> > to record SPE version number.
> 
> Sounds reasonable, i can change it to 'u16' if you insist.
> 
> >>  	u16					min_period;
> >>  	u16					counter_sz;
> >>  
> >> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
> >>  /* Keep track of our dynamic hotplug state */
> >>  static enum cpuhp_state arm_spe_pmu_online;
> >>  
> >> +static u64 sys_pmsevfr_el1_mask[] = {
> >> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> >> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> >> +		BIT_ULL(1),
> >> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> >> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> >> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> >> +};
> > 
> > Seems to me, the definitions for Aarch64 system registers should be
> > placed into the file 'arch/arm64/include/asm/sysreg.h'.  Like below
> > two macros:
> > 
> >   #define SYS_PMSEVFR_EL1_RES0_8_2		0x0000ffff00ff0f55UL
> >   #define SYS_PMSEVFR_EL1_RES0_8_3		...
> 
> I really think using GENMASK_ULL() to generate the mask is better than a definition
> with magic number. It is beneficial to be reviewed and extended later.

Understand.  Here I just want to remind, you could see the ARMv8's
system registers definition usually are placed into the global header
sysreg.h rather than define them in separate source files.

You could define the bit mask with GENMASK_ULL() for the two macros
in sysreg.h.

> > Let's wait for Will or Mark Rutland's comments for this, in case I
> > mislead for this.
> >> +
> >>  enum arm_spe_pmu_buf_fault_action {
> >>  	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
> >>  	SPE_PMU_BUF_FAULT_ACT_FATAL,
> >> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
> >>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> >>  		return -ENOENT;
> >>  
> >> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> >> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
> >>  		return -EOPNOTSUPP;
> >>  
> >>  	if (attr->exclude_idle)
> >> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
> >>  			fld, smp_processor_id());
> >>  		return;
> >>  	}
> >> +	spe_pmu->pmuver = fld;
> >>  
> >>  	/* Read PMBIDR first to determine whether or not we have access */
> >>  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
> >> @@ -1027,8 +1037,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
> >>  	}
> >>  
> >>  	dev_info(dev,
> >> -		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> >> -		 cpumask_pr_args(&spe_pmu->supported_cpus),
> >> +		 "v%d probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
> > 
> > Let's output explict info, like:
> > 
> >   "probed for CPUs %*pbl [pmuver %d, max_record_sz %u, align %u, features 0x%llx]\n",
> > 
> 
> Agree, and i have a little question here:
> Currently, the of_compatible of SPE PMU is "arm,statistical-profiling-extension-v1", and
> the platform_device name is "arm,spe-v1". So this message looks weird when supporting
> ARMv8.3-SPE because the pmuver is 2.

I think here we need to distinguish two things: SPE (as an IP) and
ARMv8.2/ARMv8.3 (as CPU architectures).  From my understanding, now we
are working on SPE-v1, but it needs to support ARMv8 variants, e.g.
ARMv8.2 and ARMv8.3 with SVE extension.

I am not the best person to clarify the version number for SPE, if Arm
colleagues disagree with this, very welcome to correct me.

Also loop in Al for this.

> As the version of SPE can be probed by reading 'ID_AA64DFR0_EL1.PMSVer', can we remove
> the version hint in of_compatible and platform_device name?

No, for device tree, usually we need to keep back compability for the
DT binding, so we cannot remove compatible string.

Thanks,
Leo
