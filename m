Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F6C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FAA24684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgBYXaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55524 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgBYXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja6-0004aP-Gp; Wed, 26 Feb 2020 00:25:38 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 3C91D104097;
        Wed, 26 Feb 2020 00:25:33 +0100 (CET)
Message-Id: <20200225221305.719921962@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 5/8] x86/entry/common: Provide trace/kprobe safe exit to user space functions
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

Split prepare_enter_to_user_mode() and mark it notrace/noprobe so the irq
flags tracing on return can be put into it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -196,7 +196,7 @@ static void exit_to_usermode_loop(struct
 }
 
 /* Called with IRQs disabled. */
-__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
+static inline void __prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags;
@@ -241,6 +241,12 @@ static void exit_to_usermode_loop(struct
 	mds_user_clear_cpu_buffers();
 }
 
+__visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
+{
+	__prepare_exit_to_usermode(regs);
+}
+NOKPROBE_SYMBOL(prepare_exit_to_usermode);
+
 #define SYSCALL_EXIT_WORK_FLAGS				\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
 	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
@@ -271,7 +277,7 @@ static void syscall_slow_exit_work(struc
  * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
  * state such that we can immediately switch to user mode.
  */
-__visible inline void syscall_return_slowpath(struct pt_regs *regs)
+__visible inline notrace void syscall_return_slowpath(struct pt_regs *regs)
 {
 	struct thread_info *ti = current_thread_info();
 	u32 cached_flags = READ_ONCE(ti->flags);
@@ -292,8 +298,9 @@ static void syscall_slow_exit_work(struc
 		syscall_slow_exit_work(regs, cached_flags);
 
 	local_irq_disable();
-	prepare_exit_to_usermode(regs);
+	__prepare_exit_to_usermode(regs);
 }
+NOKPROBE_SYMBOL(syscall_return_slowpath);
 
 #ifdef CONFIG_X86_64
 static __always_inline
@@ -417,7 +424,7 @@ static __always_inline long do_fast_sysc
 		/* User code screwed up. */
 		local_irq_disable();
 		regs->ax = -EFAULT;
-		prepare_exit_to_usermode(regs);
+		__prepare_exit_to_usermode(regs);
 		return 0;	/* Keep it simple: use IRET. */
 	}
 

