Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A3C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115F6208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvAO2IcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEGSa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:30:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588876254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSRvijYc9WX/jZopH9zHcMuBedu6Zvp4s9Ed1skZi5k=;
        b=IvAO2IcAj/yGWsabQIOqxkim7VrePKG+puid3pEiC+3vEuF9TcD07kWQI6oMEDuC7Ht/TP
        ztikGMkVskPpi0ZqWBgDcMXK4qii6D+wbjAMGualgqary8QNx3zRv5VieyOqr/fPCSTH10
        UVnRN2oUA8Zk33FRo/k5VaviBUAhKVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-YZzciQXvM0iXslwumt9qvw-1; Thu, 07 May 2020 14:30:52 -0400
X-MC-Unique: YZzciQXvM0iXslwumt9qvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6CEC80183C;
        Thu,  7 May 2020 18:30:50 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4170560C47;
        Thu,  7 May 2020 18:30:50 +0000 (UTC)
Date:   Thu, 7 May 2020 13:30:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org
Subject: Re: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about
 stack irq swizzles
Message-ID: <20200507183048.rlf2bgj4cf2g4jy6@treble>
References: <20200507161020.783541450@infradead.org>
 <20200507161828.801097834@infradead.org>
 <20200507173809.GK5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507173809.GK5298@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:38:09PM +0200, Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 06:10:23PM +0200, Peter Zijlstra wrote:
> > Thomas would very much like objtool to understand and generate correct
> > ORC unwind information for the minimal stack swizzle sequence:
> > 
> > 	mov %rsp, (%[ts])
> > 	mov %[ts], %rsp
> > 	...
> > 	pop %rsp
> > 
> > This sequence works for the fp and guess unwinders -- all they need is
> > that top-of-stack link set up by the first instruction.
> > 
> > The previous entry_64.S code worked with "UNWIND_HINT_REGS indirect=1"
> > hints to inform the unwinder about the stack-swizzle, but because
> > we've now already entered C, we can no longer point to a REGS. In
> > fact, due to being in C we don't even have a reliable sp_offset to
> > anything.
> > 
> > None of the existing UNWIND_HINT() functionality is quite sufficient
> > to generate the right thing, but SP_INDIRECT is still the closest, so
> > extend it.
> > 
> > When SP_INDIRECT is combined with .end=1 (which is otherwise unused,
> > except for sp_reg == UNDEFINED):
> > 
> >  - change it from (sp+sp_offset) to (sp)+sp_offset
> >  - have objtool preserve sp_offset from the previous state
> >  - change "pop %rsp" handling to restore the CFI state from before the
> >    hint.
> > 
> > NOTES:
> > 
> >  - We now have an instruction with stackops and a hint; make hint take
> >    precedence over stackops.
> > 
> >  - Due to the reverse search in "pop %rsp" we must
> >    fill_alternative_cfi() before validate_branch().
> > 
> >  - This all isn't really pretty, but it works and gets Thomas the code
> >    sequence he wants.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> Much simpler, also works.

Doing the stack switch in inline asm is just nasty.

Also, a frame pointer makes this SO much easier for ORC/objtool, no
funky hints needed.  In fact maybe we can get rid of the indirect hint
things altogether, which means even more deleted code.

This is much cleaner, and it boots:

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3f9b2555e6fb..4a25f72f969f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -718,15 +718,6 @@ __visible void __xen_pv_evtchn_do_upcall(void)
 	irq_exit_rcu();
 }
 
-/*
- * Separate function as objtool is unhappy about having
- * the macro at the call site.
- */
-static noinstr void run_on_irqstack(void)
-{
-	RUN_ON_IRQSTACK(__xen_pv_evtchn_do_upcall);
-}
-
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
@@ -739,7 +730,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 		__xen_pv_evtchn_do_upcall();
 		instr_end();
 	} else {
-		run_on_irqstack();
+		RUN_ON_IRQSTACK(__xen_pv_evtchn_do_upcall);
 	}
 
 	set_irq_regs(old_regs);
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3046dfc69b8c..d036dc831a23 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1295,3 +1295,31 @@ SYM_CODE_START(rewind_stack_do_exit)
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
 .popsection
+
+/*
+ * rdi: new stack pointer
+ * rsi: function pointer
+ * rdx: arg1 (can be NULL if none)
+ */
+SYM_FUNC_START(call_on_stack)
+	/*
+	 * Save the frame pointer unconditionally.  This allows the ORC
+	 * unwinder to handle the stack switch.
+	 */
+	pushq	%rbp
+	mov	%rsp, %rbp
+
+	 /*
+	  * The unwinder relies on the word at the end of the new stack page
+	  * linking back to the previous RSP.
+	 */
+	mov	%rsp, -8(%rdi)
+	lea	-8(%rdi), %rsp
+	mov	%rdx, %rdi
+	CALL_NOSPEC rsi
+
+	/* Restore the previous stack pointer from RBP. */
+	leaveq
+
+	ret
+SYM_FUNC_END(call_on_stack)
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index f307d4c27f84..131a6c689b1c 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -7,42 +7,26 @@
 #include <asm/processor.h>
 
 #ifdef CONFIG_X86_64
+
+void call_on_stack(void *stack, void *func, void *arg);
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(irq_count) != -1;
 }
 
-#define __RUN_ON_IRQSTACK(_asm, ...)					\
+#define __RUN_ON_IRQSTACK(func, arg)					\
 do {									\
-	unsigned long tos;						\
-									\
 	lockdep_assert_irqs_disabled();					\
-									\
-	tos = ((unsigned long)__this_cpu_read(hardirq_stack_ptr)) - 8;	\
-									\
-	__this_cpu_add(irq_count, 1);					\
-	asm volatile(							\
-		"movq	%%rsp, (%[ts])				\n"	\
-		"movq	%[ts], %%rsp				\n"	\
-		ASM_INSTR_BEGIN						\
-		_asm "                                          \n"	\
-		ASM_INSTR_END						\
-		"popq	%%rsp					\n"	\
-		:							\
-		: [ts] "r" (tos), ##__VA_ARGS__				\
-		: "memory"						\
-		);							\
+	call_on_stack(__this_cpu_read(hardirq_stack_ptr), func, arg);	\
 	__this_cpu_sub(irq_count, 1);					\
 } while (0)
 
-/*
- * Macro to emit code for running @func on the irq stack.
- */
 #define RUN_ON_IRQSTACK(func) \
-	__RUN_ON_IRQSTACK("call" __ASM_FORM(func))
+	__RUN_ON_IRQSTACK(func, NULL)
 
 #define RUN_ON_IRQSTACK_ARG1(func, arg) \
-	__RUN_ON_IRQSTACK("call" __ASM_FORM(func), "D" (arg))
+	__RUN_ON_IRQSTACK(func, arg)
 
 #else /* CONFIG_X86_64 */
 static __always_inline bool irqstack_active(void) { return false; }
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index c41b0a2859d7..30b6ddf64dc7 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -74,7 +74,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 
 static noinstr void handle_irq_on_irqstack(struct irq_desc *desc)
 {
-	__RUN_ON_IRQSTACK(CALL_NOSPEC, THUNK_TARGET(desc->handle_irq), "D" (desc));
+	RUN_ON_IRQSTACK_ARG1(desc->handle_irq, desc);
 }
 
 void handle_irq(struct irq_desc *desc, struct pt_regs *regs)

