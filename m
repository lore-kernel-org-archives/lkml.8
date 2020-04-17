Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CECC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD3221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgDQHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:06:27 -0400
Received: from verein.lst.de ([213.95.11.211]:56015 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgDQHG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:06:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6053468BFE; Fri, 17 Apr 2020 09:06:21 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:06:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [patch 1/7] dma-remap: separate DMA atomic pools from direct
 remap code
Message-ID: <20200417070620.GA19153@lst.de>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com> <alpine.DEB.2.22.394.2004141703030.68516@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2004141703030.68516@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:04:52PM -0700, David Rientjes wrote:
> DMA atomic pools will be needed beyond only CONFIG_DMA_DIRECT_REMAP so
> separate them out into their own file.
> 
> This also adds a new Kconfig option that can be subsequently used for
> options, such as CONFIG_AMD_MEM_ENCRYPT, that will utilize the coherent
> pools but do not have a dependency on direct remapping.
> 
> For this patch alone, there is no functional change introduced.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/Kconfig  |   6 ++-
>  kernel/dma/Makefile |   1 +
>  kernel/dma/pool.c   | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/dma/remap.c  | 114 ----------------------------------------
>  4 files changed, 129 insertions(+), 115 deletions(-)
>  create mode 100644 kernel/dma/pool.c
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 4c103a24e380..d006668c0027 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -79,10 +79,14 @@ config DMA_REMAP
>  	select DMA_NONCOHERENT_MMAP
>  	bool
>  
> -config DMA_DIRECT_REMAP
> +config DMA_COHERENT_POOL
>  	bool
>  	select DMA_REMAP
>  
> +config DMA_DIRECT_REMAP
> +	bool
> +	select DMA_COHERENT_POOL
> +
>  config DMA_CMA
>  	bool "DMA Contiguous Memory Allocator"
>  	depends on HAVE_DMA_CONTIGUOUS && CMA
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index d237cf3dc181..370f63344e9c 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
>  obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
>  obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
>  obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
> +obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
>  obj-$(CONFIG_DMA_REMAP)			+= remap.o
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> new file mode 100644
> index 000000000000..6612c2d51d3c
> --- /dev/null
> +++ b/kernel/dma/pool.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Google LLC

This now also lost the ARM copyright in addition to the Linuxfoundation
one, but I can fix that up.  Otherwise it looks good to me.
