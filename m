Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ABFC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDD72078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977747;
	bh=0t6zkQDByFuiRwpfdwonVUFFP0zPP771ofaXNQBqtlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1oFqzRz27J9vutyWyXHPLOQwR0k+pgj9uJuvYi20+y6jNGg0ghid9YYteKaV7WVmy
	 U2Po34sm8+wOvQyMQ9AOOO6QJkL65bqSyiDEzSGayDzgkX3YvhXFCWUMQh+bjoLQGj
	 yOcnsNjpC9Xu3H3ZzHcCxDJe9mA8S6vajWAUl6Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441042AbgDOTIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416819AbgDOSeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F453217BA;
        Wed, 15 Apr 2020 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975655;
        bh=0t6zkQDByFuiRwpfdwonVUFFP0zPP771ofaXNQBqtlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL/sNkRfv/bTTpwlXtaQjtPAV74kFO2IcPoFZKYn49mAz52vKHIKxMTvQHopdKhQ/
         QHosZnICV963EO04lwdESj8NOlcvvGUEGekWxyGrbxmA3ESm0xv6qM/cREJ72qhWeW
         Q3DEsbf8Nh97dlG7Wq3apyJ52FIQ6mlzjeagmGEM=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 09/15] kcsan: Add support for scoped accesses
Date:   Wed, 15 Apr 2020 11:34:05 -0700
Message-Id: <20200415183411.12368-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

This adds support for scoped accesses, where the memory range is checked
for the duration of the scope. The feature is implemented by inserting
the relevant access information into a list of scoped accesses for
the current execution context, which are then checked (until removed)
on every call (through instrumentation) into the KCSAN runtime.

An alternative, more complex, implementation could set up a watchpoint for
the scoped access, and keep the watchpoint set up. This, however, would
require first exposing a handle to the watchpoint, as well as dealing
with cases such as accesses by the same thread while the watchpoint is
still set up (and several more cases). It is also doubtful if this would
provide any benefit, since the majority of delay where the watchpoint
is set up is likely due to the injected delays by KCSAN.  Therefore,
the implementation in this patch is simpler and avoids hurting KCSAN's
main use-case (normal data race detection); it also implicitly increases
scoped-access race-detection-ability due to increased probability of
setting up watchpoints by repeatedly calling __kcsan_check_access()
throughout the scope of the access.

The implementation required adding an additional conditional branch to
the fast-path. However, the microbenchmark showed a *speedup* of ~5%
on the fast-path. This appears to be due to subtly improved codegen by
GCC from moving get_ctx() and associated load of preempt_count earlier.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 57 ++++++++++++++++++++++++++++++
 include/linux/kcsan.h        |  3 ++
 init/init_task.c             |  1 +
 kernel/kcsan/core.c          | 83 +++++++++++++++++++++++++++++++++++++++-----
 kernel/kcsan/report.c        | 33 ++++++++++++------
 5 files changed, 158 insertions(+), 19 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 3cd8bb0..b24253d 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_KCSAN_CHECKS_H
 #define _LINUX_KCSAN_CHECKS_H
 
+/* Note: Only include what is already included by compiler.h. */
+#include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
 /*
@@ -12,10 +14,12 @@
  *   WRITE : write access;
  *   ATOMIC: access is atomic;
  *   ASSERT: access is not a regular access, but an assertion;
+ *   SCOPED: access is a scoped access;
  */
 #define KCSAN_ACCESS_WRITE  0x1
 #define KCSAN_ACCESS_ATOMIC 0x2
 #define KCSAN_ACCESS_ASSERT 0x4
+#define KCSAN_ACCESS_SCOPED 0x8
 
 /*
  * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
@@ -78,6 +82,52 @@ void kcsan_atomic_next(int n);
  */
 void kcsan_set_access_mask(unsigned long mask);
 
+/* Scoped access information. */
+struct kcsan_scoped_access {
+	struct list_head list;
+	const volatile void *ptr;
+	size_t size;
+	int type;
+};
+/*
+ * Automatically call kcsan_end_scoped_access() when kcsan_scoped_access goes
+ * out of scope; relies on attribute "cleanup", which is supported by all
+ * compilers that support KCSAN.
+ */
+#define __kcsan_cleanup_scoped                                                 \
+	__maybe_unused __attribute__((__cleanup__(kcsan_end_scoped_access)))
+
+/**
+ * kcsan_begin_scoped_access - begin scoped access
+ *
+ * Begin scoped access and initialize @sa, which will cause KCSAN to
+ * continuously check the memory range in the current thread until
+ * kcsan_end_scoped_access() is called for @sa.
+ *
+ * Scoped accesses are implemented by appending @sa to an internal list for the
+ * current execution context, and then checked on every call into the KCSAN
+ * runtime.
+ *
+ * @ptr: address of access
+ * @size: size of access
+ * @type: access type modifier
+ * @sa: struct kcsan_scoped_access to use for the scope of the access
+ */
+struct kcsan_scoped_access *
+kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
+			  struct kcsan_scoped_access *sa);
+
+/**
+ * kcsan_end_scoped_access - end scoped access
+ *
+ * End a scoped access, which will stop KCSAN checking the memory range.
+ * Requires that kcsan_begin_scoped_access() was previously called once for @sa.
+ *
+ * @sa: a previously initialized struct kcsan_scoped_access
+ */
+void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
+
+
 #else /* CONFIG_KCSAN */
 
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
@@ -90,6 +140,13 @@ static inline void kcsan_flat_atomic_end(void)		{ }
 static inline void kcsan_atomic_next(int n)		{ }
 static inline void kcsan_set_access_mask(unsigned long mask) { }
 
+struct kcsan_scoped_access { };
+#define __kcsan_cleanup_scoped __maybe_unused
+static inline struct kcsan_scoped_access *
+kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
+			  struct kcsan_scoped_access *sa) { return sa; }
+static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
+
 #endif /* CONFIG_KCSAN */
 
 /*
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 3b84606..17ae59e 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -40,6 +40,9 @@ struct kcsan_ctx {
 	 * Access mask for all accesses if non-zero.
 	 */
 	unsigned long access_mask;
+
+	/* List of scoped accesses. */
+	struct list_head scoped_accesses;
 };
 
 /**
diff --git a/init/init_task.c b/init/init_task.c
index 096191d..1989438 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -168,6 +168,7 @@ struct task_struct init_task
 		.atomic_nest_count	= 0,
 		.in_flat_atomic		= false,
 		.access_mask		= 0,
+		.scoped_accesses	= {LIST_POISON1, NULL},
 	},
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4d8ea0f..a572aae 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
@@ -42,6 +43,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 	.atomic_nest_count	= 0,
 	.in_flat_atomic		= false,
 	.access_mask		= 0,
+	.scoped_accesses	= {LIST_POISON1, NULL},
 };
 
 /*
@@ -191,12 +193,23 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
+/* Check scoped accesses; never inline because this is a slow-path! */
+static noinline void kcsan_check_scoped_accesses(void)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+	struct list_head *prev_save = ctx->scoped_accesses.prev;
+	struct kcsan_scoped_access *scoped_access;
+
+	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
+	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list)
+		__kcsan_check_access(scoped_access->ptr, scoped_access->size, scoped_access->type);
+	ctx->scoped_accesses.prev = prev_save;
+}
+
 /* Rules for generic atomic accesses. Called from fast-path. */
 static __always_inline bool
-is_atomic(const volatile void *ptr, size_t size, int type)
+is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
 {
-	struct kcsan_ctx *ctx;
-
 	if (type & KCSAN_ACCESS_ATOMIC)
 		return true;
 
@@ -213,7 +226,6 @@ is_atomic(const volatile void *ptr, size_t size, int type)
 	    IS_ALIGNED((unsigned long)ptr, size))
 		return true; /* Assume aligned writes up to word size are atomic. */
 
-	ctx = get_ctx();
 	if (ctx->atomic_next > 0) {
 		/*
 		 * Because we do not have separate contexts for nested
@@ -233,7 +245,7 @@ is_atomic(const volatile void *ptr, size_t size, int type)
 }
 
 static __always_inline bool
-should_watch(const volatile void *ptr, size_t size, int type)
+should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -242,7 +254,7 @@ should_watch(const volatile void *ptr, size_t size, int type)
 	 * should not count towards skipped instructions, and (2) to actually
 	 * decrement kcsan_atomic_next for consecutive instruction stream.
 	 */
-	if (is_atomic(ptr, size, type))
+	if (is_atomic(ptr, size, type, ctx))
 		return false;
 
 	if (this_cpu_dec_return(kcsan_skip) >= 0)
@@ -563,8 +575,14 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	if (unlikely(watchpoint != NULL))
 		kcsan_found_watchpoint(ptr, size, type, watchpoint,
 				       encoded_watchpoint);
-	else if (unlikely(should_watch(ptr, size, type)))
-		kcsan_setup_watchpoint(ptr, size, type);
+	else {
+		struct kcsan_ctx *ctx = get_ctx(); /* Call only once in fast-path. */
+
+		if (unlikely(should_watch(ptr, size, type, ctx)))
+			kcsan_setup_watchpoint(ptr, size, type);
+		else if (unlikely(ctx->scoped_accesses.prev))
+			kcsan_check_scoped_accesses();
+	}
 }
 
 /* === Public interface ===================================================== */
@@ -660,6 +678,55 @@ void kcsan_set_access_mask(unsigned long mask)
 }
 EXPORT_SYMBOL(kcsan_set_access_mask);
 
+struct kcsan_scoped_access *
+kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
+			  struct kcsan_scoped_access *sa)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+
+	__kcsan_check_access(ptr, size, type);
+
+	ctx->disable_count++; /* Disable KCSAN, in case list debugging is on. */
+
+	INIT_LIST_HEAD(&sa->list);
+	sa->ptr = ptr;
+	sa->size = size;
+	sa->type = type;
+
+	if (!ctx->scoped_accesses.prev) /* Lazy initialize list head. */
+		INIT_LIST_HEAD(&ctx->scoped_accesses);
+	list_add(&sa->list, &ctx->scoped_accesses);
+
+	ctx->disable_count--;
+	return sa;
+}
+EXPORT_SYMBOL(kcsan_begin_scoped_access);
+
+void kcsan_end_scoped_access(struct kcsan_scoped_access *sa)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+
+	if (WARN(!ctx->scoped_accesses.prev, "Unbalanced %s()?", __func__))
+		return;
+
+	ctx->disable_count++; /* Disable KCSAN, in case list debugging is on. */
+
+	list_del(&sa->list);
+	if (list_empty(&ctx->scoped_accesses))
+		/*
+		 * Ensure we do not enter kcsan_check_scoped_accesses()
+		 * slow-path if unnecessary, and avoids requiring list_empty()
+		 * in the fast-path (to avoid a READ_ONCE() and potential
+		 * uaccess warning).
+		 */
+		ctx->scoped_accesses.prev = NULL;
+
+	ctx->disable_count--;
+
+	__kcsan_check_access(sa->ptr, sa->size, sa->type);
+}
+EXPORT_SYMBOL(kcsan_end_scoped_access);
+
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
 {
 	check_access(ptr, size, type);
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ae0a383..ddc18f1 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -205,6 +205,20 @@ skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
 
 static const char *get_access_type(int type)
 {
+	if (type & KCSAN_ACCESS_ASSERT) {
+		if (type & KCSAN_ACCESS_SCOPED) {
+			if (type & KCSAN_ACCESS_WRITE)
+				return "assert no accesses (scoped)";
+			else
+				return "assert no writes (scoped)";
+		} else {
+			if (type & KCSAN_ACCESS_WRITE)
+				return "assert no accesses";
+			else
+				return "assert no writes";
+		}
+	}
+
 	switch (type) {
 	case 0:
 		return "read";
@@ -214,17 +228,14 @@ static const char *get_access_type(int type)
 		return "write";
 	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked)";
-
-	/*
-	 * ASSERT variants:
-	 */
-	case KCSAN_ACCESS_ASSERT:
-	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_ATOMIC:
-		return "assert no writes";
-	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE:
-	case KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
-		return "assert no accesses";
-
+	case KCSAN_ACCESS_SCOPED:
+		return "read (scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_ATOMIC:
+		return "read (marked, scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE:
+		return "write (scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "write (marked, scoped)";
 	default:
 		BUG();
 	}
-- 
2.9.5

