Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D515C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB6822B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRpAf3O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHETwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgHEQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:51:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536DDC0617A2;
        Wed,  5 Aug 2020 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/Fw/YwT0RaCutX0cUSbcxCGxSzZ/4+guyO4MYB9PIE=; b=nRpAf3O3LK1l4VUhcqT0kTJOAy
        QUGaGE2bguJ2MZd5wtNj+IcN3W5iFfOPC9jXpuR+uNhrbITi4EvGOChS261HzgvS4YYR6P4nwJW2d
        Mpgp8KCGE7C23wCNyNaqRg+zJrx892AoVWlRDV6Pi/2h1vbN9yFQM2lqyYvbXOCFffWnc5BkpM8qb
        YDqptN46ty1/meiD+lbJ+IfCu27GxXg1LYEBqSRk7Srl2pl1lCNpwxPzqGKadW0GyVBVWAM3PETwf
        dwyd5oFGBJV4ClSiiPlJ0NloA65GZZFgFa9XHS4cS5AiCXHsyk9jwUP8P69xbwB5z+qBslrk+b16c
        m8DKuvuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Gu7-0005ei-La; Wed, 05 Aug 2020 10:44:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B83C301E02;
        Wed,  5 Aug 2020 12:44:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17BAB22281192; Wed,  5 Aug 2020 12:44:15 +0200 (CEST)
Date:   Wed, 5 Aug 2020 12:44:15 +0200
From:   peterz@infradead.org
To:     ren_guo@c-sky.com
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        mathieu.desnoyers@efficios.com, Will Deacon <will@kernel.org>
Subject: Re: csky: smp_mb__after_spinlock
Message-ID: <20200805104415.GA35926@hirez.programming.kicks-ass.net>
References: <20200805104146.GP2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805104146.GP2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 12:41:46PM +0200, peterz@infradead.org wrote:
> Hi,
> 
> While doing an audit of smp_mb__after_spinlock, I found that csky
> defines it, why?
> 
> CSKY only has smp_mb(), it doesn't override __atomic_acquire_fence or
> otherwise special cases it's atomic*_acquire() primitives. It has an
> explicit smp_mb() in its arch_spin_lock().

Also, why have two implementations of all the locking ?

---
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index bd31ab12f77d..332738e93e57 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -7,7 +7,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
 	select COMMON_CLK
 	select CLKSRC_MMIO
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index 7cf3f2b34cea..69f5aa249c5f 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -6,8 +6,6 @@
 #include <linux/spinlock_types.h>
 #include <asm/barrier.h>
 
-#ifdef CONFIG_QUEUED_RWLOCKS
-
 /*
  * Ticket-based spin-locking.
  */
@@ -88,169 +86,4 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 
 #include <asm/qrwlock.h>
 
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()	smp_mb()
-
-#else /* CONFIG_QUEUED_RWLOCKS */
-
-/*
- * Test-and-set spin-locking.
- */
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 1b   \n"
-		"	movi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-	smp_mb();
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->lock, 0);
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 2f   \n"
-		"	movi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		"	movi		%0, 0    \n"
-		"2:				 \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-
-	if (!tmp)
-		smp_mb();
-
-	return !tmp;
-}
-
-#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
-
-/*
- * read lock/unlock/trylock
- */
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	blz		%0, 1b   \n"
-		"	addi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-	smp_mb();
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	smp_mb();
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	subi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	blz		%0, 2f   \n"
-		"	addi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		"	movi		%0, 0    \n"
-		"2:				 \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-
-	if (!tmp)
-		smp_mb();
-
-	return !tmp;
-}
-
-/*
- * write lock/unlock/trylock
- */
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 1b   \n"
-		"	subi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-	smp_mb();
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	smp_mb();
-	WRITE_ONCE(lock->lock, 0);
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	u32 *p = &lock->lock;
-	u32 tmp;
-
-	asm volatile (
-		"1:	ldex.w		%0, (%1) \n"
-		"	bnez		%0, 2f   \n"
-		"	subi		%0, 1    \n"
-		"	stex.w		%0, (%1) \n"
-		"	bez		%0, 1b   \n"
-		"	movi		%0, 0    \n"
-		"2:				 \n"
-		: "=&r" (tmp)
-		: "r"(p)
-		: "cc");
-
-	if (!tmp)
-		smp_mb();
-
-	return !tmp;
-}
-
-#endif /* CONFIG_QUEUED_RWLOCKS */
 #endif /* __ASM_CSKY_SPINLOCK_H */
