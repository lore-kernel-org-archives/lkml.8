Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA85C54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE06B20746
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgELOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgELOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5ACC061A0F;
        Tue, 12 May 2020 07:37:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1h-0005oM-3r; Tue, 12 May 2020 16:36:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B745B1C0475;
        Tue, 12 May 2020 16:36:56 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:56 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] READ_ONCE: Simplify implementations of
 {READ,WRITE}_ONCE()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-11-will@kernel.org>
References: <20200511204150.27858-11-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421666.390.17077631786357018148.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     bbfa112b46bdbbdfc2f5bfb9c2dcbef780ff6417
Gitweb:        https://git.kernel.org/tip/bbfa112b46bdbbdfc2f5bfb9c2dcbef780ff6417
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:13 +02:00

READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()

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

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Link: https://lkml.kernel.org/r/20200511204150.27858-11-will@kernel.org

---
 include/linux/compiler.h | 141 ++++++++++++++------------------------
 1 file changed, 55 insertions(+), 86 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 9bd0f76..1b4e64d 100644
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
