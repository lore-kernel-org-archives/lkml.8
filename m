Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E52AC35246
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FdMory5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgA3NE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:04:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33904 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgA3NE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:04:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UD3r8w022295;
        Thu, 30 Jan 2020 07:03:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580389433;
        bh=mEcLQEChF7CG3SdoHl9lJA4gqUSKK86HYBojtm7S8K4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FdMory5EL5Lpr0oRMV/b8+w2bkp0m8n3dQv69sKaKqOqAuQb7aVSxUZh0v5UsXSgg
         IDQfesYGJX3fhF+Gi4f5C2PIxuGmZNdZPCohbCRXc8q6GnwhwN7X6Pg5+qV3HTdI+E
         Lr3BM/QAGKgzOKtFWVKfsyuXXX3t2WX6q8Q6LGoM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UD3rwY115312;
        Thu, 30 Jan 2020 07:03:53 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 07:03:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 07:03:52 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UD3oM1101462;
        Thu, 30 Jan 2020 07:03:50 -0600
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To:     Christoph Hellwig <hch@lst.de>
CC:     Robin Murphy <robin.murphy@arm.com>, <vigneshr@ti.com>,
        <konrad.wilk@oracle.com>, <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@ti.com>,
        <robh@kernel.org>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com>
Date:   Thu, 30 Jan 2020 15:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130075332.GA30735@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2020 9.53, Christoph Hellwig wrote:
> [skipping the DT bits, as I'm everything but an expert on that..]
> 
> On Mon, Jan 27, 2020 at 04:00:30PM +0200, Peter Ujfalusi wrote:
>> I agree on the phys_to_dma(). It should fail for addresses which does
>> not fall into any of the ranges.
>> It is just a that we in Linux don't have the concept atm for ranges, we
>> have only _one_ range which applies to every memory address.
> 
> what does atm here mean?

struct device have only single dma_pfn_offset, one can not have multiple
ranges defined. If we have then only the first is taken and the physical
address and dma address is discarded, only the dma_pfn_offset is stored
and used.

> We have needed multi-range support for quite a while, as common broadcom
> SOCs do need it.  So patches for that are welcome at least from the
> DMA layer perspective (kinda similar to your pseudo code earlier)

But do they have dma_pfn_offset != 0?

>>> Nobody's disputing that the current dma_direct_supported()
>>> implementation is broken for the case where ZONE_DMA itself is offset
>>> from PA 0; the more pressing question is why Christoph's diff, which was
>>> trying to take that into account, still didn't work.
>>
>> I understand that this is a bit more complex than I interpret it, but
>> the k2g is broken and currently the simplest way to make it work is to
>> use the arm dma_ops in case the pfn_offset is not 0.
>> It will be easy to test dma-direct changes trying to address the issue
>> in hand, but will allow k2g to be usable at the same time.
> 
> Well, using the legacy arm dma ops means we can't use swiotlb if there
> is an offset, which is also wrong for lots of common cases, including
> the Rpi 4.  I'm still curious why my patch didn't work, as I thought
> it should.

The dma_pfn_offset is _still_ applied to the mask we are trying to set
(and validate) via dma-direct.

in dma_direct_supported:
mask == 0xffffffff // DMA_BIT_MASK(32)
dev->dma_pfn_offset == 0x780000 // Keystone 2
min_mask == 0xffffff

tmp_mask = __phys_to_dma(dev, min_mask);
tmp_mask == 0xff880ffffff

within __phys_to_dma() converts the min_mask to pfn and calls
pfn_to_dma() which does:
if (dev)
	pfn -= dev->dma_pfn_offset;

the returned pfn is then converted back to address.

the mask (0xffffffff) is well under the tmp_mask (0xff880ffffff) so
dma_direct_supported() will tell us that DMA is not supported for
DMA_BIT_MASK(32), which is not true, because DMA is supporting 32 bits.

> We'll need to find the minimum change to make it work
> for now without switching ops, even if it isn't the correct one, and
> then work from there.

Sure, but can we fix the regression by reverting to arm_ops for now only
if dma_pfn_offset is not 0? It used to work fine in the past at least it
appeared to work on K2 platforms.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
