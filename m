Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB49C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60E62064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pR6w489j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBQIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:03:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgBQIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8P83UJrtckadRvtNN0mURBLMcfies6xy/6xqO0urT5o=; b=pR6w489jwpWzTZkIt7TS4VRUAT
        0iSpnLjSF3rARv6DXNVyvB6Aa8BpTMgegD65WXsrGIk3psu+zT3RutRyP/8rP6glPkf75451XC85e
        tLs9mTddvqYGiw6MYBcVAD0UGxELfFiWqXvOfSTq4oupG2xHkvrz9mFUFAYRhLSB5WgAsbWb/oWB6
        i0egE74ary8QC3yIaRA3wZ+eLHzFiNwnA5km1BSyqkaKvltZLF0MLQvQIO7gS0drwvPPv8qqiomGC
        CFI1U5+529P/6m+E+khKN6UFr+0beNGTLcNBxKVtKBIqHZO7D5UqpsmZV1QimSIrlgUPEz7J+mdlR
        XjylMqfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3bNT-0005bX-51; Mon, 17 Feb 2020 08:03:39 +0000
Date:   Mon, 17 Feb 2020 00:03:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Liam Mark <lmark@codeaurora.org>, joro@8bytes.org,
        pratikp@codeaurora.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
Message-ID: <20200217080339.GC10342@infradead.org>
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 03:06:42PM -0800, Isaac J. Manjarres wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Using the best-fit algorithm, instead of the first-fit
> algorithm, may reduce fragmentation when allocating
> IOVAs.

As we like to say in standards groups:  may also implies may not.
Please provide numbers showing that this helps, and preferably and
explanation how it doesn't hurt as well.

> + * Should be called prior to using dma-apis.
> + */
> +int iommu_dma_enable_best_fit_algo(struct device *dev)
> +{
> +	struct iommu_domain *domain;
> +	struct iova_domain *iovad;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || !domain->iova_cookie)
> +		return -EINVAL;
>  
> +	iovad = &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
> +	iovad->best_fit = true;
>  	return 0;
>  }
> +EXPORT_SYMBOL(iommu_dma_enable_best_fit_algo);

Who is going to call this?  Patches adding exports always need a user
that goes along with the export.  Also drivers have no business calling
directly into dma-iommu.
