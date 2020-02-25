Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD8C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C0222464
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgBYX0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgBYX0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:00 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jZw-0004W2-J0; Wed, 26 Feb 2020 00:25:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 160EA1039F7;
        Wed, 26 Feb 2020 00:25:28 +0100 (CET)
Message-Id: <20200225220216.315548935@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:38 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [patch 02/10] x86/mce: Disable tracing and kprobes on do_machine_check()
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

From: Andy Lutomirski <luto@kernel.org>

do_machine_check() can be raised in almost any context including the most
fragile ones. Prevent kprobes and tracing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/traps.h   |    3 ---
 arch/x86/kernel/cpu/mce/core.c |   12 ++++++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -88,9 +88,6 @@ dotraplinkage void do_page_fault(struct
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
-#ifdef CONFIG_X86_MCE
-dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
-#endif
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1213,8 +1213,14 @@ static void __mc_scan_banks(struct mce *
  * On Intel systems this is entered on all CPUs in parallel through
  * MCE broadcast. However some CPUs might be broken beyond repair,
  * so be always careful when synchronizing with others.
+ *
+ * Tracing and kprobes are disabled: if we interrupted a kernel context
+ * with IF=1, we need to minimize stack usage.  There are also recursion
+ * issues: if the machine check was due to a failure of the memory
+ * backing the user stack, tracing that reads the user stack will cause
+ * potentially infinite recursion.
  */
-void do_machine_check(struct pt_regs *regs, long error_code)
+void notrace do_machine_check(struct pt_regs *regs, long error_code)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
 	ist_exit(regs);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
+NOKPROBE_SYMBOL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)
@@ -1892,10 +1899,11 @@ static void unexpected_machine_check(str
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
-dotraplinkage void do_mce(struct pt_regs *regs, long error_code)
+dotraplinkage notrace void do_mce(struct pt_regs *regs, long error_code)
 {
 	machine_check_vector(regs, error_code);
 }
+NOKPROBE_SYMBOL(do_mce);
 
 /*
  * Called for each booted CPU to set up machine checks.

