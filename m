Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD82C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760B524672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OogEDyte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgANKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:43:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgANKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:43:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00EAgnwS041639;
        Tue, 14 Jan 2020 04:42:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578998569;
        bh=JLcVJs7e0hOu4k2stftcoKk4ShLk+uTqAozz7jx60yk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OogEDyteXrThJSj1elrWamSELePK44hwj+d1RqL81zgM/5d+S7oOzh4xAsRMdYErN
         f7wR7wLkofbKlDIYKKUhcgl+pFSzEyw59rEjiH53tx9j0l8pEFtOhLIkBIaF0woVaw
         nw1cUqnRHmpRcqAiRVB8uzKwvukLc51amDJs7O+w=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00EAgnMY077375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 04:42:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Jan 2020 04:42:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Jan 2020 04:42:48 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00EAgk80039702;
        Tue, 14 Jan 2020 04:42:46 -0600
Subject: Re: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>
References: <20190709142011.24984-1-hch@lst.de>
 <20190709142011.24984-3-hch@lst.de>
 <9bbd87c2-5b6c-069c-dd22-5105dc827428@ti.com> <20191219150259.GA3003@lst.de>
 <20106a84-8247-fa78-2381-2c94fad9cb6a@ti.com>
 <eca457b6-c685-59ac-1dec-5b28e4430e1d@ti.com>
 <d3921764-840c-4d1c-f240-b974b9b83ec8@arm.com>
 <27450c0e-c8aa-d59b-aa32-37f23c232eb7@ti.com>
 <0e6decce-c54e-9791-473e-0aef05650f39@arm.com>
 <20200109144920.GB22907@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
Date:   Tue, 14 Jan 2020 12:43:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109144920.GB22907@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, Robin,

On 09/01/2020 16.49, Christoph Hellwig wrote:
> On Wed, Jan 08, 2020 at 03:20:07PM +0000, Robin Murphy wrote:
>>> The problem - I think - is that the DMA_BIT_MASK(32) from
>>> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32)) is treated as physical
>>> address along the call path so the dma_pfn_offset is applied to it and
>>> the check will fail, saying that DMA_BIT_MASK(32) can not be supported.
>>
>> But that's the thing - in isolation, that is entirely correct. Considering 
>> ZONE_DMA32 for simplicity, in general the zone is expected to cover the 
>> physical address range 0x0000_0000 - 0xffff_ffff (because DMA offsets are 
>> relatively rare), and a device with a dma_pfn_offset of more than 
>> (0x1_0000_0000 >> PAGE_SHIFT) *cannot* support that range with any mask, 
>> because the DMA address itself would have to be negative.
> 
> Note that ZONE_DMA32 is irrelevant in this particular case, as we are
> talking about arm32.  But with ZONE_DMA instead this roughly makes sense.
> 
>> The problem is that platforms with esoteric memory maps have no right thing 
>> to do. If the base of RAM is at at 0x1_0000_0000 or higher, the "correct" 
>> ZONE_DMA32 would be empty while ZONE_NORMAL above it would not, and last 
>> time I looked that makes the page allocator break badly. So the standard 
>> bodge on such platforms is to make ZONE_DMA32 cover not the first 4GB of 
>> *PA space*, but the first 4GB of *RAM*, wherever that happens to be. That 
>> then brings different problems - now the page allocator is happy and 
>> successfully returns GFP_DMA32 allocations from the range 0x8_0000_0000 - 
>> 0x8_ffff_ffff that are utterly useless to 32-bit devices with zero 
>> dma_pfn_offset - see the AMD Seattle SoC for the prime example of that. If 
>> on the other hand all devices are guaranteed to have a dma_pfn_offset that 
>> puts the base of RAM at DMA address 0 then GFP_DMA32 allocations do end up 
>> working as expected, but now the original assumption of where ZONE_DMA32 
>> actually is is broken, so generic code unaware of the 
>> platform/architecture-specific bodge will be misled - that's the case 
>> you're running into.
>>
>> Having thought this far, if there's a non-hacky way to reach in and grab 
>> ZONE_DMA{32} such that dma_direct_supported() could use zone_end_pfn() 
>> instead of trying to assume either way, that might be the most robust 
>> general solution.
> 
> zone_dma_bits is our somewhat ugly way to try to poke into this
> information, although the way it is done right now sucks pretty badly.

In my view the handling of dma_pfn_offset is just incorrect as it is applied to _any_ address.
According to DT specification dma-ranges:
"Value type: <empty> or <prop-encoded-array> encoded as an arbitrary
number of (child-bus-address, parent-bus-address, length) triplets."

Yet in drivers/of/ we only take the _first_ triplet and ignore the rest.

The dma_pfn_offset should be only applied to paddr in the range:
parent-bus-address to parent-bus-address+length
for anything outside of this the dma_pfn_offset is 0.

conversion back from dma to paddr should consider the offset in range:
child-bus-address to child-bus-address+length
and 0 for everything outside of this.

To correctly handle the dma-ranges we would need something like this in device.h:
+struct dma_ranges {
+       u64 paddr;
+       u64 dma_addr;
+       u64 size;
+	unsigned long pfn_offset;
+};
+

struct device {
	...
-	unsigned long	dma_pfn_offset;
+       struct dma_ranges *dma_ranges;
	int dma_ranges_cnt;
	...
};

Then when we currently use dma_pfn_offset we would have:

unsigned long __phys_to_dma_pfn_offset(struct device *dev, phys_addr_t paddr)
{
	int i;

	if (!dev->dma_ranges)
		return 0;

	for (i = 0; i < dev->dma_ranges_cnt; i++) {
		struct dma_ranges *range = &dev->dma_ranges[i];
		if (paddr >= range->paddr &&
		    paddr <= (range->paddr + range->size))
			return range->pfn_offset;
	}

	return 0;
}

unsigned long __dma_to_phys_pfn_offset(struct device *dev, dma_addr_t dma_addr)
{
	int i;

	for (i = 0; i < dev->dma_ranges_cnt; i++) {
		struct dma_ranges *range = &dev->dma_ranges[i];
		if (dma_addr >= range->dma_addr &&
		    dma_addr <= (range->dma_addr + range->size))
			return range->pfn_offset;
	}

	return 0;
}

For existing drivers/archs setting dma_pfn_offset we can:
if (dev->dma_ranges_cnt == 1 && dev->dma_ranges[0].pfn_offset && !dev->dma_ranges[0].size)
	return dev->dma_ranges[0].pfn_offset;

and they would have to set up one struct dma_ranges.

One of the issue with this is that the struct dma_ranges would need to be allocated for
all devices, so there should be a some clever way need to be invented to use pointers
as much as we can.

> The patch I sent to Peter in December was trying to convey that
> information in a way similar to what the arm32 legacy dma code does, but
> it didn't work, so I'll need to find some time to sit down and figure out
> why.

But, while we get a proper solution can we get the following patch in to fix the regression?
Basically we are falling back to what works (and was used before commit ad3c7b18c5b362be5dbd0f2c0bcf1fd5fd659315).

commit 8c3c36b377c139603a9dff5c58dac59865f1ac0f
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Thu Dec 19 15:07:25 2019 +0200

    arm: mm: dma-mapping: Fix dma_supported() when dev->dma_pfn_offset is not 0
    
    We can only use direct mapping when LPAE is enabled if the dma_pfn_offset
    is 0, otherwise valid dma_masks will be rejected and the DMA support is
    going to be denied for peripherals, or DMA drivers.
    
    Cc: Stable <stable@vger.kernel.org> #v5.3+
    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9414d72f664b..e07ec1ea3865 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1100,15 +1100,6 @@ int arm_dma_supported(struct device *dev, u64 mask)
 
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
-	/*
-	 * When CONFIG_ARM_LPAE is set, physical address can extend above
-	 * 32-bits, which then can't be addressed by devices that only support
-	 * 32-bit DMA.
-	 * Use the generic dma-direct / swiotlb ops code in that case, as that
-	 * handles bounce buffering for us.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_LPAE))
-		return NULL;
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
 }
 
@@ -2313,6 +2304,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
 		dma_ops = arm_get_iommu_dma_map_ops(coherent);
+	else if (IS_ENABLED(CONFIG_ARM_LPAE) && !dev->dma_pfn_offset)
+		/*
+		 * When CONFIG_ARM_LPAE is set, physical address can extend
+		 * above * 32-bits, which then can't be addressed by devices
+		 * that only support 32-bit DMA.
+		 * Use the generic dma-direct / swiotlb ops code in that case,
+		 * as that handles bounce buffering for us.
+		 */
+		dma_ops = NULL;
 	else
 		dma_ops = arm_get_dma_map_ops(coherent);

--- 
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
