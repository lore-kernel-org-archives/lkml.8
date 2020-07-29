Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25390C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4282082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/dNqINI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eB9DEYMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgG2Q2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:28:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2Q23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:28:29 -0400
Date:   Wed, 29 Jul 2020 16:28:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596040105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3la9JaCMrV7rKV2iGWV1u2gThhcd3blJgMIGHQC1f7k=;
        b=O/dNqINIDT0Ij+6w+UycNcEb3VtGBZAbNfKuE49O4qNDGod8uxOtj+MhKLRGCFzV+vVvNB
        mwj2f/WyRHFfIBFM+fpyJ6vGzhTIrhKHrf3tjGWzeS4qLHIsk3TyTI+7znPE2OcK/IdaIu
        V3cC9mg+M5RvtJkLtjs/cUsi5bmMnzN9EPCUFbcftjJKfBvPeCDQIAvvzVSfMVc3gq2TqS
        I92eq67J3bFNONAnRm6dmRjBMsK06QzkCGozjkgKW0DckGvFe+AFzzahV2fTdN6sUKOpuR
        3Cr52pBce8drKxIiLy6n06LqzU76mENH9UoidoFQCMrMAgKWIJ/sAL3nEZG2Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596040105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3la9JaCMrV7rKV2iGWV1u2gThhcd3blJgMIGHQC1f7k=;
        b=eB9DEYMIdh4qv3Q2BwChULIKFjbigL6Gxh4rrFHw8ogcdk7EViHaKWXwaV6MYnA2/NynWA
        OHvsiNO08Rh8EECQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Improve IRQ state trace reporting
Cc:     Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729110916.3920464-2-elver@google.com>
References: <20200729110916.3920464-2-elver@google.com>
MIME-Version: 1.0
Message-ID: <159604010417.4006.4002892974399715730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     47490fdd411675707624fdfbf7bcfcd5f6a5e706
Gitweb:        https://git.kernel.org/tip/47490fdd411675707624fdfbf7bcfcd5f6a5e706
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 29 Jul 2020 13:09:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 29 Jul 2020 16:30:41 +02:00

kcsan: Improve IRQ state trace reporting

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200729110916.3920464-2-elver@google.com
---
 include/linux/sched.h |  4 ++++
 kernel/kcsan/core.c   | 23 +++++++++++++++++++++++
 kernel/kcsan/kcsan.h  |  7 +++++++
 kernel/kcsan/report.c |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 26adabe..2ede13a 100644
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
index 732623c..0fe0681 100644
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
index 763d6d0..2948001 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -9,6 +9,7 @@
 #define _KERNEL_KCSAN_KCSAN_H
 
 #include <linux/kcsan.h>
+#include <linux/sched.h>
 
 /* The number of adjacent watchpoints to check. */
 #define KCSAN_CHECK_ADJACENT 1
@@ -23,6 +24,12 @@ extern unsigned int kcsan_udelay_interrupt;
 extern bool kcsan_enabled;
 
 /*
+ * Save/restore IRQ flags state trace dirtied by KCSAN.
+ */
+void kcsan_save_irqtrace(struct task_struct *task);
+void kcsan_restore_irqtrace(struct task_struct *task);
+
+/*
  * Initialize debugfs file.
  */
 void kcsan_debugfs_init(void);
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 6b2fb1a..9d07e17 100644
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
