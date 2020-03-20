Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20909C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC720784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCTLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:25:47 -0400
Received: from foss.arm.com ([217.140.110.172]:47686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbgCTLZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F046231B;
        Fri, 20 Mar 2020 04:25:45 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2EE3F85E;
        Fri, 20 Mar 2020 04:25:44 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:25:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
Message-ID: <20200320105315.GA35932@C02TD0UTHF1T.local>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:03:43PM -0700, Tuan Phan wrote:
> Hi Mark,
> Please find my comments below.

Hi Tuan,

As Will said, *please* set up a more usual mail clinet configuration if
you can. The reply style (with lines starting with '=>') is unusual and
very painful to spot.

> > On Mar 19, 2020, at 8:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Hi Tuan,
> > 
> > On Tue, Mar 17, 2020 at 05:29:38PM -0700, Tuan Phan wrote:
> >> DMC-620 PMU supports total 10 counters which each is
> >> independently programmable to different events and can
> >> be started and stopped individually.
> > 
> > Looking at the TRM for DMC-620, the PMU registers are not in a separate
> > frame from the other DMC control registers, and start at offset 0xA00
> > (AKA 2560). I would generally expect that access to the DMC control
> > registers was restricted to the secure world; is that not the case on
> > your platform?
> > 
> > I ask because if those are not restricted, the Normal world could
> > potentially undermine the Secure world through this (e.g. playing with
> > training settings, messing with the physical memory map, injecting RAS
> > errors). Have you considered this?
> => Only PMU registers can be accessed within normal world. I only pass
> PMU registers (offset 0xA00) to kernel so shouldn’t be problem.

Sure, you only *describe* that in the ACPI tables, but I can't see how
that's access control is enforced in the hardware, because these
registers fall in the same 4K page as other control registers, and
AFAICT the IP doesn't distinguish S/NS accesses.

If the Secure world on your part uses DRAM (including the secure
portions of IPs like SMMUs), you *must* ensure that the Normal world
cannot access those other control registers, or it can corrupt Secure
world state and escalate privilege.

Is that not a concern here?

> >> DMC-620 PMU devices are named as arm_dmc620_<uid> where
> >> <uid> is the UID of DMC-620 PMU ACPI node. Currently, it only
> >> supports ACPI. Other platforms feel free to test and add
> >> support for device tree.
> >> 
> >> Usage example:
> >>  #perf stat -e arm_dmc620_0/clk_cycle_count/ -C 0
> >>  Get perf event for clk_cycle_count counter.
> >> 
> >>  #perf stat -e arm_dmc620_0/clkdiv2_allocate,mask=0x1f,match=0x2f,
> >>  incr=2,invert=1/ -C 0
> >>  The above example shows how to specify mask, match, incr,
> >>  invert parameters for clkdiv2_allocate event.
> > 
> > [...]
> > 
> >> +#define DMC620_CNT_MAX_PERIOD				0xffffffff
> >> +#define DMC620_PMU_CLKDIV2_MAX_COUNTERS			8
> >> +#define DMC620_PMU_CLK_MAX_COUNTERS			2
> >> +#define DMC620_PMU_MAX_COUNTERS				\
> >> +	(DMC620_PMU_CLKDIV2_MAX_COUNTERS + DMC620_PMU_CLK_MAX_COUNTERS)
> >> +
> >> +#define DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_OFFSET	8
> > 
> > This appears to be relative to 0xA00. What exactly does your ACPI
> > description provide? The whole set of DMC registers, or just the PMU
> > registers?
> => Just PMU registers from 0xA00 to 0xBFF.

I don't believe that is correct; see below w.r.t. the ACPI binding.

> >> +static int arm_dmc620_pmu_dev_init(struct arm_dmc620_pmu *dmc620_pmu)
> >> +{
> >> +	struct platform_device *pdev = dmc620_pmu->pdev;
> >> +	int ret;
> >> +
> >> +	ret = devm_request_irq(&pdev->dev, dmc620_pmu->irq,
> >> +				arm_dmc620_pmu_handle_irq,
> >> +				IRQF_SHARED,
> >> +				dev_name(&pdev->dev), dmc620_pmu);
> > 
> > This should have IRQF_NOBALANCING | IRQF_NO_THREAD. I don't think we
> > should have IRQF_SHARED.
> => I agree on having IRQF_NOBALANCING and IRQF_NO_THREAD. But
> IRQF_SHARED is needed. In our platform all DMC620s share same IRQs and
> any cpus can access the pmu registers.

Linux needs to ensure that the same instance is concistently accessed
from the same CPU, and needs to migrate the IRQ to handle that. Given we
do that on a per-instance basis, we cannot share the IRQ with another
instance.

Please feed back to you HW designers that muxing IRQs like this causes
significant problems for software.

> > 
> > [...]
> > 
> >> +static const struct acpi_device_id arm_dmc620_acpi_match[] = {
> >> +	{ "ARMHD620", 0},
> >> +	{},
> >> +};
> > 
> > Just to check, was this ID allocated by Arm, or have you allocated it?
> => ID was allocated by ARM. Please refer to 
> https://static.docs.arm.com/den0093/a/DEN0093_ACPI_Arm_Components_1.0.pdf <https://static.docs.arm.com/den0093/a/DEN0093_ACPI_Arm_Components_1.0.pdf>

Thanks for the link! For this _HID, the document says the _CRS contains
a QWordMemory Base address, which the full description is:

| Base Address of the DMC620 in the system address map

... which would presumably mean the *entire* set of MMIO registers, not
just the PMU portion. The example firmly hints that it is the entire set
of MMIO registers:

| In this example, the DMC620 register space is mapped to a 64K range
| that begins at offset 0x80CAFE0000 in the system address space

Thanks,
Mark.
