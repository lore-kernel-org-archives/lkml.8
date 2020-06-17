Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0640214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFQLiQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:38:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726879AbgFQLiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:38:14 -0400
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 86D2650D5EECF6269855;
        Wed, 17 Jun 2020 19:38:11 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Wed, 17 Jun 2020 19:38:04 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Will Deacon <will@kernel.org>, Roman Gushchin <guro@fb.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: RE: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
Thread-Topic: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
Thread-Index: AQHWRCxu8v+ZJR6HI0W0yfQfoTndDqjcEtCAgACalcA=
Date:   Wed, 17 Jun 2020 11:38:03 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2502AA9@DGGEMI525-MBS.china.huawei.com>
References: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
 <20200617101824.GB3368@willie-the-truck>
In-Reply-To: <20200617101824.GB3368@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.175]
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
> Sent: Wednesday, June 17, 2020 10:18 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: catalin.marinas@arm.com; nsaenzjulienne@suse.de;
> steve.capper@arm.com; rppt@linux.ibm.com; akpm@linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> Roman Gushchin <guro@fb.com>
> Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
> 
> On Wed, Jun 17, 2020 at 10:19:24AM +1200, Barry Song wrote:
> > hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
> > done yet. so all reserved memory will be located at node0.
> >
> > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages
> using cma")
> 
> Damn, wasn't CC'd on that :/
> 
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  -v2: add Fixes tag according to Matthias Brugger's comment
> >
> >  arch/arm64/mm/init.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index e631e6425165..41914b483d54 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
> >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >
> >  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> > -
> > -#ifdef CONFIG_ARM64_4K_PAGES
> > -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > -#endif
> 
> Why is this dependent on CONFIG_ARM64_4K_PAGES? We unconditionally
> select ARCH_HAS_GIGANTIC_PAGE so this seems unnecessary.

Roman, would you like to answer this question? Have you found any problem if system
doesn't set 4K_PAGES?

> 
> > -
> >  }
> >
> >  void __init bootmem_init(void)
> > @@ -424,6 +419,11 @@ void __init bootmem_init(void)
> >  	min_low_pfn = min;
> >
> >  	arm64_numa_init();
> > +
> > +#ifdef CONFIG_ARM64_4K_PAGES
> > +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > +#endif
> 
> A comment here wouldn't hurt, as it does look a lot more natural next
> to dma_contiguous_reserve().

Will add some comment here.

> 
> Will

barry
