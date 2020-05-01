Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E0FC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9B72173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgEASWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730738AbgEASWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD5EC061A0C;
        Fri,  1 May 2020 11:22:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIr-0003ee-IV; Fri, 01 May 2020 20:22:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3C3721C0450;
        Fri,  1 May 2020 20:22:20 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:20 -0000
From:   "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add support for intra-function calls
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200414103618.12657-4-alexandre.chartre@oracle.com>
References: <20200414103618.12657-4-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Message-ID: <158835734021.8414.5303379433420116948.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8aa8eb2a8f5b3305a95f39957dd2b715fa668e21
Gitweb:        https://git.kernel.org/tip/8aa8eb2a8f5b3305a95f39957dd2b715fa668e21
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Tue, 14 Apr 2020 12:36:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:33 +02:00

objtool: Add support for intra-function calls

Change objtool to support intra-function calls. On x86, an intra-function
call is represented in objtool as a push onto the stack (of the return
address), and a jump to the destination address. That way the stack
information is correctly updated and the call flow is still accurate.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-4-alexandre.chartre@oracle.com
---
 include/linux/frame.h                            | 11 ++-
 tools/objtool/Documentation/stack-validation.txt |  8 ++-
 tools/objtool/arch/x86/decode.c                  |  8 ++-
 tools/objtool/check.c                            | 79 ++++++++++++++-
 4 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2..303cda6 100644
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
 
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 0189039..0542e46 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -323,6 +323,14 @@ they mean, and suggestions for how to fix them.
     The easiest way to enforce this is to ensure alternatives do not contain
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
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index d7b5d10..4b504fc 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -496,6 +496,14 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d822858..32dea5f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -674,6 +674,16 @@ static int add_jump_destinations(struct objtool_file *file)
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
@@ -699,10 +709,7 @@ static int add_call_destinations(struct objtool_file *file)
 				continue;
 
 			if (!insn->call_dest) {
-				WARN_FUNC("unsupported intra-function call",
-					  insn->sec, insn->offset);
-				if (retpoline)
-					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
 				return -1;
 			}
 
@@ -725,6 +732,15 @@ static int add_call_destinations(struct objtool_file *file)
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
@@ -1404,6 +1420,57 @@ static int read_instr_hints(struct objtool_file *file)
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
@@ -1459,6 +1526,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_calls(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
