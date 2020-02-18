Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A4C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FB920801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nC+ckAaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBRRQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:16:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgBRRQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DtnUK1xASlzt/HMPi6EpJNZIY4HCkmIAFuNb2drX+S0=; b=nC+ckAaT3f0TAwRj0Ixv6COnz/
        bA8ppTmtfdRbDRfBmTwGTFcdaCHxAYu9PVgc0w5snowjNkbT+n4eLW1hs54bAMcv0OKxlJTjHavJd
        H6gMAgypDPoZMtrY7/TZ82zhFO8PUHqCaXqU1KHWKMmFgJ/uZeuC9/w7wTfEN+SwvyLl934e1cw4n
        VO/cEhnVRwSmNe+zRgzOM+E0iq5RN3m2K4Xf6CQ+Kvud+VDqfpWJDDXeN4h2iwPQ0rrYI4Xs6yWZc
        hweugJeJIVA6jl7GSvXKH8i0l9nvCgc9svIb+7fOJo7kt/zfvx30a/iQevoRSoy8JZuPYPa3NFrVu
        6tnzLF2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j46Tp-0005de-Ng; Tue, 18 Feb 2020 17:16:17 +0000
Date:   Tue, 18 Feb 2020 09:16:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Move deferred device attachment into
 helper function
Message-ID: <20200218171617.GB7067@infradead.org>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-3-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void do_deferred_attach(struct device *dev)
>  {
> +	struct iommu_domain *domain;
>  
> +	dev->archdata.iommu = NULL;
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (domain)
> +		intel_iommu_attach_device(domain, dev);
> +}
> +
> +static struct dmar_domain *deferred_attach_domain(struct device *dev)
> +{
> +	if (unlikely(attach_deferred(dev)))
> +		do_deferred_attach(dev);
>  
>  	return find_domain(dev);
>  }

Can we start using proper sybmbol prefixes and avoid do_* names where
possible?
