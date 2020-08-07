Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390E5221E4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596759851;
	bh=WT5/ZbSgfaderB5Ge8RH11JapqNx2uuvd9h0qdPCn0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k1tpODW00T93uZ+ntojKapTPy5kEZA9teaVOb7thNR7ebiUQYEhF9s4tTid2ekxZP
	 99kEogycaYcGc8fcZu8Jb0xX88BJ6GU7Zn/L0w/Lm51G0azXGZlPLTQ+gOBfo7JCt+
	 7gei0DwtmGadOizfBgEexHLr7asmToCavm35d5rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHGAYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgHGAYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:24:08 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451A120855;
        Fri,  7 Aug 2020 00:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596759847;
        bh=WT5/ZbSgfaderB5Ge8RH11JapqNx2uuvd9h0qdPCn0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pbyqJOherK/amtB8m6wkfGNCsPAGHSpqqsdWgPrK4rFkIwLPSGdiFRpHmh5hZQcDh
         x6vrKU+OKddRmM38eMZDXtYrpNwQ9Wk4bvgSrCGRTVfWnxFhie3692hpD2L5qS6uBW
         wIYQSgfe1VCvvMtcn7XPrbWvCYtl5O+mAK35TPao=
Received: by mail-lj1-f180.google.com with SMTP id g6so280235ljn.11;
        Thu, 06 Aug 2020 17:24:07 -0700 (PDT)
X-Gm-Message-State: AOAM532Hdvjugct9HdIgWVWEwGO3FacVjnbeX/fm8Kv+2F1j+gXbp9A6
        WKc/qaz3MRB4JIUiw+o5Nou1ewQNp5rUuzqrWYc=
X-Google-Smtp-Source: ABdhPJzYkrXyPAnRh91DPhVQkBmh2Vbe1E41s/eKJXEW5cF0NiWNfulpn7WC1neJ1hRZV+dLboTfh5pUycZovzdhHwo=
X-Received: by 2002:a2e:86d8:: with SMTP id n24mr4622806ljj.377.1596759845398;
 Thu, 06 Aug 2020 17:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200805104146.GP2674@hirez.programming.kicks-ass.net> <20200805104415.GA35926@hirez.programming.kicks-ass.net>
In-Reply-To: <20200805104415.GA35926@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Aug 2020 08:23:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSWCE-MCpwbiax79njqUUSQgLo_w=7SF7ejWavQQKCKZQ@mail.gmail.com>
Message-ID: <CAJF2gTSWCE-MCpwbiax79njqUUSQgLo_w=7SF7ejWavQQKCKZQ@mail.gmail.com>
Subject: Re: csky: smp_mb__after_spinlock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ren Guo <ren_guo@c-sky.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, mathieu.desnoyers@efficios.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Aug 6, 2020 at 3:55 AM <peterz@infradead.org> wrote:
>
> On Wed, Aug 05, 2020 at 12:41:46PM +0200, peterz@infradead.org wrote:
> > Hi,
> >
> > While doing an audit of smp_mb__after_spinlock, I found that csky
> > defines it, why?
> >
> > CSKY only has smp_mb(), it doesn't override __atomic_acquire_fence or
> > otherwise special cases it's atomic*_acquire() primitives. It has an
> > explicit smp_mb() in its arch_spin_lock().
>
> Also, why have two implementations of all the locking ?
>
> ---
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index bd31ab12f77d..332738e93e57 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -7,7 +7,7 @@ config CSKY
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select ARCH_USE_BUILTIN_BSWAP
> -       select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
> +       select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
>         select COMMON_CLK
>         select CLKSRC_MMIO
> diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> index 7cf3f2b34cea..69f5aa249c5f 100644
> --- a/arch/csky/include/asm/spinlock.h
> +++ b/arch/csky/include/asm/spinlock.h
> @@ -6,8 +6,6 @@
>  #include <linux/spinlock_types.h>
>  #include <asm/barrier.h>
>
> -#ifdef CONFIG_QUEUED_RWLOCKS
> -
>  /*
>   * Ticket-based spin-locking.
>   */
> @@ -88,169 +86,4 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
>
>  #include <asm/qrwlock.h>
>
> -/* See include/linux/spinlock.h */
> -#define smp_mb__after_spinlock()       smp_mb()
> -
> -#else /* CONFIG_QUEUED_RWLOCKS */
> -
> -/*
> - * Test-and-set spin-locking.
> - */
> -static inline void arch_spin_lock(arch_spinlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       bnez            %0, 1b   \n"
> -               "       movi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -       smp_mb();
> -}
> -
> -static inline void arch_spin_unlock(arch_spinlock_t *lock)
> -{
> -       smp_mb();
> -       WRITE_ONCE(lock->lock, 0);
> -}
> -
> -static inline int arch_spin_trylock(arch_spinlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       bnez            %0, 2f   \n"
> -               "       movi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               "       movi            %0, 0    \n"
> -               "2:                              \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -
> -       if (!tmp)
> -               smp_mb();
> -
> -       return !tmp;
> -}
> -
> -#define arch_spin_is_locked(x) (READ_ONCE((x)->lock) != 0)
> -
> -/*
> - * read lock/unlock/trylock
> - */
> -static inline void arch_read_lock(arch_rwlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       blz             %0, 1b   \n"
> -               "       addi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -       smp_mb();
> -}
> -
> -static inline void arch_read_unlock(arch_rwlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       smp_mb();
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       subi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -}
> -
> -static inline int arch_read_trylock(arch_rwlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       blz             %0, 2f   \n"
> -               "       addi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               "       movi            %0, 0    \n"
> -               "2:                              \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -
> -       if (!tmp)
> -               smp_mb();
> -
> -       return !tmp;
> -}
> -
> -/*
> - * write lock/unlock/trylock
> - */
> -static inline void arch_write_lock(arch_rwlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       bnez            %0, 1b   \n"
> -               "       subi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -       smp_mb();
> -}
> -
> -static inline void arch_write_unlock(arch_rwlock_t *lock)
> -{
> -       smp_mb();
> -       WRITE_ONCE(lock->lock, 0);
> -}
> -
> -static inline int arch_write_trylock(arch_rwlock_t *lock)
> -{
> -       u32 *p = &lock->lock;
> -       u32 tmp;
> -
> -       asm volatile (
> -               "1:     ldex.w          %0, (%1) \n"
> -               "       bnez            %0, 2f   \n"
> -               "       subi            %0, 1    \n"
> -               "       stex.w          %0, (%1) \n"
> -               "       bez             %0, 1b   \n"
> -               "       movi            %0, 0    \n"
> -               "2:                              \n"
> -               : "=&r" (tmp)
> -               : "r"(p)
> -               : "cc");
> -
> -       if (!tmp)
> -               smp_mb();
> -
> -       return !tmp;
> -}
> -
> -#endif /* CONFIG_QUEUED_RWLOCKS */
>  #endif /* __ASM_CSKY_SPINLOCK_H */



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
