Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2425C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A2320855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHHGd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 02:33:58 -0400
Received: from verein.lst.de ([213.95.11.211]:56035 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHHGd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 02:33:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C5AB68C7B; Sat,  8 Aug 2020 08:33:55 +0200 (CEST)
Date:   Sat, 8 Aug 2020 08:33:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200808063354.GA17329@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de> <20200806184756.32075-3-nsaenzjulienne@suse.de> <20200807052116.GA584@lst.de> <aae9250e660339142e9390427a603c4cf4e282af.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae9250e660339142e9390427a603c4cf4e282af.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 10:50:19AM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2020-08-07 at 07:21 +0200, Christoph Hellwig wrote:
> > On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> > > There is no guarantee to CMA's placement, so allocating a zone specific
> > > atomic pool from CMA might return memory from a completely different
> > > memory zone. To get around this double check CMA's placement before
> > > allocating from it.
> > 
> > As the builtbot pointed out, memblock_start_of_DRAM can't be used from
> > non-__init code.  But lookig at it I think throwing that in
> > is bogus anyway, as cma_get_base returns a proper physical address
> > already.
> 
> It does indeed, but I'm comparing CMA's base with bitmasks that don't take into
> account where the memory starts. Say memory starts at 0x80000000, and CMA falls
> into ZONE_DMA [0x80000000 0xC0000000], if you want to compare it with
> DMA_BIT_MASK(zone_dma_bits) you're forced to unify the memory bases.
> 
> That said, I now realize that this doesn't work for ZONE_DMA32 which has a hard
> limit on 32bit addresses reglardless of the memory base.
> 
> That said I still need to call memblock_start_of_DRAM() any suggestions WRT
> that? I could save the value in dma_atomic_pool_init(), which is __init code.

The pool must be about a 32-bit physical address.  The offsets can be
different for every device..
