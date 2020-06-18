Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABBE21924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592464783;
	bh=pV6O1yumfzhHIjX5Fbrm60kDmHZdVXToNrKqF29U6Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gvszpW+XZ9nx1l/XjgnNntvRZyZcfxX7HcPOJsOua18f6wP6sHEmkO7ovIhZvYn87
	 NtUX4t1is0yRATcxwMbV/ctK2iOKTXgK+Uy2cmJ+XA32qnNX5+c1AskoTpIHN4s1VK
	 wZltzPhm/hJQ6uHiq/tfynRBeOfZqNkzBqkGSHR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFRHTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgFRHTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:19:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B84FD21655;
        Thu, 18 Jun 2020 07:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592464780;
        bh=pV6O1yumfzhHIjX5Fbrm60kDmHZdVXToNrKqF29U6Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEsLvR7tl2OlcN2DqRqeWIKRKRlk+5dzYYJt2ZZkF6bW17rfvVVP478efND/3ObpL
         qEPXsK5+spsYuZmTOVJTIv5e/fZgdAs+yL+fhXD8qCTeM3T9zGj34BwNexnFdhF+JR
         vd1fItpn4l1h0zBgUOphiRZar9iWFXiKwGmYlogg=
Date:   Thu, 18 Jun 2020 08:19:35 +0100
From:   Will Deacon <will@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
Message-ID: <20200618071934.GA4864@willie-the-truck>
References: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
 <20200617101824.GB3368@willie-the-truck>
 <B926444035E5E2439431908E3842AFD2502AA9@DGGEMI525-MBS.china.huawei.com>
 <20200617182026.GA19784@carbon.dhcp.thefacebook.com>
 <B926444035E5E2439431908E3842AFD2503532@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD2503532@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:43:51PM +0000, Song Bao Hua (Barry Song) wrote:
> > From: Roman Gushchin [mailto:guro@fb.com]
> > On Wed, Jun 17, 2020 at 11:38:03AM +0000, Song Bao Hua (Barry Song)
> > > > From: Will Deacon [mailto:will@kernel.org]
> > > > On Wed, Jun 17, 2020 at 10:19:24AM +1200, Barry Song wrote:
> > > > > hugetlb_cma_reserve() is called at the wrong place. numa_init has not
> > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > > index e631e6425165..41914b483d54 100644
> > > > > --- a/arch/arm64/mm/init.c
> > > > > +++ b/arch/arm64/mm/init.c
> > > > > @@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
> > > > >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> > > > >
> > > > >  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> > > > > -
> > > > > -#ifdef CONFIG_ARM64_4K_PAGES
> > > > > -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > > > > -#endif
> > > >
> > > > Why is this dependent on CONFIG_ARM64_4K_PAGES? We unconditionally
> > > > select ARCH_HAS_GIGANTIC_PAGE so this seems unnecessary.
> > >
> > > Roman, would you like to answer this question? Have you found any
> > problem if system
> > > doesn't set 4K_PAGES?
> > 
> > No, I was just following the code in arch/arm64/mm/hugetlbpage.c where all
> > related to PUD-sized pages is guarded by CONFIG_ARM64_4K_PAGES.
> > Actually I did all my testing on x86-64, I don't even have any arm hardware.
> > 
> > I'm totally fine with removing this #ifdef if it's not needed.
> 
> At this moment, I would suggest we should keep this "ifdef". Otherwise, hugetlb_cma_reserve() won't be really useful.
> 
> For example, while setting PAGE size to 64KB. I got this error in hugetlb_cma_reserve():
> hugetlb_cma: cma area should be at least 4194304 MiB
> This is absolutely unreasonable.

Maybe one for RaspberryPi 5, huh? ;)

But ok, I'll take your patch as-is and add a comment about NUMA.

Thanks,

Will
