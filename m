Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A81C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AA820838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgEEOQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730071AbgEEOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMc-00022P-4z; Tue, 05 May 2020 16:16:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 969F6FFC8D;
        Tue,  5 May 2020 16:16:01 +0200 (CEST)
Message-Id: <20200505135314.716186134@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 14/24] x86/nmi: Protect NMI entry against instrumentation
References: <20200505134926.578885807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark all functions in the fragile code parts noinstr or force inlining so
they can't be instrumented.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/desc.h  |    8 ++++----
 arch/x86/kernel/cpu/common.c |    6 ++----
 arch/x86/kernel/nmi.c        |   10 ++++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -214,7 +214,7 @@ static inline void native_load_gdt(const
 	asm volatile("lgdt %0"::"m" (*dtr));
 }
 
-static inline void native_load_idt(const struct desc_ptr *dtr)
+static __always_inline void native_load_idt(const struct desc_ptr *dtr)
 {
 	asm volatile("lidt %0"::"m" (*dtr));
 }
@@ -393,7 +393,7 @@ extern unsigned long system_vectors[];
 
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u32, debug_idt_ctr);
-static inline bool is_debug_idt_enabled(void)
+static __always_inline bool is_debug_idt_enabled(void)
 {
 	if (this_cpu_read(debug_idt_ctr))
 		return true;
@@ -401,7 +401,7 @@ static inline bool is_debug_idt_enabled(
 	return false;
 }
 
-static inline void load_debug_idt(void)
+static __always_inline void load_debug_idt(void)
 {
 	load_idt((const struct desc_ptr *)&debug_idt_descr);
 }
@@ -423,7 +423,7 @@ static inline void load_debug_idt(void)
  * that doesn't need to disable interrupts, as nothing should be
  * bothering the CPU then.
  */
-static inline void load_current_idt(void)
+static __always_inline void load_current_idt(void)
 {
 	if (is_debug_idt_enabled())
 		load_debug_idt();
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
@@ -333,6 +333,7 @@ static void default_do_nmi(struct pt_reg
 
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
+	instr_begin();
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
 	if (handled) {
@@ -346,6 +347,7 @@ static void default_do_nmi(struct pt_reg
 		 */
 		if (handled > 1)
 			__this_cpu_write(swallow_nmi, true);
+		instr_end();
 		return;
 	}
 
@@ -378,6 +380,7 @@ static void default_do_nmi(struct pt_reg
 #endif
 		__this_cpu_add(nmi_stats.external, 1);
 		raw_spin_unlock(&nmi_reason_lock);
+		instr_end();
 		return;
 	}
 	raw_spin_unlock(&nmi_reason_lock);
@@ -416,8 +419,8 @@ static void default_do_nmi(struct pt_reg
 		__this_cpu_add(nmi_stats.swallow, 1);
 	else
 		unknown_nmi_error(reason, regs);
+	instr_end();
 }
-NOKPROBE_SYMBOL(default_do_nmi);
 
 /*
  * NMIs can page fault or hit breakpoints which will cause it to lose
@@ -489,7 +492,7 @@ static DEFINE_PER_CPU(unsigned long, nmi
  */
 static DEFINE_PER_CPU(int, update_debug_stack);
 
-static bool notrace is_debug_stack(unsigned long addr)
+static noinstr bool is_debug_stack(unsigned long addr)
 {
 	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
 	unsigned long top = CEA_ESTACK_TOP(cs, DB);
@@ -504,7 +507,6 @@ static bool notrace is_debug_stack(unsig
 	 */
 	return addr >= bot && addr < top;
 }
-NOKPROBE_SYMBOL(is_debug_stack);
 #endif
 
 DEFINE_IDTENTRY_NMI(exc_nmi)

