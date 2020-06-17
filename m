Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78405C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A10B20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592389112;
	bh=t3O3UqUPbUfT6U+LwvmDhf8VfLM3fmdWGiN7u6Z4cqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j6xZVtm38uKETNB8HgAgXscWaTPVxOT7oZ5Zf4OQ6y9rc0Eni/EIANG7hlMqI90vZ
	 +5vZz5Kj1dJT/FC9zbjTZTe7PPAn66gFjI0Burz+IOke9mRoMeeO9Z8B6lCbS8Ddxo
	 1QcRPh6SotMuIhRe8Um2f2lFvaXgStkgneHs4iAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQKSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:18:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A1C208B8;
        Wed, 17 Jun 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592389110;
        bh=t3O3UqUPbUfT6U+LwvmDhf8VfLM3fmdWGiN7u6Z4cqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTOqgPvE3c8CfIz5eGN+H1QWmhHhx4qZ+OBY53vIa2enZtatW6BqM01MylBKK03hc
         xUemYqn0zAIhcnztlOTQh46+2RDBriTxkSiLc839HNanIu3LJCYD7uwQnbYqsaW7Rk
         waEGqqsU7FVhnt5on9cwwAaNoUkeM0EySg/70Rek=
Date:   Wed, 17 Jun 2020 11:18:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     catalin.marinas@arm.com, nsaenzjulienne@suse.de,
        steve.capper@arm.com, rppt@linux.ibm.com,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
Message-ID: <20200617101824.GB3368@willie-the-truck>
References: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:19:24AM +1200, Barry Song wrote:
> hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
> done yet. so all reserved memory will be located at node0.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")

Damn, wasn't CC'd on that :/

> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v2: add Fixes tag according to Matthias Brugger's comment
> 
>  arch/arm64/mm/init.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e631e6425165..41914b483d54 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  
>  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> -
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -#endif

Why is this dependent on CONFIG_ARM64_4K_PAGES? We unconditionally
select ARCH_HAS_GIGANTIC_PAGE so this seems unnecessary.

> -
>  }
>  
>  void __init bootmem_init(void)
> @@ -424,6 +419,11 @@ void __init bootmem_init(void)
>  	min_low_pfn = min;
>  
>  	arm64_numa_init();
> +
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> +#endif

A comment here wouldn't hurt, as it does look a lot more natural next
to dma_contiguous_reserve().

Will
