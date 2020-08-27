Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE85C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD4420825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQB6dctE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wl1BNZCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgH0H46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgH0Hy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:27 -0400
Date:   Thu, 27 Aug 2020 07:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6tcGtJrvRcbQhtixqj4vbfrcEniRUb9RXpR3YqCwCo=;
        b=TQB6dctEgX0fc8AumrRync/Zakej1MV8+C5SdB3pfIiqbvm9FXGb0p9QXojiHnpHW8kgs7
        s9D0mf98P3DDjWTwtaxrTYTl70PEZYBvhAShWuprkGJJXeXVynFhuUyKXE4zt0MFuxiLD/
        79wuAEeezkyjkX+nBPttwGTYUMy7Vm6S5m/C8GKILD4WqTtfygzAonkBxHq0NETsexpZPi
        bac/bKso9X8/aFQnGTYv7QUzqowWKeWLGKNjq8W+x40cRmElfI4KUdQAF+p0SWXCQJMdcI
        hNn+SNdCSMocakz/Ch8shNQ7feSiBGfg65xzlZedTUL9VqHfZM5KrF89DcYYMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6tcGtJrvRcbQhtixqj4vbfrcEniRUb9RXpR3YqCwCo=;
        b=Wl1BNZCEH17lXb7fiw6YMVZ+QKNrI6EiUgUned3CXaSaiecJCXQT442N0omRBF5gMGBrOH
        dpPVpFKbfK+5YPBQ==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Only trace IRQ edges
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
References: <20200723105615.1268126-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486478.20229.13478044751401692917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     044d0d6de9f50192f9697583504a382347ee95ca
Gitweb:        https://git.kernel.org/tip/044d0d6de9f50192f9697583504a382347ee95ca
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Thu, 23 Jul 2020 20:56:14 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:56 +02:00

lockdep: Only trace IRQ edges

Problem:

  raw_local_irq_save(); // software state on
  local_irq_save(); // software state off
  ...
  local_irq_restore(); // software state still off, because we don't enable IRQs
  raw_local_irq_restore(); // software state still off, *whoopsie*

existing instances:

 - lock_acquire()
     raw_local_irq_save()
     __lock_acquire()
       arch_spin_lock(&graph_lock)
         pv_wait() := kvm_wait() (same or worse for Xen/HyperV)
           local_irq_save()

 - trace_clock_global()
     raw_local_irq_save()
     arch_spin_lock()
       pv_wait() := kvm_wait()
	 local_irq_save()

 - apic_retrigger_irq()
     raw_local_irq_save()
     apic->send_IPI() := default_send_IPI_single_phys()
       local_irq_save()

Possible solutions:

 A) make it work by enabling the tracing inside raw_*()
 B) make it work by keeping tracing disabled inside raw_*()
 C) call it broken and clean it up now

Now, given that the only reason to use the raw_* variant is because you don't
want tracing. Therefore A) seems like a weird option (although it can be done).
C) is tempting, but OTOH it ends up converting a _lot_ of code to raw just
because there is one raw user, this strips the validation/tracing off for all
the other users.

So we pick B) and declare any code that ends up doing:

	raw_local_irq_save()
	local_irq_save()
	lockdep_assert_irqs_disabled();

broken. AFAICT this problem has existed forever, the only reason it came
up is because commit: 859d069ee1dd ("lockdep: Prepare for NMI IRQ
state tracking") changed IRQ tracing vs lockdep recursion and the
first instance is fairly common, the other cases hardly ever happen.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[rewrote changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200723105615.1268126-1-npiggin@gmail.com
---
 arch/powerpc/include/asm/hw_irq.h | 11 ++++-------
 include/linux/irqflags.h          | 15 +++++++--------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3a0db7b..35060be 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
 #define powerpc_local_irq_pmu_save(flags)			\
 	 do {							\
 		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
+		if (!raw_irqs_disabled_flags(flags))		\
+			trace_hardirqs_off();			\
 	} while(0)
 #define powerpc_local_irq_pmu_restore(flags)			\
 	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
+		if (!raw_irqs_disabled_flags(flags))		\
 			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
+		raw_local_irq_pmu_restore(flags);		\
 	} while(0)
 #else
 #define powerpc_local_irq_pmu_save(flags)			\
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 00d553d..3ed4e87 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -191,25 +191,24 @@ do {						\
 
 #define local_irq_disable()				\
 	do {						\
+		bool was_disabled = raw_irqs_disabled();\
 		raw_local_irq_disable();		\
-		trace_hardirqs_off();			\
+		if (!was_disabled)			\
+			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
+		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+		raw_local_irq_restore(flags);		\
 	} while (0)
 
 #define safe_halt()				\
