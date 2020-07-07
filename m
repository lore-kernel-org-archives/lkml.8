Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448EA20702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGGGzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:55:54 -0400
Received: from verein.lst.de ([213.95.11.211]:57417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgGGGzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:55:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 21E0268BEB; Tue,  7 Jul 2020 08:55:50 +0200 (CEST)
Date:   Tue, 7 Jul 2020 08:55:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     David Rientjes <rientjes@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mm@kvack.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [BUG] XHCI getting ZONE_DMA32 memory > than its bus_dma_limit
Message-ID: <20200707065549.GA23760@lst.de>
References: <34619bdf-6527-ae82-7e4d-e2ea7c67ed56@arm.com> <a9058fd2c54bbea69fdf97e30277338a61b5c0b4.camel@suse.de> <cc17fe85-99a3-ec8c-985a-2a21cf09bf49@arm.com> <alpine.DEB.2.23.453.2007051635250.3687564@chino.kir.corp.google.com> <32ee3bf222b1966caa98b67a9cec8712817a4b52.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ee3bf222b1966caa98b67a9cec8712817a4b52.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 04:09:36PM +0200, Nicolas Saenz Julienne wrote:
> On Sun, 2020-07-05 at 16:41 -0700, David Rientjes wrote:
> > On Fri, 3 Jul 2020, Robin Murphy wrote:
> > > Or perhaps just get rid of atomic_pool_dma32 (and allocate atomic_pool_dma
> > > from ZONE_DMA32 if !ZONE_DMA). That should make it fall pretty much back in
> > > line while still preserving the potential benefit of the kernel pool for
> > > non-address-constrained devices.
> > > 
> > 
> > I assume it depends on how often we have devices where 
> > __dma_direct_alloc_pages() behavior is required, i.e. what requires the 
> > dma_coherent_ok() checks and altering of the gfp flags to get memory that 
> > works.
> > 
> > Is the idea that getting rid of atomic_pool_dma32 would use GFP_KERNEL 
> > (and atomic_pool_kernel) as the default policy here?  That doesn't do any 
> > dma_coherent_ok() checks so dma_direct_alloc_pages would return from 
> > ZONE_NORMAL without a < 3G check?
> 
> IIUC this is not what Robin proposes.
> 
> The idea is to only have one DMA pool, located in ZONE_DMA, if enabled, and
> ZONE_DMA32 otherwise. This way you're always sure the memory is going to be
> good enough for any device while maintaining the benefits of
> atomic_pool_kernel.

That is how I understood the proposal from Robin and I think it is
the right thing to do.

> > It *seems* like we want to check if dma_coherent_ok() succeeds for ret in 
> > dma_direct_alloc_pages() when allocating from the atomic pool and, based 
> > on criteria that allows fallback, just fall into 
> > __dma_direct_alloc_pages()?
> 
> I suspect I don't have enough perspective here but, isn't that breaking the
> point of having an atomic pool? Wouldn't that generate big latency spikes? I
> can see how audio transfers over USB could be affected by this specifically,
> IIRC those are allocated atomically and have timing constraints.
> 
> That said, if Robin solution works for you, I don't mind having a go at it.

We can't just fall back to __dma_direct_alloc_pages when allocation
from the atomic pool fails, as the atomic pool exists for provide
allocations that require sleeping actions for callers that can't
sleep.
