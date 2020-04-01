Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A99C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DDB20776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbgDAL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:49962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgDAL5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:57:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 398A930E;
        Wed,  1 Apr 2020 04:57:07 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9841D3F68F;
        Wed,  1 Apr 2020 04:57:05 -0700 (PDT)
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200319151646.GC4876@lakrids.cambridge.arm.com>
 <23AD5E45-15E3-4487-9B0D-0D9554DD9DE8@amperemail.onmicrosoft.com>
 <20200320105315.GA35932@C02TD0UTHF1T.local>
 <A50AA800-3F65-4761-9BCF-F86A028E107D@amperemail.onmicrosoft.com>
 <20200401095226.GA17163@C02TD0UTHF1T.local>
 <20200401102724.GA17575@willie-the-truck>
 <4d843ec7-ed74-4431-d8c7-d5aa6bd83c18@arm.com>
 <20200401112739.GD17163@C02TD0UTHF1T.local>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3efa118a-5c85-6af9-e676-44087f1d398e@arm.com>
Date:   Wed, 1 Apr 2020 12:57:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401112739.GD17163@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-01 12:27 pm, Mark Rutland wrote:
> On Wed, Apr 01, 2020 at 12:12:23PM +0100, Robin Murphy wrote:
>> On 2020-04-01 11:27 am, Will Deacon wrote:
>>> On Wed, Apr 01, 2020 at 10:52:26AM +0100, Mark Rutland wrote:
>>>> On Tue, Mar 31, 2020 at 03:14:59PM -0700, Tuan Phan wrote:
>>>>> I looked at the SMMUv3 PMU driver and it also uses IRQF_SHARED. SMMUv3
>>>>> PMU and DMC620 PMU are very much similar in which counters can be
>>>>> accessed by any cores using memory map. Any special reasons
>>>>> IRQF_SHARED works with SMMUv3 PMU driver?
>>>>
>>>> No; I believe that is a bug in the SMMUv3 PMU driver. If the IRQ were
>>>> shared, and another driver that held the IRQ changed the affinity,
>>>> things would go very wrong.
>>>
>>> I *think* the idea is that the SMMUv3 PMU driver manages multiple PMCG
>>> devices, which may all share an irq line, rather than the irq line being
>>> shared by some other driver that might change the affinity. So I suspect
>>> dropping IRQF_SHARED will break things.
>>
>> Each PMCG is conceptually a distinct PMU with its own interrupt - for
>> instance, MMU-600 has one PMCG for its TCU and one for each TBU, each with a
>> distinct interrupt output signal. Of course, integrators can and will mash
>> them all together into a single SPI (particularly since they're all part of
>> "the SMMU"), but that boils down to the same case as here.
>>
>> This is going to continue to happen, so we could really do with figuring out
>> a way to let MMIO system PMU drivers properly cope with shared interrupts in
>> general :/
> 
> It does seem so, but I think we can only reasonably do that where it's
> only being shared across instances of the same driver, rather than when
> the IRQ is muxed across completely independent drivers. I'd like to
> avoid that latter case if we can.
> 
> The driver would have to handle migration on a cross-instance basis.
> e.g. all the contexts need to be migrated before the IRQ is, to avoid a
> screaming IRQ on the target CPU, or the IRQ handler on the target racing
> with migration from the source.
> 
> Is there a neat way to do that in a driver without using IRQF_SHARED, so
> that we don't end up accidentally sharing with other drivers? We can
> probably librify the code to handle this under drivers/pmu/.

I can envision a fairly straightforward approach of flipping things 
upside-down such that we register a hotplug instance for the IRQ rather 
than the PMU, then handle the association of PMUs to IRQs internally to 
the driver. I believe I need to support this case in my CMN PMU driver 
too, so I'll prototype something there and see how it looks.

Robin.
