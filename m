Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED6B2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBCRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:08:13 -0500
Received: from verein.lst.de ([213.95.11.211]:56981 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbgBCRIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:08:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F48368BFE; Mon,  3 Feb 2020 18:08:09 +0100 (CET)
Date:   Mon, 3 Feb 2020 18:08:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>, robh@kernel.org, vigneshr@ti.com,
        konrad.wilk@oracle.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, rogerq@ti.com
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when
 it is valid
Message-ID: <20200203170809.GA19293@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com> <20200114164332.3164-1-peter.ujfalusi@ti.com> <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com> <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com> <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com> <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de> <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com> <20200130164010.GA6472@lst.de> <c37b12e4-0e0c-afa2-a8e4-782ccd57542d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37b12e4-0e0c-afa2-a8e4-782ccd57542d@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 04:00:20PM +0200, Peter Ujfalusi wrote:
> I see. My PoC patch was not too off then ;)
> So the plan is to have a generic implementation for all of the
> architecture, right?

І don't know of a concrete plan, but that's defintively what I'd like
to see.

> >> The dma_pfn_offset is _still_ applied to the mask we are trying to set
> >> (and validate) via dma-direct.
> > 
> > And for the general case that is exactly the right thing to do, we
> > just need to deal with really odd ZONE_DMA placements like yours.
> 
> I'm still not convinced, the point of the DMA mask, at least how I see
> it, to check that the dma address can be handled by the device (DMA,
> peripheral with built in DMA, etc), it is not against physical address.
> Doing phys_to_dma() on the mask from the dma_set_mask() is just wrong.

We have a translation between the addresses that the device sees, and
those that the CPU sees.  The device can address N bits of address space
as seen from the device.  The addresses encoded in max_pfn,
zone_dma_bits or the harcoded 32 in the zone dma 32 case are CPU address.
So no, we can't blindly compare those.


> > But that will cause yet another regression in what we have just fixed
> > with using the generic direct ops, at which points it turns into who
> > screams louder.
> 
> Hehe, I see.
> I genuinely curious why k2 platform worked just fine with LPAE (it needs
> it), but guys had issues with LPAE on dra7/am5.
> The fix for dra7/am5 broke k2.
> As far as I can see the main (only) difference is that k2 have
> dma_pfn_offset = 0x780000, while dra7/am5 have it 0 (really direct mapping).

How much memory does the platform have?  Once you are above 32-bits worth
of address space devices with a 32-bit DMA mask can't address all the
memory.  Now if k2 for example only had less than 4G of memory, but at
addresses over 4G, and the offset compensates for the offset of the DRAM
it works without bounce buffering and thus didn't need swiotlb.  But any
platform that has DRAM that is not addressable will need swiotlb.

> >  	u64 min_mask;
> >  
> > +	if (mask >= DMA_BIT_MASK(32))
> > +		return 1;
> > +
> 
> Right, so skipping phys_to_dma() for the mask and believing that it will
> work..
> 
> It does: audio and dmatest memcpy tests are just fine with this, MMC
> also probed with ADMA enabled.
> 
> As far as I can tell it works as well as falling back to the old arm ops
> in case of LPAE && dma_pfn_offset != 0
> 
> Fwiw:
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Would you be comfortable to send this patch for mainline with
> Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE
> configs")

That is the big question.  I don't feel overly comfortable as I've been
trying to get this right, but so far it seems like the least bad option.
I'll send out a proper patch with updated comments and will see what
people think.
