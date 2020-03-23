Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD5BC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F73620724
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584934343;
	bh=+sebJlZmwTkQ0Lv4nHLq6RFly3APM4ysfV4bs3HL/GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xbANFad6zUnHwRVabekBirtNg/Xw20ydlxKXUotDjB+A5ybuECj1JpYgspfw37ZaL
	 S2UiBnbfg96MnAOP2N81848+piLqRssB0+lAFVc75LkM3KTnP6ByojCOXowwE+y/I3
	 hJnekNQbpUwXAFjMSfNU87x+dwSMxLPM9Q9YuehM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCWDcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgCWDcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:32:22 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D62A20732;
        Mon, 23 Mar 2020 03:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584934341;
        bh=+sebJlZmwTkQ0Lv4nHLq6RFly3APM4ysfV4bs3HL/GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJ84vxTEexH3ovRNg2wEpi8BJlwjpEHbJNjVEB6WPaz4Va2t4UsdRXht5oAHC2oO3
         dCbKOYzSbyxOt9Vrf2nSPFEaxs88NAZHQHUMXSdCKL/d07AatWmoeVBntjCEJU+d+g
         XqBwxOHmMVjLgXSqJbl2TqHT92baR2MdNKK8VmBE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/3] lockdep/irq: Be more strict about IRQ-threadable code end
Date:   Mon, 23 Mar 2020 04:32:05 +0100
Message-Id: <20200323033207.32370-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323033207.32370-1-frederic@kernel.org>
References: <20200323033207.32370-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct task_struct::hardirq_threaded is set before the IRQ handler
is invoked but is not cleared back explicitly. This is done on the next
time trace_hardirq_enter() is called, which may be at best after softirq
execution, if any, or at worst by the next hardirq entry.

Besides being confusing, this exposes all the code in hardirq that
follows the handler outside lockdep vigilance concerning LD_WAIT_CONFIG
locking.

Lets rather be paranoid and make sure we properly define the end of an
LD_WAIT_CONFIG safe block.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqflags.h | 22 +++++++++++++++-------
 kernel/irq/handle.c      | 10 ++++++++--
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index a16adbb58f66..28481702460e 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -37,17 +37,24 @@
 # define trace_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define trace_hardirq_enter()			\
 do {						\
-	if (!current->hardirq_context++)	\
-		current->hardirq_threaded = 0;	\
-} while (0)
-# define trace_hardirq_threaded()		\
-do {						\
-	current->hardirq_threaded = 1;		\
+	current->hardirq_context++;		\
 } while (0)
+
 # define trace_hardirq_exit()			\
 do {						\
 	current->hardirq_context--;		\
 } while (0)
+
+# define trace_hardirq_threaded()		\
+do {						\
+	current->hardirq_threaded = 1;		\
+} while (0)
+
+# define trace_hardirq_unthreaded()		\
+do {						\
+	current->hardirq_threaded = 0;		\
+} while (0)
+
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
@@ -98,8 +105,9 @@ do {						\
 # define trace_hardirqs_enabled(p)	0
 # define trace_softirqs_enabled(p)	0
 # define trace_hardirq_enter()		do { } while (0)
-# define trace_hardirq_threaded()	do { } while (0)
 # define trace_hardirq_exit()		do { } while (0)
+# define trace_hardirq_threaded()	do { } while (0)
+# define trace_hardirq_unthreaded()	do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
 # define lockdep_softirq_exit()		do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 16ee716e8291..39d6cf9f5853 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -144,18 +144,24 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 
 	for_each_action_of_desc(desc, action) {
 		irqreturn_t res;
+		bool threadable;
 
 		/*
 		 * If this IRQ would be threaded under force_irqthreads, mark it so.
 		 */
-		if (irq_settings_can_thread(desc) &&
-		    !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)))
+		threadable = (irq_settings_can_thread(desc) &&
+			      !(action->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT)));
+
+		if (threadable)
 			trace_hardirq_threaded();
 
 		trace_irq_handler_entry(irq, action);
 		res = action->handler(irq, action->dev_id);
 		trace_irq_handler_exit(irq, action, res);
 
+		if (threadable)
+			trace_hardirq_unthreaded();
+
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
 			      irq, action->handler))
 			local_irq_disable();
-- 
2.25.0

