Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B0FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B673B207D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEPAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727899AbgEPAKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744BBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:47 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPI-0002FR-Qh; Sat, 16 May 2020 02:10:25 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 390F1FF834;
        Sat, 16 May 2020 02:10:24 +0200 (CEST)
Message-Id: <20200515235125.813664171@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:01 +0200
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 14/37] x86/entry: Remove the transition leftovers
References: <20200515234547.710474468@linutronix.de>
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


Now that all exceptions are converted over the sane flag is not longer
needed. Also the vector argument of idtentry_body on 64 bit is pointless
now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3c3ca6fbe58e..dd8064ffdf12 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -734,9 +734,8 @@
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Compatibility flag with 64bit
  */
-.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+.macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e061c48d0ae2..1157d63b3682 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -496,27 +496,14 @@ SYM_CODE_END(spurious_entries_start)
 
 /**
  * idtentry_body - Macro to emit code calling the C function
- * @vector:		Vector number
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Sane variant which handles irq tracing, context tracking in C
  */
-.macro idtentry_body vector cfunc has_error_code:req sane=0
+.macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
 	UNWIND_HINT_REGS
 
-	.if \sane == 0
-	TRACE_IRQS_OFF
-
-#ifdef CONFIG_CONTEXT_TRACKING
-	testb	$3, CS(%rsp)
-	jz	.Lfrom_kernel_no_ctxt_tracking_\@
-	CALL_enter_from_user_mode
-.Lfrom_kernel_no_ctxt_tracking_\@:
-#endif
-	.endif
-
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
 	.if \has_error_code == 1
@@ -526,11 +513,7 @@ SYM_CODE_END(spurious_entries_start)
 
 	call	\cfunc
 
-	.if \sane == 0
-	jmp	error_exit
-	.else
 	jmp	error_return
-	.endif
 .endm
 
 /**
@@ -539,12 +522,11 @@ SYM_CODE_END(spurious_entries_start)
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Sane variant which handles irq tracing, context tracking in C
  *
  * The macro emits code to set up the kernel context for straight forward
  * and simple IDT entries. No IST stack, no paranoid entry checks.
  */
-.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+.macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
@@ -567,7 +549,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \vector \cfunc \has_error_code \sane
+	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -642,7 +624,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector noist_\cfunc, has_error_code=0 sane=1
+	idtentry_body noist_\cfunc, has_error_code=0
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 4e4975df7ce0..3c239db60d7b 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -281,10 +281,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
  * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
  */
 #define DECLARE_IDTENTRY(vector, func)					\
-	idtentry vector asm_##func func has_error_code=0 sane=1
+	idtentry vector asm_##func func has_error_code=0
 
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
-	idtentry vector asm_##func func has_error_code=1 sane=1
+	idtentry vector asm_##func func has_error_code=1
 
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
@@ -322,7 +322,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /* XEN NMI and DB wrapper */
 #define DECLARE_IDTENTRY_XEN(vector, func)				\
-	idtentry vector asm_exc_xen##func exc_##func has_error_code=0 sane=1
+	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
 
 #endif /* __ASSEMBLY__ */
 

