Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8288F2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEVfV1Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgDBIRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:17:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387601AbgDBIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4rneyj2uBbyN/s3snHsjsVNWi1oFhxVS3X5MPkEZ0VI=; b=nEVfV1AedlA1a/UIMBE6GgwzQN
        kVnL2sLRv+PFV3LXhXQImgNjqfc/9NpBtFa6z7Jv0gBRYGH+qK/xc6vnqAgSWqdkUanDjYUnvD7Dg
        LKwoENjF077+pFzgAAWBuDNLYNx0Y5KL4/1joYmDNAwgfvMAO4i59p6kCILyHqPecUr2YNS7mN1Tn
        U9CcsrMT9nPONYXIbpZIeqO/ARwoOJRaPmAaGKOcAaYwoc45s2pn0swa5SmSBZN16yAxCKfkRJutK
        5Yqj3QdjqTwxxHP7it5FL0WMK4jsf6mfS6vUezzphBjquyJWvbDcXQDkIrKldsx5xOgiZu1X6gtXZ
        lnuWntAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJv2G-0005bV-E6; Thu, 02 Apr 2020 08:17:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBEA1306CD2;
        Thu,  2 Apr 2020 10:17:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80F18202451B7; Thu,  2 Apr 2020 10:17:10 +0200 (CEST)
Date:   Thu, 2 Apr 2020 10:17:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200402081710.GJ20760@hirez.programming.kicks-ass.net>
References: <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
 <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com>
 <20200402075036.GA20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402075036.GA20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 09:50:36AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 07:41:46AM +0100, Julien Thierry wrote:

> > Also, instead of adding a special "arch_exception_frame_size", I could
> > suggest:
> > - Picking this patch [1] from a completely arbitrary source
> > - Getting rid of INSN_STACK type, any instruction could then include stack
> > ops on top of their existing semantics, they can just have an empty list if
> > they don't touch SP/BP
> > - x86 decoder adds a stack_op to the iret to modify the stack pointer by the
> > right amount
> 
> That's not the worst idea, lemme try that.

Something like so then?

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -738,7 +738,6 @@ static inline void sync_core(void)
 	unsigned int tmp;
 
 	asm volatile (
-		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
@@ -748,7 +747,6 @@ static inline void sync_core(void)
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
 		"iretq\n\t"
-		UNWIND_HINT_RESTORE
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -19,6 +19,7 @@ enum insn_type {
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
+	INSN_EXCEPTION_RETURN,
 	INSN_CONTEXT_SWITCH,
 	INSN_STACK,
 	INSN_BUG,
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -435,9 +435,19 @@ int arch_decode_instruction(struct elf *
 		*type = INSN_RETURN;
 		break;
 
+	case 0xcf: /* iret */
+		*type = INSN_EXCEPTION_RETURN;
+
+		/* add $40, %rsp */
+		op->src.type = OP_SRC_ADD;
+		op->src.reg = CFI_SP;
+		op->src.offset = 5*8;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = CFI_SP;
+		break;
+
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
-	case 0xcf: /* iret */
 		*type = INSN_CONTEXT_SWITCH;
 		break;
 
@@ -483,7 +493,7 @@ int arch_decode_instruction(struct elf *
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK)
+	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
 		list_add_tail(&op->list, ops_list);
 	else
 		free(op);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2224,6 +2224,20 @@ static int validate_branch(struct objtoo
 
 			break;
 
+		case INSN_EXCEPTION_RETURN:
+			if (handle_insn_ops(insn, &state))
+				return 1;
+
+			/*
+			 * This handles x86's sync_core() case, where we use an
+			 * IRET to self. All 'normal' IRET instructions are in
+			 * STT_NOTYPE entry symbols.
+			 */
+			if (func)
+				break;
+
+			return 0;
+
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
 				WARN_FUNC("unsupported instruction in callable function",
