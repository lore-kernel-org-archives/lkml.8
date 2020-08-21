Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC5D20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NrSy4jUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHUMbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHUMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:31:34 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA229C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:31:33 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id r14so512900wrq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EoagnfooXXSHbL+CSOarlDeWOkZ9GCDzxKOSIZ6/Baw=;
        b=NrSy4jUp+m4sT9zXGG3YtOyeJ6raLaNowDBQ6JzpaySwJTq66Zo36qtE8WCeSqsqQM
         j+oYKo3mc4fKu/tznuaoRA9NKBL7t/dOUNCShzlwNp+ES9NKj/h6BN2p98g7N2tV/ln4
         WFwxmaXVIxcTdSl0coLR13B/jqsKXUJy4hndk85FIgSW0kL6K3Ylkt/ow/cAfx4oJW8B
         Uy/Fa28z9F8rkYOPuQ4BlfmNxTIAaAaF1ymNEJwweSjiBhCfK6/oD30O9xd46Z8n/5Dv
         Ls6FAdiZ0fjarc4B9CkZfuShI8l0RmohuU2/uDN8+EgWoxU9j1/zBy5WM3vGQYgJhArm
         ErsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EoagnfooXXSHbL+CSOarlDeWOkZ9GCDzxKOSIZ6/Baw=;
        b=oXwd3xP9tuoDUFQOYCG8i/3lUR0n0+AiuzaUyJstY3gNuXMPpfibqqZpe1LhZ17uBY
         u0XJVufhFjYJyp2GAI+Y0AEDm0bW4+JfVY4Le250nnp9vEmCsJnKIgXoA4npKobMt88G
         5+hzfIaJn03A0NIXaWYjL5Dj+xBRsXx10ymk98sVLwUCcMvpOXFgCX69yQ2w7KI1OyNG
         lUw0iivG9GGBLYZOx158Nfi4JcAAIbVXO7GfbiWWV/XF2OgKyxDJS/CONB9tHZlkLoL6
         Z1QIgfJvoWuXzTQs4+A0lcX69YTs1POgF7iOEpplNoU1NljShMEvZ3ZjYYnLS+1bHPTq
         pjqA==
X-Gm-Message-State: AOAM530qPf9epCyNVTMmMZgSL7ZI2sl4Z6WVYCZZeyaccYzfXNOH/79H
        9kbhRafaf3AOL22d4R8gdb6UaNeSig==
X-Google-Smtp-Source: ABdhPJzysKHAyS5oKxkv7CRnLjQpFmbJ2gU/87a5uKZT4QRrCcS5vACNnYIiRKI0whTB952B181UEozxuw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:4c:: with SMTP id 73mr3543536wma.58.1598013090088;
 Fri, 21 Aug 2020 05:31:30 -0700 (PDT)
Date:   Fri, 21 Aug 2020 14:31:26 +0200
Message-Id: <20200821123126.3121494-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] kcsan: Use tracing-safe version of prandom
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     peterz@infradead.org, mark.rutland@arm.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Applies to latest -rcu/dev only.

Let's wait a bit to see what happens with
  https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com,
just in case there's a better solution that might make this patch redundant.
---
 kernel/kcsan/core.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 8a1ff605ff2d..3994a217bde7 100644
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
2.28.0.297.g1956fa8f8d-goog

