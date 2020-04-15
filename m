Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C227206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586978290;
	bh=7nxr8v/IXu5xyZFvpoMi7aAlhE4Gd0YV5C/fKVUFZAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Df1CACVzK06+9xcyCo/inE/NVMU4q+w0AR+sUOZETRWRLDEpy97EbmPUFOwzHnpek
	 eq5nlDisnlv7yLS5uvsFAEx9APmlU7EF6bvrT8MsNkhjHkLv2ZCjYb2FsGTZkOaNGL
	 KrIpFsibHaAKtkjWLH0a3DfjII3absF9tEBavDBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbgDOTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416811AbgDOSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D7F2166E;
        Wed, 15 Apr 2020 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975653;
        bh=7nxr8v/IXu5xyZFvpoMi7aAlhE4Gd0YV5C/fKVUFZAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdjBUZSODrGYtqR3YnPj8Oze09lRB2yTI/AG6zLHSJM43igXck2sLVFG3T+rMLU0s
         ctykKF709Zz4QgKnioKgQX9u40+CI7JBchNgMXBf37vCM5QNyp7luObMO99zM4h0qQ
         jPZ1mP1djo1sr+CfaFIBDz2ggEj2aoAuvJEUYJvU=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 03/15] kcsan: Add current->state to implicitly atomic accesses
Date:   Wed, 15 Apr 2020 11:33:59 -0700
Message-Id: <20200415183411.12368-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
-- 
2.9.5

