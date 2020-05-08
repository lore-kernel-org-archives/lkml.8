Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CABC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20E42070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgEHNrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728330AbgEHNqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313C6C05BD09;
        Fri,  8 May 2020 06:46:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kp-0001oZ-Vb; Fri, 08 May 2020 15:46:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 704041C04D0;
        Fri,  8 May 2020 15:46:37 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:37 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Add current->state to implicitly atomic accesses
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559740.8414.419145349216715541.tip-bot2@tip-bot2>
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

Commit-ID:     44656d3dc4f0dc20010d054f27397a4a1469fabf
Gitweb:        https://git.kernel.org/tip/44656d3dc4f0dc20010d054f27397a4a1469fabf
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 25 Feb 2020 15:32:58 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 25 Mar 2020 09:56:00 -07:00

kcsan: Add current->state to implicitly atomic accesses

Add volatile current->state to list of implicitly atomic accesses. This
is in preparation to eventually enable KCSAN on kernel/sched (which
currently still has KCSAN_SANITIZE := n).

Since accesses that match the special check in atomic.h are rare, it
makes more sense to move this check to the slow-path, avoiding the
additional compare in the fast-path. With the microbenchmark, a speedup
of ~6% is measured.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/atomic.h  | 21 +++++++--------------
 kernel/kcsan/core.c    | 22 +++++++++++++++-------
 kernel/kcsan/debugfs.c | 27 ++++++++++++++++++---------
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index a9c1930..be9e625 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -4,24 +4,17 @@
 #define _KERNEL_KCSAN_ATOMIC_H
 
 #include <linux/jiffies.h>
+#include <linux/sched.h>
 
 /*
- * Helper that returns true if access to @ptr should be considered an atomic
- * access, even though it is not explicitly atomic.
- *
- * List all volatile globals that have been observed in races, to suppress
- * data race reports between accesses to these variables.
- *
- * For now, we assume that volatile accesses of globals are as strong as atomic
- * accesses (READ_ONCE, WRITE_ONCE cast to volatile). The situation is still not
- * entirely clear, as on some architectures (Alpha) READ_ONCE/WRITE_ONCE do more
- * than cast to volatile. Eventually, we hope to be able to remove this
- * function.
+ * Special rules for certain memory where concurrent conflicting accesses are
+ * common, however, the current convention is to not mark them; returns true if
+ * access to @ptr should be considered atomic. Called from slow-path.
  */
-static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
+static bool kcsan_is_atomic_special(const volatile void *ptr)
 {
-	/* only jiffies for now */
-	return ptr == &jiffies;
+	/* volatile globals that have been observed in data races. */
+	return ptr == &jiffies || ptr == &current->state;
 }
 
 #endif /* _KERNEL_KCSAN_ATOMIC_H */
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 065615d..eb30ecd 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -188,12 +188,13 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
+/* Rules for generic atomic accesses. Called from fast-path. */
 static __always_inline bool
 is_atomic(const volatile void *ptr, size_t size, int type)
 {
 	struct kcsan_ctx *ctx;
 
-	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
+	if (type & KCSAN_ACCESS_ATOMIC)
 		return true;
 
 	/*
@@ -201,16 +202,16 @@ is_atomic(const volatile void *ptr, size_t size, int type)
 	 * as atomic. This allows using them also in atomic regions, such as
 	 * seqlocks, without implicitly changing their semantics.
 	 */
-	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+	if (type & KCSAN_ACCESS_ASSERT)
 		return false;
 
 	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
-	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long) &&
+	    (type & KCSAN_ACCESS_WRITE) && size <= sizeof(long) &&
 	    IS_ALIGNED((unsigned long)ptr, size))
 		return true; /* Assume aligned writes up to word size are atomic. */
 
 	ctx = get_ctx();
-	if (unlikely(ctx->atomic_next > 0)) {
+	if (ctx->atomic_next > 0) {
 		/*
 		 * Because we do not have separate contexts for nested
 		 * interrupts, in case atomic_next is set, we simply assume that
@@ -224,10 +225,8 @@ is_atomic(const volatile void *ptr, size_t size, int type)
 			--ctx->atomic_next; /* in task, or outer interrupt */
 		return true;
 	}
-	if (unlikely(ctx->atomic_nest_count > 0 || ctx->in_flat_atomic))
-		return true;
 
-	return kcsan_is_atomic(ptr);
+	return ctx->atomic_nest_count > 0 || ctx->in_flat_atomic;
 }
 
 static __always_inline bool
@@ -367,6 +366,15 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	if (!kcsan_is_enabled())
 		goto out;
 
+	/*
+	 * Special atomic rules: unlikely to be true, so we check them here in
+	 * the slow-path, and not in the fast-path in is_atomic(). Call after
+	 * kcsan_is_enabled(), as we may access memory that is not yet
+	 * initialized during early boot.
+	 */
+	if (!is_assert && kcsan_is_atomic_special(ptr))
+		goto out;
+
 	if (!check_encodable((unsigned long)ptr, size)) {
 		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
 		goto out;
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 2ff1961..72ee188 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -74,25 +74,34 @@ void kcsan_counter_dec(enum kcsan_counter_id id)
  */
 static noinline void microbenchmark(unsigned long iters)
 {
+	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
+	const bool was_enabled = READ_ONCE(kcsan_enabled);
 	cycles_t cycles;
 
+	/* We may have been called from an atomic region; reset context. */
+	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
+	/*
+	 * Disable to benchmark fast-path for all accesses, and (expected
+	 * negligible) call into slow-path, but never set up watchpoints.
+	 */
+	WRITE_ONCE(kcsan_enabled, false);
+
 	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
 
 	cycles = get_cycles();
 	while (iters--) {
-		/*
-		 * We can run this benchmark from multiple tasks; this address
-		 * calculation increases likelyhood of some accesses
-		 * overlapping. Make the access type an atomic read, to never
-		 * set up watchpoints and test the fast-path only.
-		 */
-		unsigned long addr =
-			iters % (CONFIG_KCSAN_NUM_WATCHPOINTS * PAGE_SIZE);
-		__kcsan_check_access((void *)addr, sizeof(long), KCSAN_ACCESS_ATOMIC);
+		unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
+		int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
+				(!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
+		__kcsan_check_access((void *)addr, sizeof(long), type);
 	}
 	cycles = get_cycles() - cycles;
 
 	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+
+	WRITE_ONCE(kcsan_enabled, was_enabled);
+	/* restore context */
+	current->kcsan_ctx = ctx_save;
 }
 
 /*
