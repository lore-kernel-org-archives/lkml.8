Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFAC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0E82075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229773;
	bh=paOU8gdxMg8OX29sgJwKYcVZBCyg2lU6FRvikHyfNxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VR+2k3FaB1wMG8uk4m7HjDnPv4czPptnvWZ1510vuEQQQ3qERYTsW8yJXD30gYjDe
	 Z4Wm53ac+DL4pfhrb5VVV8yp6axkhB4eebz1rQN1c9ZQpkX6qFaADAULBhIu9CDo6n
	 E16tKb0dmovwY/Iz5IM67CkqHKgF+AqcoSB+VC6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgEKUmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbgEKUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:50 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE1820882;
        Mon, 11 May 2020 20:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229769;
        bh=paOU8gdxMg8OX29sgJwKYcVZBCyg2lU6FRvikHyfNxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJH5vqoFk464vFQ/a17wrmKwPALe1HBmLXnDrzaiXJZPSNRUKGs2HaTCnhQ/zaafu
         CuAorZwXCZCvY2Eg1SmS68/TzwRYKd5Ymf6/LjVREBXEDFonb6vx9EpGvoPuZ+q6GN
         90z0Zt3gsB5CdekNAvxtJO6Z4VdkFikrmxr2hyHs=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 10/18] READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
Date:   Mon, 11 May 2020 21:41:42 +0100
Message-Id: <20200511204150.27858-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementations of {READ,WRITE}_ONCE() suffer from a significant
amount of indirection and complexity due to a historic GCC bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

which was originally worked around by 230fa253df63 ("kernel: Provide
READ_ONCE and ASSIGN_ONCE").

Since GCC 4.8 is fairly vintage at this point and we emit a warning if
we detect it during the build, return {READ,WRITE}_ONCE() to their former
glory with an implementation that is easier to understand and, crucially,
more amenable to optimisation. A side effect of this simplification is
that WRITE_ONCE() no longer returns a value, but nobody seems to be
relying on that and the new behaviour is aligned with smp_store_release().

Acked-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h | 141 +++++++++++++++------------------------
 1 file changed, 55 insertions(+), 86 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cce2c92567b5..fe739850e7c9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -177,28 +177,57 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
 #endif
 
-#include <uapi/linux/types.h>
+/*
+ * Prevent the compiler from merging or refetching reads or writes. The
+ * compiler is also forbidden from reordering successive instances of
+ * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
+ * particular ordering. One way to make the compiler aware of ordering is to
+ * put the two invocations of READ_ONCE or WRITE_ONCE in different C
+ * statements.
+ *
+ * These two macros will also work on aggregate data types like structs or
+ * unions.
+ *
+ * Their two major use cases are: (1) Mediating communication between
+ * process-level code and irq/NMI handlers, all running on the same CPU,
+ * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
+ * mutilate accesses that either do not require ordering or that interact
+ * with an explicit memory barrier or atomic instruction that provides the
+ * required ordering.
+ */
+#include <asm/barrier.h>
+#include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 
-#define __READ_ONCE_SIZE						\
+#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
+
+#define READ_ONCE(x)							\
 ({									\
-	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
-	default:							\
-		barrier();						\
-		__builtin_memcpy((void *)res, (const void *)p, size);	\
-		barrier();						\
-	}								\
+	typeof(x) *__xp = &(x);						\
+	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
+	__kcsan_disable_current();					\
+	({								\
+		typeof(x) __x = __READ_ONCE(*__xp);			\
+		__kcsan_enable_current();				\
+		smp_read_barrier_depends();				\
+		__x;							\
+	});								\
 })
 
+#define WRITE_ONCE(x, val)						\
+do {									\
+	typeof(x) *__xp = &(x);						\
+	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
+	__kcsan_disable_current();					\
+	*(volatile typeof(x) *)__xp = (val);				\
+	__kcsan_enable_current();					\
+} while (0)
+
 #ifdef CONFIG_KASAN
 /*
- * We can't declare function 'inline' because __no_sanitize_address confilcts
+ * We can't declare function 'inline' because __no_sanitize_address conflicts
  * with inlining. Attempt to inline it may cause a build failure.
- * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
  * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
  */
 # define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
@@ -225,78 +254,26 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __no_sanitize_or_inline __always_inline
 #endif
 
-static __no_kcsan_or_inline
-void __read_once_size(const volatile void *p, void *res, int size)
-{
-	kcsan_check_atomic_read(p, size);
-	__READ_ONCE_SIZE;
-}
-
 static __no_sanitize_or_inline
-void __read_once_size_nocheck(const volatile void *p, void *res, int size)
+unsigned long __read_once_word_nocheck(const void *addr)
 {
-	__READ_ONCE_SIZE;
-}
-
-static __no_kcsan_or_inline
-void __write_once_size(volatile void *p, void *res, int size)
-{
-	kcsan_check_atomic_write(p, size);
-
-	switch (size) {
-	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
-	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
-	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
-	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
-	default:
-		barrier();
-		__builtin_memcpy((void *)p, (const void *)res, size);
-		barrier();
-	}
+	return __READ_ONCE(*(unsigned long *)addr);
 }
 
 /*
- * Prevent the compiler from merging or refetching reads or writes. The
- * compiler is also forbidden from reordering successive instances of
- * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
- * particular ordering. One way to make the compiler aware of ordering is to
- * put the two invocations of READ_ONCE or WRITE_ONCE in different C
- * statements.
- *
- * These two macros will also work on aggregate data types like structs or
- * unions. If the size of the accessed data type exceeds the word size of
- * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
- * fall back to memcpy(). There's at least two memcpy()s: one for the
- * __builtin_memcpy() and then one for the macro doing the copy of variable
- * - '__u' allocated on the stack.
- *
- * Their two major use cases are: (1) Mediating communication between
- * process-level code and irq/NMI handlers, all running on the same CPU,
- * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
- * mutilate accesses that either do not require ordering or that interact
- * with an explicit memory barrier or atomic instruction that provides the
- * required ordering.
+ * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
+ * word from memory atomically but without telling KASAN/KCSAN. This is
+ * usually used by unwinding code when walking the stack of a running process.
  */
-#include <asm/barrier.h>
-#include <linux/kasan-checks.h>
-
-#define __READ_ONCE(x, check)						\
+#define READ_ONCE_NOCHECK(x)						\
 ({									\
-	union { typeof(x) __val; char __c[1]; } __u;			\
-	if (check)							\
-		__read_once_size(&(x), __u.__c, sizeof(x));		\
-	else								\
-		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
-	__u.__val;							\
+	unsigned long __x;						\
+	compiletime_assert(sizeof(x) == sizeof(__x),			\
+		"Unsupported access size for READ_ONCE_NOCHECK().");	\
+	__x = __read_once_word_nocheck(&(x));				\
+	smp_read_barrier_depends();					\
+	__x;								\
 })
-#define READ_ONCE(x) __READ_ONCE(x, 1)
-
-/*
- * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
- * to hide memory access from KASAN.
- */
-#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
 
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
@@ -305,14 +282,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#define WRITE_ONCE(x, val) \
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__val = (__force typeof(x)) (val) }; \
-	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
-
 /**
  * data_race - mark an expression as containing intentional data races
  *
-- 
2.26.2.645.ge9eca65c58-goog

