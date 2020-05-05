Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9839C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA41B206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgEEOPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729797AbgEEOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2DC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLe-0001Lf-Np; Tue, 05 May 2020 16:15:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 026EDFFC8D;
        Tue,  5 May 2020 16:15:02 +0200 (CEST)
Message-Id: <20200505134904.166735365@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:03 +0200
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
Subject: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT entry stubs
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

From: Thomas Gleixner <tglx@linutronix.de>

32 and 64 bit have unnecessary different ways to populate the exception
entry code. Provide a idtentry macro which allows to consolidate all of
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
V3: Remove the INVD bug asm. Can be done in C (Brian)
---
 arch/x86/entry/entry_32.S |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -44,6 +44,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/frame.h>
+#include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 
 #include "calling.h"
@@ -726,6 +727,31 @@
 
 .Lend_\@:
 .endm
+
+/**
+ * idtentry - Macro to generate entry stubs for simple IDT entries
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ * @has_error_code:	Hardware pushed error code on stack
+ * @sane:		Compatibility flag with 64bit
+ */
+.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+SYM_CODE_START(\asmsym)
+	ASM_CLAC
+	cld
+
+	.if \has_error_code == 0
+		pushl	$0		/* Clear the error code */
+	.endif
+
+	/* Push the C-function address into the GS slot */
+	pushl	$\cfunc
+	/* Invoke the common exception entry */
+	jmp	handle_exception
+SYM_CODE_END(\asmsym)
+.endm
+
 /*
  * %eax: prev task
  * %edx: next task
@@ -1517,6 +1543,48 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exce
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)
 
+SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
+	/* the function address is in %gs's slot on the stack */
+	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
+	ENCODE_FRAME_POINTER
+
+	/* fixup %gs */
+	GS_TO_REG %ecx
+	movl	PT_GS(%esp), %edi		# get the function address
+	REG_TO_PTGS %ecx
+	SET_KERNEL_GS %ecx
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
+	movl	%esp, %eax			# pt_regs pointer
+	CALL_NOSPEC edi
+
+#ifdef CONFIG_VM86
+	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	movb	PT_CS(%esp), %al
+	andl	$(X86_EFLAGS_VM | SEGMENT_RPL_MASK), %eax
+#else
+	/*
+	 * We can be coming here from child spawned by kernel_thread().
+	 */
+	movl	PT_CS(%esp), %eax
+	andl	$SEGMENT_RPL_MASK, %eax
+#endif
+	cmpl	$USER_RPL, %eax			# returning to v8086 or userspace ?
+	jnb	ret_to_user
+
+	PARANOID_EXIT_TO_KERNEL_MODE
+	BUG_IF_WRONG_CR3
+	RESTORE_REGS 4
+	jmp	.Lirq_return
+
+ret_to_user:
+	movl	%esp, %eax
+	jmp	restore_all_switch_stack
+SYM_CODE_END(handle_exception)
+
 SYM_CODE_START(debug)
 	/*
 	 * Entry from sysenter is now handled in common_exception

