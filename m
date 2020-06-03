Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23751C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1E02068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgFCRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgFCRuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD30C08C5C3;
        Wed,  3 Jun 2020 10:50:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX5-0005yZ-VW; Wed, 03 Jun 2020 19:50:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 92EF91C0081;
        Wed,  3 Jun 2020 19:50:31 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:31 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: __always_inline irqflags for noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603114052.012171668@infradead.org>
References: <20200603114052.012171668@infradead.org>
MIME-Version: 1.0
Message-ID: <159120663146.17951.5262493946903596119.tip-bot2@tip-bot2>
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

Commit-ID:     43cea329af80b327cf0981df87fc26ce35d858f8
Gitweb:        https://git.kernel.org/tip/43cea329af80b327cf0981df87fc26ce35d858f8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:36 +02:00

x86/entry: __always_inline irqflags for noinstr

vmlinux.o: warning: objtool: lockdep_hardirqs_on()+0x65: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x5d: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x35: call to arch_local_irq_save() leaves .noinstr.text section
vmlinux.o: warning: objtool: check_preemption_disabled()+0x31: call to arch_local_save_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: check_preemption_disabled()+0x33: call to arch_irqs_disabled_flags() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x2f: call to native_irq_disable() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200603114052.012171668@infradead.org

---
 arch/x86/include/asm/irqflags.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8ddff8d..02a0cf5 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -17,7 +17,7 @@
 
 /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
 extern inline unsigned long native_save_fl(void);
-extern inline unsigned long native_save_fl(void)
+extern __always_inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
 
@@ -44,12 +44,12 @@ extern inline void native_restore_fl(unsigned long flags)
 		     :"memory", "cc");
 }
 
-static inline void native_irq_disable(void)
+static __always_inline void native_irq_disable(void)
 {
 	asm volatile("cli": : :"memory");
 }
 
-static inline void native_irq_enable(void)
+static __always_inline void native_irq_enable(void)
 {
 	asm volatile("sti": : :"memory");
 }
@@ -74,22 +74,22 @@ static inline __cpuidle void native_halt(void)
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
-static inline notrace unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return native_save_fl();
 }
 
-static inline notrace void arch_local_irq_restore(unsigned long flags)
+static __always_inline void arch_local_irq_restore(unsigned long flags)
 {
 	native_restore_fl(flags);
 }
 
-static inline notrace void arch_local_irq_disable(void)
+static __always_inline void arch_local_irq_disable(void)
 {
 	native_irq_disable();
 }
 
-static inline notrace void arch_local_irq_enable(void)
+static __always_inline void arch_local_irq_enable(void)
 {
 	native_irq_enable();
 }
@@ -115,7 +115,7 @@ static inline __cpuidle void halt(void)
 /*
  * For spinlocks, etc:
  */
-static inline notrace unsigned long arch_local_irq_save(void)
+static __always_inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags = arch_local_save_flags();
 	arch_local_irq_disable();
@@ -159,12 +159,12 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #endif /* CONFIG_PARAVIRT_XXL */
 
 #ifndef __ASSEMBLY__
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static __always_inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & X86_EFLAGS_IF);
 }
 
-static inline int arch_irqs_disabled(void)
+static __always_inline int arch_irqs_disabled(void)
 {
 	unsigned long flags = arch_local_save_flags();
 
