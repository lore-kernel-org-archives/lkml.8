Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA23C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EE120774
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IV6OJWR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCYQmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:42:13 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:45107 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:42:13 -0400
Received: by mail-ua1-f73.google.com with SMTP id h10so1055107uab.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EGhnUj7ioBzGectSkIqL2PzeN3zdjD+SletKvmksBXU=;
        b=IV6OJWR7Aql6xUqtOu+bWnVVeQxIaVLk4XEe2BH2UfwbGLv7POdck5LNZ4yqwdt2dy
         hE1SBs8Z7U8a5uteIDjVTRoescqDXSlkYESbZDxpB9slqT72KOGGs8pZTmX8lob1mAH4
         BArLVpphu6jt5+AY9t1N+laYhyR7Gjf0KAlJN5gb3oGDQyB34uOEfIkI4IYYIcpVYuZp
         dsgpz8ATntE/5h5quNl7yiIrSo1Wdowkyw4RA8w3oOXekNUrBEnKv4y1QOdMaPnjXDJf
         d4fyv00r8Vgrxf6W8YkpMMcwNiX6cceSuCas4bzvuA8fa5XY8x7roQ47GXQTfgn6NTwN
         A7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EGhnUj7ioBzGectSkIqL2PzeN3zdjD+SletKvmksBXU=;
        b=rsfh5xTscXjLZhkOEmxEnLm9WdIjXBtmNJSDc4pS3n42P0Cf9fM+Ruend05P3Gba+h
         E+HoLj/2/YJzsCrbsVUXsXvkH4uoO+9YDvzUEdRlIN4vIMgIU30huy+ROI7R0U7corWA
         gG4HiCCz4GLB++gJ0nrCVUleXl6cgt6XPY1cTfkGZiklvF6mJnd1LzWt2jy9xd4BrLP3
         XLl+8nhZlm79r8nbD2PZMjoPeq0+mVj531OUFpSIysTQ5ALXqcnzpMVfeyw+J6ajk+pU
         Z+3Tm3xkyVYoXZOH3eRCD1+p1yTFVFM7LFvLTVnNPBvAMRopa1qS1O9HriX3Q7gunkaB
         hLPA==
X-Gm-Message-State: ANhLgQ0jvCsOH2uoux+05Bc5N/YSSxMiHsp8uQTS40kyf5qTG+rFbcTm
        3MIMhJfyz09W4Jia3Ndpy7mG4FB69g==
X-Google-Smtp-Source: ADFU+vsxQ9yJo9DVWZgCW7Dde/xiXbKIcmC7J+MSdZsRkyb5LaCu82jvWvE3Q7SP9EL8BuM2h5fVqLFVyA==
X-Received: by 2002:a67:ecc1:: with SMTP id i1mr3159758vsp.89.1585154529924;
 Wed, 25 Mar 2020 09:42:09 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:41:56 +0100
Message-Id: <20200325164158.195303-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 1/3] kcsan: Add support for scoped accesses
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for scoped accesses, where the memory range is checked
for the duration of the scope. The feature is implemented by inserting
the relevant access information into a list of scoped accesses for the
current execution context, which are then checked (until removed) on
every call (through instrumentation) into the KCSAN runtime.

An alternative, more complex, implementation could set up a watchpoint
for the scoped access, and keep the watchpoint set up. This, however,
would require first exposing a handle to the watchpoint, as well as
dealing with cases such as accesses by the same thread while the
watchpoint is still set up (and several more cases). It is also doubtful
if this would provide any benefit, since the majority of delay where the
watchpoint is set up is likely due to the injected delays by KCSAN.
Therefore, the implementation in this patch is simpler, nor hurts
KCSAN's main use-case (normal data race detection); it also implicitly
increases scoped-access race-detection-ability due to increased
probability of setting up watchpoints by repeatedly calling
__kcsan_check_access() throughout the scope of the access.

The implementation required adding an additional conditional branch to
the fast-path. Using the microbenchmark, however, a *speedup* of ~5% of
the fast-path is measured. This appears to be due to subtly improved
codegen by GCC from moving get_ctx() and associated load of
preempt_count earlier.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 57 +++++++++++++++++++++++++
 include/linux/kcsan.h        |  3 ++
 init/init_task.c             |  1 +
 kernel/kcsan/core.c          | 83 ++++++++++++++++++++++++++++++++----
 kernel/kcsan/report.c        | 33 +++++++++-----
 5 files changed, 158 insertions(+), 19 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 3cd8bb03eb41..b24253d3a442 100644
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
index 3b84606e1e67..17ae59e4b685 100644
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
index 096191d177d5..198943851caf 100644
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
index 4d8ea0fca5f1..a572aae61b98 100644
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
index ae0a383238ea..ddc18f1224a4 100644
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
2.25.1.696.g5e7596f4ac-goog

