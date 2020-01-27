Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939FDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABB4205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="byMYjQ5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgA0OAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:00:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47656 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0OAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:00:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RDxlYL057095;
        Mon, 27 Jan 2020 07:59:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580133587;
        bh=13B9b908UVUbvOyxiJ58ECaxp0yhYxfCuSddmMPdXQo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=byMYjQ5axRrtxupLYKROYKVt8+IuRrCfDAxUd1qyo+R+/6pCmypBcK3Igp/v/iw/A
         lRKu+H7M/KnacRahNE8QWJXwKsK03GsCVj1lwDBQLGK/+wAwfHrS30u9cIeGGOFk6R
         rIW5OnTYhpCBAscc2yC6dyHMxsAYJ3Bp1PuJ+60g=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDxlA0046759;
        Mon, 27 Jan 2020 07:59:47 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 07:59:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 07:59:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDxiK6043723;
        Mon, 27 Jan 2020 07:59:44 -0600
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To:     Robin Murphy <robin.murphy@arm.com>, <hch@lst.de>
CC:     <vigneshr@ti.com>, <konrad.wilk@oracle.com>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@ti.com>,
        <robh@kernel.org>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com>
Date:   Mon, 27 Jan 2020 16:00:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/01/2020 21.13, Robin Murphy wrote:
> On 15/01/2020 11:50 am, Peter Ujfalusi wrote:
>>
>>
>> On 14/01/2020 20.19, Robin Murphy wrote:
>>> On 14/01/2020 4:43 pm, Peter Ujfalusi wrote:
>>>> The dma_pfn_offset should only be applied to an address which is
>>>> within the
>>>> dma-ranges range. Any address outside should have offset as 0.
>>>
>>> No, that's wrong. If a non-empty dma-ranges is present, then addresses
>>> which do not fall within any specified range are invalid altogether.
>>
>> It is not explicitly stated by the specification, but can be interpreted
>> like that and from a pow it does make sense to treat things like that.
> 
> Yes, DTspec doesn't explicitly say so, but it does follow fairly
> logically from the definition of "ranges"/"dma-ranges" as a translation
> between address spaces that an address not matching any range cannot
> pass between those address spaces at all. Case in point being that an
> absent "ranges" property means "no translation at all" (sadly the ship
> sailed too long ago to treat "dma-ranges" similarly strictly, so we're
> stuck with the assumption that absent = empty in that direction)

Agree.

> 
>>> The current long-term plan is indeed to try to move to some sort of
>>> internal "DMA range descriptor" in order to properly cope with the kind
>>> of esoteric integrations which have multiple disjoint windows,
>>> potentially even with different offsets, but as you point out there are
>>> still many hurdles between now and that becoming reality. So although
>>> this patch does represent the "right" thing, it's for entirely the wrong
>>> reason. AFAICT for your case it basically just works out as a very
>>> baroque way to hack dma_direct_supported() again - we shouldn't need a
>>> special case to map a bogus physical address to valid DMA address, we
>>> should be fixing the source of the bogus PA in the first place.
>>
>> DMA_BIT_MASK(32) is pretty clear: The DMA can handle addresses within
>> 32bit space. DMA_BIT_MASK(24) is also clear: The DMA can handle
>> addresses within 24bit space.
> 
> Careful there - DMA *masks* are about how wide an address the device may
> generate

Which is in a simplified view is what address range the DMA can address.
The DMA can not generate address beyond the mask.

> but it's not necessarily true that the interconnect beyond
> will actually accept every possible address that that many bits can
> encode

True.

> (see the aforementioned case of PCI host bridge windows, or the
> recent change of bus_dma_mask to a not-necessarily-power-of-two
> bus_dma_limit)...

I see.

>> dma-ranges does not change that. The DMA can still address the same
>> space.
> 
> ...thus that assumption is incorrect.

Hrm, why it is not correct?
The DMA can generate addresses up to 32 bits. Anything beyond that is
not accessible by DMA.
The interconnect makes part of a higher (not addressable memory space)
available within the 32 bits range, thus the DMA can address that.
We tell this via the dma-ranges.
I agree that for a correct dma-ranges for k2g should be:
dma-ranges = <0x0 0x0 0x0 0x80000000>,
             <0x80000000 0x8 0x00000000 0x80000000>;

> However it's not particularly
> important to the immediate problem at hand.
> 
>> What dma-ranges will tell is that a physical address range 'X'
>> can be accessed on the bus under range 'Y'.
>> For the DMA within the bus the physical address within 'X' does not
>> matter. What matters is the matching address within 'Y'
>>
>> We should do dma_pfn_offset conversion _only_ for the range it applies
>> to. Outside of it is not valid to apply it.
> 
> That much is agreed. For a physical address A in Y, phys_to_dma(A)
> should return the corresponding DMA address A' in X. What you're
> proposing is that for address B not in Y, phys_to_dma(B) should just
> return B, but my point is that even doing that is wrong, because there
> is no possible DMA address corresponding to B, so there is no valid
> value to return at all.

I agree on the phys_to_dma(). It should fail for addresses which does
not fall into any of the ranges.
It is just a that we in Linux don't have the concept atm for ranges, we
have only _one_ range which applies to every memory address.

I guess what I'm proposing is to _not_ apply the phys_to_dma() to the
DMA mask itself?

Or reverse check the dma-ranges against the dma_mask?

0x0 - 0x8000 0000 : direct mapped w/o pfn_offset
0x8000 0000 - 0xFFFF FFFF : mapped from 0x8 0000 0000 w/ pfn_offset

and this is the whole address range the DMA can address.

> Nobody's disputing that the current dma_direct_supported()
> implementation is broken for the case where ZONE_DMA itself is offset
> from PA 0; the more pressing question is why Christoph's diff, which was
> trying to take that into account, still didn't work.

I understand that this is a bit more complex than I interpret it, but
the k2g is broken and currently the simplest way to make it work is to
use the arm dma_ops in case the pfn_offset is not 0.
It will be easy to test dma-direct changes trying to address the issue
in hand, but will allow k2g to be usable at the same time.

A patch like I first proposed in:
https://lore.kernel.org/lkml/8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com/

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
