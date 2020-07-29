Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68723C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2ED2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sdRJUHj2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeRk4MsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgG2Q22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Q21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:28:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507FC061794;
        Wed, 29 Jul 2020 09:28:27 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:28:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596040105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhpLJqQPGaTk5iJBTchoCQ5XDe/6CSbsrNiBAUuKfJY=;
        b=sdRJUHj2hTmR1GBtWIb6iRKrLCap/MYQnsRlbAzAS5biTzZSZCN9SbVlPODOvw0tTBDvgs
        9obZYYWEqNavrFk2kDPpTFwCPxiM/ZrjhPqgzfbrZ3G7vDAcNERfO/uuQBUkAOz4PVMEI6
        YbXpdeDMDQQXie0pCaJWpdHC+MGxpPsM60KKRCpwHbXw21sl3qyjOIyuKdFyxdjOdz6f5n
        bjXWZT71dH5SZBvFiA1cz6sHE7Dz3DECOw+kJ9BCBcPVJ3FnHdz/5OcmtKfkDqjE1nOB50
        EQ5L4MvmccJzdMl+0Eb+74ichSZDSYXqQEjgsoDDpKVi+dhuGNStrcPGrX4HlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596040105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhpLJqQPGaTk5iJBTchoCQ5XDe/6CSbsrNiBAUuKfJY=;
        b=UeRk4MsWMDCu7DgKD/LxYrHXGczByKJiN5X81Cht7UGTIwUklOrhQimMyH/lAz86G7pa8t
        cIkGuw8aQIcd5tBw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Refactor IRQ trace events fields into struct
Cc:     Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729110916.3920464-1-elver@google.com>
References: <20200729110916.3920464-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <159604010495.4006.2027942020957558221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9cd8b723f823d007bd70a3252e681fde07143f6d
Gitweb:        https://git.kernel.org/tip/9cd8b723f823d007bd70a3252e681fde07143f6d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 29 Jul 2020 13:09:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 29 Jul 2020 16:30:40 +02:00

lockdep: Refactor IRQ trace events fields into struct

Refactor the IRQ trace events fields, used for printing information
about the IRQ trace events, into a separate struct 'irqtrace_events'.

This improves readability by separating the information only used in
reporting, as well as enables (simplified) storing/restoring of
irqtrace_events snapshots.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200729110916.3920464-1-elver@google.com
---
 include/linux/irqflags.h | 13 +++++++++-
 include/linux/sched.h    | 11 +------
 kernel/fork.c            | 16 +++--------
 kernel/locking/lockdep.c | 58 ++++++++++++++++++++-------------------
 4 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5811ee8..bd5c557 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -33,6 +33,19 @@
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+/* Per-task IRQ trace events information. */
+struct irqtrace_events {
+	unsigned int	irq_events;
+	unsigned long	hardirq_enable_ip;
+	unsigned long	hardirq_disable_ip;
+	unsigned int	hardirq_enable_event;
+	unsigned int	hardirq_disable_event;
+	unsigned long	softirq_disable_ip;
+	unsigned long	softirq_enable_ip;
+	unsigned int	softirq_disable_event;
+	unsigned int	softirq_enable_event;
+};
+
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9a9d826..26adabe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/plist.h>
 #include <linux/hrtimer.h>
+#include <linux/irqflags.h>
 #include <linux/seccomp.h>
 #include <linux/nodemask.h>
 #include <linux/rcupdate.h>
@@ -980,17 +981,9 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	unsigned int			irq_events;
+	struct irqtrace_events		irqtrace;
 	unsigned int			hardirq_threaded;
-	unsigned long			hardirq_enable_ip;
-	unsigned long			hardirq_disable_ip;
-	unsigned int			hardirq_enable_event;
-	unsigned int			hardirq_disable_event;
 	u64				hardirq_chain_key;
-	unsigned long			softirq_disable_ip;
-	unsigned long			softirq_enable_ip;
-	unsigned int			softirq_disable_event;
-	unsigned int			softirq_enable_event;
 	int				softirqs_enabled;
 	int				softirq_context;
 	int				irq_config;
diff --git a/kernel/fork.c b/kernel/fork.c
index fc72f09..f831b82 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2035,17 +2035,11 @@ static __latent_entropy struct task_struct *copy_process(
 	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
-	p->irq_events = 0;
-	p->hardirq_enable_ip = 0;
-	p->hardirq_enable_event = 0;
-	p->hardirq_disable_ip = _THIS_IP_;
-	p->hardirq_disable_event = 0;
-	p->softirqs_enabled = 1;
-	p->softirq_enable_ip = _THIS_IP_;
-	p->softirq_enable_event = 0;
-	p->softirq_disable_ip = 0;
-	p->softirq_disable_event = 0;
-	p->softirq_context = 0;
+	memset(&p->irqtrace, 0, sizeof(p->irqtrace));
+	p->irqtrace.hardirq_disable_ip	= _THIS_IP_;
+	p->irqtrace.softirq_enable_ip	= _THIS_IP_;
+	p->softirqs_enabled		= 1;
+	p->softirq_context		= 0;
 #endif
 
 	p->pagefault_disabled = 0;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c9ea05e..7b58003 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3484,19 +3484,21 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 
 void print_irqtrace_events(struct task_struct *curr)
 {
-	printk("irq event stamp: %u\n", curr->irq_events);
+	const struct irqtrace_events *trace = &curr->irqtrace;
+
+	printk("irq event stamp: %u\n", trace->irq_events);
 	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
-		curr->hardirq_enable_event, (void *)curr->hardirq_enable_ip,
-		(void *)curr->hardirq_enable_ip);
+		trace->hardirq_enable_event, (void *)trace->hardirq_enable_ip,
+		(void *)trace->hardirq_enable_ip);
 	printk("hardirqs last disabled at (%u): [<%px>] %pS\n",
-		curr->hardirq_disable_event, (void *)curr->hardirq_disable_ip,
-		(void *)curr->hardirq_disable_ip);
+		trace->hardirq_disable_event, (void *)trace->hardirq_disable_ip,
+		(void *)trace->hardirq_disable_ip);
 	printk("softirqs last  enabled at (%u): [<%px>] %pS\n",
-		curr->softirq_enable_event, (void *)curr->softirq_enable_ip,
-		(void *)curr->softirq_enable_ip);
+		trace->softirq_enable_event, (void *)trace->softirq_enable_ip,
+		(void *)trace->softirq_enable_ip);
 	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
-		curr->softirq_disable_event, (void *)curr->softirq_disable_ip,
-		(void *)curr->softirq_disable_ip);
+		trace->softirq_disable_event, (void *)trace->softirq_disable_ip,
+		(void *)trace->softirq_disable_ip);
 }
 
 static int HARDIRQ_verbose(struct lock_class *class)
@@ -3699,7 +3701,7 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_on_prepare);
 
 void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct irqtrace_events *trace = &current->irqtrace;
 
 	if (unlikely(!debug_locks))
 		return;
@@ -3752,8 +3754,8 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 skip_checks:
 	/* we'll do an OFF -> ON transition: */
 	this_cpu_write(hardirqs_enabled, 1);
-	curr->hardirq_enable_ip = ip;
-	curr->hardirq_enable_event = ++curr->irq_events;
+	trace->hardirq_enable_ip = ip;
+	trace->hardirq_enable_event = ++trace->irq_events;
 	debug_atomic_inc(hardirqs_on_events);
 }
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
@@ -3763,8 +3765,6 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
  */
 void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
-	struct task_struct *curr = current;
-
 	if (unlikely(!debug_locks))
 		return;
 
@@ -3784,12 +3784,14 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
+		struct irqtrace_events *trace = &current->irqtrace;
+
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
 		this_cpu_write(hardirqs_enabled, 0);
-		curr->hardirq_disable_ip = ip;
-		curr->hardirq_disable_event = ++curr->irq_events;
+		trace->hardirq_disable_ip = ip;
+		trace->hardirq_disable_event = ++trace->irq_events;
 		debug_atomic_inc(hardirqs_off_events);
 	} else {
 		debug_atomic_inc(redundant_hardirqs_off);
@@ -3802,7 +3804,7 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_off);
  */
 void lockdep_softirqs_on(unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct irqtrace_events *trace = &current->irqtrace;
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
@@ -3814,7 +3816,7 @@ void lockdep_softirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->softirqs_enabled) {
+	if (current->softirqs_enabled) {
 		debug_atomic_inc(redundant_softirqs_on);
 		return;
 	}
@@ -3823,9 +3825,9 @@ void lockdep_softirqs_on(unsigned long ip)
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
-	curr->softirqs_enabled = 1;
-	curr->softirq_enable_ip = ip;
-	curr->softirq_enable_event = ++curr->irq_events;
+	current->softirqs_enabled = 1;
+	trace->softirq_enable_ip = ip;
+	trace->softirq_enable_event = ++trace->irq_events;
 	debug_atomic_inc(softirqs_on_events);
 	/*
 	 * We are going to turn softirqs on, so set the
@@ -3833,7 +3835,7 @@ void lockdep_softirqs_on(unsigned long ip)
 	 * enabled too:
 	 */
 	if (lockdep_hardirqs_enabled())
-		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
+		mark_held_locks(current, LOCK_ENABLED_SOFTIRQ);
 	lockdep_recursion_finish();
 }
 
@@ -3842,8 +3844,6 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
-	struct task_struct *curr = current;
-
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
@@ -3853,13 +3853,15 @@ void lockdep_softirqs_off(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->softirqs_enabled) {
+	if (current->softirqs_enabled) {
+		struct irqtrace_events *trace = &current->irqtrace;
+
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
-		curr->softirqs_enabled = 0;
-		curr->softirq_disable_ip = ip;
-		curr->softirq_disable_event = ++curr->irq_events;
+		current->softirqs_enabled = 0;
+		trace->softirq_disable_ip = ip;
+		trace->softirq_disable_event = ++trace->irq_events;
 		debug_atomic_inc(softirqs_off_events);
 		/*
 		 * Whoops, we wanted softirqs off, so why aren't they?
