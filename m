Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBFC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DB92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIg0czH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgD1TT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728977AbgD1TTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:51 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D550C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IQ7X3Fo5RYyl4BVwXbzl8zEN5+FmXEnjyhxrg7RmT84=; b=oIg0czH4cafBNpm002T+tkGkZG
        4aZ98ArC+Ib7D1blCpoaxSwm4HdDNanRDf2rxMRsnA4pP57SwQnJAA9lWUMxKsbc1Jf0vmBAXrQSt
        9g/Yw7Dmq7RxdvUcidmjNmgCNUsuHx3bnBU98PTAtPyI/Ft+/GF274mfr0abaDvrfdgGOEvGqh/v3
        Zo0/oQ2cqu/L/4zlDfGCC6/QzjCJeZb2MWqZODVhYaWqhMtop2DB9jOwR3AgS25VJVHPjE3UW8DAI
        yV8tHVsDk3A/Oll/YlelblTknXsweX8aLaB0qTL9Dh4QLlMr7itBdQJkY+SjycHvAFluLDZC+iYwW
        J4eYlEZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlR-0007kz-WA; Tue, 28 Apr 2020 19:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAA28307770;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9536F25D01316; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.913283807@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 09/14] objtool: Move the IRET hack into the arch decoder
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

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
---
 tools/objtool/arch.h            |    1 -
 tools/objtool/arch/x86/decode.c |   28 ++++++++++++++++++----------
 tools/objtool/check.c           |   11 -----------
 tools/objtool/elf.c             |    4 ++--
 tools/objtool/elf.h             |    2 +-
 5 files changed, 21 insertions(+), 25 deletions(-)

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
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -94,6 +94,7 @@ int arch_decode_instruction(const struct
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
 	struct stack_op *op = NULL;
+	struct symbol *sym;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -469,17 +470,24 @@ int arch_decode_instruction(const struct
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
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2308,17 +2308,6 @@ static int validate_branch(struct objtoo
 
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
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -61,7 +61,7 @@ static void rb_add(struct rb_root *tree,
 	rb_insert_color(node, tree);
 }
 
-static struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
+static struct rb_node *rb_find_first(const struct rb_root *tree, const void *key,
 			       int (*cmp)(const void *key, const struct rb_node *))
 {
 	struct rb_node *node = tree->rb_node;
@@ -189,7 +189,7 @@ struct symbol *find_func_by_offset(struc
 	return NULL;
 }
 
-struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
+struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -124,7 +124,7 @@ struct section *find_section_by_name(con
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
-struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);


