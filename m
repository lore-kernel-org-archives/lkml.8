Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EACA20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIDPdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:33:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41166 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgIDPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:33:49 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-G_Mgdu9XON2HkzIs9-ufrw-1; Fri, 04 Sep 2020 11:33:45 -0400
X-MC-Unique: G_Mgdu9XON2HkzIs9-ufrw-1
Received: by mail-ed1-f69.google.com with SMTP id l2so2837373ede.19
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gcjr8g5SirYBSxXDWBF2fMCXgH8ra+/9L+L+1KdYBIM=;
        b=E/sfTQFChoFw6iRJIxNeaMrjEBnjXU8RmUhudeVdmugNuuIe0hFgGtib7N8PWPqh9N
         XtkkQ2KdlzGfNGoqaLHkpmLIOEH9PYZd8n4G6qviKPnRVBY9Riy8MKEys/q3eaRV9asI
         QjeIzYiymdFmQdFNLq/8wj44szd10/2UM8pJY89m40zOdnQez7ngiZjx/DuqkKYGv+Ri
         ayloZv3dgb3BJBRNT0HGX/WKfjRCvaSLuFDnEklvEc2e/u+gSkO+Z+y+Y6jxVzcangTz
         cN9Amks94BkJXTB5E0g3bSdRTblV89UbQ/7ZPJ2uL8v2iydIOkca5CwN8M1Y88XlHh1Y
         e+3g==
X-Gm-Message-State: AOAM531/VXW78z/SzZZooKrXWe1Xqnt/HGmcagFha21ORksFXq/45fKT
        fjjhcIa2Twe6gn/lm6GBf2DSOB24CjFaGmMyADLH5AWx6kmvM51gU0FAMTQ8rbj16xhzdwqa7oJ
        AdIE8UC/wcZUyjByvvXrRkWno
X-Received: by 2002:a50:8d57:: with SMTP id t23mr9366330edt.308.1599233624212;
        Fri, 04 Sep 2020 08:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGcWVi1EgYPHzaVHzUUI2tu/RF7XFT1TOD3iDr4hJ+idZuhsd2fqjiCLlUzquhJnb/TyPClw==
X-Received: by 2002:a50:8d57:: with SMTP id t23mr9366293edt.308.1599233623872;
        Fri, 04 Sep 2020 08:33:43 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j3sm6251221eje.75.2020.09.04.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:33:43 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 06/10] objtool: Refactor switch-tables code to support other architectures
Date:   Fri,  4 Sep 2020 16:30:24 +0100
Message-Id: <20200904153028.32676-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

The way to identify switch-tables and retrieves all the data necessary
to handle the different execution branches is not the same on all
architecture. In order to be able to add other architecture support,
define an arch-dependent function to process jump-tables.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Move arm64 bits out of this patch,
       Have only one function to find the start of the jump table,
       for now assume that the jump table format will be the same as
       x86]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/special.c | 95 ++++++++++++++++++++++++++++++++
 tools/objtool/check.c            | 88 +----------------------------
 tools/objtool/check.h            |  1 -
 tools/objtool/special.h          |  4 ++
 4 files changed, 102 insertions(+), 86 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 34e0e162e6fd..fd4af88c0ea5 100644
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
index 8217a9a9a838..921b4ba2d0f9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -19,8 +19,6 @@
 
 #define FAKE_JUMP_OFFSET -1
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
-
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -1085,55 +1083,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 
 /*
  * find_jump_table() - Given a dynamic jump, find the switch jump table in
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
@@ -1154,52 +1111,13 @@ static struct reloc *find_jump_table(struct objtool_file *file,
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
index 58374255934b..714ab8df51df 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -65,5 +65,4 @@ struct instruction *find_insn(struct objtool_file *file,
 			insn->sec == sec;				\
 	     insn = list_next_entry(insn, list))
 
-
 #endif /* _CHECK_H */
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 1dc1bb3e74c6..abddf38ef334 100644
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
-- 
2.21.3

