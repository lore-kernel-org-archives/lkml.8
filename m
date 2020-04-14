Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5809C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE1320678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406077AbgDNGng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 02:43:36 -0400
Received: from verein.lst.de ([213.95.11.211]:37684 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgDNGnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:43:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EBA468BEB; Tue, 14 Apr 2020 08:43:32 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:43:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc v2 4/6] dma-direct: atomic allocations must come from
 atomic coherent pools
Message-ID: <20200414064332.GB23359@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com> <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/*
> +	 * Unencrypted memory must come directly from DMA atomic pools if
> +	 * blocking is not allowed.
> +	 */
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp)) {
> +		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
> +		if (!ret)
> +			return NULL;
> +		goto done;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>  	    dma_alloc_need_uncached(dev, attrs) &&
>  	    !gfpflags_allow_blocking(gfp)) {

Can we keep a single conditional for the pool allocations?  Maybe
add a new dma_alloc_from_pool helper ala:

static inline bool dma_alloc_from_pool(struct device *dev, gfp_t gfp)
{
	if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
		return false;
	if (gfpflags_allow_blocking(gfp))
		return false;
	if (force_dma_unencrypted(dev))
		return true;
	if (dma_alloc_need_uncached(dev))
		return true;
}
}

> @@ -203,6 +215,10 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>  {
>  	unsigned int page_order = get_order(size);
>  
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
> +		return;
> +

Similarly I think we should have a single conditional to free from the
pool instead.
