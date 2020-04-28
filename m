Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA4C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43F920730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGk7+i0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgD1TTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgD1TTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413B9C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5ZRP2prB3+4lkffpS1QqktaqknTbNafSKFsaH4UcQQ4=; b=iGk7+i0iQoW+1UqJb2JYN+zafy
        sXngHyPQav1rnMjZYqSILWwNrLpui4uiMGt/UMsix3WlIR1jB4uQZAHrXdpHJ36sUoxZaDQvFXfbQ
        TTga4nPbELLWe0YmxYLZrN49abCFFyvYul7qi+lCSDFKdgKBGqNZwafs14Vhs7j/CIxD4DKB+Vc1R
        J7Z2b5qxHB56COcy/547/Pi/QhJbS9ZHPmcMbW4GmlAAXIvsQ4mp4cVwWMtQL9Wd0aD2e8KLan1L8
        AiFetYahkb2ytkbypdwJ+Lj39NMM7sthZt9rCGPO/Lo7cI1xLd9PdH/HiorbycRGf7T/62kToz3yq
        DOueq7bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlR-0007l0-M6; Tue, 28 Apr 2020 19:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB9330793E;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A55E25D01319; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.972514813@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 10/14] objtool: Add support for intra-function calls
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 tools/objtool/check.c                            |   79 +++++++++++++++++++++--
 4 files changed, 102 insertions(+), 4 deletions(-)

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
@@ -323,6 +323,14 @@ they mean, and suggestions for how to fi
     The easiest way to enforce this is to ensure alternative do not contain
     any ORC entries, which in turn implies the above constraint.
 
+11. file.o: warning: unannotated intra-function call
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
@@ -496,6 +496,14 @@ int arch_decode_instruction(const struct
 
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
@@ -692,6 +692,16 @@ static int add_jump_destinations(struct
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
 /*
  * Find the destination instructions for all calls.
  */
@@ -717,10 +727,7 @@ static int add_call_destinations(struct
 				continue;
 
 			if (!insn->call_dest) {
-				WARN_FUNC("unsupported intra-function call",
-					  insn->sec, insn->offset);
-				if (retpoline)
-					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
 				return -1;
 			}
 
@@ -743,6 +750,15 @@ static int add_call_destinations(struct
 			}
 		} else
 			insn->call_dest = rela->sym;
+
+		/*
+		 * Whatever stack impact regular CALLs have, should be undone
+		 * by the RETURN of the called function.
+		 *
+		 * Annotated intra-function calls retain the stack_ops but
+		 * are converted to JUMP, see read_intra_function_calls().
+		 */
+		remove_insn_ops(insn);
 	}
 
 	return 0;
@@ -1422,6 +1438,57 @@ static int read_instr_hints(struct objto
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
+		 * See add_call_destinations(), which strips stack_ops from
+		 * normal CALLs.
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
@@ -1477,6 +1544,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_calls(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;


