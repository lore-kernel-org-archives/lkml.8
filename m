Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D0DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305BD206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgAPTNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:13:43 -0500
Received: from foss.arm.com ([217.140.110.172]:60392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437474AbgAPTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:13:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F021113E;
        Thu, 16 Jan 2020 11:13:37 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37EE3F534;
        Thu, 16 Jan 2020 11:13:35 -0800 (PST)
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, hch@lst.de
Cc:     vigneshr@ti.com, konrad.wilk@oracle.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, rogerq@ti.com,
        robh@kernel.org
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
Date:   Thu, 16 Jan 2020 19:13:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2020 11:50 am, Peter Ujfalusi wrote:
> 
> 
> On 14/01/2020 20.19, Robin Murphy wrote:
>> On 14/01/2020 4:43 pm, Peter Ujfalusi wrote:
>>> The dma_pfn_offset should only be applied to an address which is
>>> within the
>>> dma-ranges range. Any address outside should have offset as 0.
>>
>> No, that's wrong. If a non-empty dma-ranges is present, then addresses
>> which do not fall within any specified range are invalid altogether.
> 
> It is not explicitly stated by the specification, but can be interpreted
> like that and from a pow it does make sense to treat things like that.

Yes, DTspec doesn't explicitly say so, but it does follow fairly 
logically from the definition of "ranges"/"dma-ranges" as a translation 
between address spaces that an address not matching any range cannot 
pass between those address spaces at all. Case in point being that an 
absent "ranges" property means "no translation at all" (sadly the ship 
sailed too long ago to treat "dma-ranges" similarly strictly, so we're 
stuck with the assumption that absent = empty in that direction)

>> The current long-term plan is indeed to try to move to some sort of
>> internal "DMA range descriptor" in order to properly cope with the kind
>> of esoteric integrations which have multiple disjoint windows,
>> potentially even with different offsets, but as you point out there are
>> still many hurdles between now and that becoming reality. So although
>> this patch does represent the "right" thing, it's for entirely the wrong
>> reason. AFAICT for your case it basically just works out as a very
>> baroque way to hack dma_direct_supported() again - we shouldn't need a
>> special case to map a bogus physical address to valid DMA address, we
>> should be fixing the source of the bogus PA in the first place.
> 
> DMA_BIT_MASK(32) is pretty clear: The DMA can handle addresses within
> 32bit space. DMA_BIT_MASK(24) is also clear: The DMA can handle
> addresses within 24bit space.

Careful there - DMA *masks* are about how wide an address the device may 
generate, but it's not necessarily true that the interconnect beyond 
will actually accept every possible address that that many bits can 
encode (see the aforementioned case of PCI host bridge windows, or the 
recent change of bus_dma_mask to a not-necessarily-power-of-two 
bus_dma_limit)...

> dma-ranges does not change that. The DMA can still address the same
> space.

...thus that assumption is incorrect. However it's not particularly 
important to the immediate problem at hand.

> What dma-ranges will tell is that a physical address range 'X'
> can be accessed on the bus under range 'Y'.
> For the DMA within the bus the physical address within 'X' does not
> matter. What matters is the matching address within 'Y'
> 
> We should do dma_pfn_offset conversion _only_ for the range it applies
> to. Outside of it is not valid to apply it.

That much is agreed. For a physical address A in Y, phys_to_dma(A) 
should return the corresponding DMA address A' in X. What you're 
proposing is that for address B not in Y, phys_to_dma(B) should just 
return B, but my point is that even doing that is wrong, because there 
is no possible DMA address corresponding to B, so there is no valid 
value to return at all.

Nobody's disputing that the current dma_direct_supported() 
implementation is broken for the case where ZONE_DMA itself is offset 
from PA 0; the more pressing question is why Christoph's diff, which was 
trying to take that into account, still didn't work.

Robin.

> The dma API will check
> (without applying dma_pfn_offset) addresses outside of any range (only
> one currently in Linux) and if it is not OK for the mask then it will fail.
> 
>>
>>> This is a proof of concept patch which works on k2g where we have
>>> dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
>>> for the SoC.
>>
>> TBH it's probably extra-confusing that you're on Keystone 2, where
>> technically this ends up closer-to-OK than most, since IIRC the 0-2GB
>> MMIO region is the same on all 3(?) interconnect maps. Thus the 100%
>> honest description would really be:
>>
>> dma-ranges = <0x0 0x0 0x0 0x80000000>,
>>           <0x80000000 0x8 0x00000000 0x80000000>;
>>
>> but yeah, that would just go horribly wrong with Linux today.
> 
> It does ;) This was the first thing I have tried.
> 
>> The
>> subtelty that dma_map_resource() ignores the pfn_offset happens to be a
>> "feature" in this regard ;)
> 
> Right, but Keystone 2 is broken since 5.3-rc3 by commit
> ad3c7b18c5b362be5dbd0f2c0bcf1fd5fd659315.
> 
> Can you propose a fix which we can use until things get sorted out?
> 
> Thanks,
> - Péter
> 
>>
>> Robin.
>>
>>> Without this patch everything which tries to set DMA_BIT_MASK(32) or less
>>> fails -> DMA and peripherals with built in DMA (SD with ADMA) will not
>>> probe or fall back to PIO mode.
>>>
>>> With this patch EDMA probes, SD's ADMA is working.
>>> Audio and dma-test is working just fine with EDMA, mmc accesses with ADMA
>>> also operational.
>>>
>>> The patch does not tried to address the incomplete handling of dma-ranges
>>> from DT and it is not fixing/updating arch code or drivers which uses
>>> dma_pfn_offset.
>>> Neither provides fallback support for kernel setting only
>>> dma_pfn_offset to
>>> arbitrary number without paddr/dma_addr/size.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>> Hi Christoph, Robin,
>>>
>>> I know it is a bit more complicated, but with this patch k2g is
>>> working fine...
>>>
>>> I wanted to test the concept I was describing and a patch speaks
>>> better than
>>> words.
>>>
>>> Kind regards,
>>> Peter
>>>
>>>    arch/arm/include/asm/dma-mapping.h | 25 ++++++++++++++++++++--
>>>    drivers/of/device.c                |  7 ++++++-
>>>    include/linux/device.h             |  8 ++++++++
>>>    include/linux/dma-direct.h         | 33 ++++++++++++++++++++++++++++--
>>>    kernel/dma/coherent.c              |  9 +++++---
>>>    5 files changed, 74 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/dma-mapping.h
>>> b/arch/arm/include/asm/dma-mapping.h
>>> index bdd80ddbca34..9bff6ad2d8c8 100644
>>> --- a/arch/arm/include/asm/dma-mapping.h
>>> +++ b/arch/arm/include/asm/dma-mapping.h
>>> @@ -33,10 +33,31 @@ static inline const struct dma_map_ops
>>> *get_arch_dma_ops(struct bus_type *bus)
>>>     * addresses. They must not be used by drivers.
>>>     */
>>>    #ifndef __arch_pfn_to_dma
>>> +
>>> +static inline unsigned long __phys_to_dma_pfn_offset(struct device *dev,
>>> +                             phys_addr_t paddr)
>>> +{
>>> +    if (paddr >= dev->dma_ranges.paddr &&
>>> +        paddr <= (dev->dma_ranges.paddr + dev->dma_ranges.size))
>>> +        return dev->dma_ranges.pfn_offset;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static inline unsigned long __dma_to_phys_pfn_offset(struct device *dev,
>>> +                             dma_addr_t dma_addr)
>>> +{
>>> +    if (dma_addr >= dev->dma_ranges.dma_addr &&
>>> +        dma_addr <= (dev->dma_ranges.dma_addr + dev->dma_ranges.size))
>>> +        return dev->dma_ranges.pfn_offset;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned
>>> long pfn)
>>>    {
>>>        if (dev)
>>> -        pfn -= dev->dma_pfn_offset;
>>> +        pfn -= __phys_to_dma_pfn_offset(dev, __pfn_to_phys(pfn));
>>>        return (dma_addr_t)__pfn_to_bus(pfn);
>>>    }
>>>    @@ -45,7 +66,7 @@ static inline unsigned long dma_to_pfn(struct
>>> device *dev, dma_addr_t addr)
>>>        unsigned long pfn = __bus_to_pfn(addr);
>>>          if (dev)
>>> -        pfn += dev->dma_pfn_offset;
>>> +        pfn += __dma_to_phys_pfn_offset(dev, addr);
>>>          return pfn;
>>>    }
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index 27203bfd0b22..07a8cc1a7d7f 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -105,7 +105,7 @@ int of_dma_configure(struct device *dev, struct
>>> device_node *np, bool force_dma)
>>>            if (!force_dma)
>>>                return ret == -ENODEV ? 0 : ret;
>>>    -        dma_addr = offset = 0;
>>> +        dma_addr = offset = paddr = 0;
>>>        } else {
>>>            offset = PFN_DOWN(paddr - dma_addr);
>>>    @@ -144,6 +144,11 @@ int of_dma_configure(struct device *dev, struct
>>> device_node *np, bool force_dma)
>>>          dev->dma_pfn_offset = offset;
>>>    +    dev->dma_ranges.paddr = paddr;
>>> +    dev->dma_ranges.dma_addr = dma_addr;
>>> +    dev->dma_ranges.size = size;
>>> +    dev->dma_ranges.pfn_offset = offset;
>>> +
>>>        /*
>>>         * Limit coherent and dma mask based on size and default mask
>>>         * set by the driver.
>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>> index ce6db68c3f29..57006b51a989 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -293,6 +293,13 @@ struct device_dma_parameters {
>>>        unsigned long segment_boundary_mask;
>>>    };
>>>    +struct dma_ranges {
>>> +    u64 paddr;
>>> +    u64 dma_addr;
>>> +    u64 size;
>>> +    unsigned long pfn_offset;
>>> +};
>>> +
>>>    /**
>>>     * struct device_connection - Device Connection Descriptor
>>>     * @fwnode: The device node of the connected device
>>> @@ -581,6 +588,7 @@ struct device {
>>>                             allocations such descriptors. */
>>>        u64        bus_dma_limit;    /* upstream dma constraint */
>>>        unsigned long    dma_pfn_offset;
>>> +    struct dma_ranges dma_ranges;
>>>          struct device_dma_parameters *dma_parms;
>>>    diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>>> index 24b8684aa21d..4a46a15945ea 100644
>>> --- a/include/linux/dma-direct.h
>>> +++ b/include/linux/dma-direct.h
>>> @@ -11,18 +11,47 @@ extern unsigned int zone_dma_bits;
>>>    #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>>>    #include <asm/dma-direct.h>
>>>    #else
>>> +
>>> +static inline unsigned long __phys_to_dma_pfn_offset(struct device *dev,
>>> +                             phys_addr_t paddr)
>>> +{
>>> +    if (!dev)
>>> +        return 0;
>>> +
>>> +    if (paddr >= dev->dma_ranges.paddr &&
>>> +        paddr <= (dev->dma_ranges.paddr + dev->dma_ranges.size))
>>> +        return dev->dma_ranges.pfn_offset
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static inline unsigned long __dma_to_phys_pfn_offset(struct device *dev,
>>> +                             dma_addr_t dma_addr)
>>> +{
>>> +    if (!dev)
>>> +        return 0;
>>> +
>>> +    if (dma_addr >= dev->dma_ranges.dma_addr &&
>>> +        dma_addr <= (dev->dma_ranges.dma_addr + dev->dma_ranges.size))
>>> +        return dev->dma_ranges.pfn_offset
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static inline dma_addr_t __phys_to_dma(struct device *dev,
>>> phys_addr_t paddr)
>>>    {
>>>        dma_addr_t dev_addr = (dma_addr_t)paddr;
>>> +    unsigned long offset = __phys_to_dma_pfn_offset(dev, paddr);
>>>    -    return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
>>> +    return dev_addr - ((dma_addr_t)offset << PAGE_SHIFT);
>>>    }
>>>      static inline phys_addr_t __dma_to_phys(struct device *dev,
>>> dma_addr_t dev_addr)
>>>    {
>>>        phys_addr_t paddr = (phys_addr_t)dev_addr;
>>> +    unsigned long offset = __dma_to_phys_pfn_offset(dev, dev_addr);
>>>    -    return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
>>> +    return paddr + ((phys_addr_t)offset << PAGE_SHIFT);
>>>    }
>>>    #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>>>    diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
>>> index 551b0eb7028a..7a68fd09f5d0 100644
>>> --- a/kernel/dma/coherent.c
>>> +++ b/kernel/dma/coherent.c
>>> @@ -31,10 +31,13 @@ static inline struct dma_coherent_mem
>>> *dev_get_coherent_memory(struct device *de
>>>    static inline dma_addr_t dma_get_device_base(struct device *dev,
>>>                             struct dma_coherent_mem * mem)
>>>    {
>>> -    if (mem->use_dev_dma_pfn_offset)
>>> -        return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
>>> -    else
>>> +    if (mem->use_dev_dma_pfn_offset) {
>>> +        unsigned long offset = __phys_to_dma_pfn_offset(dev,
>>> +                        __pfn_to_phys(mem->pfn_base));
>>> +        return (mem->pfn_base - offset) << PAGE_SHIFT;
>>> +    } else {
>>>            return mem->device_base;
>>> +    }
>>>    }
>>>      static int dma_init_coherent_memory(phys_addr_t phys_addr,
>>>
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
