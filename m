Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4CB206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgB1kbDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgFHP2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730260AbgFHP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLL/LvbCg6sI+PUQYZsWWFiOJR+42LVNu4qeLgPuoyY=;
        b=UgB1kbDr0XcBZ24B9x7cSUYX39lNVmj78f4o0zn46tINvPIeV6bUUVLR6Tgz0pO5+ghcm7
        FlA1pOgUhcWzcHlaE1wODLFpI4UzRmvuxPxPIOXLezLR5B4AiyGnM15YVx2Lavv8275dEx
        48NuYsTqJVEPvNEEmXcXLgfX4/arGkI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-mizYC_81OTqf9D8SmJtkdA-1; Mon, 08 Jun 2020 11:28:05 -0400
X-MC-Unique: mizYC_81OTqf9D8SmJtkdA-1
Received: by mail-wr1-f69.google.com with SMTP id p9so7322104wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLL/LvbCg6sI+PUQYZsWWFiOJR+42LVNu4qeLgPuoyY=;
        b=SMswHD4LdPQyjoN+moVzwwzOmw+yN57Wvb5/NU8hiuDvjyKsKHwAqSQls8logBTuBf
         drJfEEUETHID0GBTHnXfrzYIeWhPXG/Qjq95F4Yjq7eEW0OguDh++LJhpo5io1vYxULQ
         xpzMEX3USdgRJdKZg8guJdROzO9EamOD5c+6vo2ZZrqqqg3qrm6VsUBxBLE7Yhh7cMOj
         Z6A9f/w0LQf2ivlbUsRdyiKdOaqsrtIpVPUNY221WFAZLvzYtbe0v+RUlxOgdg/fUjpE
         uJVa4fyqb/ay3n4wHHnRHm0lTFdQjF3T4rwWaUGqYRvvOpuXL60C6WG4l3R6XwjfVeNA
         6L2g==
X-Gm-Message-State: AOAM533H6Pc6MTbzdf1MdVbVC0hvyWWylY+gTbFHUH49Y5TMUcsFrIfS
        agNj/H76thjJDZiRNAqQY9KeB/1f8lxisNDG0VAzsCPVJwPTqrB66DFKSrpYTdznzvfFIyRwQRm
        B4bbBGSC/WPDxOSXBJktITVcP
X-Received: by 2002:a5d:5092:: with SMTP id a18mr23879988wrt.42.1591630084172;
        Mon, 08 Jun 2020 08:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcL1gn6l+1u8L4LBir3PyP8/4phnh5toKKhPtuk9g8DDxHP9Fhmiz1k/4gM6RRGKhXfNWJyw==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr23879963wrt.42.1591630083806;
        Mon, 08 Jun 2020 08:28:03 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:28:03 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 6/7] objtool: Refactor switch-tables code to support other architectures
Date:   Mon,  8 Jun 2020 16:27:53 +0100
Message-Id: <20200608152754.2483-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
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

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Move arm64 bits out of this patch,
       Have only one function to find the start of the jump table,
       for now assume that the jump table format will be the same as
       x86]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/arch_special.c | 95 +++++++++++++++++++++++++++
 tools/objtool/check.c                 | 88 +------------------------
 tools/objtool/check.h                 |  1 -
 tools/objtool/special.h               |  4 ++
 4 files changed, 102 insertions(+), 86 deletions(-)

diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
index 4931ad1a0ab5..fa4571c8ae5d 100644
--- a/tools/objtool/arch/x86/arch_special.c
+++ b/tools/objtool/arch/x86/arch_special.c
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
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn)
+{
+	struct rela *text_rela, *rodata_rela;
+	struct section *table_sec;
+	unsigned long table_offset;
+
+	/* look for a relocation which references .rodata */
+	text_rela = find_rela_by_dest_range(file->elf, insn->sec,
+					    insn->offset, insn->len);
+	if (!text_rela || text_rela->sym->type != STT_SECTION ||
+	    !text_rela->sym->sec->rodata)
+		return NULL;
+
+	table_offset = text_rela->addend;
+	table_sec = text_rela->sym->sec;
+
+	if (text_rela->type == R_X86_64_PC32)
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
+	rodata_rela = find_rela_by_dest(file->elf, table_sec, table_offset);
+	if (!rodata_rela)
+		return NULL;
+
+	/*
+	 * Use of RIP-relative switch jumps is quite rare, and
+	 * indicates a rare GCC quirk/bug which can leave dead
+	 * code behind.
+	 */
+	if (text_rela->type == R_X86_64_PC32)
+		file->ignore_unreachables = true;
+
+	return rodata_rela;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 738bfd458595..444688264c39 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,8 +18,6 @@
 
 #define FAKE_JUMP_OFFSET -1
 
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
-
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -1044,55 +1042,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 
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
 static struct rela *find_jump_table(struct objtool_file *file,
 				      struct symbol *func,
 				      struct instruction *insn)
 {
-	struct rela *text_rela, *table_rela;
+	struct rela *table_rela;
 	struct instruction *dest_insn, *orig_insn = insn;
-	struct section *table_sec;
-	unsigned long table_offset;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -1113,52 +1070,13 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		     insn->jump_dest->offset > orig_insn->offset))
 		    break;
 
-		/* look for a relocation which references .rodata */
-		text_rela = find_rela_by_dest_range(file->elf, insn->sec,
-						    insn->offset, insn->len);
-		if (!text_rela || text_rela->sym->type != STT_SECTION ||
-		    !text_rela->sym->sec->rodata)
-			continue;
-
-		table_offset = text_rela->addend;
-		table_sec = text_rela->sym->sec;
-
-		if (text_rela->type == R_X86_64_PC32)
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
-		 * Each table entry has a rela associated with it.  The rela
-		 * should reference text in the same function as the original
-		 * instruction.
-		 */
-		table_rela = find_rela_by_dest(file->elf, table_sec, table_offset);
+		table_rela = arch_find_switch_table(file, insn);
 		if (!table_rela)
 			continue;
 		dest_insn = find_insn(file, table_rela->sym->sec, table_rela->addend);
 		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc != func)
 			continue;
 
-		/*
-		 * Use of RIP-relative switch jumps is quite rare, and
-		 * indicates a rare GCC quirk/bug which can leave dead code
-		 * behind.
-		 */
-		if (text_rela->type == R_X86_64_PC32)
-			file->ignore_unreachables = true;
-
 		return table_rela;
 	}
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 785388cf3872..1ecf8f9125a6 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -62,5 +62,4 @@ struct instruction *find_insn(struct objtool_file *file,
 			insn->sec == sec;				\
 	     insn = list_next_entry(insn, list))
 
-
 #endif /* _CHECK_H */
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index e15d52d3595d..0f35a67c93b8 100644
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
 				 struct rela *rela);
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn);
 #endif /* _SPECIAL_H */
-- 
2.21.1

