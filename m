Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63472C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3572074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHNKDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgHNKDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:03:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E37FAD1B;
        Fri, 14 Aug 2020 10:03:34 +0000 (UTC)
Message-ID: <ae794be3426776d5977fdb12e42807c0d82ce203.camel@suse.de>
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     amit.pundir@linaro.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, rientjes@google.com,
        Robin Murphy <robin.murphy@arm.com>
Date:   Fri, 14 Aug 2020 12:03:09 +0200
In-Reply-To: <20200814060642.GA1338@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de>
         <20200806184756.32075-3-nsaenzjulienne@suse.de>
         <20200807052116.GA584@lst.de>
         <aae9250e660339142e9390427a603c4cf4e282af.camel@suse.de>
         <20200808063354.GA17329@lst.de> <20200814060642.GA1338@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 08:06 +0200, Christoph Hellwig wrote:
> On Sat, Aug 08, 2020 at 08:33:54AM +0200, Christoph Hellwig wrote:
> > On Fri, Aug 07, 2020 at 10:50:19AM +0200, Nicolas Saenz Julienne wrote:
> > > On Fri, 2020-08-07 at 07:21 +0200, Christoph Hellwig wrote:
> > > > On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> > > > > There is no guarantee to CMA's placement, so allocating a zone specific
> > > > > atomic pool from CMA might return memory from a completely different
> > > > > memory zone. To get around this double check CMA's placement before
> > > > > allocating from it.
> > > > 
> > > > As the builtbot pointed out, memblock_start_of_DRAM can't be used from
> > > > non-__init code.  But lookig at it I think throwing that in
> > > > is bogus anyway, as cma_get_base returns a proper physical address
> > > > already.
> > > 
> > > It does indeed, but I'm comparing CMA's base with bitmasks that don't take into
> > > account where the memory starts. Say memory starts at 0x80000000, and CMA falls
> > > into ZONE_DMA [0x80000000 0xC0000000], if you want to compare it with
> > > DMA_BIT_MASK(zone_dma_bits) you're forced to unify the memory bases.
> > > 
> > > That said, I now realize that this doesn't work for ZONE_DMA32 which has a hard
> > > limit on 32bit addresses reglardless of the memory base.
> > > 
> > > That said I still need to call memblock_start_of_DRAM() any suggestions WRT
> > > that? I could save the value in dma_atomic_pool_init(), which is __init code.
> > 
> > The pool must be about a 32-bit physical address.  The offsets can be
> > different for every device..

I now see what you mean.

I was trying to blindly fit CMA with arm64's DMA zone setup, which, as it turns
out, doesn't really honor its purpose. arm64 introduced ZONE_DMA to provide a
30-bit address space, but we're creating it regardless of whether it exists or
not. This creates a mismatch between zone_dma_bits and ZONE_DMA's real
placement. I'll try to look at fixing that in arm64.

> Do you plan to resend this one without the memblock_start_of_DRAM
> thingy?

Yes, sorry for the wait, I've been on vacation and short on time, I'll send it
during the day.

Regards,
Nicolas

