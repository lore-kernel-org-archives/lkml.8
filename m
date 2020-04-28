Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875CFC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ADC206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AkRzSgUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD1ICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgD1ICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:02:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E0BC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Gc8wiZaH5vxzoL7Y4RD61mnokWImM3/OUm105M5x4Q=; b=AkRzSgUBS3spTGGb1FU2ZdnFp4
        7BKimlNU77GlBbuUM/8B5MPQQ/E6pQxNnqbGv+7iaZdB1yzXSBR4E6U5GIwvyG6VLpIOzmZt8b+Af
        FhXp4/msJvZ5wc9Q/RiSGYZjj5WugzIgMCgyvRtTHLiMoRI/isejvWR1rP9hHQqpa9qWD+mUpziT9
        uaVqa13Hhc/t59XAU11bOMVnUb4ynS0/3sHmfE672BTSnYmRzfdf+63SFCOFf2DKOM2/lg8NAzimF
        fD0PTuRTAIjTIr+c2X26hXxC4p/Xa5P+lwbVfvO9LSTlCL0fe8zEy86Odd6yWyhlALdnxCk28aydq
        KqW8hdGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTLBy-0000XO-Ed; Tue, 28 Apr 2020 08:02:10 +0000
Date:   Tue, 28 Apr 2020 01:02:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     peng.fan@nxp.com
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Message-ID: <20200428080210.GA25643@infradead.org>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:33:45PM +0800, peng.fan@nxp.com wrote:
> 
> In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask) or
> range_straddles_page_boundary(phys, size) are true, it will
> create contiguous region. So when free, we need to free contiguous
> region use upper check condition.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/xen/swiotlb-xen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index b6d27762c6f8..ab96e468584f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> -		     range_straddles_page_boundary(phys, size)) &&
> +	if (((dev_addr + size - 1 > dma_mask) ||
> +	    range_straddles_page_boundary(phys, size)) &&
>  	    TestClearPageXenRemapped(virt_to_page(vaddr)))

No need for the inner braces.

But more importantly please factor our a helper that can be used by
alloc and free to make sure that they always stay in sync.  Something
like:

static inline bool xen_swiotlb_need_contiguous_region(struct device *dev,
		phys_addr_t phys, size_t size)
{
	
	return xen_phys_to_bus(phys) + size - 1 > dev->coherent_dma_mask ||
		range_straddles_page_boundary(phys, size))
}

