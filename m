Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA4DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C406C20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgEEOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729782AbgEEOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46212C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:18 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLd-0001Kl-9w; Tue, 05 May 2020 16:15:01 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id BCEFAFFC8D;
        Tue,  5 May 2020 16:15:00 +0200 (CEST)
Message-Id: <20200505134904.058904490@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:02 +0200
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
Subject: [patch V4 part 3 08/29] x86/entry/64: Provide sane error entry/exit
References: <20200505134354.774943181@linutronix.de>
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

For gradual conversion provide a macro parameter and the required code
which allows to handle instrumentation and interrupt flags tracking in C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -500,8 +500,9 @@ SYM_CODE_END(spurious_entries_start)
  * @vector:		Vector number
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
+ * @sane:		Sane variant which handles irq tracing, context tracking in C
  */
-.macro idtentry_body vector cfunc has_error_code:req
+.macro idtentry_body vector cfunc has_error_code:req sane=0
 
 	call	error_entry
 	UNWIND_HINT_REGS
@@ -515,6 +516,7 @@ SYM_CODE_END(spurious_entries_start)
 		GET_CR2_INTO(%r12);
 	.endif
 
+	.if \sane == 0
 	TRACE_IRQS_OFF
 
 #ifdef CONFIG_CONTEXT_TRACKING
@@ -523,6 +525,7 @@ SYM_CODE_END(spurious_entries_start)
 	CALL_enter_from_user_mode
 .Lfrom_kernel_no_ctxt_tracking_\@:
 #endif
+	.endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
@@ -539,7 +542,11 @@ SYM_CODE_END(spurious_entries_start)
 
 	call	\cfunc
 
+	.if \sane == 0
 	jmp	error_exit
+	.else
+	jmp	error_return
+	.endif
 .endm
 
 /**
@@ -548,11 +555,12 @@ SYM_CODE_END(spurious_entries_start)
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
+ * @sane:		Sane variant which handles irq tracing, context tracking in C
  *
  * The macro emits code to set up the kernel context for straight forward
  * and simple IDT entries. No IST stack, no paranoid entry checks.
  */
-.macro idtentry vector asmsym cfunc has_error_code:req
+.macro idtentry vector asmsym cfunc has_error_code:req sane=0
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
@@ -575,7 +583,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \vector \cfunc \has_error_code
+	idtentry_body \vector \cfunc \has_error_code \sane
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -1405,6 +1413,14 @@ SYM_CODE_START_LOCAL(error_exit)
 	jmp	.Lretint_user
 SYM_CODE_END(error_exit)
 
+SYM_CODE_START_LOCAL(error_return)
+	UNWIND_HINT_REGS
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
+	testb	$3, CS(%rsp)
+	jz	restore_regs_and_return_to_kernel
+	jmp	swapgs_restore_regs_and_return_to_usermode
+SYM_CODE_END(error_return)
+
 /*
  * Runs on exception stack.  Xen PV does not go through this path at all,
  * so we can use real assembly here.

