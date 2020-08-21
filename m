Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE530C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8800207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHUJoQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:44:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgHUJoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:44:15 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 2F7596B2AF45BDFCDE06;
        Fri, 21 Aug 2020 17:44:09 +0800 (CST)
Received: from dggema771-chm.china.huawei.com (10.1.198.213) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 21 Aug 2020 17:44:08 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema771-chm.china.huawei.com (10.1.198.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 21 Aug 2020 17:44:08 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 21 Aug 2020 17:44:08 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Will Deacon <will@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        huangdaode <huangdaode@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWd2LcxiMeqDASCk2fUz72+ALjbKlBunaAgACH7kD//4M8AIAAhymg
Date:   Fri, 21 Aug 2020 09:44:08 +0000
Message-ID: <850443180c3c48c8bcb146e114556870@hisilicon.com>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821022615.28596-2-song.bao.hua@hisilicon.com>
 <20200821084717.GA20255@willie-the-truck>
 <4ab78767553f48a584217063f6f24eb9@hisilicon.com>
 <20200821092713.GD20255@willie-the-truck>
In-Reply-To: <20200821092713.GD20255@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: Friday, August 21, 2020 9:27 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> huangdaode <huangdaode@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
> per-numa CMA
> 
> On Fri, Aug 21, 2020 at 09:13:39AM +0000, Song Bao Hua (Barry Song) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Will Deacon [mailto:will@kernel.org]
> > > Sent: Friday, August 21, 2020 8:47 PM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> > > ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
> > > iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > huangdaode <huangdaode@huawei.com>; Jonathan Cameron
> > > <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>;
> > > Andrew Morton <akpm@linux-foundation.org>; Mike Rapoport
> > > <rppt@linux.ibm.com>
> > > Subject: Re: [PATCH v6 1/2] dma-contiguous: provide the ability to
> > > reserve per-numa CMA
> > >
> > > On Fri, Aug 21, 2020 at 02:26:14PM +1200, Barry Song wrote:
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > b/Documentation/admin-guide/kernel-parameters.txt
> > > > index bdc1f33fd3d1..3f33b89aeab5 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -599,6 +599,15 @@
> > > >  			altogether. For more information, see
> > > >  			include/linux/dma-contiguous.h
> > > >
> > > > +	pernuma_cma=nn[MG]
> > > > +			[ARM64,KNL]
> > > > +			Sets the size of kernel per-numa memory area for
> > > > +			contiguous memory allocations. A value of 0 disables
> > > > +			per-numa CMA altogether. DMA users on node nid will
> > > > +			first try to allocate buffer from the pernuma area
> > > > +			which is located in node nid, if the allocation fails,
> > > > +			they will fallback to the global default memory area.
> > >
> > > What is the default behaviour if this option is not specified? Seems
> > > like that should be mentioned here.
> 
> Just wanted to make sure you didn't miss this ^^

If it is not specified, the default size is 0 that means pernuma_cma is disabled.

Will put some words for this.

> 
> > >
> > > > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig index
> > > > 847a9d1fa634..db7a37ed35eb 100644
> > > > --- a/kernel/dma/Kconfig
> > > > +++ b/kernel/dma/Kconfig
> > > > @@ -118,6 +118,16 @@ config DMA_CMA
> > > >  	  If unsure, say "n".
> > > >
> > > >  if  DMA_CMA
> > > > +
> > > > +config DMA_PERNUMA_CMA
> > > > +	bool "Enable separate DMA Contiguous Memory Area for each
> NUMA
> > > Node"
> > >
> > > I don't understand the need for this config option. If you have
> > > DMA_DMA and you have NUMA, why wouldn't you want this enabled?
> >
> > Christoph preferred this in previous patchset in order to be able to
> > remove all of the code in the text if users don't use pernuma CMA.
> 
> Ok, I defer to Christoph here, but maybe a "default NUMA" might work?

maybe "default NUMA && ARM64"?
Though I believe it will benefit x86, but I don't have a x86 server hardware
and real scenario to test. So I haven't put the dma_pernuma_cma_reserve()
code in arch/x86.
Hopefully some x86 guys will bring it up and remove the "&& ARM64".

> 
> > > > +	help
> > > > +	  Enable this option to get pernuma CMA areas so that devices like
> > > > +	  ARM64 SMMU can get local memory by DMA coherent APIs.
> > > > +
> > > > +	  You can set the size of pernuma CMA by specifying
> > > "pernuma_cma=size"
> > > > +	  on the kernel's command line.
> > > > +
> > > >  comment "Default contiguous memory area size:"
> > > >
> > > >  config CMA_SIZE_MBYTES
> > > > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > > > index cff7e60968b9..89b95f10e56d 100644
> > > > --- a/kernel/dma/contiguous.c
> > > > +++ b/kernel/dma/contiguous.c
> > > > @@ -69,6 +69,19 @@ static int __init early_cma(char *p)  }
> > > > early_param("cma", early_cma);
> > > >
> > > > +#ifdef CONFIG_DMA_PERNUMA_CMA
> > > > +
> > > > +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> > > > +static phys_addr_t pernuma_size_bytes __initdata;
> > > > +
> > > > +static int __init early_pernuma_cma(char *p) {
> > > > +	pernuma_size_bytes = memparse(p, &p);
> > > > +	return 0;
> > > > +}
> > > > +early_param("pernuma_cma", early_pernuma_cma); #endif
> > > > +
> > > >  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
> > > >
> > > >  static phys_addr_t __init __maybe_unused
> > > cma_early_percent_memory(void)
> > > > @@ -96,6 +109,34 @@ static inline __maybe_unused phys_addr_t
> > > cma_early_percent_memory(void)
> > > >
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_DMA_PERNUMA_CMA
> > > > +void __init dma_pernuma_cma_reserve(void) {
> > > > +	int nid;
> > > > +
> > > > +	if (!pernuma_size_bytes)
> > > > +		return;
> > >
> > > If this is useful (I assume it is), then I think we should have a
> > > non-zero default value, a bit like normal CMA does via CMA_SIZE_MBYTES.
> >
> > The patchet used to have a CONFIG_PERNUMA_CMA_SIZE in
> > kernel/dma/Kconfig, but Christoph was not comfortable with it:
> > https://lore.kernel.org/linux-iommu/20200728115231.GA793@lst.de/
> >
> > Would you mind to hardcode the value in CONFIG_CMDLINE in
> arch/arm64/Kconfig as Christoph mentioned:
> > config CMDLINE
> > 	default "pernuma_cma=16M"
> >
> > If you also don't like the change in arch/arm64/Kconfig CMDLINE, I
> > guess I have to depend on users' setting in cmdline just like hugetlb_cma.
> 
> Again, I defere to CHristophe for this code, so leave it like it is.
> However, the same argument applies to CMA_SIZE_MBYTES afaict, and I'm
> mainly looking for consistency.
> 
> > > > +	for_each_node_state(nid, N_ONLINE) {
> > >
> > > for_each_online_node() {
> > >
> > > > +		int ret;
> > > > +		char name[20];
> > >
> > > 20?
> > >
> > > Ah, wait, this is copy-pasta from hugetlb_cma_reserve(). Can you
> > > factor out the common parts at all?
> >
> > Actually I have a "#define CMA_MAX_NAME 64" in this commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
> > mit/?id=18e98e56f440
> >
> > the 20 in hugetlb_cma_reserve() was also made by me. If you are not
> > comfortable, I can move to CMA_MAX_NAME. do you think it does really
> > matter here? 20 seems to be long enough for this scenario.
> 
> Using CMA_MAX_NAME seems sensible to me, although I'm still a bit wary
> about the code duplication between this and the hugetlb code.

If the name has no index, we don't have to maintain a local name array, so they
can simply put a const string. 
Here for hugetlb_cma and pernuma_cma, it happens they both have to use
sprintf() to get a local name with index. But this kind of scenarios would be rare.

> Will

Thanks
Barry

