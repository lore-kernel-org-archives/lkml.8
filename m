Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A520C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E23207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBDgIpc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG2LJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2LJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:09:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8ADC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:09:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x10so10419593ybj.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hCZz7pD2WpbFrBmK0yvXbCAHYFWZieUEyvav6WgX9Ww=;
        b=fBDgIpc0vOgaoQ/c5Acm19xM8Ng1SzkonK/8XqMgrHbmpQab5QBVSTafbTKumrT4cv
         2+UG+2kWEoEzT/cLNCHB+rebdSRbaM4i07yPfMPhgczEDiHdZE8wr8LCmZVHNWIWYJbj
         4gA1SJyQ984td/pcUrzGyQBEmUU5Es41Ea1YAEoj8tA0nJHBv/DSKiWvF5BaLo6tmuMQ
         qRPqFZxZjH8jI0mpGZWSjJYjjnUEXrwLN8CToBs5Pe6Dl2J8vIG7k+9iw+odWkbsi95v
         6oWeygH+nZgnGfUHunxEi3cZmYrKtQhHkXytykugUKrxa8AMJg7u9/DOhGtfCLCs9R9p
         iWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hCZz7pD2WpbFrBmK0yvXbCAHYFWZieUEyvav6WgX9Ww=;
        b=pRJPgR7K/rQB9eiTW+uOB0dpSsn52pLLMmubZh3bnzpZlNV3tJolTbrYTmLuJDa5XW
         +2cOy20vPVCWq09NY2rlKd+Vv4f71b1/omrJYortv/DewJqMhnYm7A6pZDOhNzwab2dI
         Dt2mOwQuqgUYejxSPNpzAQT96l+Cky/5OBCoWiOFusH81TG58010Yk0bfPsokRDKjNkz
         q/zKWV3I+Ee+gho3tIlKZWsnqo3tp5P2vKvfrsO3UCsARnn0tg1vnxH69peKIg+Ebgrf
         F8+5ODz41FqZ3QuqzBPeexdfxoHv6V2aCza4HDt57g4Eli8X+vR04sRGV2U1oW01PfE/
         mmkA==
X-Gm-Message-State: AOAM532vsmDECr5RvL4n2Zg8amV7FPCmEOiwWLHz2HuZt5+keV+Du9QJ
        Ijt24qXbU/3fVA2gqQ2VfxGr9R6Srg==
X-Google-Smtp-Source: ABdhPJwemBwyrcQmtq+i6JehXshDb3Z/EDFY3af/tGxRmGei/ZmHiIhqREN96vheiKWPySsokH4rkvJIxA==
X-Received: by 2002:a25:7908:: with SMTP id u8mr30559476ybc.144.1596020989922;
 Wed, 29 Jul 2020 04:09:49 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:09:16 +0200
In-Reply-To: <20200729110916.3920464-1-elver@google.com>
Message-Id: <20200729110916.3920464-2-elver@google.com>
Mime-Version: 1.0
References: <20200729110916.3920464-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH tip/locking/core v2 2/2] kcsan: Improve IRQ state trace reporting
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, paulmck@kernel.org,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the general usefulness of the IRQ state trace events with
KCSAN enabled, save and restore the trace information when entering and
exiting the KCSAN runtime as well as when generating a KCSAN report.

Without this, reporting the IRQ trace events (whether via a KCSAN report
or outside of KCSAN via a lockdep report) is rather useless due to
continuously being touched by KCSAN. This is because if KCSAN is
enabled, every instrumented memory access causes changes to IRQ trace
events (either by KCSAN disabling/enabling interrupts or taking
report_lock when generating a report).

Before "lockdep: Prepare for NMI IRQ state tracking", KCSAN avoided
touching the IRQ trace events via raw_local_irq_save/restore() and
lockdep_off/on().

Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use simple struct copy, now that the IRQ trace events are in a struct.

Depends on:  "lockdep: Prepare for NMI IRQ state tracking"
---
 include/linux/sched.h |  4 ++++
 kernel/kcsan/core.c   | 23 +++++++++++++++++++++++
 kernel/kcsan/kcsan.h  |  7 +++++++
 kernel/kcsan/report.c |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 52e0fdd6a555..060e9214c8b5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1184,8 +1184,12 @@ struct task_struct {
 #ifdef CONFIG_KASAN
 	unsigned int			kasan_depth;
 #endif
+
 #ifdef CONFIG_KCSAN
 	struct kcsan_ctx		kcsan_ctx;
+#ifdef CONFIG_TRACE_IRQFLAGS
+	struct irqtrace_events		kcsan_save_irqtrace;
+#endif
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 732623c30359..0fe068192781 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -291,6 +291,20 @@ static inline unsigned int get_delay(void)
 				0);
 }
 
+void kcsan_save_irqtrace(struct task_struct *task)
+{
+#ifdef CONFIG_TRACE_IRQFLAGS
+	task->kcsan_save_irqtrace = task->irqtrace;
+#endif
+}
+
+void kcsan_restore_irqtrace(struct task_struct *task)
+{
+#ifdef CONFIG_TRACE_IRQFLAGS
+	task->irqtrace = task->kcsan_save_irqtrace;
+#endif
+}
+
 /*
  * Pull everything together: check_access() below contains the performance
  * critical operations; the fast-path (including check_access) functions should
@@ -336,9 +350,11 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	flags = user_access_save();
 
 	if (consumed) {
+		kcsan_save_irqtrace(current);
 		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
 			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
 			     watchpoint - watchpoints);
+		kcsan_restore_irqtrace(current);
 	} else {
 		/*
 		 * The other thread may not print any diagnostics, as it has
@@ -396,6 +412,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 	}
 
+	/*
+	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
+	 * runtime is entered for every memory access, and potentially useful
+	 * information is lost if dirtied by KCSAN.
+	 */
+	kcsan_save_irqtrace(current);
 	if (!kcsan_interrupt_watcher)
 		local_irq_save(irq_flags);
 
@@ -539,6 +561,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 out_unlock:
 	if (!kcsan_interrupt_watcher)
 		local_irq_restore(irq_flags);
+	kcsan_restore_irqtrace(current);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 763d6d08d94b..29480010dc30 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -9,6 +9,7 @@
 #define _KERNEL_KCSAN_KCSAN_H
 
 #include <linux/kcsan.h>
+#include <linux/sched.h>
 
 /* The number of adjacent watchpoints to check. */
 #define KCSAN_CHECK_ADJACENT 1
@@ -22,6 +23,12 @@ extern unsigned int kcsan_udelay_interrupt;
  */
 extern bool kcsan_enabled;
 
+/*
+ * Save/restore IRQ flags state trace dirtied by KCSAN.
+ */
+void kcsan_save_irqtrace(struct task_struct *task);
+void kcsan_restore_irqtrace(struct task_struct *task);
+
 /*
  * Initialize debugfs file.
  */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 6b2fb1a6d8cd..9d07e175de0f 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -308,6 +308,9 @@ static void print_verbose_info(struct task_struct *task)
 	if (!task)
 		return;
 
+	/* Restore IRQ state trace for printing. */
+	kcsan_restore_irqtrace(task);
+
 	pr_err("\n");
 	debug_show_held_locks(task);
 	print_irqtrace_events(task);
-- 
2.28.0.rc0.142.g3c755180ce-goog

