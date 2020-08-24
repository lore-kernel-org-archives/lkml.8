Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6255C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF0620639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGDkNFKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHXRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHXRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:50:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:50:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so6842033qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PG7MrXVlFs0wuGE6F4rw7no0ij89eengQZlo+8LNVJY=;
        b=pGDkNFKcoOaVTKPHwtIvOFBPRsThQQ4X7hMFpIrdJipt0s90J4QqQBghOywnlYMaMw
         g67RHYZNJoOaLPtb/Axdo1xLTgHd3IEMseTcVKzkIVk3Muk8HQJoyA5yECTDSYUVWO45
         ZHd0yR+42md7pum08RX5S1G5qlntGZ/v1Lg8hqN8KRyyn4rZJj4VZwMJtvsfCZC2RBpC
         FtSUmxR77pUmktwcvcLvmGxexSBpBbqrXJlJL2jFrZRNrrHpuIvMMiCqSR6rU6rTHMO4
         0j4XppzSKC0+LPMOrSp8MW+WTxhEQRkZiR+Pmhtgg8ITHzkyarIZK9KPwPb1XIjueStr
         uNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PG7MrXVlFs0wuGE6F4rw7no0ij89eengQZlo+8LNVJY=;
        b=TGtLH3g5TiDvAeVRmzcG26qiYkMHukMjgSF629tIsX2z364IRCw5vdOVT92m9imdM2
         w1OaJigCN0RargnuJQByoqrg8wZ+3nMoVsy3aWxj3WFZAf6hVkXClkJdUStQQWws7RVv
         Vpvuj4zuT6mb2zmtm18+lTxOrjlVddeo5nBn1FDXDBXeVGVg+zvDO+i/+cfQWi4MQexs
         XvfS4bI0udzbx1qoDd9MYkLRSLcgbr7CchPW84NxzYUa/VqwUb4b0DdsE9pmEEc6an/D
         +rhnyUCyqjFmHmxAudHLJ80k9dHIbg8UwLD4/4jTXY2s1DJgZ649cQTlq5zvJo+0cuS/
         RGMg==
X-Gm-Message-State: AOAM5330bFWb12zDiEKorvifbgInWGjRV0LABfvWFMBN7YueILZzV26r
        FBnhnsFZBhSqAQaMPXK7uN0=
X-Google-Smtp-Source: ABdhPJw58rzxYWpLyuxDK1qSNS1jki4xQjK0N27wxcd8WptiNN2vLq9gZivNO3mpjvj4YEyw47cC0g==
X-Received: by 2002:ac8:72d2:: with SMTP id o18mr3967937qtp.162.1598291425553;
        Mon, 24 Aug 2020 10:50:25 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 95sm11700637qtc.29.2020.08.24.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:50:24 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:50:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] x86/asm: Replace __force_order with memory clobber
Message-ID: <20200824175022.GA1617698@ubuntu-n2-xlarge-x86>
References: <20200823011652.GA1910689@rani.riverdale.lan>
 <20200823212550.3377591-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823212550.3377591-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 05:25:50PM -0400, Arvind Sankar wrote:
> The CRn accessor functions use __force_order as a dummy operand to
> prevent the compiler from reordering the inline asm.
> 
> The fact that the asm is volatile should be enough to prevent this
> already, however older versions of GCC had a bug that could sometimes
> result in reordering. This was fixed in 8.1, 7.3 and 6.5.
> 
> There are some issues with __force_order as implemented:
> - It is used only as an input operand for the write functions, and hence
>   doesn't do anything additional to prevent reordering writes.
> - It allows memory accesses to be cached/reordered across write
>   functions, but CRn writes affect the semantics of memory accesses, so
>   this could be dangerous.
> - __force_order is not actually defined in the kernel proper, but the
>   LLVM toolchain can in some cases require a definition: LLVM (as well
>   as GCC 4.9) requires it for PIE code, which is why the compressed
>   kernel has a definition, but also the clang integrated assembler may
>   consider the address of __force_order to be significant, resulting in
>   a reference that requires a definition.
> 
> Fix this by:
> - Using a memory clobber for the write functions to additionally prevent
>   caching/reordering memory accesses across CRn writes.
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602

I applied this patch to v5.9-rc2 and next-20200824 and built several
different configurations with clang + GNU as and some with clang +
LLVM's integrated assembler and saw no build failures.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/x86/boot/compressed/pgtable_64.c |  9 ---------
>  arch/x86/include/asm/special_insns.h  | 27 ++++++++++++++-------------
>  arch/x86/kernel/cpu/common.c          |  4 ++--
>  3 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index c8862696a47b..7d0394f4ebf9 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -5,15 +5,6 @@
>  #include "pgtable.h"
>  #include "../string.h"
>  
> -/*
> - * __force_order is used by special_insns.h asm code to force instruction
> - * serialization.
> - *
> - * It is not referenced from the code, but GCC < 5 with -fPIE would fail
> - * due to an undefined symbol. Define it to make these ancient GCCs work.
> - */
> -unsigned long __force_order;
> -
>  #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
>  #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
>  
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 59a3e13204c3..8f7791217ef4 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -11,45 +11,46 @@
>  #include <linux/jump_label.h>
>  
>  /*
> - * Volatile isn't enough to prevent the compiler from reordering the
> - * read/write functions for the control registers and messing everything up.
> - * A memory clobber would solve the problem, but would prevent reordering of
> - * all loads stores around it, which can hurt performance. Solution is to
> - * use a variable and mimic reads and writes to it to enforce serialization
> + * The compiler should not reorder volatile asm, however older versions of GCC
> + * had a bug (which was fixed in 8.1, 7.3 and 6.5) where they could sometimes
> + * reorder volatile asm. The write functions are not a problem since they have
> + * memory clobbers preventing reordering. To prevent reads from being reordered
> + * with respect to writes, use a dummy memory operand.
>   */
> -extern unsigned long __force_order;
> +
> +#define __FORCE_ORDER "m"(*(unsigned int *)0x1000UL)
>  
>  void native_write_cr0(unsigned long val);
>  
>  static inline unsigned long native_read_cr0(void)
>  {
>  	unsigned long val;
> -	asm volatile("mov %%cr0,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr0,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  	return val;
>  }
>  
>  static __always_inline unsigned long native_read_cr2(void)
>  {
>  	unsigned long val;
> -	asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr2,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  	return val;
>  }
>  
>  static __always_inline void native_write_cr2(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr2": : "r" (val), "m" (__force_order));
> +	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
>  }
>  
>  static inline unsigned long __native_read_cr3(void)
>  {
>  	unsigned long val;
> -	asm volatile("mov %%cr3,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  	return val;
>  }
>  
>  static inline void native_write_cr3(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr3": : "r" (val), "m" (__force_order));
> +	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
>  }
>  
>  static inline unsigned long native_read_cr4(void)
> @@ -64,10 +65,10 @@ static inline unsigned long native_read_cr4(void)
>  	asm volatile("1: mov %%cr4, %0\n"
>  		     "2:\n"
>  		     _ASM_EXTABLE(1b, 2b)
> -		     : "=r" (val), "=m" (__force_order) : "0" (0));
> +		     : "=r" (val) : "0" (0), __FORCE_ORDER);
>  #else
>  	/* CR4 always exists on x86_64. */
> -	asm volatile("mov %%cr4,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr4,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  #endif
>  	return val;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index c5d6f17d9b9d..178499f90366 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -359,7 +359,7 @@ void native_write_cr0(unsigned long val)
>  	unsigned long bits_missing = 0;
>  
>  set_register:
> -	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> +	asm volatile("mov %0,%%cr0": "+r" (val) : : "memory");
>  
>  	if (static_branch_likely(&cr_pinning)) {
>  		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> @@ -378,7 +378,7 @@ void native_write_cr4(unsigned long val)
>  	unsigned long bits_changed = 0;
>  
>  set_register:
> -	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> +	asm volatile("mov %0,%%cr4": "+r" (val) : : "memory");
>  
>  	if (static_branch_likely(&cr_pinning)) {
>  		if (unlikely((val & cr4_pinned_mask) != cr4_pinned_bits)) {
> -- 
> 2.26.2
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200823212550.3377591-1-nivedita%40alum.mit.edu.
