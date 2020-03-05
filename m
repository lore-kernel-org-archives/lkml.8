Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDD2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C482073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:42:37 -0500
Received: from verein.lst.de ([213.95.11.211]:60014 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgCEPmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:42:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD43668B05; Thu,  5 Mar 2020 16:42:33 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:42:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc 2/6] dma-remap: add additional atomic pools to map to gfp
 mask
Message-ID: <20200305154233.GA5332@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011537000.213582@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003011537000.213582@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 04:05:13PM -0800, David Rientjes wrote:
> The single atomic pool is allocated from the lowest zone possible since
> it is guaranteed to be applicable for any DMA allocation.
> 
> Devices may allocate through the DMA API but not have a strict reliance
> on GFP_DMA memory.  Since the atomic pool will be used for all
> non-blockable allocations, returning all memory from ZONE_DMA may
> unnecessarily deplete the zone.
> 
> Provision for multiple atomic pools that will map to the optimal gfp
> mask of the device.  These will be wired up in a subsequent patch.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/remap.c | 75 +++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -100,6 +100,8 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
>  
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  static struct gen_pool *atomic_pool __ro_after_init;
> +static struct gen_pool *atomic_pool_dma32 __ro_after_init;
> +static struct gen_pool *atomic_pool_normal __ro_after_init;

Maybe rename atomic_pool as well as it really kinda looks like the
default at the moment?

>  
>  #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
>  static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
> @@ -111,66 +113,79 @@ static int __init early_coherent_pool(char *p)
>  }
>  early_param("coherent_pool", early_coherent_pool);
>  
> -static gfp_t dma_atomic_pool_gfp(void)
> +static int __init __dma_atomic_pool_init(struct gen_pool **pool,
> +					 size_t pool_size, gfp_t gfp)
>  {

Can this just return the pool and return NULL (or an ERR_PTR) on
failure?
