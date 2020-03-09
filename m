Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B7EC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CA0215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780710;
	bh=nvxvgWdtEgnDRqamc2GBWCsWAoOX94Fj8G+9vEM+csI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y5B2SmN7m8vxVa32yYGF24kxutPzVP1oh+P+hpf9IOq9akXPaVbJlLG3Zpb4Yj9Zg
	 1w/s+kbRRJZhhHuih4QkEUSXDLe1Xj1l3T5k5pFvIG9gc/oXeS6Avgy8HpeIgYwdKO
	 5XcuVJynu323bJkDRuqzqfEdyJfSM81MCTiWq+xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCITE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbgCITEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A46F2465A;
        Mon,  9 Mar 2020 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780665;
        bh=nvxvgWdtEgnDRqamc2GBWCsWAoOX94Fj8G+9vEM+csI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLCKQzKRVJcFGcG2+Cl2hY/Ds3fWou+kMjKhrUohcvjKDlTjTBrJbD9UkbnYsLqbb
         HRG/MRLvhE9k0yKiz5ntxrnmi1Kalh0ACqKg/GNHX1mL2x3z2vGGpsMpas+7QANJkT
         fc58l1eCTQmkC9OXQHFog4dXzz6JXlaWYiTtqzJ4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 12/32] kcsan: Add option to assume plain aligned writes up to word size are atomic
Date:   Mon,  9 Mar 2020 12:04:00 -0700
Message-Id: <20200309190420.6100-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

This adds option KCSAN_ASSUME_PLAIN_WRITES_ATOMIC. If enabled, plain
aligned writes up to word size are assumed to be atomic, and also not
subject to other unsafe compiler optimizations resulting in data races.

This option has been enabled by default to reflect current kernel-wide
preferences.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 22 +++++++++++++++++-----
 lib/Kconfig.kcsan   | 27 ++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 64b30f7..e3c7d8f 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/random.h>
@@ -169,10 +170,20 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static __always_inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool
+is_atomic(const volatile void *ptr, size_t size, int type)
 {
-	struct kcsan_ctx *ctx = get_ctx();
+	struct kcsan_ctx *ctx;
+
+	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
+		return true;
 
+	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
+	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long) &&
+	    IS_ALIGNED((unsigned long)ptr, size))
+		return true; /* Assume aligned writes up to word size are atomic. */
+
+	ctx = get_ctx();
 	if (unlikely(ctx->atomic_next > 0)) {
 		/*
 		 * Because we do not have separate contexts for nested
@@ -193,7 +204,8 @@ static __always_inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static __always_inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool
+should_watch(const volatile void *ptr, size_t size, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -202,7 +214,7 @@ static __always_inline bool should_watch(const volatile void *ptr, int type)
 	 * should not count towards skipped instructions, and (2) to actually
 	 * decrement kcsan_atomic_next for consecutive instruction stream.
 	 */
-	if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
+	if (is_atomic(ptr, size, type))
 		return false;
 
 	if (this_cpu_dec_return(kcsan_skip) >= 0)
@@ -460,7 +472,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	if (unlikely(watchpoint != NULL))
 		kcsan_found_watchpoint(ptr, size, type, watchpoint,
 				       encoded_watchpoint);
-	else if (unlikely(should_watch(ptr, type)))
+	else if (unlikely(should_watch(ptr, size, type)))
 		kcsan_setup_watchpoint(ptr, size, type);
 }
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3552990..6612685 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -91,13 +91,13 @@ config KCSAN_REPORT_ONCE_IN_MS
 	  limiting reporting to avoid flooding the console with reports.
 	  Setting this to 0 disables rate limiting.
 
-# Note that, while some of the below options could be turned into boot
-# parameters, to optimize for the common use-case, we avoid this because: (a)
-# it would impact performance (and we want to avoid static branch for all
-# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
-# without real benefit. The main purpose of the below options is for use in
-# fuzzer configs to control reported data races, and they are not expected
-# to be switched frequently by a user.
+# The main purpose of the below options is to control reported data races (e.g.
+# in fuzzer configs), and are not expected to be switched frequently by other
+# users. We could turn some of them into boot parameters, but given they should
+# not be switched normally, let's keep them here to simplify configuration.
+#
+# The defaults below are chosen to be very conservative, and may miss certain
+# bugs.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
@@ -116,6 +116,19 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	  the data value of the memory location was observed to remain
 	  unchanged, do not report the data race.
 
+config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
+	bool "Assume that plain aligned writes up to word size are atomic"
+	default y
+	help
+	  Assume that plain aligned writes up to word size are atomic by
+	  default, and also not subject to other unsafe compiler optimizations
+	  resulting in data races. This will cause KCSAN to not report data
+	  races due to conflicts where the only plain accesses are aligned
+	  writes up to word size: conflicts between marked reads and plain
+	  aligned writes up to word size will not be reported as data races;
+	  notice that data races between two conflicting plain aligned writes
+	  will also not be reported.
+
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-- 
2.9.5

