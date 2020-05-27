Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22934C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA2E21531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbgE0INk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgE0ILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BCEC061A0F;
        Wed, 27 May 2020 01:11:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAH-0002YT-Ga; Wed, 27 May 2020 10:11:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D91231C03A9;
        Wed, 27 May 2020 10:11:51 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:51 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/irq: Rework handle_irq() for 64-bit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202118.889972748@linutronix.de>
References: <20200521202118.889972748@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711175.17951.6360504740403837337.tip-bot2@tip-bot2>
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

Commit-ID:     9fe3411558d31f9489cd58400b2f508a98dc13a5
Gitweb:        https://git.kernel.org/tip/9fe3411558d31f9489cd58400b2f508a98dc13a5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/irq: Rework handle_irq() for 64-bit

To consolidate the interrupt entry/exit code vs. the other exceptions
make handle_irq() and inline and handle both 64-bit and 32-bit mode.

Preparatory change to move irq stack switching for 64-bit to C which allows
to consolidate the entry exit handling by reusing the idtentry machinery
both in ASM and C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202118.889972748@linutronix.de
---
 arch/x86/include/asm/irq.h |  2 +-
 arch/x86/kernel/irq.c      | 11 ++++++++++-
 arch/x86/kernel/irq_32.c   |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 74690a3..67aa1e2 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -34,7 +34,7 @@ extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 extern void (*x86_platform_ipi_callback)(void);
 extern void native_init_IRQ(void);
 
-extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
+extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c766936..5495ea4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 
+#include <asm/irq_stack.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/irq.h>
@@ -221,6 +222,14 @@ u64 arch_irq_stat(void)
 	return sum;
 }
 
+static __always_inline void handle_irq(struct irq_desc *desc,
+				       struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_X86_64))
+		run_on_irqstack_cond(desc->handle_irq, desc, regs);
+	else
+		__handle_irq(desc, regs);
+}
 
 /*
  * do_IRQ handles all normal device IRQ's (the special
@@ -246,7 +255,7 @@ __visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		if (IS_ENABLED(CONFIG_X86_32))
-			handle_irq(desc, regs);
+			__handle_irq(desc, regs);
 		else
 			generic_handle_irq_desc(desc);
 	} else {
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index a759ca9..0b79efc 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -148,7 +148,7 @@ void do_softirq_own_stack(void)
 	call_on_stack(__do_softirq, isp);
 }
 
-void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
+void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
 	int overflow = check_stack_overflow();
 
