Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B097BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD072073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCEPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:45:00 -0500
Received: from verein.lst.de ([213.95.11.211]:60028 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgCEPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:44:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4FC168B05; Thu,  5 Mar 2020 16:44:56 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:44:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc 5/6] dma-direct: atomic allocations must come from
 unencrypted pools
Message-ID: <20200305154456.GC5332@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:05:23PM -0800, David Rientjes wrote:
> When AMD memory encryption is enabled, all non-blocking DMA allocations
> must originate from the atomic pools depending on the device and the gfp
> mask of the allocation.
> 
> Keep all memory in these pools unencrypted.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  arch/x86/Kconfig    | 1 +
>  kernel/dma/direct.c | 9 ++++-----
>  kernel/dma/remap.c  | 2 ++
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1523,6 +1523,7 @@ config X86_CPA_STATISTICS
>  config AMD_MEM_ENCRYPT
>  	bool "AMD Secure Memory Encryption (SME) support"
>  	depends on X86_64 && CPU_SUP_AMD
> +	select DMA_DIRECT_REMAP

I think we need to split the pool from remapping so that we don't drag
in the remap code for x86.

>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    dma_alloc_need_uncached(dev, attrs) &&

We still need a check here for either uncached or memory encryption.

> @@ -141,6 +142,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	if (!addr)
>  		goto free_page;
>  
> +	set_memory_decrypted((unsigned long)page_to_virt(page), nr_pages);

This probably warrants a comment.

Also I think the infrastructure changes should be split from the x86
wire up.
