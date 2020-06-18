Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D921C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059F8221E6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFRHny convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:43:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:37790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgFRHnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:43:53 -0400
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id BABD685A482B5AEB3235;
        Thu, 18 Jun 2020 15:43:50 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Thu, 18 Jun 2020 15:43:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Will Deacon <will@kernel.org>
CC:     Roman Gushchin <guro@fb.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Thread-Index: AQHWRCxu8v+ZJR6HI0W0yfQfoTndDqjcEtCAgACalcD//+wXAIAAuwbAgAAeq4CAAIwvUA==
Date:   Thu, 18 Jun 2020 07:43:43 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2507431@DGGEMI525-MBS.china.huawei.com>
References: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
 <20200617101824.GB3368@willie-the-truck>
 <B926444035E5E2439431908E3842AFD2502AA9@DGGEMI525-MBS.china.huawei.com>
 <20200617182026.GA19784@carbon.dhcp.thefacebook.com>
 <B926444035E5E2439431908E3842AFD2503532@DGGEMI525-MBS.china.huawei.com>
 <20200618071934.GA4864@willie-the-truck>
In-Reply-To: <20200618071934.GA4864@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.42]
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
> Sent: Thursday, June 18, 2020 7:20 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Roman Gushchin <guro@fb.com>; catalin.marinas@arm.com;
> nsaenzjulienne@suse.de; steve.capper@arm.com; rppt@linux.ibm.com;
> akpm@linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Matthias
> Brugger <matthias.bgg@gmail.com>
> Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
> 
> On Wed, Jun 17, 2020 at 09:43:51PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > From: Roman Gushchin [mailto:guro@fb.com]
> > > On Wed, Jun 17, 2020 at 11:38:03AM +0000, Song Bao Hua (Barry Song)
> > > > > From: Will Deacon [mailto:will@kernel.org]
> > > > > On Wed, Jun 17, 2020 at 10:19:24AM +1200, Barry Song wrote:
> > > > > > hugetlb_cma_reserve() is called at the wrong place. numa_init has not
> > > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > > > index e631e6425165..41914b483d54 100644
> > > > > > --- a/arch/arm64/mm/init.c
> > > > > > +++ b/arch/arm64/mm/init.c
> > > > > > @@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
> > > > > >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> > > > > >
> > > > > >  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> > > > > > -
> > > > > > -#ifdef CONFIG_ARM64_4K_PAGES
> > > > > > -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > > > > -#endif
> > > > >
> > > > > Why is this dependent on CONFIG_ARM64_4K_PAGES? We
> unconditionally
> > > > > select ARCH_HAS_GIGANTIC_PAGE so this seems unnecessary.
> > > >
> > > > Roman, would you like to answer this question? Have you found any
> > > problem if system
> > > > doesn't set 4K_PAGES?
> > >
> > > No, I was just following the code in arch/arm64/mm/hugetlbpage.c where
> all
> > > related to PUD-sized pages is guarded by CONFIG_ARM64_4K_PAGES.
> > > Actually I did all my testing on x86-64, I don't even have any arm
> hardware.
> > >
> > > I'm totally fine with removing this #ifdef if it's not needed.
> >
> > At this moment, I would suggest we should keep this "ifdef". Otherwise,
> hugetlb_cma_reserve() won't be really useful.
> >
> > For example, while setting PAGE size to 64KB. I got this error in
> hugetlb_cma_reserve():
> > hugetlb_cma: cma area should be at least 4194304 MiB
> > This is absolutely unreasonable.
> 
> Maybe one for RaspberryPi 5, huh? ;)
> 
> But ok, I'll take your patch as-is and add a comment about NUMA.

Have you seen the v3 with comment? I've already sent.

> 
> Thanks,
> 
> Will
