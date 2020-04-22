Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE54C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1532168B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDVWZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgDVWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1349C03C1AA;
        Wed, 22 Apr 2020 15:24:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnO-0001Oq-84; Thu, 23 Apr 2020 00:24:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1A4531C0809;
        Thu, 23 Apr 2020 00:24:40 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:39 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Better handle IRET
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.631224674@infradead.org>
References: <20200416115118.631224674@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427943.28353.7135426174372512474.tip-bot2@tip-bot2>
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

Commit-ID:     016db2d9c63e3ef0e7c3776efb38f352053cdd1e
Gitweb:        https://git.kernel.org/tip/016db2d9c63e3ef0e7c3776efb38f352053cdd1e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 02 Apr 2020 10:15:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:05 +02:00

objtool: Better handle IRET

Teach objtool a little more about IRET so that we can avoid using the
SAVE/RESTORE annotation. In particular, make the weird corner case in
insn->restore go away.

The purpose of that corner case is to deal with the fact that
UNWIND_HINT_RESTORE lands on the instruction after IRET, but that
instruction can end up being outside the basic block, consider:

	if (cond)
		sync_core()
	foo();

Then the hint will land on foo(), and we'll encounter the restore
hint without ever having seen the save hint.

By teaching objtool about the arch specific exception frame size, and
assuming that any IRET in an STT_FUNC symbol is an exception frame
sized POP, we can remove the use of save/restore hints for this code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.631224674@infradead.org
---
 arch/x86/include/asm/processor.h |  2 --
 tools/objtool/arch.h             |  1 +
 tools/objtool/arch/x86/decode.c  | 14 ++++++++++++--
 tools/objtool/check.c            | 29 ++++++++++++++++-------------
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3bcf27c..3eeaaeb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -727,7 +727,6 @@ static inline void sync_core(void)
 	unsigned int tmp;
 
 	asm volatile (
-		UNWIND_HINT_SAVE
 		"mov %%ss, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
@@ -737,7 +736,6 @@ static inline void sync_core(void)
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
 		"iretq\n\t"
-		UNWIND_HINT_RESTORE
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 #endif
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index f9883c4..55396df 100644
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
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 199b408..3273638 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -446,9 +446,19 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
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
 
@@ -494,7 +504,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
-	if (*type == INSN_STACK)
+	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
 		list_add_tail(&op->list, ops_list);
 	else
 		free(op);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 819de0d..72bf5cc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2081,15 +2081,14 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *first, struct insn_state state)
+			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *insn, *next_insn;
+	struct instruction *next_insn;
 	struct section *sec;
 	u8 visited;
 	int ret;
 
-	insn = first;
 	sec = insn->sec;
 
 	if (insn->alt_group && list_empty(&insn->alts)) {
@@ -2142,16 +2141,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 
 				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
 					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
 						  sec, insn->offset);
 					return 1;
@@ -2244,6 +2233,20 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
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
