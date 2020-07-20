Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3620C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2DE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iASTdcQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgGTMEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgGTMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:04:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 05:04:00 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i6so11238774qkn.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hO0JBht5uOWoAmAL+7KjQJEygdsPtbQCk3P9CwJY3U0=;
        b=iASTdcQELQt5EHouNROxJiilxT9/qvLao4euOotIELKn+JKd2bFuPD35SyCXv2SKll
         iCpAlQTC73rHoQYS/Stg++GW+NUQL9jmUnqNYJs3m92A7o8hXkwIbEccv316BhSSq8AJ
         6I1nNyMPAJEfixzma7UCoteglEopqFTMgPsVEUp4BGvYTUcqqr/1u5RHNuL0CIY04PzF
         3juqjNwEVOFGyt8xMKdtrCPAaGctzOSx2XpklygjI847Ut8P5BnWXc/bY4NgSeZYJCyb
         rwtPlR7HHdVQ/N8FkmmKA1i5lz56P/+33a/b4vovmYH3VX7SZf8BmxM9cF9f+d2r9aHR
         57Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hO0JBht5uOWoAmAL+7KjQJEygdsPtbQCk3P9CwJY3U0=;
        b=T0dnaUyeACeiNk6SgU/BZBltIZlgI8Bb2x1ZP0PQ66IhseklW0TDA+NTsZw+ARJzHW
         YqtYkgUbe0u4hOXnCnl6zEfZE2AYZxWdbQPt3vUVN07P+8UktKNT9AOQfv4956B+9MUV
         zw5j7jD5GDsyr9pSR6vjckzq9saL/mWYdum+Js5R6g6nK5PEmQFms1sPJ1lhzmPRt5i4
         stMErrKujsidABi1Oowl/EIV5FMJGnhKXXfmUGWMd3QOjXV68TmZdSgTV6J0o+XYeSx8
         5TO0GkYPLarh1RJA5f7WcyUSWWM4ZW9MHuqNUcjz3FTN5Ie6XK4HjqlTB2YYbxHuIMpU
         z2EA==
X-Gm-Message-State: AOAM531SPcDQ2plEkaEtsVeUpggPKQijl32+5d8s0/O/0AKMWXjOoTew
        WI21PXipEHAOKJbNCVOAhiSKWXvfAQ==
X-Google-Smtp-Source: ABdhPJztHUn5DXkQS6vqLz66ATv3qE3aee0hEBpdJCpLhs51YXxPPcA/j/aML7lIT37wssYPOnoaeTsFNQ==
X-Received: by 2002:a0c:b9a8:: with SMTP id v40mr21901301qvf.90.1595246639491;
 Mon, 20 Jul 2020 05:03:59 -0700 (PDT)
Date:   Mon, 20 Jul 2020 14:03:48 +0200
Message-Id: <20200720120348.2406588-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH tip/locking/core] kcsan: Improve IRQ state trace reporting
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
        paulmck@kernel.org, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the general usefulness of the IRQ state trace information
with KCSAN enabled, save and restore the trace information when entering
and exiting the KCSAN runtime as well as when generating a KCSAN report.

Without this, reporting the IRQ state trace (whether via a KCSAN report
or outside of KCSAN via a lockdep report) is rather useless due to
continuously being touched by KCSAN. This is because if KCSAN is
enabled, every instrumented memory access causes changes to IRQ state
tracking information (either by KCSAN disabling/enabling interrupts or
taking report_lock when generating a report).

Before "lockdep: Prepare for NMI IRQ state tracking", KCSAN avoided
touching the IRQ state trace via raw_local_irq_save/restore() and
lockdep_off/on().

Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
Signed-off-by: Marco Elver <elver@google.com>
---


Hi, Peter,

If this is reasonable, please take it into the branch that currently has
the series around "lockdep: Prepare for NMI IRQ state tracking"
(tip/locking/core?).

Thanks,
-- Marco


---
 include/linux/sched.h | 13 +++++++++++++
 kernel/kcsan/core.c   | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/kcsan/kcsan.h  |  7 +++++++
 kernel/kcsan/report.c |  3 +++
 4 files changed, 62 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..ca5324b1657c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1199,6 +1199,19 @@ struct task_struct {
 #endif
 #ifdef CONFIG_KCSAN
 	struct kcsan_ctx		kcsan_ctx;
+#ifdef CONFIG_TRACE_IRQFLAGS
+	struct {
+		unsigned int		irq_events;
+		unsigned long		hardirq_enable_ip;
+		unsigned long		hardirq_disable_ip;
+		unsigned int		hardirq_enable_event;
+		unsigned int		hardirq_disable_event;
+		unsigned long		softirq_disable_ip;
+		unsigned long		softirq_enable_ip;
+		unsigned int		softirq_disable_event;
+		unsigned int		softirq_enable_event;
+	} kcsan_save_irqtrace;
+#endif
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 732623c30359..7e8347c14530 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -291,6 +291,36 @@ static inline unsigned int get_delay(void)
 				0);
 }
 
+void kcsan_save_irqtrace(struct task_struct *task)
+{
+#ifdef CONFIG_TRACE_IRQFLAGS
+	task->kcsan_save_irqtrace.irq_events = task->irq_events;
+	task->kcsan_save_irqtrace.hardirq_enable_ip = task->hardirq_enable_ip;
+	task->kcsan_save_irqtrace.hardirq_disable_ip = task->hardirq_disable_ip;
+	task->kcsan_save_irqtrace.hardirq_enable_event = task->hardirq_enable_event;
+	task->kcsan_save_irqtrace.hardirq_disable_event = task->hardirq_disable_event;
+	task->kcsan_save_irqtrace.softirq_disable_ip = task->softirq_disable_ip;
+	task->kcsan_save_irqtrace.softirq_enable_ip = task->softirq_enable_ip;
+	task->kcsan_save_irqtrace.softirq_disable_event = task->softirq_disable_event;
+	task->kcsan_save_irqtrace.softirq_enable_event = task->softirq_enable_event;
+#endif
+}
+
+void kcsan_restore_irqtrace(struct task_struct *task)
+{
+#ifdef CONFIG_TRACE_IRQFLAGS
+	task->irq_events = task->kcsan_save_irqtrace.irq_events;
+	task->hardirq_enable_ip = task->kcsan_save_irqtrace.hardirq_enable_ip;
+	task->hardirq_disable_ip = task->kcsan_save_irqtrace.hardirq_disable_ip;
+	task->hardirq_enable_event = task->kcsan_save_irqtrace.hardirq_enable_event;
+	task->hardirq_disable_event = task->kcsan_save_irqtrace.hardirq_disable_event;
+	task->softirq_disable_ip = task->kcsan_save_irqtrace.softirq_disable_ip;
+	task->softirq_enable_ip = task->kcsan_save_irqtrace.softirq_enable_ip;
+	task->softirq_disable_event = task->kcsan_save_irqtrace.softirq_disable_event;
+	task->softirq_enable_event = task->kcsan_save_irqtrace.softirq_enable_event;
+#endif
+}
+
 /*
  * Pull everything together: check_access() below contains the performance
  * critical operations; the fast-path (including check_access) functions should
@@ -336,9 +366,11 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
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
@@ -396,6 +428,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
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
 
@@ -539,6 +577,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
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
2.28.0.rc0.105.gf9edc3c819-goog

