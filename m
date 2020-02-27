Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2502BC52D22
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E1224691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbgB0OQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:16:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389389AbgB0OQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7JxF-0005AY-KQ; Thu, 27 Feb 2020 15:15:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4DAA81C2170;
        Thu, 27 Feb 2020 15:15:57 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:15:57 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/irq: Remove useless return value from do_IRQ()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200225220216.826870369@linutronix.de>
References: <20200225220216.826870369@linutronix.de>
MIME-Version: 1.0
Message-ID: <158281295706.28353.9151423427467602652.tip-bot2@tip-bot2>
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

Commit-ID:     17dbedb5da184b501c5c51fc78d1071005139e48
Gitweb:        https://git.kernel.org/tip/17dbedb5da184b501c5c51fc78d1071005139e48
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 22:36:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 27 Feb 2020 14:48:40 +01:00

x86/irq: Remove useless return value from do_IRQ()

Nothing is using it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200225220216.826870369@linutronix.de

---
 arch/x86/include/asm/irq.h | 2 +-
 arch/x86/kernel/irq.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index a176f61..72fba0e 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -36,7 +36,7 @@ extern void native_init_IRQ(void);
 
 extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible unsigned int do_IRQ(struct pt_regs *regs);
+extern __visible void do_IRQ(struct pt_regs *regs);
 
 extern void init_ISA_irqs(void);
 
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 21efee3..c7965ff 100644
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
@@ -263,7 +263,6 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	exiting_irq();
 
 	set_irq_regs(old_regs);
-	return 1;
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
