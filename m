Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B388214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3T0WlSYn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7qM4sxKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIJS51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgIJSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:54:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E5C0613ED;
        Thu, 10 Sep 2020 11:54:38 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BDWCx5CG7QZYZYGuZLFqM9zQ2cyym5LnIYx5E7HDE8M=;
        b=3T0WlSYnbH/IwNc6i/O9Tli+3wIC+udD24/O4bWelqyVurKFKOouPGq7F7R46UCIVTCMT0
        R6uTOA7f39jMEGAY9c2lj1B8M/Dl3pEVOgBqn6YoDAazHXu/n0dQec4oTB867DwVjnxo7O
        nLtF8LAqIoPGtEPg/qFxa25S6D7uBqPxIVfSw/kvur62vJeK+s+rBU1cbGGVHhZx8sWTiq
        C3LPaWpUHlI1lJtD2OvqKicJXFfZbE2jBExihE182S80DdP9iRFVL29m+MXBFkFoTA5w1M
        bmI5vlNNfTi5VFFVP9bTesj4rc6+9hnjlO5QdAnHaWXtLzpLQDK+KeHPI6DUvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BDWCx5CG7QZYZYGuZLFqM9zQ2cyym5LnIYx5E7HDE8M=;
        b=7qM4sxKsVRIIaqmQmM1bieRIcxNSRwadzTV9NQOchNrzvoCfSMYcr+4tg+wj2Ae9B+tZum
        4werBPAE2Hv9cqCw==
From:   "tip-bot2 for Raphael Gault" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Refactor jump table code to support
 other architectures
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407644.20229.4713400936302381756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d871f7b5a6a2a30f4eba577fd56941fa3657e394
Gitweb:        https://git.kernel.org/tip/d871f7b5a6a2a30f4eba577fd56941fa3657e394
Author:        Raphael Gault <raphael.gault@arm.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:24 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Refactor jump table code to support other architectures

The way to identify jump tables and retrieve all the data necessary to
handle the different execution branches is not the same on all
architectures.  In order to be able to add other architecture support,
define an arch-dependent function to process jump-tables.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Move arm64 bits out of this patch,
       Have only one function to find the start of the jump table,
       for now assume that the jump table format will be the same as
       x86]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/special.c | 95 +++++++++++++++++++++++++++++++-
 tools/objtool/check.c            | 90 +----------------------------
 tools/objtool/check.h            |  1 +-
 tools/objtool/special.h          |  4 +-
 4 files changed, 103 insertions(+), 87 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 34e0e16..fd4af88 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
+
 #include "../../special.h"
 #include "../../builtin.h"
 
@@ -48,3 +50,96 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return insn->offset == special_alt->new_off &&
 	       (insn->type == INSN_CALL || is_static_jump(insn));
 }
+
+/*
+ * There are 3 basic jump table patterns:
+ *
+ * 1. jmpq *[rodata addr](,%reg,8)
+ *
+ *    This is the most common case by far.  It jumps to an address in a simple
+ *    jump table which is stored in .rodata.
+ *
+ * 2. jmpq *[rodata addr](%rip)
+ *
+ *    This is caused by a rare GCC quirk, currently only seen in three driver
+ *    functions in the kernel, only with certain obscure non-distro configs.
+ *
+ *    As part of an optimization, GCC makes a copy of an existing switch jump
+ *    table, modifies it, and then hard-codes the jump (albeit with an indirect
+ *    jump) to use a single entry in the table.  The rest of the jump table and
+ *    some of its jump targets remain as dead code.
+ *
+ *    In such a case we can just crudely ignore all unreachable instruction
+ *    warnings for the entire object file.  Ideally we would just ignore them
+ *    for the function, but that would require redesigning the code quite a
+ *    bit.  And honestly that's just not worth doing: unreachable instruction
+ *    warnings are of questionable value anyway, and this is such a rare issue.
+ *
+ * 3. mov [rodata addr],%reg1
+ *    ... some instructions ...
+ *    jmpq *(%reg1,%reg2,8)
+ *
+ *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
+ *    writing, there are 11 occurrences of it in the allmodconfig kernel.
+ *
+ *    As of GCC 7 there are quite a few more of these and the 'in between' code
+ *    is significant. Esp. with KASAN enabled some of the code between the mov
+ *    and jmpq uses .rodata itself, which can confuse things.
+ *
+ *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
+ *    ensure the same register is used in the mov and jump instructions.
+ *
+ *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
+ */
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn)
+{
+	struct reloc  *text_reloc, *rodata_reloc;
+	struct section *table_sec;
+	unsigned long table_offset;
+
+	/* look for a relocation which references .rodata */
+	text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					      insn->offset, insn->len);
+	if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
+	    !text_reloc->sym->sec->rodata)
+		return NULL;
+
+	table_offset = text_reloc->addend;
+	table_sec = text_reloc->sym->sec;
+
+	if (text_reloc->type == R_X86_64_PC32)
+		table_offset += 4;
+
+	/*
+	 * Make sure the .rodata address isn't associated with a
+	 * symbol.  GCC jump tables are anonymous data.
+	 *
+	 * Also support C jump tables which are in the same format as
+	 * switch jump tables.  For objtool to recognize them, they
+	 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
+	 * have symbols associated with them.
+	 */
+	if (find_symbol_containing(table_sec, table_offset) &&
+	    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
+		return NULL;
+
+	/*
+	 * Each table entry has a rela associated with it.  The rela
+	 * should reference text in the same function as the original
+	 * instruction.
+	 */
+	rodata_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
+	if (!rodata_reloc)
+		return NULL;
+
+	/*
+	 * Use of RIP-relative switch jumps is quite rare, and
+	 * indicates a rare GCC quirk/bug which can leave dead
+	 * code behind.
+	 */
+	if (text_reloc->type == R_X86_64_PC32)
+		file->ignore_unreachables = true;
+
+	return rodata_reloc;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1796a7c..a94ad88 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -20,8 +20,6 @@
 
 #define FAKE_JUMP_OFFSET -1
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
-
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -1190,56 +1188,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 }
 
 /*
- * find_jump_table() - Given a dynamic jump, find the switch jump table in
- * .rodata associated with it.
- *
- * There are 3 basic patterns:
- *
- * 1. jmpq *[rodata addr](,%reg,8)
- *
- *    This is the most common case by far.  It jumps to an address in a simple
- *    jump table which is stored in .rodata.
- *
- * 2. jmpq *[rodata addr](%rip)
- *
- *    This is caused by a rare GCC quirk, currently only seen in three driver
- *    functions in the kernel, only with certain obscure non-distro configs.
- *
- *    As part of an optimization, GCC makes a copy of an existing switch jump
- *    table, modifies it, and then hard-codes the jump (albeit with an indirect
- *    jump) to use a single entry in the table.  The rest of the jump table and
- *    some of its jump targets remain as dead code.
- *
- *    In such a case we can just crudely ignore all unreachable instruction
- *    warnings for the entire object file.  Ideally we would just ignore them
- *    for the function, but that would require redesigning the code quite a
- *    bit.  And honestly that's just not worth doing: unreachable instruction
- *    warnings are of questionable value anyway, and this is such a rare issue.
- *
- * 3. mov [rodata addr],%reg1
- *    ... some instructions ...
- *    jmpq *(%reg1,%reg2,8)
- *
- *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
- *    writing, there are 11 occurrences of it in the allmodconfig kernel.
- *
- *    As of GCC 7 there are quite a few more of these and the 'in between' code
- *    is significant. Esp. with KASAN enabled some of the code between the mov
- *    and jmpq uses .rodata itself, which can confuse things.
- *
- *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
- *    ensure the same register is used in the mov and jump instructions.
- *
- *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
+ * find_jump_table() - Given a dynamic jump, find the switch jump table
+ * associated with it.
  */
 static struct reloc *find_jump_table(struct objtool_file *file,
 				      struct symbol *func,
 				      struct instruction *insn)
 {
-	struct reloc *text_reloc, *table_reloc;
+	struct reloc *table_reloc;
 	struct instruction *dest_insn, *orig_insn = insn;
-	struct section *table_sec;
-	unsigned long table_offset;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -1260,52 +1217,13 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		     insn->jump_dest->offset > orig_insn->offset))
 		    break;
 
-		/* look for a relocation which references .rodata */
-		text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-						    insn->offset, insn->len);
-		if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
-		    !text_reloc->sym->sec->rodata)
-			continue;
-
-		table_offset = text_reloc->addend;
-		table_sec = text_reloc->sym->sec;
-
-		if (text_reloc->type == R_X86_64_PC32)
-			table_offset += 4;
-
-		/*
-		 * Make sure the .rodata address isn't associated with a
-		 * symbol.  GCC jump tables are anonymous data.
-		 *
-		 * Also support C jump tables which are in the same format as
-		 * switch jump tables.  For objtool to recognize them, they
-		 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
-		 * have symbols associated with them.
-		 */
-		if (find_symbol_containing(table_sec, table_offset) &&
-		    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
-			continue;
-
-		/*
-		 * Each table entry has a reloc associated with it.  The reloc
-		 * should reference text in the same function as the original
-		 * instruction.
-		 */
-		table_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
+		table_reloc = arch_find_switch_table(file, insn);
 		if (!table_reloc)
 			continue;
 		dest_insn = find_insn(file, table_reloc->sym->sec, table_reloc->addend);
 		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc != func)
 			continue;
 
-		/*
-		 * Use of RIP-relative switch jumps is quite rare, and
-		 * indicates a rare GCC quirk/bug which can leave dead code
-		 * behind.
-		 */
-		if (text_reloc->type == R_X86_64_PC32)
-			file->ignore_unreachables = true;
-
 		return table_reloc;
 	}
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 1de1188..5ec00a4 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -66,5 +66,4 @@ struct instruction *find_insn(struct objtool_file *file,
 			insn->sec == sec;				\
 	     insn = list_next_entry(insn, list))
 
-
 #endif /* _CHECK_H */
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 1dc1bb3..abddf38 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -10,6 +10,8 @@
 #include "check.h"
 #include "elf.h"
 
+#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+
 struct special_alt {
 	struct list_head list;
 
@@ -34,4 +36,6 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc);
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn);
 #endif /* _SPECIAL_H */
