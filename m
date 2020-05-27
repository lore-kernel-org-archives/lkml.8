Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7816AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587FD21531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgE0INY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgE0IMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC13DC03E97D;
        Wed, 27 May 2020 01:12:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAO-0002d5-B5; Wed, 27 May 2020 10:12:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4ED311C03A9;
        Wed, 27 May 2020 10:11:57 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:56 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Move do_softirq_own_stack() to C
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.870911120@linutronix.de>
References: <20200521202117.870911120@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711699.17951.2241474367551072856.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4f41db23ef2593aec26e23e7f4bacc620e82f545
Gitweb:        https://git.kernel.org/tip/4f41db23ef2593aec26e23e7f4bacc620e82f545
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/entry/64: Move do_softirq_own_stack() to C

The first step to get rid of the ENTER/LEAVE_IRQ_STACK ASM macro maze.  Use
the new C code helpers to move do_softirq_own_stack() out of ASM code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.870911120@linutronix.de
---
 arch/x86/entry/entry_64.S | 13 -------------
 arch/x86/kernel/irq_64.c  |  6 ++++++
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1597370..6b518be 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1145,19 +1145,6 @@ SYM_FUNC_START(asm_call_on_stack)
 	ret
 SYM_FUNC_END(asm_call_on_stack)
 
-/* Call softirq on interrupt stack. Interrupts are off. */
-.pushsection .text, "ax"
-SYM_FUNC_START(do_softirq_own_stack)
-	pushq	%rbp
-	mov	%rsp, %rbp
-	ENTER_IRQ_STACK regs=0 old_rsp=%r11
-	call	__do_softirq
-	LEAVE_IRQ_STACK regs=0
-	leaveq
-	ret
-SYM_FUNC_END(do_softirq_own_stack)
-.popsection
-
 #ifdef CONFIG_XEN_PV
 /*
  * A note on the "critical region" in our callback handler.
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 12df3a4..d5f9df4 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/irq_stack.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
@@ -70,3 +71,8 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return 0;
 	return map_irq_stack(cpu);
 }
+
+void do_softirq_own_stack(void)
+{
+	run_on_irqstack_cond(__do_softirq, NULL, NULL);
+}
