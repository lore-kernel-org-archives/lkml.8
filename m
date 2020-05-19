Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A48EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465E920878
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgESUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgEST61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18FCC08C5C0;
        Tue, 19 May 2020 12:58:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Na-0008Bk-7J; Tue, 19 May 2020 21:58:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D98631C047E;
        Tue, 19 May 2020 21:58:21 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:21 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/nmi: Protect NMI entry against instrumentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.716186134@linutronix.de>
References: <20200505135314.716186134@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830178.17951.11427014884978582535.tip-bot2@tip-bot2>
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

Commit-ID:     3a301dc808b77c6ca25be35660f2fcb13389b038
Gitweb:        https://git.kernel.org/tip/3a301dc808b77c6ca25be35660f2fcb13389b038
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Apr 2020 15:55:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:10 +02:00

x86/nmi: Protect NMI entry against instrumentation

Mark all functions in the fragile code parts noinstr or force inlining so
they can't be instrumented.

Also make the hardware latency tracer invocation explicit outside of
non-instrumentable section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.716186134@linutronix.de


---
 arch/x86/include/asm/desc.h  |  8 ++++----
 arch/x86/kernel/cpu/common.c |  6 ++----
 arch/x86/kernel/nmi.c        | 15 +++++++++------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 085a2dd..d6c3d34 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -214,7 +214,7 @@ static inline void native_load_gdt(const struct desc_ptr *dtr)
 	asm volatile("lgdt %0"::"m" (*dtr));
 }
 
-static inline void native_load_idt(const struct desc_ptr *dtr)
+static __always_inline void native_load_idt(const struct desc_ptr *dtr)
 {
 	asm volatile("lidt %0"::"m" (*dtr));
 }
@@ -392,7 +392,7 @@ extern unsigned long system_vectors[];
 
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u32, debug_idt_ctr);
-static inline bool is_debug_idt_enabled(void)
+static __always_inline bool is_debug_idt_enabled(void)
 {
 	if (this_cpu_read(debug_idt_ctr))
 		return true;
@@ -400,7 +400,7 @@ static inline bool is_debug_idt_enabled(void)
 	return false;
 }
 
-static inline void load_debug_idt(void)
+static __always_inline void load_debug_idt(void)
 {
 	load_idt((const struct desc_ptr *)&debug_idt_descr);
 }
@@ -422,7 +422,7 @@ static inline void load_debug_idt(void)
  * that doesn't need to disable interrupts, as nothing should be
  * bothering the CPU then.
  */
-static inline void load_current_idt(void)
+static __always_inline void load_current_idt(void)
 {
 	if (is_debug_idt_enabled())
 		load_debug_idt();
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb8..6751b81 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1692,21 +1692,19 @@ void syscall_init(void)
 DEFINE_PER_CPU(int, debug_stack_usage);
 DEFINE_PER_CPU(u32, debug_idt_ctr);
 
-void debug_stack_set_zero(void)
+noinstr void debug_stack_set_zero(void)
 {
 	this_cpu_inc(debug_idt_ctr);
 	load_current_idt();
 }
-NOKPROBE_SYMBOL(debug_stack_set_zero);
 
-void debug_stack_reset(void)
+noinstr void debug_stack_reset(void)
 {
 	if (WARN_ON(!this_cpu_read(debug_idt_ctr)))
 		return;
 	if (this_cpu_dec_return(debug_idt_ctr) == 0)
 		load_current_idt();
 }
-NOKPROBE_SYMBOL(debug_stack_reset);
 
 #else	/* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d55e448..d18ec18 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -307,7 +307,7 @@ NOKPROBE_SYMBOL(unknown_nmi_error);
 static DEFINE_PER_CPU(bool, swallow_nmi);
 static DEFINE_PER_CPU(unsigned long, last_nmi_rip);
 
-static void default_do_nmi(struct pt_regs *regs)
+static noinstr void default_do_nmi(struct pt_regs *regs)
 {
 	unsigned char reason = 0;
 	int handled;
@@ -333,6 +333,8 @@ static void default_do_nmi(struct pt_regs *regs)
 
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
+	instrumentation_begin();
+
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
 	if (handled) {
@@ -346,7 +348,7 @@ static void default_do_nmi(struct pt_regs *regs)
 		 */
 		if (handled > 1)
 			__this_cpu_write(swallow_nmi, true);
-		return;
+		goto out;
 	}
 
 	/*
@@ -378,7 +380,7 @@ static void default_do_nmi(struct pt_regs *regs)
 #endif
 		__this_cpu_add(nmi_stats.external, 1);
 		raw_spin_unlock(&nmi_reason_lock);
-		return;
+		goto out;
 	}
 	raw_spin_unlock(&nmi_reason_lock);
 
@@ -416,8 +418,10 @@ static void default_do_nmi(struct pt_regs *regs)
 		__this_cpu_add(nmi_stats.swallow, 1);
 	else
 		unknown_nmi_error(reason, regs);
+
+out:
+	instrumentation_end();
 }
-NOKPROBE_SYMBOL(default_do_nmi);
 
 /*
  * NMIs can page fault or hit breakpoints which will cause it to lose
@@ -489,7 +493,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_cr2);
  */
 static DEFINE_PER_CPU(int, update_debug_stack);
 
-static bool notrace is_debug_stack(unsigned long addr)
+static noinstr bool is_debug_stack(unsigned long addr)
 {
 	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
 	unsigned long top = CEA_ESTACK_TOP(cs, DB);
@@ -504,7 +508,6 @@ static bool notrace is_debug_stack(unsigned long addr)
 	 */
 	return addr >= bot && addr < top;
 }
-NOKPROBE_SYMBOL(is_debug_stack);
 #endif
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
