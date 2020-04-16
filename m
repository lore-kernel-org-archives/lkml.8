Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC8BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BCE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TYfep7er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503487AbgDPPP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395070AbgDPPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173FC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VO8OgZtTlpanMZN2sQJ/dRFzTr62tn4AjfwviFGlzT4=; b=TYfep7erSM+2EBYCzjis1tAedJ
        xpXq5szVbZYnLk8Ieb7Q5uaMG6kHqPggeZFeqcU0/ZBDLsAtClpYiOQumYkr+K53AWY0POcq699jH
        Xk3XMN/IKl9L+dVDJOuvPxaAzITm3ngbw0oQ7mZriZsaDijOXaj00sp2KeD218hyMO5mbfa7u5T1r
        zL1T/VfuO+iEaqqkUJHFYsYiL/eScYNYU1cjw6JsuIne8H6QluJLL9iEmdOogGuWo+nFi9FjDPcae
        5qy5XszowiEqj/yXk0NJYxZr1G/sMpZ6b1yskWBWizzlFysdPM/R8Vrd2d4YlW2QhZrWGZ7lQuv/n
        eUOPGfmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BJ-00046v-3u; Thu, 16 Apr 2020 15:11:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 277A9307456;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 10A492B0DE4BF; Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Message-Id: <20200416151024.944613249@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 4/7] objtool: Add support for intra-function calls
References: <20200416150752.569029800@infradead.org>
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
 include/linux/frame.h                            |   11 +
 tools/objtool/Documentation/stack-validation.txt |    8 +
 tools/objtool/arch/x86/decode.c                  |   17 ++-
 tools/objtool/check.c                            |  129 ++++++++++++++++++-----
 tools/objtool/check.h                            |    1 
 5 files changed, 140 insertions(+), 26 deletions(-)

--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,20 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue warning.
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
@@ -290,6 +290,14 @@ they mean, and suggestions for how to fi
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
 
+9. file.o: warning: unsupported intra-function call
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
@@ -453,6 +453,12 @@ int arch_decode_instruction(struct elf *
 
 	case 0xe8:
 		*type = INSN_CALL;
+		/*
+		 * For the impact on the stack, a call behaves like
+		 * a push of an immediate value (the return address).
+		 */
+		op->src.type = OP_SRC_CONST;
+		op->dest.type = OP_DEST_PUSH;
 		break;
 
 	case 0xfc:
@@ -493,10 +499,17 @@ int arch_decode_instruction(struct elf *
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
+	switch (*type) {
+	case INSN_STACK:
+	case INSN_EXCEPTION_RETURN:
+	case INSN_CALL:
 		list_add_tail(&op->list, ops_list);
-	else
+		break;
+
+	default:
 		free(op);
+		break;
+	}
 
 	return 0;
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -691,44 +691,51 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
+static int setup_call_dest(struct objtool_file *file, struct instruction *insn)
+{
+	unsigned long dest_off;
+
+	dest_off = insn->offset + insn->len + insn->immediate;
+	insn->call_dest = find_func_by_offset(insn->sec, dest_off);
+	if (!insn->call_dest)
+		insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
+
+	if (!insn->call_dest) {
+		/* intra-function call */
+		if (insn->intra_function_call)
+			return 0;
+
+		WARN_FUNC("intra-function call", insn->sec, insn->offset);
+		return -1;
+	}
+
+	/* regular call */
+	if (insn->func && insn->call_dest->type != STT_FUNC) {
+		WARN_FUNC("unsupported call to non-function",
+			  insn->sec, insn->offset);
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Find the destination instructions for all calls.
  */
 static int add_call_destinations(struct objtool_file *file)
 {
 	struct instruction *insn;
-	unsigned long dest_off;
 	struct rela *rela;
 
 	for_each_insn(file, insn) {
-		if (insn->type != INSN_CALL)
+		if (insn->type != INSN_CALL || insn->ignore)
 			continue;
 
 		rela = find_rela_by_dest_range(file->elf, insn->sec,
 					       insn->offset, insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
-			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
-			if (!insn->call_dest)
-				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
-
-			if (insn->ignore)
-				continue;
-
-			if (!insn->call_dest) {
-				WARN_FUNC("unsupported intra-function call",
-					  insn->sec, insn->offset);
-				if (retpoline)
-					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
-				return -1;
-			}
-
-			if (insn->func && insn->call_dest->type != STT_FUNC) {
-				WARN_FUNC("unsupported call to non-function",
-					  insn->sec, insn->offset);
+			if (setup_call_dest(file, insn))
 				return -1;
-			}
-
 		} else if (rela->sym->type == STT_SECTION) {
 			insn->call_dest = find_func_by_offset(rela->sym->sec,
 							      rela->addend+4);
@@ -1414,6 +1421,52 @@ static int read_instr_hints(struct objto
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
+		insn->intra_function_call = true;
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
@@ -1469,6 +1522,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_calls(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
@@ -2260,7 +2317,8 @@ static int validate_branch(struct objtoo
 				return ret;
 
 			if (!no_fp && func && !is_fentry_call(insn) &&
-			    !has_valid_stack_frame(&state)) {
+			    !has_valid_stack_frame(&state) &&
+			    !insn->intra_function_call) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
@@ -2269,6 +2327,29 @@ static int validate_branch(struct objtoo
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
+			if (insn->intra_function_call) {
+				/*
+				 * The call instruction can update the stack
+				 * state. Then make the intra-function call
+				 * behaves like and unconditional jump.
+				 */
+				ret = handle_insn_ops(insn, &state);
+				if (ret)
+					return ret;
+
+				ret = validate_branch(file, func, insn,
+						      insn->jump_dest, state);
+				if (ret) {
+					if (backtrace) {
+						BT_FUNC("(intra-function call)",
+							insn);
+					}
+					return ret;
+				}
+
+				return 0;
+			}
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,6 +33,7 @@ struct instruction {
 	int alt_group;
 	bool dead_end, ignore, ignore_alts;
 	bool hint;
+	bool intra_function_call;
 	bool retpoline_safe;
 	s8 instr;
 	u8 visited;


