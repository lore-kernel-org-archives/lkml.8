Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6252AC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4008C24979
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgEASWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730710AbgEASWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7009C061A0C;
        Fri,  1 May 2020 11:22:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIr-0003ei-SB; Fri, 01 May 2020 20:22:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8EB131C048C;
        Fri,  1 May 2020 20:22:20 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:20 -0000
From:   "tip-bot2 for Miroslav Benes" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move the IRET hack into the arch decoder
Cc:     Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191659.913283807@infradead.org>
References: <20200428191659.913283807@infradead.org>
MIME-Version: 1.0
Message-ID: <158835734054.8414.7454435298178677103.tip-bot2@tip-bot2>
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

Commit-ID:     b490f45362002fef57996388e395efc974b013f4
Gitweb:        https://git.kernel.org/tip/b490f45362002fef57996388e395efc974b013f4
Author:        Miroslav Benes <mbenes@suse.cz>
AuthorDate:    Fri, 24 Apr 2020 16:30:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:33 +02:00

objtool: Move the IRET hack into the arch decoder

Quoting Julien:

  "And the other suggestion is my other email was that you don't even
  need to add INSN_EXCEPTION_RETURN. You can keep IRET as
  INSN_CONTEXT_SWITCH by default and x86 decoder lookups the symbol
  conaining an iret. If it's a function symbol, it can just set the type
  to INSN_OTHER so that it caries on to the next instruction after
  having handled the stack_op."

Suggested-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191659.913283807@infradead.org
---
 tools/objtool/arch.h            |  1 -
 tools/objtool/arch/x86/decode.c | 28 ++++++++++++++++++----------
 tools/objtool/check.c           | 11 -----------
 tools/objtool/elf.c             |  4 ++--
 tools/objtool/elf.h             |  2 +-
 5 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 25dd4a9..cd118eb 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -19,7 +19,6 @@ enum insn_type {
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
-	INSN_EXCEPTION_RETURN,
 	INSN_CONTEXT_SWITCH,
 	INSN_BUG,
 	INSN_NOP,
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index e26bedb..d7b5d10 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -94,6 +94,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
 	struct stack_op *op = NULL;
+	struct symbol *sym;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -469,17 +470,24 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0xcf: /* iret */
-		*type = INSN_EXCEPTION_RETURN;
-
-		ADD_OP(op) {
-			/* add $40, %rsp */
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_SP;
-			op->src.offset = 5*8;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
+		/*
+		 * Handle sync_core(), which has an IRET to self.
+		 * All other IRET are in STT_NONE entry code.
+		 */
+		sym = find_symbol_containing(sec, offset);
+		if (sym && sym->type == STT_FUNC) {
+			ADD_OP(op) {
+				/* add $40, %rsp */
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_SP;
+				op->src.offset = 5*8;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
+			break;
 		}
-		break;
+
+		/* fallthrough */
 
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4f3db2f..d822858 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2320,17 +2320,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			break;
 
-		case INSN_EXCEPTION_RETURN:
-			/*
-			 * This handles x86's sync_core() case, where we use an
-			 * IRET to self. All 'normal' IRET instructions are in
-			 * STT_NOTYPE entry symbols.
-			 */
-			if (func)
-				break;
-
-			return 0;
-
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
 				WARN_FUNC("unsupported instruction in callable function",
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 453b723..b6349ca 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -61,7 +61,7 @@ static void rb_add(struct rb_root *tree, struct rb_node *node,
 	rb_insert_color(node, tree);
 }
 
-static struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
+static struct rb_node *rb_find_first(const struct rb_root *tree, const void *key,
 			       int (*cmp)(const void *key, const struct rb_node *))
 {
 	struct rb_node *node = tree->rb_node;
@@ -189,7 +189,7 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
-struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
+struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 5e76ac3..9d6bb07 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -124,7 +124,7 @@ struct section *find_section_by_name(const struct elf *elf, const char *name);
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
-struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
