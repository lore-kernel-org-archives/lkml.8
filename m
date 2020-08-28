Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D13C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744F72098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH1Rno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1Rnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:43:43 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB422074A;
        Fri, 28 Aug 2020 17:43:41 +0000 (UTC)
Date:   Fri, 28 Aug 2020 18:43:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com, hch@lst.de,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org
Subject: Re: [RFC] arm64: mm: Do not use both DMA zones when 30-bit address
 space unavailable
Message-ID: <20200828174338.GK3169@gaia>
References: <20200819182434.28196-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819182434.28196-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, Aug 19, 2020 at 08:24:33PM +0200, Nicolas Saenz Julienne wrote:
> There is no benefit in splitting the 32-bit address space into two
> distinct DMA zones when the 30-bit address space isn't even available on
> a device. If that is the case, default to one big ZONE_DMA spanning the
> whole 32-bit address space.
> 
> This will help reduce some of the issues we've seen with big crash
> kernel allocations.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> Whith this patch, on a 8GB RPi4 the setup looks like this:
> 
> 	DMA      [mem 0x0000000000000000-0x000000003fffffff]
> 	DMA32    [mem 0x0000000040000000-0x00000000ffffffff]
> 	Normal   [mem 0x0000000100000000-0x00000001ffffffff]
> 
> And stock 8GB virtme/qemu:
> 
> 	DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> 	DMA32    empty
> 	Normal   [mem 0x0000000100000000-0x000000023fffffff]
> 
>  arch/arm64/mm/init.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b6881d61b818..857a62611d7a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -183,13 +183,20 @@ static void __init reserve_elfcorehdr(void)
>  
>  /*
>   * Return the maximum physical address for a zone with a given address size
> - * limit. It currently assumes that for memory starting above 4G, 32-bit
> - * devices will use a DMA offset.
> + * limit or zero if memory starts from an address higher than the zone targeted.
> + * It currently assumes that for memory starting above 4G, 32-bit devices will
> + * use a DMA offset.
>   */
>  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>  {
> -	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
> -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> +	phys_addr_t base = memblock_start_of_DRAM();
> +	phys_addr_t offset = base & GENMASK_ULL(63, 32);
> +	s64 zone_size = (1ULL << zone_bits) - (base & DMA_BIT_MASK(32));
> +
> +	if (zone_size <= 0)
> +		return 0;
> +
> +	return min(base + zone_size + offset, memblock_end_of_DRAM());
>  }

OK, so we can still get some ZONE_DMA if DRAM starts in the first GB.

I don't think it entirely solves the problem. It just happens that the
other affected SoCs don't have memory in the first GB. With this patch,
we go by the assumption that ZONE_DMA/DMA32 split is only needed if
there is memory in the low 1GB and such <32-bit devices don't have a DMA
offset.

Adding Rob H (it's easier to ask him than grep'ing the DT files ;)), we
may be ok with this assumption on current SoCs.

An alternative (and I think we had a patch at some point) is to make it
generic and parse the dma-range in the DT to identify the minimum mask
and set ZONE_DMA accordingly. But this doesn't solve ACPI, so if Linux
can boot with ACPI on RPi4 it would still be broken.

-- 
Catalin
