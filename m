Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7022DC18E5C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52815208CD
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCHXYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgCHXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:56 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gj-00035b-ST; Mon, 09 Mar 2020 00:23:39 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3DE491040AE;
        Mon,  9 Mar 2020 00:23:30 +0100 (CET)
Message-Id: <20200308222609.932307492@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:09 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 10/13] x86/entry/common: Split prepare_exit_to_usermode() and syscall_return_slowpath()
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

Split the functions into traceable and probale parts and a part protected
from instrumentation.

This is required because after calling user_exit_irqsoff() kprobes and
tracepoints/function entry/exit which can be utilized by e.g. BPF are not
longer safe vs. RCU.

Preparatory step to move irq flags tracing to C code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch to reduce the churn
---
 arch/x86/entry/common.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -206,7 +206,7 @@ static void exit_to_usermode_loop(struct
 }
 
 /* Called with IRQs disabled. */
-__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
+static noinline void __prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags;
@@ -245,11 +245,16 @@ static void exit_to_usermode_loop(struct
 	 */
 	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
 #endif
+}
 
-	user_enter_irqoff();
+__visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
+{
+	__prepare_exit_to_usermode(regs);
 
+	user_enter_irqoff();
 	mds_user_clear_cpu_buffers();
 }
+NOKPROBE_SYMBOL(prepare_exit_to_usermode);
 
 #define SYSCALL_EXIT_WORK_FLAGS				\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
@@ -277,11 +282,7 @@ static void syscall_slow_exit_work(struc
 		tracehook_report_syscall_exit(regs, step);
 }
 
-/*
- * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
- * state such that we can immediately switch to user mode.
- */
-__visible inline void syscall_return_slowpath(struct pt_regs *regs)
+static void __syscall_return_slowpath(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags = READ_ONCE(ti->flags);
@@ -302,8 +303,18 @@ static void syscall_slow_exit_work(struc
 		syscall_slow_exit_work(regs, cached_flags);
 
 	local_irq_disable();
+}
+
+/*
+ * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
+ * state such that we can immediately switch to user mode.
+ */
+__visible inline notrace void syscall_return_slowpath(struct pt_regs *regs)
+{
+	__syscall_return_slowpath(regs);
 	prepare_exit_to_usermode(regs);
 }
+NOKPROBE_SYMBOL(syscall_return_slowpath);
 
 #ifdef CONFIG_X86_64
 static __always_inline

