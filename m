Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F002C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4283D20792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgG1KJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:09:23 -0400
Received: from verein.lst.de ([213.95.11.211]:47569 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgG1KJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:09:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FA8868B05; Tue, 28 Jul 2020 12:09:19 +0200 (CEST)
Date:   Tue, 28 Jul 2020 12:09:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200728100918.GA26364@lst.de>
References: <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de> <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com> <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de> <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com> <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de> <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com> <20200724134114.GA3152@lst.de> <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de> <20200728091335.GA23744@lst.de> <e39e8f87ed5b4e9da2f08a0651801954e61f4b4e.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39e8f87ed5b4e9da2f08a0651801954e61f4b4e.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 11:30:32AM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2020-07-28 at 11:13 +0200, Christoph Hellwig wrote:
> > On Mon, Jul 27, 2020 at 07:56:56PM +0200, Nicolas Saenz Julienne wrote:
> > > Hi Christoph,
> > > thanks for having a look at this!
> > > 
> > > On Fri, 2020-07-24 at 15:41 +0200, Christoph Hellwig wrote:
> > > > Yes, the iommu is an interesting case, and the current code is
> > > > wrong for that.
> > > 
> > > Care to expand on this? I do get that checking dma_coherent_ok() on memory
> > > that'll later on be mapped into an iommu is kind of silly, although I think
> > > harmless in Amir's specific case, since devices have wide enough dma-
> ranges. 
> > > Is
> > > there more to it?
> > 
> > I think the problem is that it can lead to not finding suitable memory.
> > 
> > > > Can you try the patch below?  It contains a modified version of Nicolas'
> > > > patch to try CMA again for the expansion and a new (for now hackish) way
> > > > to
> > > > not apply the addressability check for dma-iommu allocations.
> > > > 
> > > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > > index 6bc74a2d51273e..ec5e525d2b9309 100644
> > > > --- a/kernel/dma/pool.c
> > > > +++ b/kernel/dma/pool.c
> > > > @@ -3,7 +3,9 @@
> > > >   * Copyright (C) 2012 ARM Ltd.
> > > >   * Copyright (C) 2020 Google LLC
> > > >   */
> > > > +#include <linux/cma.h>
> > > >  #include <linux/debugfs.h>
> > > > +#include <linux/dma-contiguous.h>
> > > >  #include <linux/dma-direct.h>
> > > >  #include <linux/dma-noncoherent.h>
> > > >  #include <linux/init.h>
> > > > @@ -55,6 +57,31 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t
> > > > size)
> > > >  		pool_size_kernel += size;
> > > >  }
> > > >  
> > > > +static bool cma_in_zone(gfp_t gfp)
> > > > +{
> > > > +	phys_addr_t end;
> > > > +	unsigned long size;
> > > > +	struct cma *cma;
> > > > +
> > > > +	cma = dev_get_cma_area(NULL);
> > > > +	if (!cma)
> > > > +		return false;
> > > > +
> > > > +	size = cma_get_size(cma);
> > > > +	if (!size)
> > > > +		return false;
> > > > +	end = cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
> > > > +
> > > > +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> > > > +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA) &&
> > > > +	    end <= DMA_BIT_MASK(zone_dma_bits))
> > > > +		return true;
> > > > +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) &&
> > > > +	    end <= DMA_BIT_MASK(32))
> > > > +		return true;
> > > > +	return true;
> > > 
> > > IIUC this will always return true given a CMA is present. Which reverts to
> > > the
> > > previous behaviour (previous as in breaking some rpi4 setups), isn't it?
> > 
> > Was that really what broke the PI?  I'll try to get the split out series
> > today, which might have a few more tweaks, and then we'll need to test it
> > both on these rpi4 setups and Amits phone.
> 
> There was two issues with RPi:
>  - Not validating that pool allocated memory was OK for the device
>  - Locating all atomic pools in CMA, which doesn't work for all RPi4 devices*,
>    and IMO misses the point of having multiple pools.
> 
> * With ACPI RPi4 we have CMA located in ZONE_DMA32, yet have an atomic pool
> consumer, PCIe, that only wants memory in the [0 3GB] area, effectively needing
> ZONE_DMA memory.

Ok, I found a slight bug that wasn't intended.  I wanted to make sure
we can always fall back to a lower pool, but got that wrong.  Should be
fixed in the next version.
