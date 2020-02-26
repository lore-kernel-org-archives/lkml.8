Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A70C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77EA2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LkajbC6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgBZJxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:53:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2FKWmSWFldOCG/pa1mcyIl64t9II7EAfel+OFPcME0Q=; b=LkajbC6UqRhohe2L0QYFTMvp2b
        jsYqHLZAx5EjxEiBdWuZhG+WRhrZ3M9UHAUlMI2c1eq4kKe3AisRfE0lE8QG7hf4JzF8XxZLeI5/c
        E1w9M+XjXZzKxP/WosCVTMWjOx6BjzMHpE2nErYTQV9sWUWE5zOtKOh/RPSd27AjoWPeW7REMMyxp
        mWSfrJzekCYPb7jkPlI3Av1KkUqd+nE3vkz5mdjMO3kFJBgRYTNwPcmNAgQpe/Z9ul9Bwsly8pAw9
        gDQKJmXoK92+rBzVOjoJ7X0CJejHHlSdNEZxxoGv0irbjsp1i332KgdyRdrU9tJb3zDHSuhKZ2G7I
        A9FuRAVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6tNZ-0001nV-UG; Wed, 26 Feb 2020 09:53:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8371D30018B;
        Wed, 26 Feb 2020 10:51:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB6ED20160BF2; Wed, 26 Feb 2020 10:53:19 +0100 (CET)
Date:   Wed, 26 Feb 2020 10:53:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 00/15] x86/entry: Consolidation - Part V
Message-ID: <20200226095319.GT18400@hirez.programming.kicks-ass.net>
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225224719.950376311@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:47:19PM +0100, Thomas Gleixner wrote:

>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part5

How about the completely untested something below on top to avoid that
silly indirect call on 32bit idtentry.

---
 arch/x86/entry/entry_32.S | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index cf94e724743d..c92cd8412ab2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -723,19 +723,19 @@
 .endm
 
 #ifdef CONFIG_X86_INVD_BUG
-.macro idtentry_push_func vector cfunc
+.macro idtentry_call_func vector cfunc
 	.if \vector == X86_TRAP_XF
 		/* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
-		ALTERNATIVE "pushl	$exc_general_protection",	\
-			    "pushl	$exc_simd_coprocessor_error",	\
+		ALTERNATIVE "call	exc_general_protection",	\
+			    "call	exc_simd_coprocessor_error",	\
 			    X86_FEATURE_XMM
 	.else
-		pushl $\cfunc
+		call \cfunc
 	.endif
 .endm
 #else
-.macro idtentry_push_func vector cfunc
-	pushl $\cfunc
+.macro idtentry_call_func vector cfunc
+	call \cfunc
 .endm
 #endif
 
@@ -755,10 +755,9 @@ SYM_CODE_START(\asmsym)
 		pushl	$0		/* Clear the error code */
 	.endif
 
-	/* Push the C-function address into the GS slot */
-	idtentry_push_func \vector \cfunc
-	/* Invoke the common exception entry */
-	jmp	common_exception
+	call	common_idtentry
+	idtentry_call_func \vector \cfunc
+	jmp	ret_from_exception
 SYM_CODE_END(\asmsym)
 .endm
 
@@ -1125,7 +1124,6 @@ SYM_FUNC_START(entry_INT80_32)
 .section .fixup, "ax"
 SYM_CODE_START(asm_exc_iret_error)
 	pushl	$0				# no error code
-	pushl	$exc_iret_error
 
 #ifdef CONFIG_DEBUG_ENTRY
 	/*
@@ -1139,7 +1137,9 @@ SYM_CODE_START(asm_exc_iret_error)
 	popl	%eax
 #endif
 
-	jmp	common_exception
+	call	common_idtentry
+	call	exc_iret_error
+	jmp	ret_from_exception
 SYM_CODE_END(asm_exc_iret_error)
 .previous
 	_ASM_EXTABLE(.Lirq_return, asm_exc_iret_error)
@@ -1332,15 +1332,15 @@ SYM_FUNC_START(xen_failsafe_callback)
 SYM_FUNC_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
-SYM_CODE_START_LOCAL_NOALIGN(common_exception)
-	/* the function address is in %gs's slot on the stack */
+SYM_CODE_START_LOCAL_NOALIGN(common_idtentry)
+	/* the return address is in the %gs stack slot */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 	ENCODE_FRAME_POINTER
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
-	movl	PT_GS(%esp), %edi		# get the function address
-	REG_TO_PTGS %ecx
+	pushl	PT_GS(%esp)			# push return address
+	REG_TO_OTGS %ecx
 	SET_KERNEL_GS %ecx
 
 	/* fixup orig %eax */
@@ -1348,9 +1348,8 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
 
 	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC %edi
-	jmp	ret_from_exception
-SYM_CODE_END(common_exception)
+	ret
+SYM_CODE_END(common_idtentry)
 
 #ifdef CONFIG_DOUBLEFAULT
 SYM_CODE_START(asm_exc_double_fault)
