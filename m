Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4227C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F55C2465D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgBYXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:25:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55518 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgBYXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja3-0004Yw-V5; Wed, 26 Feb 2020 00:25:36 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8EBFC1039F7;
        Wed, 26 Feb 2020 00:25:32 +0100 (CET)
Message-Id: <20200225221305.390667997@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:03 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 2/8] x86/entry/common: Consolidate syscall entry code
References: <20200225220801.571835584@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All syscall entry points call enter_from_user_mode() and
local_irq_enable(). Move that into an inline helper so the interrupt
tracing can be moved into that helper later instead of sprinkling
it all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,6 +49,18 @@
 static inline void enter_from_user_mode(void) {}
 #endif
 
+/*
+ * All syscall entry variants call with interrupts disabled.
+ *
+ * Invoke context tracking if enabled and enable interrupts for further
+ * processing.
+ */
+static __always_inline void syscall_entry_fixups(void)
+{
+	enter_from_user_mode();
+	local_irq_enable();
+}
+
 static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
 {
 #ifdef CONFIG_X86_64
@@ -279,13 +291,11 @@ static void syscall_slow_exit_work(struc
 }
 
 #ifdef CONFIG_X86_64
-__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+static __always_inline
+void do_syscall_64_irqs_on(unsigned long nr, struct pt_regs *regs)
 {
-	struct thread_info *ti;
+	struct thread_info *ti = current_thread_info();
 
-	enter_from_user_mode();
-	local_irq_enable();
-	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
@@ -303,6 +313,12 @@ static void syscall_slow_exit_work(struc
 
 	syscall_return_slowpath(regs);
 }
+
+__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+{
+	syscall_entry_fixups();
+	do_syscall_64_irqs_on(nr, regs);
+}
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
@@ -355,19 +371,17 @@ static __always_inline void do_syscall_3
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
-	enter_from_user_mode();
-	local_irq_enable();
+	syscall_entry_fixups();
 	do_syscall_32_irqs_on(regs);
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible long do_fast_syscall_32(struct pt_regs *regs)
+/* Fast syscall 32bit variant */
+static __always_inline long do_fast_syscall_32_irqs_on(struct pt_regs *regs)
 {
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 		vdso_image_32.sym_int80_landing_pad;
 
@@ -378,10 +392,6 @@ static __always_inline void do_syscall_3
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode();
-
-	local_irq_enable();
-
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (
 #ifdef CONFIG_X86_64
@@ -437,4 +447,12 @@ static __always_inline void do_syscall_3
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
 }
-#endif
+
+/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
+__visible long do_fast_syscall_32(struct pt_regs *regs)
+{
+	syscall_entry_fixups();
+	return do_fast_syscall_32_irqs_on(regs);
+}
+
+#endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */

