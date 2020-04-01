Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA40C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF4E2080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgDALM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:12:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbgDALM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:12:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDAA930E;
        Wed,  1 Apr 2020 04:12:27 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6EFA3F68F;
        Wed,  1 Apr 2020 04:12:25 -0700 (PDT)
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
 <20200320105315.GA35932@C02TD0UTHF1T.local>
 <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
 <20200401095226.GA17163@C02TD0UTHF1T.local>
 <20200401102724.GA17575@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4d843ec7-ed74-4431-d8c7-d5aa6bd83c18@arm.com>
Date:   Wed, 1 Apr 2020 12:12:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401102724.GA17575@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-01 11:27 am, Will Deacon wrote:
> On Wed, Apr 01, 2020 at 10:52:26AM +0100, Mark Rutland wrote:
>> On Tue, Mar 31, 2020 at 03:14:59PM -0700, Tuan Phan wrote:
>>>> On Mar 20, 2020, at 4:25 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> On Thu, Mar 19, 2020 at 12:03:43PM -0700, Tuan Phan wrote:
>>>>>> On Mar 19, 2020, at 8:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>> On Tue, Mar 17, 2020 at 05:29:38PM -0700, Tuan Phan wrote:
>>>>>>> +static int arm_dmc620_pmu_dev_init(struct arm_dmc620_pmu *dmc620_pmu)
>>>>>>> +{
>>>>>>> +	struct platform_device *pdev = dmc620_pmu->pdev;
>>>>>>> +	int ret;
>>>>>>> +
>>>>>>> +	ret = devm_request_irq(&pdev->dev, dmc620_pmu->irq,
>>>>>>> +				arm_dmc620_pmu_handle_irq,
>>>>>>> +				IRQF_SHARED,
>>>>>>> +				dev_name(&pdev->dev), dmc620_pmu);
>>>>>>
>>>>>> This should have IRQF_NOBALANCING | IRQF_NO_THREAD. I don't think we
>>>>>> should have IRQF_SHARED.
>>>>> => I agree on having IRQF_NOBALANCING and IRQF_NO_THREAD. But
>>>>> IRQF_SHARED is needed. In our platform all DMC620s share same IRQs and
>>>>> any cpus can access the pmu registers.
>>>>
>>>> Linux needs to ensure that the same instance is concistently accessed
>>>> from the same CPU, and needs to migrate the IRQ to handle that. Given we
>>>> do that on a per-instance basis, we cannot share the IRQ with another
>>>> instance.
>>>>
>>>> Please feed back to you HW designers that muxing IRQs like this causes
>>>> significant problems for software.
>>>
>>> I looked at the SMMUv3 PMU driver and it also uses IRQF_SHARED. SMMUv3
>>> PMU and DMC620 PMU are very much similar in which counters can be
>>> accessed by any cores using memory map. Any special reasons
>>> IRQF_SHARED works with SMMUv3 PMU driver?
>>
>> No; I believe that is a bug in the SMMUv3 PMU driver. If the IRQ were
>> shared, and another driver that held the IRQ changed the affinity,
>> things would go very wrong.
> 
> I *think* the idea is that the SMMUv3 PMU driver manages multiple PMCG
> devices, which may all share an irq line, rather than the irq line being
> shared by some other driver that might change the affinity. So I suspect
> dropping IRQF_SHARED will break things.

Each PMCG is conceptually a distinct PMU with its own interrupt - for 
instance, MMU-600 has one PMCG for its TCU and one for each TBU, each 
with a distinct interrupt output signal. Of course, integrators can and 
will mash them all together into a single SPI (particularly since 
they're all part of "the SMMU"), but that boils down to the same case as 
here.

This is going to continue to happen, so we could really do with figuring 
out a way to let MMIO system PMU drivers properly cope with shared 
interrupts in general :/

Robin.
