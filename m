Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA28C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CC3206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CM1WTlXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHKFtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgHKFtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:49:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D439C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NOsh3G65hi+TCssaL7yrhoL+bIInJnFblszFK9D0Cnk=; b=CM1WTlXJnA0Ff0vX6lk6G+dxyf
        cCVYNx3G+b/Nbr9wSNLsns16xKIum5ESAdhhuKkWNC1H85zh3M5nZCuLNyM965OV7+jrBCZYC5XxH
        QGjwjKhBXdMG0F5G2eb83NN/oGKi6+Ch9YfHTClJ2C3PMKLtFiXH6y8CzB64j+lf0xHbcf20Hj/6A
        GGxWQr1NhzhVKFpxRgUnNd/h8vBY12TfYnpR9XFS1AFST0qF47oAgT3tErGxW32WsY18iiNaVMd8E
        CXrTk6tme1Ld0D7wCD5RtcVe4suSo/OQE/zbhLwXJdw+Zj3J4qylWOzO0/Htz0We00BT4EZi+h8go
        QGb5ad4g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5N9s-00006Q-LF; Tue, 11 Aug 2020 05:49:12 +0000
Date:   Tue, 11 Aug 2020 06:49:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ajay Kumar <ajaykumar.rs@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, will@kernel.org, joro@8bytes.org,
        nleeder@codeaurora.org, robin.murphy@arm.com, hch@infradead.org
Subject: Re: [RFC V2 PATCH] dma-iommu: allow devices to set IOVA range
 dynamically
Message-ID: <20200811054912.GA301@infradead.org>
References: <CGME20200810182328epcas5p2d5ffb5a5850a641fe7d31aa945c6c835@epcas5p2.samsung.com>
 <20200810175812.29100-1-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810175812.29100-1-ajaykumar.rs@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:28:12PM +0530, Ajay Kumar wrote:
> Currently, there is no other option to change the lower limit of
> IOVA for any device than calling iova_init_domain(), but the
> said function will re-init whole domain and also doesn't track
> the previously allocated IOVA before re-initing the domain.
> 
> There are cases where the device might not support continuous
> range of addresses, and can also have dependency among buffers
> allocated for firmware, image manipulation, etc and all of the
> address requests pass through IOMMU. In such cases, we can allocate
> buffers stage by stage by setting address limit, and also keep
> track the of same.
> 
> Bit of background can be found here:
> IOVA allocation dependency between firmware buffer and remaining buffers
> https://www.spinics.net/lists/iommu/msg43586.html
> 
> This patch allows devices to limit the IOVA space they want
> during allocation at any given point of time. We shall allow
> the same only if the device owns the corresponding iommu_domain,
> that is the device is the only master attached to the domain.
> 
> The lower limit of IOVA space is marked by start_pfn, and the upper
> limit is marked by dma_mask and this patch honors the same.
> Since changing dma_mask can extend the addressable region beyond
> current cached node, we do a reset of current cached nodes as well.
> 
> User drivers can make call sequence like below:
> ============================================================
> When they want to limit IOVA for allocated buffers in range
> 0x0 to 0x1000000:
> iommu_set_iova_range(dev, 0x0, 0x1000000 - 1);
> 
> When they want to limit IOVA for allocated buffers in range
> 0x1000000 to 0xC0000000:
> iommu_set_iova_range(dev, 0x1000000, 0xC0000000 - 0x1000000);
> =============================================================

This still seems to be missing an actual user of the functionality.
