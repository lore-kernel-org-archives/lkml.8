Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5133C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4824684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgBYXaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgBYXZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:55 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja2-0004Xx-3A; Wed, 26 Feb 2020 00:25:34 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2F30F10408E;
        Wed, 26 Feb 2020 00:25:29 +0100 (CET)
Message-Id: <20200225220216.826870369@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:43 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 07/10] x86/irq: Remove useless return value from do_IRQ()
References: <20200225213636.689276920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing is using it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq.h |    2 +-
 arch/x86/kernel/irq.c      |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -36,7 +36,7 @@ extern void native_init_IRQ(void);
 
 extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible unsigned int do_IRQ(struct pt_regs *regs);
+extern __visible void do_IRQ(struct pt_regs *regs);
 
 extern void init_ISA_irqs(void);
 
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -230,7 +230,7 @@ u64 arch_irq_stat(void)
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-__visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
+__visible void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc * desc;
@@ -263,7 +263,6 @@ u64 arch_irq_stat(void)
 	exiting_irq();
 
 	set_irq_regs(old_regs);
-	return 1;
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC

