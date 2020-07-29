Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B42207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8U10ECs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hH6hkYLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgG2OeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgG2Odr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:47 -0400
Date:   Wed, 29 Jul 2020 14:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFa3SAkjEyREdFLzBvw0ZcWPo19YOHDYLVKcml1K1X0=;
        b=j8U10ECsR9SzKbHL+d0QhHTGotUhv75VIUZUTlE9CkFxsdINoSZ5tmI7ERmv30+PFrOrFy
        vm0t19FPvIQo6wmX2UXAVgS1I72nJ1DWrNpYaFcEtuxVzvHNvZcZRbs49OPeOwiPOrtcNK
        YtV99F2eufmvfyhjZ2q6+ItNxFSdOmu91RZEytXlE9Rf8Zt/NHAOqAgcC1IDCjc914DxOi
        vfkRAGeWGyKTHBpVSn/jvz4N2w/GaFtsI1CN45VCSn5tcs3JnB1Uf6XdUb6VyxAmm+ffnA
        FtNExymFCoeXKngJQNMXhQEZpBGid/DLUoGj39YiusRd19oVobva6lPIT+ILaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFa3SAkjEyREdFLzBvw0ZcWPo19YOHDYLVKcml1K1X0=;
        b=hH6hkYLhrKFEGQDg6IQsYxalWXiLpFwdvlmc2ShwO2Z/e6m/MmYDpgasWh+kAZ1r9/ZrL5
        pJ9tlFoxNRJiejAA==
From:   "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: Move ATOMIC_INIT into linux/types.h
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729123105.GB7047@gondor.apana.org.au>
References: <20200729123105.GB7047@gondor.apana.org.au>
MIME-Version: 1.0
Message-ID: <159603322408.4006.5173732956730943381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7ca8cf5347f720b07a0b32a924b768f5710547e7
Gitweb:        https://git.kernel.org/tip/7ca8cf5347f720b07a0b32a924b768f5710547e7
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Wed, 29 Jul 2020 22:31:05 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:18 +02:00

locking/atomic: Move ATOMIC_INIT into linux/types.h

This patch moves ATOMIC_INIT from asm/atomic.h into linux/types.h.
This allows users of atomic_t to use ATOMIC_INIT without having to
include atomic.h as that way may lead to header loops.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20200729123105.GB7047@gondor.apana.org.au
---
 arch/alpha/include/asm/atomic.h    | 1 -
 arch/arc/include/asm/atomic.h      | 2 --
 arch/arm/include/asm/atomic.h      | 2 --
 arch/arm64/include/asm/atomic.h    | 2 --
 arch/h8300/include/asm/atomic.h    | 2 --
 arch/hexagon/include/asm/atomic.h  | 2 --
 arch/ia64/include/asm/atomic.h     | 1 -
 arch/m68k/include/asm/atomic.h     | 2 --
 arch/mips/include/asm/atomic.h     | 1 -
 arch/parisc/include/asm/atomic.h   | 2 --
 arch/powerpc/include/asm/atomic.h  | 2 --
 arch/riscv/include/asm/atomic.h    | 2 --
 arch/s390/include/asm/atomic.h     | 2 --
 arch/sh/include/asm/atomic.h       | 2 --
 arch/sparc/include/asm/atomic_32.h | 2 --
 arch/sparc/include/asm/atomic_64.h | 1 -
 arch/x86/include/asm/atomic.h      | 2 --
 arch/xtensa/include/asm/atomic.h   | 2 --
 include/asm-generic/atomic.h       | 2 --
 include/linux/types.h              | 2 ++
 20 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 2144530..e209399 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -24,7 +24,6 @@
 #define __atomic_acquire_fence()
 #define __atomic_post_full_fence()
 
-#define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
 
 #define atomic_read(v)		READ_ONCE((v)->counter)
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 7298ce8..c614857 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -14,8 +14,6 @@
 #include <asm/barrier.h>
 #include <asm/smp.h>
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #ifndef CONFIG_ARC_PLAT_EZNPS
 
 #define atomic_read(v)  READ_ONCE((v)->counter)
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 75bb2c5..455eb19 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -15,8 +15,6 @@
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index a08890d..015ddff 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -99,8 +99,6 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 	return __lse_ll_sc_body(atomic64_dec_if_positive, v);
 }
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define arch_atomic_read(v)			__READ_ONCE((v)->counter)
 #define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
 
diff --git a/arch/h8300/include/asm/atomic.h b/arch/h8300/include/asm/atomic.h
index c6b6a06..a990d15 100644
--- a/arch/h8300/include/asm/atomic.h
+++ b/arch/h8300/include/asm/atomic.h
@@ -12,8 +12,6 @@
  * resource counting etc..
  */
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		READ_ONCE((v)->counter)
 #define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
 
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 0231d69..4ab895d 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -12,8 +12,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define ATOMIC_INIT(i)		{ (i) }
-
 /*  Normal writes in our arch don't clear lock reservations  */
 
 static inline void atomic_set(atomic_t *v, int new)
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 50440f3..f267d95 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -19,7 +19,6 @@
 #include <asm/barrier.h>
 
 
-#define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
 
 #define atomic_read(v)		READ_ONCE((v)->counter)
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 47228b0..756c5cc 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -16,8 +16,6 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		READ_ONCE((v)->counter)
 #define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
 
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index e5ac883..f904084 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -45,7 +45,6 @@ static __always_inline type pfx##_xchg(pfx##_t *v, type n)		\
 	return xchg(&v->counter, n);					\
 }
 
-#define ATOMIC_INIT(i)		{ (i) }
 ATOMIC_OPS(atomic, int)
 
 #ifdef CONFIG_64BIT
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 118953d..f960e2f 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -136,8 +136,6 @@ ATOMIC_OPS(xor, ^=)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #ifdef CONFIG_64BIT
 
 #define ATOMIC64_INIT(i) { (i) }
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 498785f..0311c3c 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,8 +11,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define ATOMIC_INIT(i)		{ (i) }
-
 /*
  * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
  * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 96f95c9..400a8c8 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -19,8 +19,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define __atomic_acquire_fence()					\
 	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
 
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 491ad53..cae473a 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -15,8 +15,6 @@
 #include <asm/barrier.h>
 #include <asm/cmpxchg.h>
 
-#define ATOMIC_INIT(i)  { (i) }
-
 static inline int atomic_read(const atomic_t *v)
 {
 	int c;
diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index f37b95a..7c2a8a7 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -19,8 +19,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		READ_ONCE((v)->counter)
 #define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
 
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 94c930f..efad553 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -18,8 +18,6 @@
 #include <asm/barrier.h>
 #include <asm-generic/atomic64.h>
 
-#define ATOMIC_INIT(i)  { (i) }
-
 int atomic_add_return(int, atomic_t *);
 int atomic_fetch_add(int, atomic_t *);
 int atomic_fetch_and(int, atomic_t *);
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index b604483..6b235d3 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -12,7 +12,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
 
 #define atomic_read(v)		READ_ONCE((v)->counter)
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index bf35e47..b6cac6e 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -14,8 +14,6 @@
  * resource counting etc..
  */
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 /**
  * arch_atomic_read - read atomic variable
  * @v: pointer of type atomic_t
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 3e7c613..744c2f4 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -19,8 +19,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 /*
  * This Xtensa implementation assumes that the right mechanism
  * for exclusion is for locking interrupts to level EXCM_LEVEL.
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 286867f..11f96f4 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -159,8 +159,6 @@ ATOMIC_OP(xor, ^)
  * resource counting etc..
  */
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 /**
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
diff --git a/include/linux/types.h b/include/linux/types.h
index d3021c8..a147977 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -167,6 +167,8 @@ typedef struct {
 	int counter;
 } atomic_t;
 
+#define ATOMIC_INIT(i) { (i) }
+
 #ifdef CONFIG_64BIT
 typedef struct {
 	s64 counter;
