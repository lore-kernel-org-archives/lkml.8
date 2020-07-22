Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C615DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEBC2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbgGVVmD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:42:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgGVVmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:42:03 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id E8611F4957C3AE51D4A3;
        Thu, 23 Jul 2020 05:42:00 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Thu, 23 Jul 2020 05:41:50 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        huangdaode <huangdaode@huawei.com>
Subject: RE: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWTT1ZxTwLmOgUCE+K/2/rfDv6P6kTSH2AgAD8G8A=
Date:   Wed, 22 Jul 2020 21:41:50 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25A1606@DGGEMI525-MBS.china.huawei.com>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
 <20200722142943.GB17658@lst.de>
In-Reply-To: <20200722142943.GB17658@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, July 23, 2020 2:30 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
> per-numa CMA
> 
+cc Prime and Daode who are interested in this patchset.

> On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
> >  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t
> gfp)
> >  {
> >  	size_t count = size >> PAGE_SHIFT;
> >  	struct page *page = NULL;
> >  	struct cma *cma = NULL;
> > +	int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> > +	bool alloc_from_pernuma = false;
> > +
> > +	if ((count <= 1) && !(dev && dev->cma_area))
> > +		return NULL;
> >
> >  	if (dev && dev->cma_area)
> >  		cma = dev->cma_area;
> > -	else if (count > 1)
> > +	else if ((nid != NUMA_NO_NODE) &&
> dma_contiguous_pernuma_area[nid]
> > +		&& !(gfp & (GFP_DMA | GFP_DMA32))) {
> > +		cma = dma_contiguous_pernuma_area[nid];
> > +		alloc_from_pernuma = true;
> > +	} else {
> >  		cma = dma_contiguous_default_area;
> > +	}
> 
> I find the function rather confusing now.  What about something
> like (this relies on the fact that dev should never be NULL in the
> DMA API)
> 
> struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> {
> 	size_t cma_align = min_t(size_t, get_order(size),
> CONFIG_CMA_ALIGNMENT);
>  	size_t count = size >> PAGE_SHIFT;
> 
> 	if (gfpflags_allow_blocking(gfp))
> 		return NULL;
> 	gfp &= __GFP_NOWARN;
> 
> 	if (dev->cma_area)

I got a kernel robot warning which said dev should be checked before being accessed
when I did a similar change in v1. Probably it was an invalid warning if dev should
never be null.

> 		return cma_alloc(dev->cma_area, count, cma_align, gfp);
> 	if (count <= 1)
> 		return NULL;
> 
> 	if (IS_ENABLED(CONFIG_PERNODE_CMA) && !(gfp & (GFP_DMA |
> GFP_DMA32)) {
> 		int nid = dev_to_node(dev);
>  		struct cma *cma = dma_contiguous_pernuma_area[nid];
> 		struct page *page;
> 
> 		if (cma) {
> 			page = cma_alloc(cma, count, cma_align, gfp);
> 			if (page)
> 				return page;
> 		}
> 	}
> 
> 	return cma_alloc(dma_contiguous_default_area, count, cma_align, gfp);
> }

Yes, it looks much better.

> 
> > +		/*
> > +		 * otherwise, page is from either per-numa cma or default cma
> > +		 */
> > +		int nid = page_to_nid(page);
> > +
> > +		if (nid != NUMA_NO_NODE) {
> > +			if (cma_release(dma_contiguous_pernuma_area[nid], page,
> > +						PAGE_ALIGN(size) >> PAGE_SHIFT))
> > +				return;
> > +		}
> > +
> > +		if (cma_release(dma_contiguous_default_area, page,
> 
> How can page_to_nid ever return NUMA_NO_NODE?

I thought page_to_nid would return NUMA_NO_NODE if CONFIG_NUMA is
not enabled. Probably I was wrong. Will get it fixed in v4.

Thanks
Barry

