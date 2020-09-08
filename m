Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1367BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC14D208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgIHLVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbgIHLPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:15:08 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1BE8208DB;
        Tue,  8 Sep 2020 11:14:56 +0000 (UTC)
Date:   Tue, 8 Sep 2020 12:14:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com, hch@lst.de,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC] arm64: mm: Do not use both DMA zones when 30-bit address
 space unavailable
Message-ID: <20200908111454.GB25591@gaia>
References: <20200819182434.28196-1-nsaenzjulienne@suse.de>
 <20200828174338.GK3169@gaia>
 <1ae30b3bfd97aba56323422baeb5b48b787c7561.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae30b3bfd97aba56323422baeb5b48b787c7561.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Mon, Sep 07, 2020 at 07:50:43PM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2020-08-28 at 18:43 +0100, Catalin Marinas wrote:
> > On Wed, Aug 19, 2020 at 08:24:33PM +0200, Nicolas Saenz Julienne wrote:
> > > There is no benefit in splitting the 32-bit address space into two
> > > distinct DMA zones when the 30-bit address space isn't even available on
> > > a device. If that is the case, default to one big ZONE_DMA spanning the
> > > whole 32-bit address space.
> > > 
> > > This will help reduce some of the issues we've seen with big crash
> > > kernel allocations.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > > 
> > > Whith this patch, on a 8GB RPi4 the setup looks like this:
> > > 
> > > 	DMA      [mem 0x0000000000000000-0x000000003fffffff]
> > > 	DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
> > > 	Normal   [mem 0x0000000100000000-0x00000001ffffffff]
> > > 
> > > And stock 8GB virtme/qemu:
> > > 
> > > 	DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> > > 	DMA32    empty
> > > 	Normal   [mem 0x0000000100000000-0x000000023fffffff]
> > > 
> > >  arch/arm64/mm/init.c | 29 +++++++++++++++++++++++++----
> > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index b6881d61b818..857a62611d7a 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -183,13 +183,20 @@ static void __init reserve_elfcorehdr(void)
> > >  
> > >  /*
> > >   * Return the maximum physical address for a zone with a given address size
> > > - * limit. It currently assumes that for memory starting above 4G, 32-bit
> > > - * devices will use a DMA offset.
> > > + * limit or zero if memory starts from an address higher than the zone targeted.
> > > + * It currently assumes that for memory starting above 4G, 32-bit devices will
> > > + * use a DMA offset.
> > >   */
> > >  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> > >  {
> > > -	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
> > > -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> > > +	phys_addr_t base = memblock_start_of_DRAM();
> > > +	phys_addr_t offset = base & GENMASK_ULL(63, 32);
> > > +	s64 zone_size = (1ULL << zone_bits) - (base & DMA_BIT_MASK(32));
> > > +
> > > +	if (zone_size <= 0)
> > > +		return 0;
> > > +
> > > +	return min(base + zone_size + offset, memblock_end_of_DRAM());
> > >  }
> > 
> > OK, so we can still get some ZONE_DMA if DRAM starts in the first GB.
> > 
> > I don't think it entirely solves the problem.
> 
> Agree. Didn't mean to imply it.

What I meant is that if we have a SoC with RAM starting at 0, it hits
the same issue with ZONE_DMA even if it doesn't have any 30-bit devices.
This patch assumes that RPi4 is the only device with RAM starting at 0.

> > It just happens that the
> > other affected SoCs don't have memory in the first GB. With this patch,
> > we go by the assumption that ZONE_DMA/DMA32 split is only needed if
> > there is memory in the low 1GB and such <32-bit devices don't have a DMA
> > offset.
> 
> The way I understand it is: "we may have 30 bit DMA limited devices, the rest
> can deal with 32 bit."
> 
> On top of that, I believe it makes little sense to use an offset in the
> physical address space below the 32bit mark. You'd be limiting the amount of
> memory available to the system. So, if you're going support DMA limited devices
> on your otherwise RAM hungry SoC, you'll have to have that physical address
> space directly available, or at least part of it.
> 
> All in all, I believe that assuming no 30 bit DMA limited devices exist in the
> system if the physical addresses don't exist is a fairly safe.

One could design a SoC with RAM starting at 2GB. A 30-bit device may
have bits 31 and 30 tied to 0b10 so that the access is offset into the
1st GB of RAM.

So while it's possible theoretically, I guess it's safe to assume it
won't happen soon.

> Also note the usage of 'zone_dma_bits' in the DMA code, which assumes that
> ZONE_DMA's physical address space is always smaller than (1 << zone_dma_bits) -
> 1.

I think part of those uses are broken. dma_direct_supported() does the
right thing and uses the DMA address instead of the physical one. Here
__phys_to_dma() subtracts the dma_pfn_offset, which in my above example
would be (0b10 << (30 - PAGE_SHIFT)).

dma_direct_optimal_gfp_mask(), OTOH, seems to start ok with a
__dma_to_phys() on the dma_limit but it ends up comparing the physical
address with the DMA mask. This gives the wrong result on arm64
platforms where RAM starts above 4GB and still expect a ZONE_DMA32. It
should compare *phys_limit with __dma_to_phys(DMA_BIT_MASK(...)). I
guess it ends up bouncing via swiotlb more often.

We assumed such offsets on arm64 since commit d50314a6b070 ("arm64:
Create non-empty ZONE_DMA when DRAM starts above 4GB").

> > An alternative (and I think we had a patch at some point) is to make it
> > generic and parse the dma-range in the DT to identify the minimum mask
> > and set ZONE_DMA accordingly. But this doesn't solve ACPI, so if Linux
> > can boot with ACPI on RPi4 it would still be broken.
> 
> ACPI is being worked on by, among others, Jeremy Linton (one of your colleagues
> I believe).
> 
> We could always use sane defaults for ACPI and be smarter with DT. Yet,
> implementing this entails translating nested dma-ranges with the only help of
> libfdt, which isn't trivial (see devices/of/address.c). IIRC RobH said that it
> wasn't worth the effort just for a board.

That would have been the ideal, more generic solution. But I agree that
it's not worth the effort if the only SoC affected is RPi4.

To summarise, I'd like ZONE_DMA to overlap with ZONE_DMA32 (i.e. expand
zone_dma_bits to 32 and drop ZONE_DMA32) for all SoCs other than RPi4.
The solutions so far:

1. Assume that, if RAM starts at 0, we need a zone_dma_bits == 30. This
   also assumes that it's only RPi4 in this category or that any such
   future SoC has a need for 30-bit DMA.

2. Adjust zone_dma_bits at boot-time only if the SoC is RPi4.

3. Use the more complex dma-ranges approach to calculate the correct
   zone_dma_bits as a minimum of all dma masks in the DT.

We can discount (3) as not worth the effort. I'd go with (1) (this
patch) if we can guarantee that no current or future SoC has RAM
starting at 0 while not needing 30-bit DMA masks. If not, we can go with
(2) unless others have a better suggestion.

-- 
Catalin
