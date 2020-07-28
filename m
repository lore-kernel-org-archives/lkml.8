Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE4BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4BC2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgG1MTQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:19:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728825AbgG1MTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:19:15 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 29EBAF5557244007B84B;
        Tue, 28 Jul 2020 20:19:14 +0800 (CST)
Received: from DGGEMI421-HUB.china.huawei.com (10.1.199.150) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 28 Jul 2020 20:19:13 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.120]) by
 dggemi421-hub.china.huawei.com ([10.1.199.150]) with mapi id 14.03.0487.000;
 Tue, 28 Jul 2020 20:19:03 +0800
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
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        huangdaode <huangdaode@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWYPN0xh/nM4EZ4kKvOhwzWqp/oakcYyKAgACGKwA=
Date:   Tue, 28 Jul 2020 12:19:03 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25C329D@DGGEMI525-MBS.china.huawei.com>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com>
 <20200723131344.41472-2-song.bao.hua@hisilicon.com>
 <20200728115231.GA793@lst.de>
In-Reply-To: <20200728115231.GA793@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.55]
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
> Sent: Tuesday, July 28, 2020 11:53 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> huangdaode <huangdaode@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v4 1/2] dma-direct: provide the ability to reserve
> per-numa CMA
> 
> On Fri, Jul 24, 2020 at 01:13:43AM +1200, Barry Song wrote:
> > +config CMA_PERNUMA_SIZE_MBYTES
> > +	int "Size in Mega Bytes for per-numa CMA areas"
> > +	depends on NUMA
> > +	default 16 if ARM64
> > +	default 0
> > +	help
> > +	  Defines the size (in MiB) of the per-numa memory area for Contiguous
> > +	  Memory Allocator. Every numa node will get a separate CMA with this
> > +	  size. If the size of 0 is selected, per-numa CMA is disabled.
> 
> I'm still not a fan of the config option.  You can just hardcode the
> value in CONFIG_CMDLINE based on the kernel parameter.  Also I wonder

I am sorry I haven't got your point yet. Do you mean something like the below?

arch/arm64/Kconfig:
config CMDLINE
	string "Default kernel command string"
-	default ""
+	default "pernuma_cma=16M"
	help
	  Provide a set of default command-line options at build time by
	  entering them here. As a minimum, you should specify the the
	  root device (e.g. root=/dev/nfs).

A background of the current code is that Linux distributions can usually use arch/arm64/configs/defconfig
directly to build kernel. cmdline can be easily ignored during the generation of Linux distributions.

> if a way to expose this in the device tree might be useful, but people
> more familiar with the device tree and the arm code will have to chime
> in on that.

Not sure if it is an useful user case as we are using ACPI but not device tree since it is an ARM64
server with NUMA.

> 
> >  struct cma *dma_contiguous_default_area;
> > +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> >
> >  /*
> >   * Default global CMA area size can be defined in kernel's .config.
> > @@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
> >   */
> >  static const phys_addr_t size_bytes __initconst =
> >  	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> > +static phys_addr_t pernuma_size_bytes __initdata =
> > +	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
> >  static phys_addr_t  size_cmdline __initdata = -1;
> >  static phys_addr_t base_cmdline __initdata;
> >  static phys_addr_t limit_cmdline __initdata;
> > @@ -69,6 +78,13 @@ static int __init early_cma(char *p)
> >  }
> >  early_param("cma", early_cma);
> >
> > +static int __init early_pernuma_cma(char *p)
> > +{
> > +	pernuma_size_bytes = memparse(p, &p);
> > +	return 0;
> > +}
> > +early_param("pernuma_cma", early_pernuma_cma);
> > +
> >  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
> >
> >  static phys_addr_t __init __maybe_unused
> cma_early_percent_memory(void)
> > @@ -96,6 +112,33 @@ static inline __maybe_unused phys_addr_t
> cma_early_percent_memory(void)
> >
> >  #endif
> >
> > +void __init dma_pernuma_cma_reserve(void)
> > +{
> > +	int nid;
> > +
> > +	if (!pernuma_size_bytes)
> > +		return;
> > +
> > +	for_each_node_state(nid, N_MEMORY) {
> > +		int ret;
> > +		char name[20];
> > +
> > +		snprintf(name, sizeof(name), "pernuma%d", nid);
> > +		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> > +						 0, false, name,
> > +						 &dma_contiguous_pernuma_area[nid],
> > +						 nid);
> 
> This adds a > 80 char line.

Will refine.

> 
> >  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t
> gfp)
> >  {
> > +	int nid = dev_to_node(dev);
> > +
> >  	/* CMA can be used only in the context which permits sleeping */
> >  	if (!gfpflags_allow_blocking(gfp))
> >  		return NULL;
> >  	if (dev->cma_area)
> >  		return cma_alloc_aligned(dev->cma_area, size, gfp);
> > -	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
> > +	if (size <= PAGE_SIZE)
> >  		return NULL;
> > +
> > +	if ((nid != NUMA_NO_NODE) && !(gfp & (GFP_DMA | GFP_DMA32))) {
> 
> No need for the braces around the nid check.

Will refine.

> 
> > +		struct cma *cma = dma_contiguous_pernuma_area[nid];
> > +		struct page *page;
> > +
> > +		if (cma) {
> > +			page = cma_alloc_aligned(cma, size, gfp);
> > +			if (page)
> > +				return page;
> > +		}
> > +	}
> > +
> >  	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
> 
> This seems to have lost the dma_contiguous_default_area NULL check.

cma_alloc() is doing the check by returning NULL if cma is NULL.

struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
		       bool no_warn)
{
	...
	if (!cma || !cma->count)
		return NULL;
}

But I agree here the code can check before calling cma_alloc_aligned.

> 
> > +	/* if dev has its own cma, free page from there */
> > +	if (dev->cma_area) {
> > +		if (cma_release(dev->cma_area, page, PAGE_ALIGN(size) >>
> PAGE_SHIFT))
> > +			return;
> 
> Another overly long line.

Will refine.

> 
> > +	} else {
> > +		/*
> > +		 * otherwise, page is from either per-numa cma or default cma
> > +		 */
> > +		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
> > +					page, PAGE_ALIGN(size) >> PAGE_SHIFT))
> > +			return;
> > +
> > +		if (cma_release(dma_contiguous_default_area, page,
> > +					PAGE_ALIGN(size) >> PAGE_SHIFT))
> > +			return;
> > +	}
> 
> I'd introduce a count variable for the value of "PAGE_ALIGN(size) >>
> PAGE_SHIFT" to clean al lthis up a bit.

Good idea.

> 
> Also please add a CONFIG_PERCPU_DMA_CMA config variable so that we
> don't build this code for the vast majority of users that don't need it.

agreed.

Thanks
Barry

