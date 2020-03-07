Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A9BC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D0B2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583618928;
	bh=fL8GGu0ZhmH+hgEok4DsLrWbGnPfkAedaNWd8aPpGes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vP+94eWnom+3OlsBblULQpWDS1KLx8ATwSJm9sZ78mNkJAIgK/dhJ3huweRlUC9o7
	 +BuS9xWPOa5m5fSHE623UiCw9LeWv3cT3SnDAXdoHRGabbIyMxg3e0OgYY1IzHudu4
	 6DqbLwY/vbDL95XetG8GqxyKEDSOcC4DVJx6tqoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCGWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 17:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgCGWGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 17:06:18 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D269206D7;
        Sat,  7 Mar 2020 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583618777;
        bh=fL8GGu0ZhmH+hgEok4DsLrWbGnPfkAedaNWd8aPpGes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FS8rDTljIpYYiM6+BQ4PB6SgscPXHr5HSM6GRRuVUtILb5KiruHQo4Q/MBha6rTrs
         oWVVkrnGS3oI10SMayN25VVIiXexJWTPeGgirJaMHhuRRM5fY3x1abm0M2wICfL9Wn
         FMpC8+J6nSu0J74uAx2GjC5HwsgRYmtZC2o5iCiA=
Date:   Sat, 7 Mar 2020 14:06:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-Id: <20200307140616.034b3e537ffd46eb757dec73@linux-foundation.org>
In-Reply-To: <20200307010353.172991-1-cannonmatthews@google.com>
References: <20200307010353.172991-1-cannonmatthews@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 17:03:53 -0800 Cannon Matthews <cannonmatthews@google.com> wrote:

> Reimplement clear_gigantic_page() to clear gigabytes pages using the
> non-temporal streaming store instructions that bypass the cache
> (movnti), since an entire 1GiB region will not fit in the cache anyway.
> 
> Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
> average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
> and optimizing the control flow over the constituent small pages, this
> can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
> taking only 34 seconds on average, or 67ms/GiB.
> 
> The assembly code for the __clear_page_nt routine is more or less
> taken directly from the output of gcc with -O3 for this function with
> some tweaks to support arbitrary sizes and moving memory barriers:
> 
> void clear_page_nt_64i (void *page)
> {
>   for (int i = 0; i < GiB /sizeof(long long int); ++i)
>     {
>       _mm_stream_si64 (((long long int*)page) + i, 0);
>     }
>   sfence();
> }
> 
> Tested:
> 	Time to `mlock()` a 512GiB region on broadwell CPU
> 				AVG time (s)	% imp.	ms/page
> 	clear_page_erms		133.584		-	261
> 	clear_page_nt		34.154		74.43%	67
> 
> An earlier version of this code was sent as an RFC patch ~July 2018
> https://patchwork.kernel.org/patch/10543193/ but never merged.
> 
> ...
>
>  MAINTAINERS                        |  1 +
>  arch/x86/Kconfig                   |  4 ++++
>  arch/x86/include/asm/page_64.h     |  1 +
>  arch/x86/lib/Makefile              |  2 +-
>  arch/x86/lib/clear_gigantic_page.c | 28 ++++++++++++++++++++++++++++
>  arch/x86/lib/clear_page_64.S       | 19 +++++++++++++++++++
>  include/linux/mm.h                 |  2 ++
>  mm/memory.c                        |  2 ++

Please cc the x86 maintainers on such things.

>
> ...
>
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -70,6 +70,7 @@ config X86
>  	select ARCH_HAS_KCOV			if X86_64
>  	select ARCH_HAS_MEM_ENCRYPT
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> +	select ARCH_HAS_CLEAR_GIGANTIC_PAGE	if X86_64
>  	select ARCH_HAS_PMEM_API		if X86_64
>  	select ARCH_HAS_PTE_DEVMAP		if X86_64
>  	select ARCH_HAS_PTE_SPECIAL
> @@ -290,6 +291,9 @@ config ARCH_MAY_HAVE_PC_FDC
>  config GENERIC_CALIBRATE_DELAY
>  	def_bool y
>  
> +config ARCH_HAS_CLEAR_GIGANTIC_PAGE
> +	bool

Opinions might differ, but I believe the Linus-approved way of doing
this sort of thing is

#ifndef clear_gigantic_page
extern void clear_gigantic_page(...);
#define clear_gigantic_page clear_gigantic_page
#endif

alternatively, __weak works nicely.

>
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2856,6 +2856,8 @@ enum mf_action_page_type {
>  };
>  
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> +extern void clear_gigantic_page(struct page *page, unsigned long addr,
> +				unsigned int pages);

Shouldn't this be inside #ifdef CONFIG_ARCH_HAS_CLEAR_GIGANTIC_PAGE?

Also, the third argument here is called "pages" but here:

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4706,6 +4706,7 @@ static inline void process_huge_page(
>  	}
>  }
>  
> +#ifndef CONFIG_ARCH_HAS_CLEAR_GIGANTIC_PAGE
>  static void clear_gigantic_page(struct page *page,
>  				unsigned long addr,
>  				unsigned int pages_per_huge_page)

it is called "pages_per_huge_page".

> @@ -4720,6 +4721,7 @@ static void clear_gigantic_page(struct page *page,
>  		clear_user_highpage(p, addr + i * PAGE_SIZE);
>  	}
>  }
> +#endif  /* CONFIG_ARCH_HAS_CLEAR_GIGANTIC_PAGE */
>  
> ...
