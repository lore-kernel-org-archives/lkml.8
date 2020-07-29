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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB4B2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEfYgmft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgG2LJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2LJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:09:49 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:09:49 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id u14so507112wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bGSTmhcT1A+YDeTIlpgIQTYHsX+reXp1jHDYNBfMLqs=;
        b=wEfYgmftUlVQDPJ5vKfutqdKnomE646n58JG26GTIAOWnnXv3fbHBOaRPbB/vAdY3r
         9ux8oQwv0jVPNkRh6Ehv3+cWk+yfzlVqp91jzz06XYPJf0zAs0s+2r02nszPliWfpZeM
         mvHPheD4BooGbOomJP9LW94h42iWUmWJdyEIThP1xXCuYW1BN1XsGyW/tnXgsM7P6roL
         BxMZZcw86VnsjimriVxczfjmVLIeAoHHHa4YZ2LAuMPp/eB4la/krd5tJXN4WY3aqmCT
         F3pPewSlBqWvKjE/hmlyuHhXM7NrKFx1Gv7pQ8TRQsoqz9dmTZ5YuJ5icJd99niVaq4Q
         RWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bGSTmhcT1A+YDeTIlpgIQTYHsX+reXp1jHDYNBfMLqs=;
        b=fhHXGozpeZ8mlDv7FxrOy5n/dWW4Hyrxz8j6h1fWHMan/S4rKZQRE1uVeLLa08TnxF
         I16iN+bvtomGk2gj+NGdPoTFxcM9YtYB6z0CPyxzFTJ9KBvKWzDWcgIMO3Jto1d5iwKC
         LEw1RhPBOjcRvY7kAyvODtTniXJNSIQR6Vchm9eEPNbICSodNcPyQbXZuNL6+cL40+O0
         hCqlS9YZUACM5zfMn8LM1HsVlbmDQRJwXYyOhOayWmafUjaS5/931p0OcW2dYwB+pwIW
         BcCtPqu6sLpN2OnXBet8shO6Nfk8JkRNBh6154yUXxY7E8uqKP34Vy39gAqbY2TwzlTL
         gNnA==
X-Gm-Message-State: AOAM532rjufCm3e/gKdW1GNzoav9aNfwHZnPD6kK/ys0T3uzxNkP2Ttn
        0d9zz0KfZAUFFIwp7v+5+oPWZVWQQA==
X-Google-Smtp-Source: ABdhPJw704xDOuCVXNA3KSeyFElp7GhG4j5AYM0+u9Y70NGEXaWHN6LIj4Si7euDlrErdXEBMCUtu4GlbQ==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr8164909wmj.124.1596020987677;
 Wed, 29 Jul 2020 04:09:47 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:09:15 +0200
Message-Id: <20200729110916.3920464-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH tip/locking/core v2 1/2] lockdep: Refactor IRQ trace events
 fields into struct
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

Refactor the IRQ trace events fields, used for printing information
about the IRQ trace events, into a separate struct 'irqtrace_events'.

This improves readability by separating the information only used in
reporting, as well as enables (simplified) storing/restoring of
irqtrace_events snapshots.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Introduce patch, as pre-requisite to "kcsan: Improve IRQ state trace
  reporting".
---
 include/linux/irqflags.h | 13 +++++++++
 include/linux/sched.h    | 11 ++------
 kernel/fork.c            | 16 ++++-------
 kernel/locking/lockdep.c | 58 +++++++++++++++++++++-------------------
 4 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5811ee8a5cd8..bd5c55755447 100644
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
index 8d1de021b315..52e0fdd6a555 100644
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
index 70d9d0a4de2a..56a640799680 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2035,17 +2035,11 @@ static __latent_entropy struct task_struct *copy_process(
 	seqcount_init(&p->mems_allowed_seq);
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
index c9ea05edce25..7b5800374c40 100644
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
-- 
2.28.0.rc0.142.g3c755180ce-goog

