Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C80C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C00620836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgEEOOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729597AbgEEOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636ADC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:33 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKt-0000ws-SM; Tue, 05 May 2020 16:14:16 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 483D0FFC8D;
        Tue,  5 May 2020 16:14:15 +0200 (CEST)
Message-Id: <20200505134340.320164650@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:14 +0200
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
Subject: [patch V4 part 2 02/18] x86/entry/32: Move non entry code into .text section
References: <20200505134112.272268764@linutronix.de>
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

All ASM code which is not part of the entry functionality can move out into
the .text section. No reason to keep it in the non-instrumentable entry
section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -729,7 +729,8 @@
 /*
  * %eax: prev task
  * %edx: next task
- */
+*/
+.pushsection .text, "ax"
 SYM_CODE_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
@@ -776,6 +777,7 @@ SYM_CODE_START(__switch_to_asm)
 
 	jmp	__switch_to
 SYM_CODE_END(__switch_to_asm)
+.popsection
 
 /*
  * The unwinder expects the last frame on the stack to always be at the same
@@ -784,6 +786,7 @@ SYM_CODE_END(__switch_to_asm)
  * asmlinkage function so its argument has to be pushed on the stack.  This
  * wrapper creates a proper "end of stack" frame header before the call.
  */
+.pushsection .text, "ax"
 SYM_FUNC_START(schedule_tail_wrapper)
 	FRAME_BEGIN
 
@@ -794,6 +797,8 @@ SYM_FUNC_START(schedule_tail_wrapper)
 	FRAME_END
 	ret
 SYM_FUNC_END(schedule_tail_wrapper)
+.popsection
+
 /*
  * A newly forked process directly context switches into this address.
  *
@@ -801,6 +806,7 @@ SYM_FUNC_END(schedule_tail_wrapper)
  * ebx: kernel thread func (NULL for user thread)
  * edi: kernel thread arg
  */
+.pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	call	schedule_tail_wrapper
 
@@ -825,6 +831,7 @@ SYM_CODE_START(ret_from_fork)
 	movl	$0, PT_EAX(%esp)
 	jmp	2b
 SYM_CODE_END(ret_from_fork)
+.popsection
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -1693,6 +1700,7 @@ SYM_CODE_START(general_protection)
 	jmp	common_exception
 SYM_CODE_END(general_protection)
 
+.pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
@@ -1703,3 +1711,4 @@ SYM_CODE_START(rewind_stack_do_exit)
 	call	do_exit
 1:	jmp 1b
 SYM_CODE_END(rewind_stack_do_exit)
+.popsection

