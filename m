Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC893C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDAC2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clG4WrVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHGJAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHGJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:00:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB29C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:00:46 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e14so1206341qtm.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oCzauoN+RxiYcRFcgDoGwgH2irisX28lT31YYK8dufk=;
        b=clG4WrVQkl25nMSkZDXFxdSak2ybk2eeSMw1L7rVDlC7Kvn2LrM8xLVIJJc7i+J11N
         yQVg86dLn1rSA+LaERdsZJkdvBZqCByADNOwcyEVRzArkNRT7Wex5wl/m5MWFoqlrNdt
         zCzFPJlSWQ9uUOZA6BmpUXnLVpQYnFeHqAUOiiWfNXX5fb4+8kvE2gm/MinQu3qomxJC
         sC8xeLHe6CiN7yY+vn/2IQZ0hIxXvVIGShqsv8OnIX++NZkn3/wwAGs/JSwSt0tua0jt
         q8/A9fzJC5CFZmysyXhfS92wv8tkG2raGHc/HnH4C5sezakvPfXcUhA15a7EUlTST8gC
         Zncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oCzauoN+RxiYcRFcgDoGwgH2irisX28lT31YYK8dufk=;
        b=a5+2Xzx9gUsuUF7n2Ulqz9KT0zR2C5XRQWyrrJ3L92ftjfJEBA1OCSWi1Ov31gLs6P
         zdlgFEgmsmiMXz8RiDAc6NI0RYB+jw9q+Ktp6bRHz1opn07gBJdvje7v4SoZMe4KxcPP
         6hu08pvVJgHNnCyZ+45i6TXhz6Cpf653VwuO4xb40A8ZlhzzfdUZiEM2/SGWIt9aqukk
         IAy1yXgosDrlfUViv+ODmEh3IaHnY9GOyAqXnbwJXamaU8ErqX9FKYy3NBuqA1K8cJ4H
         VP1Dt+QoV7wSrF4SUTPBiPrWfUWRBbC3VBS0v63wCFyec37RMqI2iIaHIjNB9PptNbL+
         /Eeg==
X-Gm-Message-State: AOAM533bGOeJNhQceorXI7I4G+1qvt6fgMZSWsfm7lHdO52YQzYSCuU6
        FkCyxYvt5x2AtSaAm9wd5dpMf2XOdw==
X-Google-Smtp-Source: ABdhPJyi1pILYCD0oIoicc3HTdrh+JMQatSDwSmHFv4PDP1a/w3luSTeS8n3ucuaj9uIVL+Lrg+unCJ9XA==
X-Received: by 2002:a0c:f14d:: with SMTP id y13mr12756071qvl.136.1596790844872;
 Fri, 07 Aug 2020 02:00:44 -0700 (PDT)
Date:   Fri,  7 Aug 2020 11:00:31 +0200
Message-Id: <20200807090031.3506555-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH] kcsan: Treat runtime as NMI-like with interrupt tracing
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        mingo@kernel.org, mark.rutland@arm.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since KCSAN instrumentation is everywhere, we need to treat the hooks
NMI-like for interrupt tracing. In order to present an as 'normal' as
possible context to the code called by KCSAN when reporting errors, we
need to update the IRQ-tracing state.

Tested: Several runs through kcsan-test with different configuration
(PROVE_LOCKING on/off), as well as hours of syzbot testing with the
original config that caught the problem (without CONFIG_PARAVIRT=y,
which appears to cause IRQ state tracking inconsistencies even when
KCSAN remains off, see Link).

Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
Patch Note: This patch applies to latest mainline. While current
mainline suffers from the above problem, the configs required to hit the
issue are likely not enabled too often (of course with PROVE_LOCKING on;
we hit it on syzbot though). It'll probably be wise to queue this as
normal on -rcu, just in case something is still off, given the
non-trivial nature of the issue. (If it should instead go to mainline
right now as a fix, I'd like some more test time on syzbot.)
---
 kernel/kcsan/core.c  | 79 ++++++++++++++++++++++++++++++++++----------
 kernel/kcsan/kcsan.h |  3 +-
 2 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 9147ff6a12e5..6202a645f1e2 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -291,13 +291,28 @@ static inline unsigned int get_delay(void)
 				0);
 }
 
-void kcsan_save_irqtrace(struct task_struct *task)
-{
+/*
+ * KCSAN instrumentation is everywhere, which means we must treat the hooks
+ * NMI-like for interrupt tracing. In order to present a 'normal' as possible
+ * context to the code called by KCSAN when reporting errors we need to update
+ * the IRQ-tracing state.
+ *
+ * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
+ * runtime is entered for every memory access, and potentially useful
+ * information is lost if dirtied by KCSAN.
+ */
+
+struct kcsan_irq_state {
+	unsigned long		flags;
 #ifdef CONFIG_TRACE_IRQFLAGS
-	task->kcsan_save_irqtrace = task->irqtrace;
+	int			hardirqs_enabled;
 #endif
-}
+};
 
+/*
+ * This is also called by the reporting task for the other task, to generate the
+ * right report with CONFIG_KCSAN_VERBOSE. No harm in restoring more than once.
+ */
 void kcsan_restore_irqtrace(struct task_struct *task)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -305,6 +320,41 @@ void kcsan_restore_irqtrace(struct task_struct *task)
 #endif
 }
 
+/*
+ * Saves/restores IRQ state (see comment above). Need noinline to work around
+ * unfortunate code-gen upon inlining, resulting in objtool getting confused as
+ * well as losing stack trace information.
+ */
+static noinline void kcsan_irq_save(struct kcsan_irq_state *irq_state)
+{
+#ifdef CONFIG_TRACE_IRQFLAGS
+	current->kcsan_save_irqtrace = current->irqtrace;
+	irq_state->hardirqs_enabled = lockdep_hardirqs_enabled();
+#endif
+	if (!kcsan_interrupt_watcher) {
+		kcsan_disable_current(); /* Lockdep might WARN, etc. */
+		raw_local_irq_save(irq_state->flags);
+		lockdep_hardirqs_off(_RET_IP_);
+		kcsan_enable_current();
+	}
+}
+
+static noinline void kcsan_irq_restore(struct kcsan_irq_state *irq_state)
+{
+	if (!kcsan_interrupt_watcher) {
+		kcsan_disable_current(); /* Lockdep might WARN, etc. */
+#ifdef CONFIG_TRACE_IRQFLAGS
+		if (irq_state->hardirqs_enabled) {
+			lockdep_hardirqs_on_prepare(_RET_IP_);
+			lockdep_hardirqs_on(_RET_IP_);
+		}
+#endif
+		raw_local_irq_restore(irq_state->flags);
+		kcsan_enable_current();
+	}
+	kcsan_restore_irqtrace(current);
+}
+
 /*
  * Pull everything together: check_access() below contains the performance
  * critical operations; the fast-path (including check_access) functions should
@@ -350,11 +400,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	flags = user_access_save();
 
 	if (consumed) {
-		kcsan_save_irqtrace(current);
+		struct kcsan_irq_state irqstate;
+
+		kcsan_irq_save(&irqstate);
 		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
 			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
 			     watchpoint - watchpoints);
-		kcsan_restore_irqtrace(current);
+		kcsan_irq_restore(&irqstate);
 	} else {
 		/*
 		 * The other thread may not print any diagnostics, as it has
@@ -387,7 +439,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
-	unsigned long irq_flags = 0;
+	struct kcsan_irq_state irqstate;
 
 	/*
 	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
@@ -412,14 +464,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 	}
 
-	/*
-	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
-	 * runtime is entered for every memory access, and potentially useful
-	 * information is lost if dirtied by KCSAN.
-	 */
-	kcsan_save_irqtrace(current);
-	if (!kcsan_interrupt_watcher)
-		local_irq_save(irq_flags);
+	kcsan_irq_save(&irqstate);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -559,9 +604,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	remove_watchpoint(watchpoint);
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	if (!kcsan_interrupt_watcher)
-		local_irq_restore(irq_flags);
-	kcsan_restore_irqtrace(current);
+	kcsan_irq_restore(&irqstate);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 29480010dc30..6eb35a9514d8 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -24,9 +24,8 @@ extern unsigned int kcsan_udelay_interrupt;
 extern bool kcsan_enabled;
 
 /*
- * Save/restore IRQ flags state trace dirtied by KCSAN.
+ * Restore IRQ flags state trace dirtied by KCSAN.
  */
-void kcsan_save_irqtrace(struct task_struct *task);
 void kcsan_restore_irqtrace(struct task_struct *task);
 
 /*
-- 
2.28.0.236.gb10cc79966-goog

