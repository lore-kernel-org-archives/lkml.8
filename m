Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B77C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87001206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFLAc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgFLAcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:32:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E142C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:32:23 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjXcG-00015G-3m; Fri, 12 Jun 2020 02:32:17 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ADE4B100D0B;
        Fri, 12 Jun 2020 02:32:15 +0200 (CEST)
Date:   Fri, 12 Jun 2020 00:24:48 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT pull V2] locking/urgent for v5.8
References: <159192148730.1475.8112596092479045470.tglx@nanos.tec.linutronix.de>
Message-ID: <159192148852.1475.15416757527255848556.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-06-11

up to:  37f8173dd849: locking/atomics: Flip fallbacks and instrumentation

It has been rebased and distangled as you requested. It is based on

  b29482fde649 ("Merge branch 'work.epoll' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

from your tree which contains the rwonce rework from Will. The rebase has
been checked by Peter.


Peter Zijlstra's rework of atomics and fallbacks. This solves two problems:

  1) Compilers uninline small atomic_* static inline functions which can
     expose them to instrumentation.

  2) The instrumentation of atomic primitives was done at the architecture
     level while composites or fallbacks were provided at the generic level.
     As a result there are no uninstrumented variants of the fallbacks.

Both issues were in the way of fully isolating fragile entry code pathes
and especially the text poke int3 handler which is prone to an endless
recursion problem when anything in that code path is about to be
instrumented. This was always a problem, but got elevated due to the new
batch mode updates of tracing.

The solution is to mark the functions __always_inline and to flip the
fallback and instrumentation so the non-instrumented variants are at the
architecture level and the instrumentation is done in generic code.

The latter introduces another fallback variant which will go away once all
architectures have been moved over to arch_atomic_*.

Thanks,

	tglx

------------------>
Marco Elver (1):
      asm-generic/atomic: Use __always_inline for fallback wrappers

Peter Zijlstra (1):
      locking/atomics: Flip fallbacks and instrumentation


 arch/arm64/include/asm/atomic.h              |    6 +-
 arch/x86/include/asm/atomic.h                |   17 +-
 arch/x86/include/asm/atomic64_32.h           |    9 +
 arch/x86/include/asm/atomic64_64.h           |   15 +-
 include/linux/atomic-arch-fallback.h         | 2291 ++++++++++++++++++++++++++
 include/linux/atomic-fallback.h              |  346 ++--
 include/linux/atomic.h                       |   11 +
 scripts/atomic/fallbacks/acquire             |    6 +-
 scripts/atomic/fallbacks/add_negative        |    8 +-
 scripts/atomic/fallbacks/add_unless          |    8 +-
 scripts/atomic/fallbacks/andnot              |    6 +-
 scripts/atomic/fallbacks/dec                 |    6 +-
 scripts/atomic/fallbacks/dec_and_test        |    8 +-
 scripts/atomic/fallbacks/dec_if_positive     |    8 +-
 scripts/atomic/fallbacks/dec_unless_positive |    8 +-
 scripts/atomic/fallbacks/fence               |    6 +-
 scripts/atomic/fallbacks/fetch_add_unless    |   10 +-
 scripts/atomic/fallbacks/inc                 |    6 +-
 scripts/atomic/fallbacks/inc_and_test        |    8 +-
 scripts/atomic/fallbacks/inc_not_zero        |    8 +-
 scripts/atomic/fallbacks/inc_unless_negative |    8 +-
 scripts/atomic/fallbacks/read_acquire        |    4 +-
 scripts/atomic/fallbacks/release             |    6 +-
 scripts/atomic/fallbacks/set_release         |    4 +-
 scripts/atomic/fallbacks/sub_and_test        |    8 +-
 scripts/atomic/fallbacks/try_cmpxchg         |    6 +-
 scripts/atomic/gen-atomic-fallback.sh        |   31 +-
 scripts/atomic/gen-atomics.sh                |    5 +-
 28 files changed, 2594 insertions(+), 269 deletions(-)
 create mode 100644 include/linux/atomic-arch-fallback.h

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 9543b5e0534d..a08890da696c 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -101,8 +101,8 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define arch_atomic_read(v)			READ_ONCE((v)->counter)
-#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)			__READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
 
 #define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
 #define arch_atomic_add_return_acquire		arch_atomic_add_return_acquire
@@ -225,6 +225,6 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
 
-#include <asm-generic/atomic-instrumented.h>
+#define ARCH_ATOMIC
 
 #endif /* __ASM_ATOMIC_H */
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 115127c7ad28..a9ae58826074 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -28,7 +28,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
 	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
 	 * it's non-inlined function that increases binary size and stack usage.
 	 */
-	return READ_ONCE((v)->counter);
+	return __READ_ONCE((v)->counter);
 }
 
 /**
@@ -40,7 +40,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
  */
 static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
-	WRITE_ONCE(v->counter, i);
+	__WRITE_ONCE(v->counter, i);
 }
 
 /**
@@ -166,6 +166,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
+#define arch_atomic_add_return arch_atomic_add_return
 
 /**
  * arch_atomic_sub_return - subtract integer and return
@@ -178,32 +179,37 @@ static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 {
 	return arch_atomic_add_return(-i, v);
 }
+#define arch_atomic_sub_return arch_atomic_sub_return
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
 	return xadd(&v->counter, i);
 }
+#define arch_atomic_fetch_add arch_atomic_fetch_add
 
 static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
 {
 	return xadd(&v->counter, -i);
 }
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	return try_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
 static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	return arch_xchg(&v->counter, new);
 }
+#define arch_atomic_xchg arch_atomic_xchg
 
 static inline void arch_atomic_and(int i, atomic_t *v)
 {
@@ -221,6 +227,7 @@ static inline int arch_atomic_fetch_and(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_and arch_atomic_fetch_and
 
 static inline void arch_atomic_or(int i, atomic_t *v)
 {
@@ -238,6 +245,7 @@ static inline int arch_atomic_fetch_or(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_or arch_atomic_fetch_or
 
 static inline void arch_atomic_xor(int i, atomic_t *v)
 {
@@ -255,6 +263,7 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
@@ -262,6 +271,6 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
-#include <asm-generic/atomic-instrumented.h>
+#define ARCH_ATOMIC
 
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 52cfaecb13f9..5efd01b548d1 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -75,6 +75,7 @@ static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
 /**
  * arch_atomic64_xchg - xchg atomic64 variable
@@ -94,6 +95,7 @@ static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 			     : "memory");
 	return o;
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 /**
  * arch_atomic64_set - set atomic64 variable
@@ -138,6 +140,7 @@ static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 			     ASM_NO_INPUT_CLOBBER("memory"));
 	return i;
 }
+#define arch_atomic64_add_return arch_atomic64_add_return
 
 /*
  * Other variants with different arithmetic operators:
@@ -149,6 +152,7 @@ static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 			     ASM_NO_INPUT_CLOBBER("memory"));
 	return i;
 }
+#define arch_atomic64_sub_return arch_atomic64_sub_return
 
 static inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
@@ -242,6 +246,7 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 			     "S" (v) : "memory");
 	return (int)a;
 }
+#define arch_atomic64_add_unless arch_atomic64_add_unless
 
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -281,6 +286,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
@@ -299,6 +305,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -317,6 +324,7 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -327,6 +335,7 @@ static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
 #define arch_atomic64_fetch_sub(i, v)	arch_atomic64_fetch_add(-(i), (v))
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 95c6ceac66b9..809bd010a751 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -19,7 +19,7 @@
  */
 static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
-	return READ_ONCE((v)->counter);
+	return __READ_ONCE((v)->counter);
 }
 
 /**
@@ -31,7 +31,7 @@ static inline s64 arch_atomic64_read(const atomic64_t *v)
  */
 static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
-	WRITE_ONCE(v->counter, i);
+	__WRITE_ONCE(v->counter, i);
 }
 
 /**
@@ -159,37 +159,43 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
+#define arch_atomic64_add_return arch_atomic64_add_return
 
 static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	return arch_atomic64_add_return(-i, v);
 }
+#define arch_atomic64_sub_return arch_atomic64_sub_return
 
 static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, i);
 }
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
 static inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, -i);
 }
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
 
 static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	return try_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
 static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	return arch_xchg(&v->counter, new);
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
@@ -207,6 +213,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 	return val;
 }
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
@@ -224,6 +231,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 	return val;
 }
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -241,5 +249,6 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 	return val;
 }
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 #endif /* _ASM_X86_ATOMIC64_64_H */
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
new file mode 100644
index 000000000000..bcb6aa27cfa6
--- /dev/null
+++ b/include/linux/atomic-arch-fallback.h
@@ -0,0 +1,2291 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-fallback.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_FALLBACK_H
+#define _LINUX_ATOMIC_FALLBACK_H
+
+#include <linux/compiler.h>
+
+#ifndef arch_xchg_relaxed
+#define arch_xchg_relaxed		arch_xchg
+#define arch_xchg_acquire		arch_xchg
+#define arch_xchg_release		arch_xchg
+#else /* arch_xchg_relaxed */
+
+#ifndef arch_xchg_acquire
+#define arch_xchg_acquire(...) \
+	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg_release
+#define arch_xchg_release(...) \
+	__atomic_op_release(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg
+#define arch_xchg(...) \
+	__atomic_op_fence(arch_xchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_xchg_relaxed */
+
+#ifndef arch_cmpxchg_relaxed
+#define arch_cmpxchg_relaxed		arch_cmpxchg
+#define arch_cmpxchg_acquire		arch_cmpxchg
+#define arch_cmpxchg_release		arch_cmpxchg
+#else /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg_acquire
+#define arch_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg_release
+#define arch_cmpxchg_release(...) \
+	__atomic_op_release(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg
+#define arch_cmpxchg(...) \
+	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg64_relaxed
+#define arch_cmpxchg64_relaxed		arch_cmpxchg64
+#define arch_cmpxchg64_acquire		arch_cmpxchg64
+#define arch_cmpxchg64_release		arch_cmpxchg64
+#else /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_cmpxchg64_acquire
+#define arch_cmpxchg64_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64_release
+#define arch_cmpxchg64_release(...) \
+	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64
+#define arch_cmpxchg64(...) \
+	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_atomic_read_acquire
+static __always_inline int
+arch_atomic_read_acquire(const atomic_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic_read_acquire arch_atomic_read_acquire
+#endif
+
+#ifndef arch_atomic_set_release
+static __always_inline void
+arch_atomic_set_release(atomic_t *v, int i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic_set_release arch_atomic_set_release
+#endif
+
+#ifndef arch_atomic_add_return_relaxed
+#define arch_atomic_add_return_acquire arch_atomic_add_return
+#define arch_atomic_add_return_release arch_atomic_add_return
+#define arch_atomic_add_return_relaxed arch_atomic_add_return
+#else /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_add_return_acquire
+static __always_inline int
+arch_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
+#endif
+
+#ifndef arch_atomic_add_return_release
+static __always_inline int
+arch_atomic_add_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_add_return_relaxed(i, v);
+}
+#define arch_atomic_add_return_release arch_atomic_add_return_release
+#endif
+
+#ifndef arch_atomic_add_return
+static __always_inline int
+arch_atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_add_return arch_atomic_add_return
+#endif
+
+#endif /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add
+#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add
+#else /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_fetch_add_acquire
+static __always_inline int
+arch_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic_fetch_add_release
+static __always_inline int
+arch_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add_release
+#endif
+
+#ifndef arch_atomic_fetch_add
+static __always_inline int
+arch_atomic_fetch_add(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add arch_atomic_fetch_add
+#endif
+
+#endif /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_sub_return_relaxed
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return
+#define arch_atomic_sub_return_release arch_atomic_sub_return
+#define arch_atomic_sub_return_relaxed arch_atomic_sub_return
+#else /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_sub_return_acquire
+static __always_inline int
+arch_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
+#endif
+
+#ifndef arch_atomic_sub_return_release
+static __always_inline int
+arch_atomic_sub_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+#define arch_atomic_sub_return_release arch_atomic_sub_return_release
+#endif
+
+#ifndef arch_atomic_sub_return
+static __always_inline int
+arch_atomic_sub_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_sub_return arch_atomic_sub_return
+#endif
+
+#endif /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
+#else /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_fetch_sub_acquire
+static __always_inline int
+arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic_fetch_sub_release
+static __always_inline int
+arch_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub_release
+#endif
+
+#ifndef arch_atomic_fetch_sub
+static __always_inline int
+arch_atomic_fetch_sub(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#endif
+
+#endif /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_inc
+static __always_inline void
+arch_atomic_inc(atomic_t *v)
+{
+	arch_atomic_add(1, v);
+}
+#define arch_atomic_inc arch_atomic_inc
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+#ifdef arch_atomic_inc_return
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return
+#define arch_atomic_inc_return_release arch_atomic_inc_return
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return
+#endif /* arch_atomic_inc_return */
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	return arch_atomic_add_return(1, v);
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	return arch_atomic_add_return_acquire(1, v);
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	return arch_atomic_add_return_release(1, v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+static __always_inline int
+arch_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_add_return_relaxed(1, v);
+}
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+#endif
+
+#else /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_inc_return_relaxed(v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#endif /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_fetch_inc_relaxed
+#ifdef arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
+#endif /* arch_atomic_fetch_inc */
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	return arch_atomic_fetch_add(1, v);
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_add_acquire(1, v);
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	return arch_atomic_fetch_add_release(1, v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc_relaxed
+static __always_inline int
+arch_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_add_relaxed(1, v);
+}
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#endif /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_dec
+static __always_inline void
+arch_atomic_dec(atomic_t *v)
+{
+	arch_atomic_sub(1, v);
+}
+#define arch_atomic_dec arch_atomic_dec
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+#ifdef arch_atomic_dec_return
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return
+#define arch_atomic_dec_return_release arch_atomic_dec_return
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return
+#endif /* arch_atomic_dec_return */
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	return arch_atomic_sub_return(1, v);
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	return arch_atomic_sub_return_acquire(1, v);
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	return arch_atomic_sub_return_release(1, v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+static __always_inline int
+arch_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_sub_return_relaxed(1, v);
+}
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
+#endif
+
+#else /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_dec_return_relaxed(v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#endif /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_fetch_dec_relaxed
+#ifdef arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
+#endif /* arch_atomic_fetch_dec */
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	return arch_atomic_fetch_sub(1, v);
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_acquire(1, v);
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_release(1, v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec_relaxed
+static __always_inline int
+arch_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#endif /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and
+#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and
+#else /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_fetch_and_acquire
+static __always_inline int
+arch_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic_fetch_and_release
+static __always_inline int
+arch_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and_release
+#endif
+
+#ifndef arch_atomic_fetch_and
+static __always_inline int
+arch_atomic_fetch_and(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and arch_atomic_fetch_and
+#endif
+
+#endif /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_andnot
+static __always_inline void
+arch_atomic_andnot(int i, atomic_t *v)
+{
+	arch_atomic_and(~i, v);
+}
+#define arch_atomic_andnot arch_atomic_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+#ifdef arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
+#endif /* arch_atomic_fetch_andnot */
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and(~i, v);
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_acquire(~i, v);
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_release(~i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+static __always_inline int
+arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#endif /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or
+#define arch_atomic_fetch_or_relaxed arch_atomic_fetch_or
+#else /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_or_acquire
+static __always_inline int
+arch_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic_fetch_or_release
+static __always_inline int
+arch_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or_release
+#endif
+
+#ifndef arch_atomic_fetch_or
+static __always_inline int
+arch_atomic_fetch_or(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or arch_atomic_fetch_or
+#endif
+
+#endif /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
+#else /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_fetch_xor_acquire
+static __always_inline int
+arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic_fetch_xor_release
+static __always_inline int
+arch_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor_release
+#endif
+
+#ifndef arch_atomic_fetch_xor
+static __always_inline int
+arch_atomic_fetch_xor(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
+#endif
+
+#endif /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_xchg_relaxed
+#define arch_atomic_xchg_acquire arch_atomic_xchg
+#define arch_atomic_xchg_release arch_atomic_xchg
+#define arch_atomic_xchg_relaxed arch_atomic_xchg
+#else /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_xchg_acquire
+static __always_inline int
+arch_atomic_xchg_acquire(atomic_t *v, int i)
+{
+	int ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
+#endif
+
+#ifndef arch_atomic_xchg_release
+static __always_inline int
+arch_atomic_xchg_release(atomic_t *v, int i)
+{
+	__atomic_release_fence();
+	return arch_atomic_xchg_relaxed(v, i);
+}
+#define arch_atomic_xchg_release arch_atomic_xchg_release
+#endif
+
+#ifndef arch_atomic_xchg
+static __always_inline int
+arch_atomic_xchg(atomic_t *v, int i)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_xchg arch_atomic_xchg
+#endif
+
+#endif /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
+#else /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_acquire
+static __always_inline int
+arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_cmpxchg_release
+static __always_inline int
+arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_cmpxchg
+static __always_inline int
+arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
+#endif
+
+#endif /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+#ifdef arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
+#endif /* arch_atomic_try_cmpxchg */
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#endif /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_sub_and_test
+/**
+ * arch_atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return(i, v) == 0;
+}
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
+#endif
+
+#ifndef arch_atomic_dec_and_test
+/**
+ * arch_atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic_dec_and_test(atomic_t *v)
+{
+	return arch_atomic_dec_return(v) == 0;
+}
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
+#endif
+
+#ifndef arch_atomic_inc_and_test
+/**
+ * arch_atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_inc_and_test(atomic_t *v)
+{
+	return arch_atomic_inc_return(v) == 0;
+}
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
+#endif
+
+#ifndef arch_atomic_add_negative
+/**
+ * arch_atomic_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic_add_negative(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(i, v) < 0;
+}
+#define arch_atomic_add_negative arch_atomic_add_negative
+#endif
+
+#ifndef arch_atomic_fetch_add_unless
+/**
+ * arch_atomic_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline int
+arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
+#endif
+
+#ifndef arch_atomic_add_unless
+/**
+ * arch_atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return arch_atomic_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic_add_unless arch_atomic_add_unless
+#endif
+
+#ifndef arch_atomic_inc_not_zero
+/**
+ * arch_atomic_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic_inc_not_zero(atomic_t *v)
+{
+	return arch_atomic_add_unless(v, 1, 0);
+}
+#define arch_atomic_inc_not_zero arch_atomic_inc_not_zero
+#endif
+
+#ifndef arch_atomic_inc_unless_negative
+static __always_inline bool
+arch_atomic_inc_unless_negative(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+#endif
+
+#ifndef arch_atomic_dec_unless_positive
+static __always_inline bool
+arch_atomic_dec_unless_positive(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+#endif
+
+#ifndef arch_atomic_dec_if_positive
+static __always_inline int
+arch_atomic_dec_if_positive(atomic_t *v)
+{
+	int dec, c = arch_atomic_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
+#endif
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
+#ifndef arch_atomic64_read_acquire
+static __always_inline s64
+arch_atomic64_read_acquire(const atomic64_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic64_read_acquire arch_atomic64_read_acquire
+#endif
+
+#ifndef arch_atomic64_set_release
+static __always_inline void
+arch_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic64_set_release arch_atomic64_set_release
+#endif
+
+#ifndef arch_atomic64_add_return_relaxed
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return
+#define arch_atomic64_add_return_release arch_atomic64_add_return
+#define arch_atomic64_add_return_relaxed arch_atomic64_add_return
+#else /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_add_return_acquire
+static __always_inline s64
+arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
+#endif
+
+#ifndef arch_atomic64_add_return_release
+static __always_inline s64
+arch_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+#define arch_atomic64_add_return_release arch_atomic64_add_return_release
+#endif
+
+#ifndef arch_atomic64_add_return
+static __always_inline s64
+arch_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_add_return arch_atomic64_add_return
+#endif
+
+#endif /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
+#else /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_fetch_add_acquire
+static __always_inline s64
+arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_add_release
+static __always_inline s64
+arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
+#endif
+
+#ifndef arch_atomic64_fetch_add
+static __always_inline s64
+arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
+#endif
+
+#endif /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_sub_return_relaxed
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return
+#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
+#else /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_sub_return_acquire
+static __always_inline s64
+arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
+#endif
+
+#ifndef arch_atomic64_sub_return_release
+static __always_inline s64
+arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
+#endif
+
+#ifndef arch_atomic64_sub_return
+static __always_inline s64
+arch_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return arch_atomic64_sub_return
+#endif
+
+#endif /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
+#else /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_acquire
+static __always_inline s64
+arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_sub_release
+static __always_inline s64
+arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
+#endif
+
+#ifndef arch_atomic64_fetch_sub
+static __always_inline s64
+arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#endif
+
+#endif /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_inc
+static __always_inline void
+arch_atomic64_inc(atomic64_t *v)
+{
+	arch_atomic64_add(1, v);
+}
+#define arch_atomic64_inc arch_atomic64_inc
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+#ifdef arch_atomic64_inc_return
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return
+#endif /* arch_atomic64_inc_return */
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	return arch_atomic64_add_return(1, v);
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_add_return_acquire(1, v);
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	return arch_atomic64_add_return_release(1, v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+static __always_inline s64
+arch_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_add_return_relaxed(1, v);
+}
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+#endif
+
+#else /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_inc_return_relaxed(v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#endif /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+#ifdef arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
+#endif /* arch_atomic64_fetch_inc */
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add(1, v);
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_acquire(1, v);
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_release(1, v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+static __always_inline s64
+arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_relaxed(1, v);
+}
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#endif /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_dec
+static __always_inline void
+arch_atomic64_dec(atomic64_t *v)
+{
+	arch_atomic64_sub(1, v);
+}
+#define arch_atomic64_dec arch_atomic64_dec
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+#ifdef arch_atomic64_dec_return
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return
+#endif /* arch_atomic64_dec_return */
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	return arch_atomic64_sub_return(1, v);
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_acquire(1, v);
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_release(1, v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+static __always_inline s64
+arch_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_relaxed(1, v);
+}
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
+#endif
+
+#else /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_dec_return_relaxed(v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#endif /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+#ifdef arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
+#endif /* arch_atomic64_fetch_dec */
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub(1, v);
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_acquire(1, v);
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_release(1, v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+static __always_inline s64
+arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#endif /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
+#else /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_fetch_and_acquire
+static __always_inline s64
+arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_and_release
+static __always_inline s64
+arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and_release
+#endif
+
+#ifndef arch_atomic64_fetch_and
+static __always_inline s64
+arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
+#endif
+
+#endif /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_andnot
+static __always_inline void
+arch_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(~i, v);
+}
+#define arch_atomic64_andnot arch_atomic64_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+#ifdef arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
+#endif /* arch_atomic64_fetch_andnot */
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and(~i, v);
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_acquire(~i, v);
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_release(~i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+static __always_inline s64
+arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#endif /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
+#else /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_or_acquire
+static __always_inline s64
+arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_or_release
+static __always_inline s64
+arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
+#endif
+
+#ifndef arch_atomic64_fetch_or
+static __always_inline s64
+arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
+#endif
+
+#endif /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
+#else /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_acquire
+static __always_inline s64
+arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_xor_release
+static __always_inline s64
+arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
+#endif
+
+#ifndef arch_atomic64_fetch_xor
+static __always_inline s64
+arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
+#endif
+
+#endif /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_xchg_relaxed
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg
+#define arch_atomic64_xchg_release arch_atomic64_xchg
+#define arch_atomic64_xchg_relaxed arch_atomic64_xchg
+#else /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_xchg_acquire
+static __always_inline s64
+arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+{
+	s64 ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
+#endif
+
+#ifndef arch_atomic64_xchg_release
+static __always_inline s64
+arch_atomic64_xchg_release(atomic64_t *v, s64 i)
+{
+	__atomic_release_fence();
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+#define arch_atomic64_xchg_release arch_atomic64_xchg_release
+#endif
+
+#ifndef arch_atomic64_xchg
+static __always_inline s64
+arch_atomic64_xchg(atomic64_t *v, s64 i)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_xchg arch_atomic64_xchg
+#endif
+
+#endif /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
+#else /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_acquire
+static __always_inline s64
+arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_cmpxchg_release
+static __always_inline s64
+arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_cmpxchg
+static __always_inline s64
+arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
+#endif
+
+#endif /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+#ifdef arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
+#endif /* arch_atomic64_try_cmpxchg */
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#endif /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_sub_and_test
+/**
+ * arch_atomic64_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return(i, v) == 0;
+}
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
+#endif
+
+#ifndef arch_atomic64_dec_and_test
+/**
+ * arch_atomic64_dec_and_test - decrement and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic64_dec_and_test(atomic64_t *v)
+{
+	return arch_atomic64_dec_return(v) == 0;
+}
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
+#endif
+
+#ifndef arch_atomic64_inc_and_test
+/**
+ * arch_atomic64_inc_and_test - increment and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_inc_and_test(atomic64_t *v)
+{
+	return arch_atomic64_inc_return(v) == 0;
+}
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
+#endif
+
+#ifndef arch_atomic64_add_negative
+/**
+ * arch_atomic64_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return(i, v) < 0;
+}
+#define arch_atomic64_add_negative arch_atomic64_add_negative
+#endif
+
+#ifndef arch_atomic64_fetch_add_unless
+/**
+ * arch_atomic64_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline s64
+arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
+#endif
+
+#ifndef arch_atomic64_add_unless
+/**
+ * arch_atomic64_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic64_add_unless arch_atomic64_add_unless
+#endif
+
+#ifndef arch_atomic64_inc_not_zero
+/**
+ * arch_atomic64_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return arch_atomic64_add_unless(v, 1, 0);
+}
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
+#endif
+
+#ifndef arch_atomic64_inc_unless_negative
+static __always_inline bool
+arch_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
+#endif
+
+#ifndef arch_atomic64_dec_unless_positive
+static __always_inline bool
+arch_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
+#endif
+
+#ifndef arch_atomic64_dec_if_positive
+static __always_inline s64
+arch_atomic64_dec_if_positive(atomic64_t *v)
+{
+	s64 dec, c = arch_atomic64_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
+#endif
+
+#endif /* _LINUX_ATOMIC_FALLBACK_H */
+// 90cd26cfd69d2250303d654955a0cc12620fb91b
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index a7d240e465c0..2c4927bf7b8d 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_ATOMIC_FALLBACK_H
 #define _LINUX_ATOMIC_FALLBACK_H
 
+#include <linux/compiler.h>
+
 #ifndef xchg_relaxed
 #define xchg_relaxed		xchg
 #define xchg_acquire		xchg
@@ -76,7 +78,7 @@
 #endif /* cmpxchg64_relaxed */
 
 #ifndef atomic_read_acquire
-static inline int
+static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
@@ -85,7 +87,7 @@ atomic_read_acquire(const atomic_t *v)
 #endif
 
 #ifndef atomic_set_release
-static inline void
+static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
 	smp_store_release(&(v)->counter, i);
@@ -100,7 +102,7 @@ atomic_set_release(atomic_t *v, int i)
 #else /* atomic_add_return_relaxed */
 
 #ifndef atomic_add_return_acquire
-static inline int
+static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_add_return_relaxed(i, v);
@@ -111,7 +113,7 @@ atomic_add_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_add_return_release
-static inline int
+static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -121,7 +123,7 @@ atomic_add_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_add_return
-static inline int
+static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
 	int ret;
@@ -142,7 +144,7 @@ atomic_add_return(int i, atomic_t *v)
 #else /* atomic_fetch_add_relaxed */
 
 #ifndef atomic_fetch_add_acquire
-static inline int
+static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_add_relaxed(i, v);
@@ -153,7 +155,7 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_add_release
-static inline int
+static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -163,7 +165,7 @@ atomic_fetch_add_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_add
-static inline int
+static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
 	int ret;
@@ -184,7 +186,7 @@ atomic_fetch_add(int i, atomic_t *v)
 #else /* atomic_sub_return_relaxed */
 
 #ifndef atomic_sub_return_acquire
-static inline int
+static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_sub_return_relaxed(i, v);
@@ -195,7 +197,7 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_sub_return_release
-static inline int
+static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -205,7 +207,7 @@ atomic_sub_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_sub_return
-static inline int
+static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
 	int ret;
@@ -226,7 +228,7 @@ atomic_sub_return(int i, atomic_t *v)
 #else /* atomic_fetch_sub_relaxed */
 
 #ifndef atomic_fetch_sub_acquire
-static inline int
+static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_sub_relaxed(i, v);
@@ -237,7 +239,7 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_sub_release
-static inline int
+static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -247,7 +249,7 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_sub
-static inline int
+static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
 	int ret;
@@ -262,7 +264,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 #endif /* atomic_fetch_sub_relaxed */
 
 #ifndef atomic_inc
-static inline void
+static __always_inline void
 atomic_inc(atomic_t *v)
 {
 	atomic_add(1, v);
@@ -278,7 +280,7 @@ atomic_inc(atomic_t *v)
 #endif /* atomic_inc_return */
 
 #ifndef atomic_inc_return
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	return atomic_add_return(1, v);
@@ -287,7 +289,7 @@ atomic_inc_return(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_acquire
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	return atomic_add_return_acquire(1, v);
@@ -296,7 +298,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_release
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	return atomic_add_return_release(1, v);
@@ -305,7 +307,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_relaxed
-static inline int
+static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	return atomic_add_return_relaxed(1, v);
@@ -316,7 +318,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 #else /* atomic_inc_return_relaxed */
 
 #ifndef atomic_inc_return_acquire
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	int ret = atomic_inc_return_relaxed(v);
@@ -327,7 +329,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_release
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -337,7 +339,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	int ret;
@@ -359,7 +361,7 @@ atomic_inc_return(atomic_t *v)
 #endif /* atomic_fetch_inc */
 
 #ifndef atomic_fetch_inc
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	return atomic_fetch_add(1, v);
@@ -368,7 +370,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_acquire
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	return atomic_fetch_add_acquire(1, v);
@@ -377,7 +379,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_release
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	return atomic_fetch_add_release(1, v);
@@ -386,7 +388,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	return atomic_fetch_add_relaxed(1, v);
@@ -397,7 +399,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 #else /* atomic_fetch_inc_relaxed */
 
 #ifndef atomic_fetch_inc_acquire
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	int ret = atomic_fetch_inc_relaxed(v);
@@ -408,7 +410,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_release
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -418,7 +420,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	int ret;
@@ -433,7 +435,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif /* atomic_fetch_inc_relaxed */
 
 #ifndef atomic_dec
-static inline void
+static __always_inline void
 atomic_dec(atomic_t *v)
 {
 	atomic_sub(1, v);
@@ -449,7 +451,7 @@ atomic_dec(atomic_t *v)
 #endif /* atomic_dec_return */
 
 #ifndef atomic_dec_return
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	return atomic_sub_return(1, v);
@@ -458,7 +460,7 @@ atomic_dec_return(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_acquire
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	return atomic_sub_return_acquire(1, v);
@@ -467,7 +469,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_release
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	return atomic_sub_return_release(1, v);
@@ -476,7 +478,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_relaxed
-static inline int
+static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	return atomic_sub_return_relaxed(1, v);
@@ -487,7 +489,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 #else /* atomic_dec_return_relaxed */
 
 #ifndef atomic_dec_return_acquire
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	int ret = atomic_dec_return_relaxed(v);
@@ -498,7 +500,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_release
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -508,7 +510,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	int ret;
@@ -530,7 +532,7 @@ atomic_dec_return(atomic_t *v)
 #endif /* atomic_fetch_dec */
 
 #ifndef atomic_fetch_dec
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	return atomic_fetch_sub(1, v);
@@ -539,7 +541,7 @@ atomic_fetch_dec(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_acquire
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	return atomic_fetch_sub_acquire(1, v);
@@ -548,7 +550,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_release
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	return atomic_fetch_sub_release(1, v);
@@ -557,7 +559,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	return atomic_fetch_sub_relaxed(1, v);
@@ -568,7 +570,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 #else /* atomic_fetch_dec_relaxed */
 
 #ifndef atomic_fetch_dec_acquire
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	int ret = atomic_fetch_dec_relaxed(v);
@@ -579,7 +581,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_release
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -589,7 +591,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	int ret;
@@ -610,7 +612,7 @@ atomic_fetch_dec(atomic_t *v)
 #else /* atomic_fetch_and_relaxed */
 
 #ifndef atomic_fetch_and_acquire
-static inline int
+static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_and_relaxed(i, v);
@@ -621,7 +623,7 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_and_release
-static inline int
+static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -631,7 +633,7 @@ atomic_fetch_and_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_and
-static inline int
+static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
 	int ret;
@@ -646,7 +648,7 @@ atomic_fetch_and(int i, atomic_t *v)
 #endif /* atomic_fetch_and_relaxed */
 
 #ifndef atomic_andnot
-static inline void
+static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	atomic_and(~i, v);
@@ -662,7 +664,7 @@ atomic_andnot(int i, atomic_t *v)
 #endif /* atomic_fetch_andnot */
 
 #ifndef atomic_fetch_andnot
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	return atomic_fetch_and(~i, v);
@@ -671,7 +673,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_acquire
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	return atomic_fetch_and_acquire(~i, v);
@@ -680,7 +682,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_release
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	return atomic_fetch_and_release(~i, v);
@@ -689,7 +691,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	return atomic_fetch_and_relaxed(~i, v);
@@ -700,7 +702,7 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 #else /* atomic_fetch_andnot_relaxed */
 
 #ifndef atomic_fetch_andnot_acquire
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_andnot_relaxed(i, v);
@@ -711,7 +713,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_release
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -721,7 +723,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	int ret;
@@ -742,7 +744,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #else /* atomic_fetch_or_relaxed */
 
 #ifndef atomic_fetch_or_acquire
-static inline int
+static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_or_relaxed(i, v);
@@ -753,7 +755,7 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_or_release
-static inline int
+static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -763,7 +765,7 @@ atomic_fetch_or_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_or
-static inline int
+static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
 	int ret;
@@ -784,7 +786,7 @@ atomic_fetch_or(int i, atomic_t *v)
 #else /* atomic_fetch_xor_relaxed */
 
 #ifndef atomic_fetch_xor_acquire
-static inline int
+static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_xor_relaxed(i, v);
@@ -795,7 +797,7 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_xor_release
-static inline int
+static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -805,7 +807,7 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_xor
-static inline int
+static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
 	int ret;
@@ -826,7 +828,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 #else /* atomic_xchg_relaxed */
 
 #ifndef atomic_xchg_acquire
-static inline int
+static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	int ret = atomic_xchg_relaxed(v, i);
@@ -837,7 +839,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 #endif
 
 #ifndef atomic_xchg_release
-static inline int
+static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
 	__atomic_release_fence();
@@ -847,7 +849,7 @@ atomic_xchg_release(atomic_t *v, int i)
 #endif
 
 #ifndef atomic_xchg
-static inline int
+static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
 	int ret;
@@ -868,7 +870,7 @@ atomic_xchg(atomic_t *v, int i)
 #else /* atomic_cmpxchg_relaxed */
 
 #ifndef atomic_cmpxchg_acquire
-static inline int
+static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	int ret = atomic_cmpxchg_relaxed(v, old, new);
@@ -879,7 +881,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 #endif
 
 #ifndef atomic_cmpxchg_release
-static inline int
+static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	__atomic_release_fence();
@@ -889,7 +891,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 #endif
 
 #ifndef atomic_cmpxchg
-static inline int
+static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
@@ -911,7 +913,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 #endif /* atomic_try_cmpxchg */
 
 #ifndef atomic_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -924,7 +926,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -937,7 +939,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -950,7 +952,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_relaxed
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -965,7 +967,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 #else /* atomic_try_cmpxchg_relaxed */
 
 #ifndef atomic_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	bool ret = atomic_try_cmpxchg_relaxed(v, old, new);
@@ -976,7 +978,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	__atomic_release_fence();
@@ -986,7 +988,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	bool ret;
@@ -1010,7 +1012,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
 	return atomic_sub_return(i, v) == 0;
@@ -1027,7 +1029,7 @@ atomic_sub_and_test(int i, atomic_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
 	return atomic_dec_return(v) == 0;
@@ -1044,7 +1046,7 @@ atomic_dec_and_test(atomic_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
 	return atomic_inc_return(v) == 0;
@@ -1062,7 +1064,7 @@ atomic_inc_and_test(atomic_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
 	return atomic_add_return(i, v) < 0;
@@ -1080,7 +1082,7 @@ atomic_add_negative(int i, atomic_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline int
+static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c = atomic_read(v);
@@ -1105,7 +1107,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
 	return atomic_fetch_add_unless(v, a, u) != u;
@@ -1121,7 +1123,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
 	return atomic_add_unless(v, 1, 0);
@@ -1130,7 +1132,7 @@ atomic_inc_not_zero(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_unless_negative
-static inline bool
+static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
 	int c = atomic_read(v);
@@ -1146,7 +1148,7 @@ atomic_inc_unless_negative(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_unless_positive
-static inline bool
+static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
 	int c = atomic_read(v);
@@ -1162,7 +1164,7 @@ atomic_dec_unless_positive(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_if_positive
-static inline int
+static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
 	int dec, c = atomic_read(v);
@@ -1178,15 +1180,12 @@ atomic_dec_if_positive(atomic_t *v)
 #define atomic_dec_if_positive atomic_dec_if_positive
 #endif
 
-#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
 
 #ifndef atomic64_read_acquire
-static inline s64
+static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
@@ -1195,7 +1194,7 @@ atomic64_read_acquire(const atomic64_t *v)
 #endif
 
 #ifndef atomic64_set_release
-static inline void
+static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
 	smp_store_release(&(v)->counter, i);
@@ -1210,7 +1209,7 @@ atomic64_set_release(atomic64_t *v, s64 i)
 #else /* atomic64_add_return_relaxed */
 
 #ifndef atomic64_add_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_add_return_relaxed(i, v);
@@ -1221,7 +1220,7 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_add_return_release
-static inline s64
+static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1231,7 +1230,7 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_add_return
-static inline s64
+static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1252,7 +1251,7 @@ atomic64_add_return(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_add_relaxed */
 
 #ifndef atomic64_fetch_add_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_add_relaxed(i, v);
@@ -1263,7 +1262,7 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_add_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1273,7 +1272,7 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_add
-static inline s64
+static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1294,7 +1293,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 #else /* atomic64_sub_return_relaxed */
 
 #ifndef atomic64_sub_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_sub_return_relaxed(i, v);
@@ -1305,7 +1304,7 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_sub_return_release
-static inline s64
+static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1315,7 +1314,7 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_sub_return
-static inline s64
+static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1336,7 +1335,7 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_sub_relaxed */
 
 #ifndef atomic64_fetch_sub_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_sub_relaxed(i, v);
@@ -1347,7 +1346,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_sub_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1357,7 +1356,7 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_sub
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1372,7 +1371,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_sub_relaxed */
 
 #ifndef atomic64_inc
-static inline void
+static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
 	atomic64_add(1, v);
@@ -1388,7 +1387,7 @@ atomic64_inc(atomic64_t *v)
 #endif /* atomic64_inc_return */
 
 #ifndef atomic64_inc_return
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	return atomic64_add_return(1, v);
@@ -1397,7 +1396,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	return atomic64_add_return_acquire(1, v);
@@ -1406,7 +1405,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_release
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	return atomic64_add_return_release(1, v);
@@ -1415,7 +1414,7 @@ atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_relaxed
-static inline s64
+static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	return atomic64_add_return_relaxed(1, v);
@@ -1426,7 +1425,7 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 #else /* atomic64_inc_return_relaxed */
 
 #ifndef atomic64_inc_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_inc_return_relaxed(v);
@@ -1437,7 +1436,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_release
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1447,7 +1446,7 @@ atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	s64 ret;
@@ -1469,7 +1468,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif /* atomic64_fetch_inc */
 
 #ifndef atomic64_fetch_inc
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	return atomic64_fetch_add(1, v);
@@ -1478,7 +1477,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	return atomic64_fetch_add_acquire(1, v);
@@ -1487,7 +1486,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	return atomic64_fetch_add_release(1, v);
@@ -1496,7 +1495,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	return atomic64_fetch_add_relaxed(1, v);
@@ -1507,7 +1506,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 #else /* atomic64_fetch_inc_relaxed */
 
 #ifndef atomic64_fetch_inc_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_inc_relaxed(v);
@@ -1518,7 +1517,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1528,7 +1527,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	s64 ret;
@@ -1543,7 +1542,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif /* atomic64_fetch_inc_relaxed */
 
 #ifndef atomic64_dec
-static inline void
+static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
 	atomic64_sub(1, v);
@@ -1559,7 +1558,7 @@ atomic64_dec(atomic64_t *v)
 #endif /* atomic64_dec_return */
 
 #ifndef atomic64_dec_return
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	return atomic64_sub_return(1, v);
@@ -1568,7 +1567,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	return atomic64_sub_return_acquire(1, v);
@@ -1577,7 +1576,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_release
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	return atomic64_sub_return_release(1, v);
@@ -1586,7 +1585,7 @@ atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_relaxed
-static inline s64
+static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	return atomic64_sub_return_relaxed(1, v);
@@ -1597,7 +1596,7 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 #else /* atomic64_dec_return_relaxed */
 
 #ifndef atomic64_dec_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_dec_return_relaxed(v);
@@ -1608,7 +1607,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_release
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1618,7 +1617,7 @@ atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	s64 ret;
@@ -1640,7 +1639,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif /* atomic64_fetch_dec */
 
 #ifndef atomic64_fetch_dec
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	return atomic64_fetch_sub(1, v);
@@ -1649,7 +1648,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	return atomic64_fetch_sub_acquire(1, v);
@@ -1658,7 +1657,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	return atomic64_fetch_sub_release(1, v);
@@ -1667,7 +1666,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	return atomic64_fetch_sub_relaxed(1, v);
@@ -1678,7 +1677,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 #else /* atomic64_fetch_dec_relaxed */
 
 #ifndef atomic64_fetch_dec_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_dec_relaxed(v);
@@ -1689,7 +1688,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1699,7 +1698,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	s64 ret;
@@ -1720,7 +1719,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #else /* atomic64_fetch_and_relaxed */
 
 #ifndef atomic64_fetch_and_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_and_relaxed(i, v);
@@ -1731,7 +1730,7 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_and_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1741,7 +1740,7 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_and
-static inline s64
+static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1756,7 +1755,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_and_relaxed */
 
 #ifndef atomic64_andnot
-static inline void
+static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	atomic64_and(~i, v);
@@ -1772,7 +1771,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_andnot */
 
 #ifndef atomic64_fetch_andnot
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and(~i, v);
@@ -1781,7 +1780,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_acquire(~i, v);
@@ -1790,7 +1789,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_release(~i, v);
@@ -1799,7 +1798,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_relaxed(~i, v);
@@ -1810,7 +1809,7 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_andnot_relaxed */
 
 #ifndef atomic64_fetch_andnot_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_andnot_relaxed(i, v);
@@ -1821,7 +1820,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1831,7 +1830,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1852,7 +1851,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_or_relaxed */
 
 #ifndef atomic64_fetch_or_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_or_relaxed(i, v);
@@ -1863,7 +1862,7 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_or_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1873,7 +1872,7 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_or
-static inline s64
+static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1894,7 +1893,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_xor_relaxed */
 
 #ifndef atomic64_fetch_xor_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_xor_relaxed(i, v);
@@ -1905,7 +1904,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_xor_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1915,7 +1914,7 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_xor
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1936,7 +1935,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 #else /* atomic64_xchg_relaxed */
 
 #ifndef atomic64_xchg_acquire
-static inline s64
+static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	s64 ret = atomic64_xchg_relaxed(v, i);
@@ -1947,7 +1946,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64 i)
 #endif
 
 #ifndef atomic64_xchg_release
-static inline s64
+static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	__atomic_release_fence();
@@ -1957,7 +1956,7 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 #endif
 
 #ifndef atomic64_xchg
-static inline s64
+static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
 	s64 ret;
@@ -1978,7 +1977,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 #else /* atomic64_cmpxchg_relaxed */
 
 #ifndef atomic64_cmpxchg_acquire
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret = atomic64_cmpxchg_relaxed(v, old, new);
@@ -1989,7 +1988,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef atomic64_cmpxchg_release
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_release_fence();
@@ -1999,7 +1998,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef atomic64_cmpxchg
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret;
@@ -2021,7 +2020,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 #endif /* atomic64_try_cmpxchg */
 
 #ifndef atomic64_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2034,7 +2033,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2047,7 +2046,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2060,7 +2059,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_relaxed
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2075,7 +2074,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 #else /* atomic64_try_cmpxchg_relaxed */
 
 #ifndef atomic64_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	bool ret = atomic64_try_cmpxchg_relaxed(v, old, new);
@@ -2086,7 +2085,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_release_fence();
@@ -2096,7 +2095,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	bool ret;
@@ -2120,7 +2119,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return atomic64_sub_return(i, v) == 0;
@@ -2137,7 +2136,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
 	return atomic64_dec_return(v) == 0;
@@ -2154,7 +2153,7 @@ atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
 	return atomic64_inc_return(v) == 0;
@@ -2172,7 +2171,7 @@ atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return atomic64_add_return(i, v) < 0;
@@ -2190,7 +2189,7 @@ atomic64_add_negative(s64 i, atomic64_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c = atomic64_read(v);
@@ -2215,7 +2214,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	return atomic64_fetch_add_unless(v, a, u) != u;
@@ -2231,7 +2230,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
 	return atomic64_add_unless(v, 1, 0);
@@ -2240,7 +2239,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_unless_negative
-static inline bool
+static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
 	s64 c = atomic64_read(v);
@@ -2256,7 +2255,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_unless_positive
-static inline bool
+static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
 	s64 c = atomic64_read(v);
@@ -2272,7 +2271,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_if_positive
-static inline s64
+static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 dec, c = atomic64_read(v);
@@ -2288,8 +2287,5 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 #endif
 
-#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 25de4a2804d70f57e994fe3b419148658bb5378a
+// 1fac0941c79bf0ae100723cc2ac9b94061f0b67a
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 4c0d009a46f0..571a11008ab5 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -25,6 +25,12 @@
  * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
  */
 
+#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
+#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
@@ -71,7 +77,12 @@
 	__ret;								\
 })
 
+#ifdef ARCH_ATOMIC
+#include <linux/atomic-arch-fallback.h>
+#include <asm-generic/atomic-instrumented.h>
+#else
 #include <linux/atomic-fallback.h>
+#endif
 
 #include <asm-generic/atomic-long.h>
 
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index e38871e64db6..59c00529dc7c 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,8 +1,8 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}${name}${sfx}_acquire(${params})
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
-	${ret} ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${ret} ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index e6f4815637de..a66635bceefb 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_add_negative - add and test if negative
+ * ${arch}${atomic}_add_negative - add and test if negative
  * @i: integer value to add
  * @v: pointer of type ${atomic}_t
  *
@@ -8,9 +8,9 @@ cat <<EOF
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
-${atomic}_add_negative(${int} i, ${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_add_negative(${int} i, ${atomic}_t *v)
 {
-	return ${atomic}_add_return(i, v) < 0;
+	return ${arch}${atomic}_add_return(i, v) < 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 792533885fbf..2ff598a3f9ec 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${atomic}_add_unless - add unless the number is already a given value
+ * ${arch}${atomic}_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -8,9 +8,9 @@ cat << EOF
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
-${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+static __always_inline bool
+${arch}${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	return ${atomic}_fetch_add_unless(v, a, u) != u;
+	return ${arch}${atomic}_fetch_add_unless(v, a, u) != u;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 9f3a3216b5e3..3f18663dcefb 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,7 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}and${sfx}${order}(~i, v);
+	${retstmt}${arch}${atomic}_${pfx}and${sfx}${order}(~i, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index 10bbc82be31d..e2e01f0574bb 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,7 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}sub${sfx}${order}(1, v);
+	${retstmt}${arch}${atomic}_${pfx}sub${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 0ce7103b3df2..e8a5e492eb5f 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,15 +1,15 @@
 cat <<EOF
 /**
- * ${atomic}_dec_and_test - decrement and test
+ * ${arch}${atomic}_dec_and_test - decrement and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically decrements @v by 1 and
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
-${atomic}_dec_and_test(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_dec_and_test(${atomic}_t *v)
 {
-	return ${atomic}_dec_return(v) == 0;
+	return ${arch}${atomic}_dec_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index c52eacec43c8..527adec89c37 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,14 +1,14 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_dec_if_positive(${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_dec_if_positive(${atomic}_t *v)
 {
-	${int} dec, c = ${atomic}_read(v);
+	${int} dec, c = ${arch}${atomic}_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!${atomic}_try_cmpxchg(v, &c, dec));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index 8a2578f14268..dcab6848ca1e 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,13 +1,13 @@
 cat <<EOF
-static inline bool
-${atomic}_dec_unless_positive(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 82f68fa6931a..3764fc8ce945 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,10 +1,10 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}${name}${sfx}(${params})
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
 	__atomic_pre_full_fence();
-	ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_post_full_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index d2c091db7eae..0e0b9aef1515 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${atomic}_fetch_add_unless - add unless the number is already a given value
+ * ${arch}${atomic}_fetch_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -8,15 +8,15 @@ cat << EOF
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline ${int}
-${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+static __always_inline ${int}
+${arch}${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index f866b3ad2353..15ec62946e8c 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,7 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}add${sfx}${order}(1, v);
+	${retstmt}${arch}${atomic}_${pfx}add${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 4e2068869f7e..cecc8322a21f 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,15 +1,15 @@
 cat <<EOF
 /**
- * ${atomic}_inc_and_test - increment and test
+ * ${arch}${atomic}_inc_and_test - increment and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
-${atomic}_inc_and_test(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_inc_and_test(${atomic}_t *v)
 {
-	return ${atomic}_inc_return(v) == 0;
+	return ${arch}${atomic}_inc_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index a7c45c8d107c..50f2d4d48279 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,14 +1,14 @@
 cat <<EOF
 /**
- * ${atomic}_inc_not_zero - increment unless the number is zero
+ * ${arch}${atomic}_inc_not_zero - increment unless the number is zero
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
-${atomic}_inc_not_zero(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_inc_not_zero(${atomic}_t *v)
 {
-	return ${atomic}_add_unless(v, 1, 0);
+	return ${arch}${atomic}_add_unless(v, 1, 0);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 0c266e71dbd4..87629e0d4a80 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,13 +1,13 @@
 cat <<EOF
-static inline bool
-${atomic}_inc_unless_negative(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 75863b5203f7..341a88dccaa7 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,6 +1,6 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_read_acquire(const ${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
 }
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index 3f628a3802d9..f8906d537c0f 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,8 +1,8 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}${name}${sfx}_release(${params})
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
-	${retstmt}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${retstmt}${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 45bb5e0cfc08..76068272d5f5 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,6 +1,6 @@
 cat <<EOF
-static inline void
-${atomic}_set_release(${atomic}_t *v, ${int} i)
+static __always_inline void
+${arch}${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	smp_store_release(&(v)->counter, i);
 }
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 289ef17a2d7a..c580f4c2136e 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_sub_and_test - subtract value from variable and test result
+ * ${arch}${atomic}_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
  * @v: pointer of type ${atomic}_t
  *
@@ -8,9 +8,9 @@ cat <<EOF
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
-${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-	return ${atomic}_sub_return(i, v) == 0;
+	return ${arch}${atomic}_sub_return(i, v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 4ed85e2f5378..06db0f738e45 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,9 +1,9 @@
 cat <<EOF
-static inline bool
-${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+static __always_inline bool
+${arch}${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o = *old;
-	r = ${atomic}_cmpxchg${order}(v, o, new);
+	r = ${arch}${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 1bd7c1707633..0fd1cf0c2b94 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ATOMICDIR=$(dirname $0)
+ARCH=$2
 
 . ${ATOMICDIR}/atomic-tbl.sh
 
-#gen_template_fallback(template, meta, pfx, name, sfx, order, atomic, int, args...)
+#gen_template_fallback(template, meta, pfx, name, sfx, order, arch, atomic, int, args...)
 gen_template_fallback()
 {
 	local template="$1"; shift
@@ -14,10 +15,11 @@ gen_template_fallback()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
+	local arch="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+	local atomicname="${arch}${atomic}_${pfx}${name}${sfx}${order}"
 
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
@@ -32,7 +34,7 @@ gen_template_fallback()
 	fi
 }
 
-#gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
+#gen_proto_fallback(meta, pfx, name, sfx, order, arch, atomic, int, args...)
 gen_proto_fallback()
 {
 	local meta="$1"; shift
@@ -56,16 +58,17 @@ cat << EOF
 EOF
 }
 
-#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
+#gen_proto_order_variants(meta, pfx, name, sfx, arch, atomic, int, args...)
 gen_proto_order_variants()
 {
 	local meta="$1"; shift
 	local pfx="$1"; shift
 	local name="$1"; shift
 	local sfx="$1"; shift
-	local atomic="$1"
+	local arch="$1"
+	local atomic="$2"
 
-	local basename="${atomic}_${pfx}${name}${sfx}"
+	local basename="${arch}${atomic}_${pfx}${name}${sfx}"
 
 	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
@@ -94,7 +97,7 @@ gen_proto_order_variants()
 	gen_basic_fallbacks "${basename}"
 
 	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${atomic}_${pfx}${name}${sfx} */\n\n"
+		printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
@@ -149,20 +152,19 @@ cat << EOF
 #ifndef _LINUX_ATOMIC_FALLBACK_H
 #define _LINUX_ATOMIC_FALLBACK_H
 
+#include <linux/compiler.h>
+
 EOF
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
 done
 
 cat <<EOF
-#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -170,12 +172,9 @@ cat <<EOF
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+	gen_proto "${meta}" "${name}" "${ARCH}" "atomic64" "s64" ${args}
 done
 
 cat <<EOF
-#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
 EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 000dc6437893..d29e159ef489 100644
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -10,10 +10,11 @@ LINUXDIR=${ATOMICDIR}/../..
 cat <<EOF |
 gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
 gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
 gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
-while read script header; do
-	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
+while read script header args; do
+	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
 	HASH="$(sha1sum ${LINUXDIR}/include/${header})"
 	HASH="${HASH%% *}"
 	printf "// %s\n" "${HASH}" >> ${LINUXDIR}/include/${header}

