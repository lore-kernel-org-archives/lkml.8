Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E570C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE66207D8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nd5NSFf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgFCLm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgFCLmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432AC08C5C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/2QXn+atrvGmy2WDbzn5KMB/u9lheYoEWUB6ctzoU3g=; b=nd5NSFf1K9rXAPZ5EqvJWLfgJj
        K0Udc3DDJu569lTf2A7VaH8rgTeBA6lWIS81w8GFLRHNd1DAbwtMrCS3Mu9XjgWkIFWRhTFgWeU54
        CrBJsRr1MxN8ukND6clELPnM/tI5AvfrHJ1VofR37y9xGghURpQQJC+iKuh/uAr25Gr1OUoSXYrJ2
        C8ryF7mf/xTLWOkDyQbeE+/M+9taxnwG79sXN106K+E5INVrBeyYi6hXYgA5+pEnf3pZXPl4EkTeU
        glsWl3s65PTcQsfG0mIR9FjqyJWyrnAq1uzQPsh3KMNC6Trn+zZGXDzG7065dRyJr91ynAmtNyAOs
        zAJBNCZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRmr-0005oW-FJ; Wed, 03 Jun 2020 11:42:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F266B306D6D;
        Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B4319209DB0D0; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114052.070166551@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 5/9] x86/entry: __always_inline arch_atomic_* for noinstr
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x33: call to arch_atomic_and.constprop.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -205,13 +205,13 @@ static __always_inline bool arch_atomic_
 }
 #define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
-static inline int arch_atomic_xchg(atomic_t *v, int new)
+static __always_inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	return arch_xchg(&v->counter, new);
 }
 #define arch_atomic_xchg arch_atomic_xchg
 
-static inline void arch_atomic_and(int i, atomic_t *v)
+static __always_inline void arch_atomic_and(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "andl %1,%0"
 			: "+m" (v->counter)
@@ -219,7 +219,7 @@ static inline void arch_atomic_and(int i
 			: "memory");
 }
 
-static inline int arch_atomic_fetch_and(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
 {
 	int val = arch_atomic_read(v);
 
@@ -229,7 +229,7 @@ static inline int arch_atomic_fetch_and(
 }
 #define arch_atomic_fetch_and arch_atomic_fetch_and
 
-static inline void arch_atomic_or(int i, atomic_t *v)
+static __always_inline void arch_atomic_or(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "orl %1,%0"
 			: "+m" (v->counter)
@@ -237,7 +237,7 @@ static inline void arch_atomic_or(int i,
 			: "memory");
 }
 
-static inline int arch_atomic_fetch_or(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
 {
 	int val = arch_atomic_read(v);
 
@@ -247,7 +247,7 @@ static inline int arch_atomic_fetch_or(i
 }
 #define arch_atomic_fetch_or arch_atomic_fetch_or
 
-static inline void arch_atomic_xor(int i, atomic_t *v)
+static __always_inline void arch_atomic_xor(int i, atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "xorl %1,%0"
 			: "+m" (v->counter)
@@ -255,7 +255,7 @@ static inline void arch_atomic_xor(int i
 			: "memory");
 }
 
-static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
+static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 {
 	int val = arch_atomic_read(v);
 


