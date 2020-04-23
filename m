Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB36C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7736120736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yyk8jf5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgDWLlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgDWLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:41:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FECC035494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+7JRGIZOws4sjcFVxHZCSWNNCdWjiFuMHa0uxMHVAJU=; b=Yyk8jf5GDYUQ6bGSemRU6tH/i+
        E7tcHQJPGfThUKd5okOCNzzweUPZ5xfhNC4BS7/B9bv+oOVxXF1t4j6eBOvLWd8R6h956B53GrExr
        tH1nsBVvUbFHmjU+INrpkgKUUaGuZH0Ep3+dBmfZ68amTJiiAJWAm3/LT97xR74rGqewA9pOPabEB
        +irxdJriIBi+CCral24uKoA/4BMdkEoEsOtza7uPshHMeVYf1IR5opScWi8yTXm5AlzuVJow7tqA+
        bs1QIXDK4L0Mrzdl++gll8VPKxNHovEHptrgUvxuRLG9VhmKK1psU2NK+5gIx5kVkGSoNeylciokd
        KnRGKxVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRaDz-0006D3-SO; Thu, 23 Apr 2020 11:41:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CC60300739;
        Thu, 23 Apr 2020 13:40:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88F3E23D3AABE; Thu, 23 Apr 2020 13:40:56 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 4/7] objtool: Add support for intra-function calls
Message-ID: <20200423114056.GT20730@hirez.programming.kicks-ass.net>
References: <20200416150752.569029800@infradead.org>
 <20200416151024.944613249@infradead.org>
 <20200419164150.q5ut7gjhwzdrg4lf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164150.q5ut7gjhwzdrg4lf@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 11:41:50AM -0500, Josh Poimboeuf wrote:

> Could this be cleaner if the insn->type were just changed to
> INSN_JUMP_UNCONDITIONAL?  Then it could share the normal jump logic.

A little something like so, then?

---
Subject: objtool: Add support for intra-function calls
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Date: Tue, 14 Apr 2020 12:36:12 +0200

From: Alexandre Chartre <alexandre.chartre@oracle.com>

Change objtool to support intra-function calls. On x86, an intra-function
call is represented in objtool as a push onto the stack (of the return
address), and a jump to the destination address. That way the stack
information is correctly updated and the call flow is still accurate.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200414103618.12657-4-alexandre.chartre@oracle.com
---
 include/linux/frame.h                            |   11 +++
 tools/objtool/Documentation/stack-validation.txt |    8 ++
 tools/objtool/arch/x86/decode.c                  |    8 ++
 tools/objtool/check.c                            |   83 +++++++++++++++++++++--
 4 files changed, 103 insertions(+), 7 deletions(-)

--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,20 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL				\
+	999:							\
+	.pushsection .discard.intra_function_calls;		\
+	.long 999b;						\
+	.popsection;
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define ANNOTATE_INTRA_FUNCTION_CALL
 
 #endif /* CONFIG_STACK_VALIDATION */
 
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -316,6 +316,14 @@ they mean, and suggestions for how to fi
       sources).
 
 
+10. file.o: warning: unsupported intra-function call
+
+   This warning means that a direct call is done to a destination which
+   is not at the beginning of a function. If this is a legit call, you
+   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
+   directive right before the call.
+
+
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
 
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -516,6 +516,14 @@ int arch_decode_instruction(struct elf *
 
 	case 0xe8:
 		*type = INSN_CALL;
+		/*
+		 * For the impact on the stack, a CALL behaves like
+		 * a PUSH of an immediate value (the return address).
+		 */
+		ADD_OP(op) {
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSH;
+		}
 		break;
 
 	case 0xfc:
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -690,6 +690,16 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
+static void remove_insn_ops(struct instruction *insn)
+{
+	struct stack_op *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
+		list_del(&op->list);
+		free(op);
+	}
+}
+
 static bool setup_call_dest(struct objtool_file *file, struct instruction *insn)
 {
 	unsigned long dest_off;
@@ -700,19 +710,23 @@ static bool setup_call_dest(struct objto
 		insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
 
 	if (!insn->call_dest) {
-		WARN_FUNC("unsupported intra-function call",
-			  insn->sec, insn->offset);
-		if (retpoline)
-			WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+		WARN_FUNC("intra-function call", insn->sec, insn->offset);
 		return false;
 	}
 
+	/* regular call */
 	if (insn->func && insn->call_dest->type != STT_FUNC) {
 		WARN_FUNC("unsupported call to non-function",
 			  insn->sec, insn->offset);
 		return false;
 	}
 
+	/*
+	 * Whatever stack impact regular CALLs have, should be
+	 * undone by the RETURN of the called function.
+	 */
+	remove_insn_ops(insn);
+
 	return true;
 }
 
@@ -1423,6 +1437,57 @@ static int read_instr_hints(struct objto
 	return 0;
 }
 
+static int read_intra_function_calls(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		unsigned long dest_off;
+
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s",
+			     sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.intra_function_call entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_CALL) {
+			WARN_FUNC("intra_function_call not a direct call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		/*
+		 * Treat intra-function CALLs as JMPs, but with a stack_op.
+		 * Also see how setup_call_dest() strips stack_ops from normal
+		 * CALLs.
+		 */
+		insn->type = INSN_JUMP_UNCONDITIONAL;
+
+		dest_off = insn->offset + insn->len + insn->immediate;
+		insn->jump_dest = find_insn(file, insn->sec, dest_off);
+		if (!insn->jump_dest) {
+			WARN_FUNC("can't find call dest at %s+0x%lx",
+				  insn->sec, insn->offset,
+				  insn->sec->name, dest_off);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1478,6 +1543,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_calls(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
@@ -2252,6 +2321,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		if (handle_insn_ops(insn, &state))
+			return 1;
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
@@ -2311,9 +2383,6 @@ static int validate_branch(struct objtoo
 			break;
 
 		case INSN_EXCEPTION_RETURN:
-			if (handle_insn_ops(insn, &state))
-				return 1;
-
 			/*
 			 * This handles x86's sync_core() case, where we use an
 			 * IRET to self. All 'normal' IRET instructions are in
