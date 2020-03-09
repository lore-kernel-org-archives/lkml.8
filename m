Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB08BC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A063F20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pfDN6wzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgCIAI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 20:08:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34238 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCIAI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 20:08:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id i19so260593lfl.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H3HHt6/2Ioa4SgFGbDK5MKmUVALCqld5KSNGhu687qk=;
        b=pfDN6wznBvFMYfVBxQmwNcEfVzqTxaUyPN7B80YAzLFOeEqnHkbjUiOqloDwsvbOh0
         jrz6WoaOUIaiJ+wpzkEcmabG6i6gGpZlWcPsaWRvhhv6p6UxLIHYy/5lb6GdR7QjpDTn
         RS+fdvtE7Bcw2UGJHj9na079Kvbl163icPB+X0pQac+8QcDkNacDvHNsx/OlZ9vBHHzL
         1CskJ5NejshSsygW0d3ZD1p1Zhrtw07N1tPYLAzkDXTlICuCjXH7Stln1dEhgJhXes2A
         tCpUAbDxEuRiSA7at6zC9gMI59J7iLB31P95/BoRWnhtMZUgNSL2nrzBy5v3RhSstL+o
         6FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H3HHt6/2Ioa4SgFGbDK5MKmUVALCqld5KSNGhu687qk=;
        b=XN9gWZlO1j4BCWP2s5EC0RjfMboVof3jmK2hmVEZPHCFu0i7Ra1JsaV2KVYh89EYRo
         1z00FaVCH9cFd9Md6t9+kMxFLd5fblaMraz/Fj/zBtK5GwQVor/jewPuhwTj7YLVQDK3
         uoGGYmscsV5JhezbXY/cb0Bu23QjI2oxcrQdJI0Vzi4EPhzDIb0E6uHGvRDCMJCnK+my
         d/v8CgGhp2fe2KKM/mheu3Fw9SlWwjYWSyXilx0YanP2sOELH0kGnWvsvW6PsrRrUCEN
         qQ6XugnorRkiGfMAL2iGcGr+eiEOS16oVFOG9C9wHUVl+OBxct9ui4S9RJT0HNaGz1sS
         0/Sw==
X-Gm-Message-State: ANhLgQ0kObQbZWAlDNx5K1HFqZqfmObtjrZpDX61aqQfRFN+41mF4+sZ
        upnO/uAjYQ0ozs0ufaG613ZdiQ==
X-Google-Smtp-Source: ADFU+vtjx3OJnCFqb5CmYOQZUg2KlZ9pZFAYiWGIoiyum4ISJUo+dD7mN8FooGQdcsH2H7e8UcnRlg==
X-Received: by 2002:ac2:54b4:: with SMTP id w20mr1419330lfk.39.1583712502109;
        Sun, 08 Mar 2020 17:08:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o23sm10538515ljc.9.2020.03.08.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 17:08:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 708D3100BFE; Mon,  9 Mar 2020 03:08:20 +0300 (+03)
Date:   Mon, 9 Mar 2020 03:08:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200309000820.f37opzmppm67g6et@box>
References: <20200307010353.172991-1-cannonmatthews@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307010353.172991-1-cannonmatthews@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 05:03:53PM -0800, Cannon Matthews wrote:
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

Some macrobenchmark would be great too.

> An earlier version of this code was sent as an RFC patch ~July 2018
> https://patchwork.kernel.org/patch/10543193/ but never merged.

Andi and I tried to use MOVNTI for large/gigantic page clearing back in
2012[1]. Maybe it can be useful.

That patchset is somewhat more complex trying to keep the memory around
the fault address hot in cache. In theory it should help to reduce latency
on the first access to the memory.

I was not able to get convincing numbers back then for the hardware of the
time. Maybe it's better now.

https://lore.kernel.org/r/1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com

> 
> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
> ---
>  MAINTAINERS                        |  1 +
>  arch/x86/Kconfig                   |  4 ++++
>  arch/x86/include/asm/page_64.h     |  1 +
>  arch/x86/lib/Makefile              |  2 +-
>  arch/x86/lib/clear_gigantic_page.c | 28 ++++++++++++++++++++++++++++
>  arch/x86/lib/clear_page_64.S       | 19 +++++++++++++++++++
>  include/linux/mm.h                 |  2 ++
>  mm/memory.c                        |  2 ++
>  8 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/lib/clear_gigantic_page.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68eebf3650ac..efe84f085404 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7702,6 +7702,7 @@ S:	Maintained
>  F:	fs/hugetlbfs/
>  F:	mm/hugetlb.c
>  F:	include/linux/hugetlb.h
> +F:	arch/x86/lib/clear_gigantic_page.c
>  F:	Documentation/admin-guide/mm/hugetlbpage.rst
>  F:	Documentation/vm/hugetlbfs_reserv.rst
>  F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..f49e7b6f6851 100644
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
> +
>  config ARCH_HAS_CPU_RELAX
>  	def_bool y
>  
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> index 939b1cff4a7b..6ea60883b6d6 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -55,6 +55,7 @@ static inline void clear_page(void *page)
>  }
>  
>  void copy_page(void *to, void *from);
> +void clear_page_nt(void *page, u64 page_size);
>  
>  #endif	/* !__ASSEMBLY__ */
>  
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 5246db42de45..a620c6636210 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -56,7 +56,7 @@ endif
>  else
>          obj-y += iomap_copy_64.o
>          lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
> -        lib-y += clear_page_64.o copy_page_64.o
> +        lib-y += clear_page_64.o copy_page_64.o clear_gigantic_page.o
>          lib-y += memmove_64.o memset_64.o
>          lib-y += copy_user_64.o
>  	lib-y += cmpxchg16b_emu.o
> diff --git a/arch/x86/lib/clear_gigantic_page.c b/arch/x86/lib/clear_gigantic_page.c
> new file mode 100644
> index 000000000000..6fcb494ec9bc
> --- /dev/null
> +++ b/arch/x86/lib/clear_gigantic_page.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/page.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> +
> +void clear_gigantic_page(struct page *page, unsigned long addr,
> +			 unsigned int pages)
> +{
> +	int i;
> +	void *dest = page_to_virt(page);
> +
> +	/*
> +	 * cond_resched() every 2M. Hypothetical page sizes not divisible by
> +	 * this are not supported.
> +	 */
> +	BUG_ON(pages % HPAGE_PMD_NR != 0);
> +	for (i = 0; i < pages; i += HPAGE_PMD_NR) {
> +		clear_page_nt(dest + (i * PAGE_SIZE), HPAGE_PMD_NR * PAGE_SIZE);
> +		cond_resched();
> +	}
> +	/* clear_page_nt requires an `sfence` barrier. */
> +	wmb();
> +}
> +#endif /* defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS) */
> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> index c4c7dd115953..1224094fd863 100644
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -50,3 +50,22 @@ SYM_FUNC_START(clear_page_erms)
>  	ret
>  SYM_FUNC_END(clear_page_erms)
>  EXPORT_SYMBOL_GPL(clear_page_erms)
> +
> +/*
> + * Zero memory using non temporal stores, bypassing the cache.
> + * Requires an `sfence` (wmb()) afterwards.
> + * %rdi - destination.
> + * %rsi - page size. Must be 64 bit aligned.
> +*/
> +SYM_FUNC_START(clear_page_nt)
> +	leaq	(%rdi,%rsi), %rdx
> +	xorl	%eax, %eax
> +	.p2align 4,,10
> +	.p2align 3
> +.L2:
> +	movnti	%rax, (%rdi)
> +	addq	$8, %rdi
> +	cmpq	%rdx, %rdi
> +	jne	.L2
> +	ret
> +SYM_FUNC_END(clear_page_nt)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c54fb96cb1e6..a57f9007374b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2856,6 +2856,8 @@ enum mf_action_page_type {
>  };
>  
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> +extern void clear_gigantic_page(struct page *page, unsigned long addr,
> +				unsigned int pages);
>  extern void clear_huge_page(struct page *page,
>  			    unsigned long addr_hint,
>  			    unsigned int pages_per_huge_page);
> diff --git a/mm/memory.c b/mm/memory.c
> index e8bfdf0d9d1d..2a13bf102890 100644
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
> @@ -4720,6 +4721,7 @@ static void clear_gigantic_page(struct page *page,
>  		clear_user_highpage(p, addr + i * PAGE_SIZE);
>  	}
>  }
> +#endif  /* CONFIG_ARCH_HAS_CLEAR_GIGANTIC_PAGE */
>  
>  static void clear_subpage(unsigned long addr, int idx, void *arg)
>  {
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 
> 

-- 
 Kirill A. Shutemov
