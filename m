Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC49C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12463206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594801111;
	bh=34jg8R1xjCptBC76HUWkIvJCkwN8uJQ6UcQj8rPdzhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w3C6edlsYFAZ+HnCQoe/ehyIEX0PWIMUvGw24/U6vuyX57qepJs6GTeaKWB8Bls2Q
	 y1T5jZ53KLAbh2iRKAuo6ZUz7UV3/P+buYkkU5FFMkInx7JzgmwBUnIzBQm/Xiz7Rb
	 23E0jXPv3S3FOyhj3HtOxUXvoFV2dzKLkliVYgu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGOISa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbgGOIS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:18:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6EE206D5;
        Wed, 15 Jul 2020 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594801108;
        bh=34jg8R1xjCptBC76HUWkIvJCkwN8uJQ6UcQj8rPdzhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuZmZQbB2NC9HJ03ltwn8FIENpV1ZEF2fcWMzNkj0v0Cg5s+FMoEbbBKm+RrYgkrO
         s+Q6HzzuDhlCyCGQ4AFs4g9aIHIt/tumrc0QFpNFjkBOs2m3zCgDkpgqyvYFiQuJxv
         oT1T/gOZbuq08Aih9I0y+RFaYsq7JJrPltgmdFp0=
Date:   Wed, 15 Jul 2020 09:18:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        Roman Gushchin <guro@fb.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
Message-ID: <20200715081822.GA5683@willie-the-truck>
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Jul 14, 2020 at 04:21:01PM -0700, Mike Kravetz wrote:
> I agree we should only be concerned with N_MEMORY nodes for the CMA
> reservations.  However, this patch got me thinking:
> - Do we really have to initiate the CMA reservations from arch specific code?
> - Can we move the call to reserve CMA a little later into hugetlb arch
>   independent code?
> 
> I know the cma_declare_contiguous_nid() routine says it should be called
> from arch specific code.  However, unless I am missing something that seems
> mostly about timing.
> 
> What about a change like this on top of this patch?
> 
> From 72b5b9a623f8711ad7f79f1a8f910906245f5d07 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 14 Jul 2020 15:54:46 -0700
> Subject: [PATCH] hugetlb: move cma allocation call to arch independent code
> 
> Instead of calling hugetlb_cma_reserve() from arch specific code,
> call from arch independent code when a gigantic page hstate is
> created.  This is late enough in the init process that all numa
> memory information should be initialized.  And, it is early enough
> to still use early memory allocator.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  arch/arm64/mm/init.c    | 10 ----------
>  arch/x86/kernel/setup.c |  9 ---------
>  mm/hugetlb.c            |  8 +++++++-
>  3 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 79806732f4b4..ff0ff584dde9 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -427,16 +427,6 @@ void __init bootmem_init(void)
>  	sparse_init();
>  	zone_sizes_init(min, max);
>  
> -	/*
> -	 * must be done after zone_sizes_init() which calls free_area_init()
> -	 * that calls node_set_state() to initialize node_states[N_MEMORY]
> -	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
> -	 * state
> -	 */
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -#endif
> -
>  	memblock_dump_all();
>  }
>  
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a1a9712090ae..111c8467fafa 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1177,15 +1177,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	x86_init.paging.pagetable_init();
>  
> -	/*
> -	 * must be done after zone_sizes_init() which calls free_area_init()
> -	 * that calls node_set_state() to initialize node_states[N_MEMORY]
> -	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
> -	 * state
> -	 */
> -	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> -		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -
>  	kasan_init();
>  
>  	/*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f24acb3af741..a0007d1d12d2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3273,6 +3273,9 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
>  					huge_page_size(h)/1024);

(nit: you can also make hugetlb_cma_reserve() static and remote its function
prototypes from hugetlb.h)

> +	if (order >= MAX_ORDER && hugetlb_cma_size)
> +		hugetlb_cma_reserve(order);

Although I really like the idea of moving this out of the arch code, I don't
quite follow the check against MAX_ORDER here -- it looks like a bit of a
hack to try to intercept the "PUD_SHIFT - PAGE_SHIFT" order which we
currently pass to hugetlb_cma_reserve(). Maybe we could instead have
something like:

	#ifndef HUGETLB_CMA_ORDER
	#define HUGETLB_CMA_ORDER	(PUD_SHIFT - PAGE_SHIFT)
	#endif

and then just do:

	if (order == HUGETLB_CMA_ORDER)
		hugetlb_cma_reserve(order);

? Is there something else I'm missing?

> +
>  	parsed_hstate = h;
>  }
>  
> @@ -5647,7 +5650,10 @@ void __init hugetlb_cma_reserve(int order)
>  	unsigned long size, reserved, per_node;
>  	int nid;
>  
> -	cma_reserve_called = true;
> +	if (cma_reserve_called)
> +		return;
> +	else
> +		cma_reserve_called = true;

(nit: don't need the 'else' here)

Will
