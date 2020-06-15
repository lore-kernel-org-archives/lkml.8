Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F154C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B852067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgFOHBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:01:08 -0400
Received: from verein.lst.de ([213.95.11.211]:59869 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgFOHBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:01:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 010A568B05; Mon, 15 Jun 2020 09:00:14 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:00:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [patch for-5.8 4/4] dma-direct: add missing
 set_memory_decrypted() for coherent mapping
Message-ID: <20200615070014.GC21248@lst.de>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com> <alpine.DEB.2.22.394.2006111220010.153880@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006111220010.153880@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:20:32PM -0700, David Rientjes wrote:
> When a coherent mapping is created in dma_direct_alloc_pages(), it needs
> to be decrypted if the device requires unencrypted DMA before returning.
> 
> Fixes: 3acac065508f ("dma-mapping: merge the generic remapping helpers
> into dma-direct")
> Cc: stable@vger.kernel.org # 5.5+
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/direct.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -195,6 +195,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  				__builtin_return_address(0));
>  		if (!ret)
>  			goto out_free_pages;
> +		if (force_dma_unencrypted(dev)) {
> +			err = set_memory_decrypted((unsigned long)ret,
> +						   1 << get_order(size));
> +			if (err)
> +				goto out_free_pages;
> +		}

Note that ret is a vmalloc address here.  Does set_memory_decrypted
work for that case?  Again this should be mostly theoretical, so I'm
not too worried for now.
