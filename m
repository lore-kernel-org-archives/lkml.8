Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C143C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53492078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgHQKU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:20:28 -0400
Received: from verein.lst.de ([213.95.11.211]:56177 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHQKU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:20:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46FC568B05; Mon, 17 Aug 2020 12:20:21 +0200 (CEST)
Date:   Mon, 17 Aug 2020 12:20:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] swiotlb: Allow allocating buffer anywhere in memory
Message-ID: <20200817102020.GD25336@lst.de>
References: <20200815204536.663801-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815204536.663801-1-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 05:45:36PM -0300, Thiago Jung Bauermann wrote:
> POWER secure guests (i.e., guests which use the Protection Execution
> Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
> they don't need the SWIOTLB memory to be in low addresses since the
> hypervisor doesn't have any addressing limitation.
> 
> This solves a SWIOTLB initialization problem we are seeing in secure guests
> with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
> memory, which leaves no space for SWIOTLB in low addresses.

What about just open coding the allocation and using
swiotlb_init_with_tbl?

> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/mm/mem.c   |  7 ++++++-
>  include/linux/swiotlb.h |  8 +++++++-
>  kernel/dma/swiotlb.c    | 10 +++++++---
>  3 files changed, 20 insertions(+), 5 deletions(-)
> 
> Normally I would split changes like this into one patch touching generic
> code and another for the arch-specific part, but in this case I thought it
> would be unneeded complexity. I can split though if people prefer it that
> way.
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index c2c11eb8dcfc..13f2e3aff8b5 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -50,6 +50,7 @@
>  #include <asm/swiotlb.h>
>  #include <asm/rtas.h>
>  #include <asm/kasan.h>
> +#include <asm/svm.h>
>  
>  #include <mm/mmu_decl.h>
>  
> @@ -290,7 +291,11 @@ void __init mem_init(void)
>  	 * back to to-down.
>  	 */
>  	memblock_set_bottom_up(true);
> -	swiotlb_init(0);
> +	/*
> +	 * SVM guests can use the SWIOTLB wherever it is in memory,
> +	 * even if not DMA-able.
> +	 */
> +	swiotlb_init_anywhere(0, is_secure_guest());
>  #endif
>  
>  	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 046bb94bd4d6..433f3dbb35b5 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -29,7 +29,13 @@ enum swiotlb_force {
>   */
>  #define IO_TLB_SHIFT 11
>  
> -extern void swiotlb_init(int verbose);
> +void __init swiotlb_init_anywhere(int verbose, bool allocate_anywhere);
> +
> +static inline void swiotlb_init(int verbose)
> +{
> +	swiotlb_init_anywhere(verbose, false);
> +}
> +
>  int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
>  extern unsigned long swiotlb_nr_tbl(void);
>  unsigned long swiotlb_size_or_default(void);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..27070aa59e34 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -244,7 +244,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>   * structures for the software IO TLB used to implement the DMA API.
>   */
>  void  __init
> -swiotlb_init(int verbose)
> +swiotlb_init_anywhere(int verbose, bool allocate_anywhere)
>  {
>  	size_t default_size = IO_TLB_DEFAULT_SIZE;
>  	unsigned char *vstart;
> @@ -257,8 +257,12 @@ swiotlb_init(int verbose)
>  
>  	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
>  
> -	/* Get IO TLB memory from the low pages */
> -	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> +	if (allocate_anywhere)
> +		vstart = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
> +	else
> +		/* Get IO TLB memory from the low pages */
> +		vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> +
>  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
>  		return;
>  
---end quoted text---
