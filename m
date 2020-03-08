Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A42C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FA120866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgCHXXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:23:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgCHXXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:50 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gf-00033c-5F; Mon, 09 Mar 2020 00:23:33 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4DF891040A7;
        Mon,  9 Mar 2020 00:23:29 +0100 (CET)
Message-Id: <20200308222609.522613084@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:05 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 06/13] x86/entry/common: Mark syscall entry points notrace and NOKPROBE
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entry code has some limitations for instrumentation. Anything before
invoking enter_from_user_mode() cannot be probed because kprobes depend on
RCU and with NOHZ_FULL user mode can be accounted similar to idle from a
RCU point of view. enter_from_user_mode() calls into context tracking which
adjusts the RCU state.

A similar problem exists vs. function tracing. The function entry/exit
points can be used by BPF which again is not safe before CONTEXT_KERNEL has
been reached.

Mark the C-entry points for the various syscalls with notrace and
NOKPROBE_SYMBOL().

Note, that this still leaves the ASM invocations of trace_hardirqs_off()
unprotected. While this is safe vs. RCU at least from the ftrace POV, these
are trace points which can be utilized by BPF... This will be addressed in
later patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
V2: Amend changelog
---
 arch/x86/entry/common.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -315,11 +315,12 @@ void do_syscall_64_irqs_on(unsigned long
 	syscall_return_slowpath(regs);
 }
 
-__visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+__visible notrace void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	syscall_entry_apply_fixups();
 	do_syscall_64_irqs_on(nr, regs);
 }
+NOKPROBE_SYMBOL(do_syscall_64);
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
@@ -370,11 +371,12 @@ static __always_inline void do_syscall_3
 }
 
 /* Handles int $0x80 */
-__visible void do_int80_syscall_32(struct pt_regs *regs)
+__visible notrace void do_int80_syscall_32(struct pt_regs *regs)
 {
 	syscall_entry_apply_fixups();
 	do_syscall_32_irqs_on(regs);
 }
+NOKPROBE_SYMBOL(do_int80_syscall_32);
 
 /* Fast syscall 32bit variant */
 static __always_inline long do_fast_syscall_32_irqs_on(struct pt_regs *regs)
@@ -450,10 +452,11 @@ static __always_inline long do_fast_sysc
 }
 
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible long do_fast_syscall_32(struct pt_regs *regs)
+__visible notrace long do_fast_syscall_32(struct pt_regs *regs)
 {
 	syscall_entry_apply_fixups();
 	return do_fast_syscall_32_irqs_on(regs);
 }
+NOKPROBE_SYMBOL(do_fast_syscall_32);
 
 #endif /* CONFIG_X86_32 || CONFIG_IA32_EMULATION */

