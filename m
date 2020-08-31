Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88EC2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897971;
	bh=+RXrssZAOzQNHzoPuMEErrLqNVzDGlCdVjn9K4tvDus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tJq+fyQ5W2Zcv/Sa8f8C+PTfacENPHVTj0fb031OEZxkG831j1CoiZZlPGmN2Vuvf
	 hTdhYllMN1F59mN4P37MhDd358OlxhwSvoBGCNH8ZY3BKzaiS4HWjLRh/q8TjfE8Am
	 UtSACXy/l6+jOLdjGhz8ppGoSljfYC8KrWuJNpm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgHaSTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbgHaSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415312176B;
        Mon, 31 Aug 2020 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897889;
        bh=+RXrssZAOzQNHzoPuMEErrLqNVzDGlCdVjn9K4tvDus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOo6nvQC6/b6mhXP4lieR1op8GcJcGtSa1jOcI578m3x8rHgWCnTpAm8OEmg/4Dah
         z04zUp7KJnuJ2aLvy9ToAXwtUlAWHVxorOyEipP1OkDrcbSOpsfEuBgweGyMX1IMXH
         JTqbt/VWXIQYlrDsQMhKbeuD+nIowNlIwtjgnDfs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 19/19] kcsan: Use tracing-safe version of prandom
Date:   Mon, 31 Aug 2020 11:18:05 -0700
Message-Id: <20200831181805.1833-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

In the core runtime, we must minimize any calls to external library
functions to avoid any kind of recursion. This can happen even though
instrumentation is disabled for called functions, but tracing is
enabled.

Most recently, prandom_u32() added a tracepoint, which can cause
problems for KCSAN even if the rcuidle variant is used. For example:
	kcsan -> prandom_u32() -> trace_prandom_u32_rcuidle ->
	srcu_read_lock_notrace -> __srcu_read_lock -> kcsan ...

While we could disable KCSAN in kcsan_setup_watchpoint(), this does not
solve other unexpected behaviour we may get due recursing into functions
that may not be tolerant to such recursion:
	__srcu_read_lock -> kcsan -> ... -> __srcu_read_lock

Therefore, switch to using prandom_u32_state(), which is uninstrumented,
and does not have a tracepoint.

Link: https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com
Link: https://lkml.kernel.org/r/20200820172046.GA177701@elver.google.com
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 8a1ff605..3994a21 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -100,6 +100,9 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
+/* For kcsan_prandom_u32_max(). */
+static DEFINE_PER_CPU(struct rnd_state, kcsan_rand_state);
+
 static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
 						      size_t size,
 						      bool expect_write,
@@ -271,11 +274,28 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 	return true;
 }
 
+/*
+ * Returns a pseudo-random number in interval [0, ep_ro). See prandom_u32_max()
+ * for more details.
+ *
+ * The open-coded version here is using only safe primitives for all contexts
+ * where we can have KCSAN instrumentation. In particular, we cannot use
+ * prandom_u32() directly, as its tracepoint could cause recursion.
+ */
+static u32 kcsan_prandom_u32_max(u32 ep_ro)
+{
+	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
+	const u32 res = prandom_u32_state(state);
+
+	put_cpu_var(kcsan_rand_state);
+	return (u32)(((u64) res * ep_ro) >> 32);
+}
+
 static inline void reset_kcsan_skip(void)
 {
 	long skip_count = kcsan_skip_watch -
 			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
-				   prandom_u32_max(kcsan_skip_watch) :
+				   kcsan_prandom_u32_max(kcsan_skip_watch) :
 				   0);
 	this_cpu_write(kcsan_skip, skip_count);
 }
@@ -285,16 +305,18 @@ static __always_inline bool kcsan_is_enabled(void)
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
 
-static inline unsigned int get_delay(int type)
+/* Introduce delay depending on context and configuration. */
+static void delay_access(int type)
 {
 	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
 	/* For certain access types, skew the random delay to be longer. */
 	unsigned int skew_delay_order =
 		(type & (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_ASSERT)) ? 1 : 0;
 
-	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
-				prandom_u32_max(delay >> skew_delay_order) :
-				0);
+	delay -= IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
+			       kcsan_prandom_u32_max(delay >> skew_delay_order) :
+			       0;
+	udelay(delay);
 }
 
 void kcsan_save_irqtrace(struct task_struct *task)
@@ -476,7 +498,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
 	 */
-	udelay(get_delay(type));
+	delay_access(type);
 
 	/*
 	 * Re-read value, and check if it is as expected; if not, we infer a
@@ -620,6 +642,7 @@ void __init kcsan_init(void)
 	BUG_ON(!in_task());
 
 	kcsan_debugfs_init();
+	prandom_seed_full_state(&kcsan_rand_state);
 
 	/*
 	 * We are in the init task, and no other tasks should be running;
-- 
2.9.5

