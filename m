Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246C5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003762067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFOGy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:54:58 -0400
Received: from verein.lst.de ([213.95.11.211]:59830 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgFOGy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:54:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 82E9968B02; Mon, 15 Jun 2020 08:54:55 +0200 (CEST)
Date:   Mon, 15 Jun 2020 08:54:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [patch for-5.8 1/4] dma-direct: always align allocation size
 in dma_direct_alloc_pages()
Message-ID: <20200615065455.GA21248@lst.de>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com> <alpine.DEB.2.22.394.2006111218570.153880@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006111218570.153880@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:20:28PM -0700, David Rientjes wrote:
> dma_alloc_contiguous() does size >> PAGE_SHIFT and set_memory_decrypted()
> works at page granularity.  It's necessary to page align the allocation
> size in dma_direct_alloc_pages() for consistent behavior.
> 
> This also fixes an issue when arch_dma_prep_coherent() is called on an
> unaligned allocation size for dma_alloc_need_uncached() when
> CONFIG_DMA_DIRECT_REMAP is disabled but CONFIG_ARCH_HAS_DMA_SET_UNCACHED
> is enabled.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/direct.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -112,11 +112,12 @@ static inline bool dma_should_free_from_pool(struct device *dev,
>  struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  		gfp_t gfp, unsigned long attrs)
>  {
> -	size_t alloc_size = PAGE_ALIGN(size);
>  	int node = dev_to_node(dev);
>  	struct page *page = NULL;
>  	u64 phys_limit;
>  
> +	VM_BUG_ON(!PAGE_ALIGNED(size));

This really should be a WARN_ON_ONCE, but I've fixed this up before
applying.  I've also added a prep patch to mark __dma_direct_alloc_pages
static as part of auditing for other callers.
