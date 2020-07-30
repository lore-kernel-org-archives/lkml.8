Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5012074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkPGCUwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgG3IPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgG3IPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:15:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124FC0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:15:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so3852606plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXhXeo5DT1U4Mt7azhGbDpi+m3oo8FBug52jhLI9T/o=;
        b=OkPGCUwmUqX8FuvZxnbEvgYbW8LlF8sM3jn2O9ieDgq3t4eSMY/R3u4jQpbNBl2h11
         K0+Kp29VvXNSXMVGCgm0sbyE5p4l6v164CYgSNdt7GhkAnlsBlD+tQiZQtm43SontwOZ
         xCs6ZJSAmLytEBrHsXM8DQSTvkgkFG9jL7CJI91cKRNtLsQsZgmop1rmZ6ABvCxVtcNL
         RlaP44nEGAE3g4F4KJC54bf04cYYzi6YDPMl7M8xeob88m/Ywfb2uSbUtQrisOxgDQBH
         YtGvN5TTSLwwLnYRwLNaE6O7wMlQY0SQtAVVIoJZgr3RALbO3fCjB03pVuIyfsKxwytD
         vdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXhXeo5DT1U4Mt7azhGbDpi+m3oo8FBug52jhLI9T/o=;
        b=Z54sGcmNp6L66FteSSSff3FnXQVH+ESdw7ilBOJl8CagOaoVoobTNfdmU3iATsBBmQ
         88fHHq0PNAnsUzIJyrITnLTNtP7hWA6itUTBC5ttTiaI5PTiWHBP567MnJsNuCdejwKa
         pLPHZRu7HKZOcwTp09LlAxYB9B6rQrHdnRWJVuUIOYlbfNxFWIOdJ4n6Tti+DBD9ykcP
         WGbnPXUNhXUqZJ76vNyfOtdaF/ijXCzyiYa25ftg/v0xsmt/kfuyP9YY6JKuUx8ufdr0
         /DOqVT8lTQ5RYYPcrq9TPkpbPzV+XeYnFUBEbB0R9eMma2gULJWa8hy08T/qrqgiAav5
         oL2g==
X-Gm-Message-State: AOAM5323r+SFd15hB4c0TIb6/lCFQ8nZ2CKMvGs9NwS8DRPFG177IdDp
        X6Gq3IzQvgMfR2s3C+6cg9UJ+w==
X-Google-Smtp-Source: ABdhPJzvRbByC4r7/CwXCqsFv2AWWEnUIRHeKi3zrgYZ+m2mp1ViqbxECOu3G+BBb6tolkP4R2OXTw==
X-Received: by 2002:a17:90b:4a44:: with SMTP id lb4mr11279810pjb.160.1596096908328;
        Thu, 30 Jul 2020 01:15:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a6sm4652207pje.8.2020.07.30.01.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jul 2020 01:15:07 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:14:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     liwei391@huawei.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        catalin.marinas@arm.com, James.Clark@arm.com, jolsa@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, will@kernel.org,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, guohanjun@huawei.com
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20200730081458.GA23324@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
 <a9c59cb6-80f7-1abe-cef4-33127f051488@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c59cb6-80f7-1abe-cef4-33127f051488@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Jul 29, 2020 at 10:12:50AM +0100, Suzuki Kuruppassery Poulose wrote:
> On 07/24/2020 10:16 AM, Wei Li wrote:
> > Armv8.3 extends the SPE by adding:
> > - Alignment field in the Events packet, and filtering on this event
> >    using PMSEVFR_EL1.
> > - Support for the Scalable Vector Extension (SVE).
> > 
> > The main additions for SVE are:
> > - Recording the vector length for SVE operations in the Operation Type
> >    packet. It is not possible to filter on vector length.
> > - Incomplete predicate and empty predicate fields in the Events packet,
> >    and filtering on these events using PMSEVFR_EL1.
> > 
> > Update the check of pmsevfr for empty/partial predicated SVE and
> > alignment event in kernel driver.
> > 
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > ---
> >   arch/arm64/include/asm/sysreg.h |  4 +++-
> >   drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
> >   2 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 463175f80341..be4c44ccdb56 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -281,7 +281,6 @@
> >   #define SYS_PMSFCR_EL1_ST_SHIFT		18
> >   #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> > -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
> >   #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
> >   #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> > @@ -769,6 +768,9 @@
> >   #define ID_AA64DFR0_PMUVER_8_5		0x6
> >   #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
> > +#define ID_AA64DFR0_PMSVER_8_2		0x1
> > +#define ID_AA64DFR0_PMSVER_8_3		0x2
> > +
> >   #define ID_DFR0_PERFMON_SHIFT		24
> >   #define ID_DFR0_PERFMON_8_1		0x4
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index e51ddb6d63ed..5ec7ee0c8fa1 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -54,7 +54,7 @@ struct arm_spe_pmu {
> >   	struct hlist_node			hotplug_node;
> >   	int					irq; /* PPI */
> > -
> > +	int					pmuver;
> >   	u16					min_period;
> >   	u16					counter_sz;
> > @@ -80,6 +80,15 @@ struct arm_spe_pmu {
> >   /* Keep track of our dynamic hotplug state */
> >   static enum cpuhp_state arm_spe_pmu_online;
> > +static u64 sys_pmsevfr_el1_mask[] = {
> > +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> > +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> > +		BIT_ULL(1),
> > +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> > +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> > +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> > +};
> > +
> >   enum arm_spe_pmu_buf_fault_action {
> >   	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
> >   	SPE_PMU_BUF_FAULT_ACT_FATAL,
> > @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
> >   	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> >   		return -ENOENT;
> > -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> > +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
> >   		return -EOPNOTSUPP;
> >   	if (attr->exclude_idle)
> > @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
> >   			fld, smp_processor_id());
> >   		return;
> >   	}
> > +	spe_pmu->pmuver = fld;
> 
> How do we deal with cases where we have big.LITTLE system with differing
> SPE versions ?

Good point.

The first question we need to answer is: how to define SPE version?
From my understanding, if SPE uses the same sample specification and
the same packet format, then we should consider the SPE is the same
version cross CPUs.  So even some CPUs are ARMv8.2 and other CPUs are
ARMv8.3 variants, we still should take the SPE as the same version.

And when read the SPE driver in the file drivers/perf/arm_spe_pmu.c and
I concluded that so far the SPE perf driver is to only support SPE-v1
with single instance, it cannot support a complex usage case like
below:

  CPU0-3: ARMv8.2 architecture with SPE
  CPU4-7: ARMv8.3 architecture with SPE

For this case, if we take SPE as two different versions, let's say
SPE-8.2 and SPE-8.3, then should the SPE driver need to create multi
perf PMU events?  For example, we should create a perf PMU event
'arm_spe_8.2' and another PMU event 'arm_spe_8.3'.

Another option is we always take this as SPE-v1 and only create single
PMU event, just keep what's we are doing with the perf event
'arm_spe_0', but the driver needs to dynamically detect SPE PMU version
number in the function arm_spe_pmu_event_init(), and then based on
version number to select corresponding mask for PMSEVFR.

Thanks,
Leo

[1] https://lore.kernel.org/linux-arm-kernel/20200724071111.35593-1-liwei391@huawei.com/
