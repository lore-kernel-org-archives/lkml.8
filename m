Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A19C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E43214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgE2VBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:01:32 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31982 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgE2VB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:01:27 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 29 May 2020 14:01:21 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9C579B29FE;
        Fri, 29 May 2020 17:01:25 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH 1/2] objtool: Rename rela to reloc
Date:   Fri, 29 May 2020 14:01:13 -0700
Message-ID: <39f183f3acec8a758939dcbede7908a7455be8b8.1590785960.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1590785960.git.mhelsley@vmware.com>
References: <cover.1590785960.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before supporting additional relocation types rename the relevant
types and functions from "rela" to "reloc". This work be done with
the following regex:

	sed -i -e 's/struct rela/struct reloc/g' \
		-e 's/\([_\*]\)rela\(s\{0,1\}\)/\1reloc\2/g' \
		-e 's/tmprela\(s\{0,1\}\)/tmpreloc\1/g' \
		-e 's/relasec/relocsec/g' \
		-e 's/rela_list/reloc_list/g' \
		-e 's/rela_hash/reloc_hash/g' \
		-e 's/add_rela/add_reloc/g' \
		-e 's/rela->/reloc->/g' \
		-e '/rela[,\.]/{ s/\([^\.>]\)rela\([\.,]\)/\1reloc\2/g ; }' \
		-e 's/rela =/reloc =/g' \
		-e 's/relas =/relocs =/g' \
		-e 's/relas\[/relocs[/g' \
		-e 's/relaname =/relocname =/g' \
		-e 's/= rela\;/= reloc\;/g' \
		-e 's/= relas\;/= relocs\;/g' \
		-e 's/= relaname\;/= relocname\;/g' \
		-e 's/, rela)/, reloc)/g' \
		-e 's/, relaname/, relocname/g' \
		-e 's/sec->rela/sec->reloc/g' \
		-e 's/(\(!\{0,1\}\)rela/(\1reloc/g' \
		arch.h \
		arch/x86/decode.c  \
		check.c \
		check.h \
		elf.c \
		elf.h \
		orc_gen.c \
		special.c \

Notable exceptions which complicate the regex include gelf_*
library calls and standard/expected section names which still use
"rela" because they encode the type of relocation expected. Also, keep
"rela" in the struct because it encodes a specific type of relocation
we currently expect.

It will eventually turn into a member of an anonymous union when a
susequent patch adds implicit addend, or "rel", relocation support.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/arch.h            |   2 +-
 tools/objtool/arch/x86/decode.c |   2 +-
 tools/objtool/check.c           | 190 ++++++++++++++++----------------
 tools/objtool/check.h           |   2 +-
 tools/objtool/elf.c             | 134 +++++++++++-----------
 tools/objtool/elf.h             |  22 ++--
 tools/objtool/orc_gen.c         |  44 ++++----
 tools/objtool/special.c         |  22 ++--
 8 files changed, 209 insertions(+), 209 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index eda15a5a285e..d0969a9328c2 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -82,6 +82,6 @@ bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
 
-unsigned long arch_dest_rela_offset(int addend);
+unsigned long arch_dest_reloc_offset(int addend);
 
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 4b504fc90bbb..fe83d4c92825 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -67,7 +67,7 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
-unsigned long arch_dest_rela_offset(int addend)
+unsigned long arch_dest_reloc_offset(int addend)
 {
 	return addend + 4;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 63d65a702900..4c39734b29ed 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -352,7 +352,7 @@ static struct instruction *find_last_insn(struct objtool_file *file,
 static int add_dead_ends(struct objtool_file *file)
 {
 	struct section *sec;
-	struct rela *rela;
+	struct reloc *reloc;
 	struct instruction *insn;
 
 	/*
@@ -370,24 +370,24 @@ static int add_dead_ends(struct objtool_file *file)
 	if (!sec)
 		goto reachable;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		if (rela->sym->type != STT_SECTION) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
 			insn = list_prev_entry(insn, list);
-		else if (rela->addend == rela->sym->sec->len) {
-			insn = find_last_insn(file, rela->sym->sec);
+		else if (reloc->addend == reloc->sym->sec->len) {
+			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",
-				     rela->sym->sec->name, rela->addend);
+				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
 			WARN("can't find unreachable insn at %s+0x%x",
-			     rela->sym->sec->name, rela->addend);
+			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
 
@@ -405,24 +405,24 @@ static int add_dead_ends(struct objtool_file *file)
 	if (!sec)
 		return 0;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		if (rela->sym->type != STT_SECTION) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
 			insn = list_prev_entry(insn, list);
-		else if (rela->addend == rela->sym->sec->len) {
-			insn = find_last_insn(file, rela->sym->sec);
+		else if (reloc->addend == reloc->sym->sec->len) {
+			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%x",
-				     rela->sym->sec->name, rela->addend);
+				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
 			WARN("can't find reachable insn at %s+0x%x",
-			     rela->sym->sec->name, rela->addend);
+			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
 
@@ -440,26 +440,26 @@ static void add_ignores(struct objtool_file *file)
 	struct instruction *insn;
 	struct section *sec;
 	struct symbol *func;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
 	if (!sec)
 		return;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		switch (rela->sym->type) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		switch (reloc->sym->type) {
 		case STT_FUNC:
-			func = rela->sym;
+			func = reloc->sym;
 			break;
 
 		case STT_SECTION:
-			func = find_func_by_offset(rela->sym->sec, rela->addend);
+			func = find_func_by_offset(reloc->sym->sec, reloc->addend);
 			if (!func)
 				continue;
 			break;
 
 		default:
-			WARN("unexpected relocation symbol type in %s: %d", sec->name, rela->sym->type);
+			WARN("unexpected relocation symbol type in %s: %d", sec->name, reloc->sym->type);
 			continue;
 		}
 
@@ -557,20 +557,20 @@ static void add_uaccess_safe(struct objtool_file *file)
 static int add_ignore_alternatives(struct objtool_file *file)
 {
 	struct section *sec;
-	struct rela *rela;
+	struct reloc *reloc;
 	struct instruction *insn;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
 	if (!sec)
 		return 0;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		if (rela->sym->type != STT_SECTION) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.ignore_alts entry");
 			return -1;
@@ -588,7 +588,7 @@ static int add_ignore_alternatives(struct objtool_file *file)
 static int add_jump_destinations(struct objtool_file *file)
 {
 	struct instruction *insn;
-	struct rela *rela;
+	struct reloc *reloc;
 	struct section *dest_sec;
 	unsigned long dest_off;
 
@@ -599,19 +599,19 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
-		rela = find_rela_by_dest_range(file->elf, insn->sec,
+		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 					       insn->offset, insn->len);
-		if (!rela) {
+		if (!reloc) {
 			dest_sec = insn->sec;
 			dest_off = arch_jump_destination(insn);
-		} else if (rela->sym->type == STT_SECTION) {
-			dest_sec = rela->sym->sec;
-			dest_off = arch_dest_rela_offset(rela->addend);
-		} else if (rela->sym->sec->idx) {
-			dest_sec = rela->sym->sec;
-			dest_off = rela->sym->sym.st_value +
-				   arch_dest_rela_offset(rela->addend);
-		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
+		} else if (reloc->sym->type == STT_SECTION) {
+			dest_sec = reloc->sym->sec;
+			dest_off = arch_dest_reloc_offset(reloc->addend);
+		} else if (reloc->sym->sec->idx) {
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->sym.st_value +
+				   arch_dest_reloc_offset(reloc->addend);
+		} else if (strstr(reloc->sym->name, "_indirect_thunk_")) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -625,7 +625,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			continue;
 		} else {
 			/* external sibling call */
-			insn->call_dest = rela->sym;
+			insn->call_dest = reloc->sym;
 			continue;
 		}
 
@@ -701,15 +701,15 @@ static int add_call_destinations(struct objtool_file *file)
 {
 	struct instruction *insn;
 	unsigned long dest_off;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	for_each_insn(file, insn) {
 		if (insn->type != INSN_CALL)
 			continue;
 
-		rela = find_rela_by_dest_range(file->elf, insn->sec,
+		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 					       insn->offset, insn->len);
-		if (!rela) {
+		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
 			if (!insn->call_dest)
@@ -729,19 +729,19 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-		} else if (rela->sym->type == STT_SECTION) {
-			dest_off = arch_dest_rela_offset(rela->addend);
-			insn->call_dest = find_func_by_offset(rela->sym->sec,
+		} else if (reloc->sym->type == STT_SECTION) {
+			dest_off = arch_dest_reloc_offset(reloc->addend);
+			insn->call_dest = find_func_by_offset(reloc->sym->sec,
 							      dest_off);
 			if (!insn->call_dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
-					  rela->sym->sec->name,
+					  reloc->sym->sec->name,
 					  dest_off);
 				return -1;
 			}
 		} else
-			insn->call_dest = rela->sym;
+			insn->call_dest = reloc->sym;
 
 		/*
 		 * Whatever stack impact regular CALLs have, should be undone
@@ -849,7 +849,7 @@ static int handle_group_alt(struct objtool_file *file,
 		 */
 		if ((insn->offset != special_alt->new_off ||
 		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
-		    find_rela_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
+		    find_reloc_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
@@ -995,9 +995,9 @@ static int add_special_section_alts(struct objtool_file *file)
 }
 
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			    struct rela *table)
+			    struct reloc *table)
 {
-	struct rela *rela = table;
+	struct reloc *reloc = table;
 	struct instruction *dest_insn;
 	struct alternative *alt;
 	struct symbol *pfunc = insn->func->pfunc;
@@ -1007,22 +1007,22 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	 * Each @rela is a switch table relocation which points to the target
 	 * instruction.
 	 */
-	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
+	list_for_each_entry_from(reloc, &table->sec->reloc_list, list) {
 
 		/* Check for the end of the table: */
-		if (rela != table && rela->jump_table_start)
+		if (reloc != table && reloc->jump_table_start)
 			break;
 
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && rela->offset != prev_offset + 8)
+		if (prev_offset && reloc->offset != prev_offset + 8)
 			break;
 
 		/* Detect function pointers from contiguous objects: */
-		if (rela->sym->sec == pfunc->sec &&
-		    rela->addend == pfunc->offset)
+		if (reloc->sym->sec == pfunc->sec &&
+		    reloc->addend == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, rela->sym->sec, rela->addend);
+		dest_insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!dest_insn)
 			break;
 
@@ -1038,7 +1038,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 
 		alt->insn = dest_insn;
 		list_add_tail(&alt->list, &insn->alts);
-		prev_offset = rela->offset;
+		prev_offset = reloc->offset;
 	}
 
 	if (!prev_offset) {
@@ -1093,11 +1093,11 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
  *
  *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
-static struct rela *find_jump_table(struct objtool_file *file,
+static struct reloc *find_jump_table(struct objtool_file *file,
 				      struct symbol *func,
 				      struct instruction *insn)
 {
-	struct rela *text_rela, *table_rela;
+	struct reloc *text_reloc, *table_reloc;
 	struct instruction *dest_insn, *orig_insn = insn;
 	struct section *table_sec;
 	unsigned long table_offset;
@@ -1122,16 +1122,16 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		    break;
 
 		/* look for a relocation which references .rodata */
-		text_rela = find_rela_by_dest_range(file->elf, insn->sec,
+		text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 						    insn->offset, insn->len);
-		if (!text_rela || text_rela->sym->type != STT_SECTION ||
-		    !text_rela->sym->sec->rodata)
+		if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
+		    !text_reloc->sym->sec->rodata)
 			continue;
 
-		table_offset = text_rela->addend;
-		table_sec = text_rela->sym->sec;
+		table_offset = text_reloc->addend;
+		table_sec = text_reloc->sym->sec;
 
-		if (text_rela->type == R_X86_64_PC32)
+		if (text_reloc->type == R_X86_64_PC32)
 			table_offset += 4;
 
 		/*
@@ -1152,10 +1152,10 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		 * should reference text in the same function as the original
 		 * instruction.
 		 */
-		table_rela = find_rela_by_dest(file->elf, table_sec, table_offset);
-		if (!table_rela)
+		table_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
+		if (!table_reloc)
 			continue;
-		dest_insn = find_insn(file, table_rela->sym->sec, table_rela->addend);
+		dest_insn = find_insn(file, table_reloc->sym->sec, table_reloc->addend);
 		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc != func)
 			continue;
 
@@ -1164,10 +1164,10 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		 * indicates a rare GCC quirk/bug which can leave dead code
 		 * behind.
 		 */
-		if (text_rela->type == R_X86_64_PC32)
+		if (text_reloc->type == R_X86_64_PC32)
 			file->ignore_unreachables = true;
 
-		return table_rela;
+		return table_reloc;
 	}
 
 	return NULL;
@@ -1181,7 +1181,7 @@ static void mark_func_jump_tables(struct objtool_file *file,
 				    struct symbol *func)
 {
 	struct instruction *insn, *last = NULL;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	func_for_each_insn(file, func, insn) {
 		if (!last)
@@ -1204,10 +1204,10 @@ static void mark_func_jump_tables(struct objtool_file *file,
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
-		rela = find_jump_table(file, func, insn);
-		if (rela) {
-			rela->jump_table_start = true;
-			insn->jump_table = rela;
+		reloc = find_jump_table(file, func, insn);
+		if (reloc) {
+			reloc->jump_table_start = true;
+			insn->jump_table = reloc;
 		}
 	}
 }
@@ -1261,8 +1261,8 @@ static int add_jump_table_alts(struct objtool_file *file)
 
 static int read_unwind_hints(struct objtool_file *file)
 {
-	struct section *sec, *relasec;
-	struct rela *rela;
+	struct section *sec, *relocsec;
+	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
 	struct cfi_reg *cfa;
@@ -1272,8 +1272,8 @@ static int read_unwind_hints(struct objtool_file *file)
 	if (!sec)
 		return 0;
 
-	relasec = sec->rela;
-	if (!relasec) {
+	relocsec = sec->reloc;
+	if (!relocsec) {
 		WARN("missing .rela.discard.unwind_hints section");
 		return -1;
 	}
@@ -1288,13 +1288,13 @@ static int read_unwind_hints(struct objtool_file *file)
 	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
 		hint = (struct unwind_hint *)sec->data->d_buf + i;
 
-		rela = find_rela_by_dest(file->elf, sec, i * sizeof(*hint));
-		if (!rela) {
+		reloc = find_reloc_by_dest(file->elf, sec, i * sizeof(*hint));
+		if (!reloc) {
 			WARN("can't find rela for unwind_hints[%d]", i);
 			return -1;
 		}
 
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!insn) {
 			WARN("can't find insn for unwind_hints[%d]", i);
 			return -1;
@@ -1352,19 +1352,19 @@ static int read_retpoline_hints(struct objtool_file *file)
 {
 	struct section *sec;
 	struct instruction *insn;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
 	if (!sec)
 		return 0;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		if (rela->sym->type != STT_SECTION) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.retpoline_safe entry");
 			return -1;
@@ -1387,19 +1387,19 @@ static int read_instr_hints(struct objtool_file *file)
 {
 	struct section *sec;
 	struct instruction *insn;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.instr_end");
 	if (!sec)
 		return 0;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		if (rela->sym->type != STT_SECTION) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.instr_end entry");
 			return -1;
@@ -1412,13 +1412,13 @@ static int read_instr_hints(struct objtool_file *file)
 	if (!sec)
 		return 0;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		if (rela->sym->type != STT_SECTION) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.instr_begin entry");
 			return -1;
@@ -1434,22 +1434,22 @@ static int read_intra_function_calls(struct objtool_file *file)
 {
 	struct instruction *insn;
 	struct section *sec;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
 	if (!sec)
 		return 0;
 
-	list_for_each_entry(rela, &sec->rela_list, list) {
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		unsigned long dest_off;
 
-		if (rela->sym->type != STT_SECTION) {
+		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s",
 			     sec->name);
 			return -1;
 		}
 
-		insn = find_insn(file, rela->sym->sec, rela->addend);
+		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.intra_function_call entry");
 			return -1;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 906b5210f7ca..061aa96e15d3 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -37,7 +37,7 @@ struct instruction {
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
-	struct rela *jump_table;
+	struct reloc *jump_table;
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c1ba92abaa03..c21e8417637b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -228,26 +228,26 @@ struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 	return NULL;
 }
 
-struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
+struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len)
 {
-	struct rela *rela, *r = NULL;
+	struct reloc *reloc, *r = NULL;
 	unsigned long o;
 
-	if (!sec->rela)
+	if (!sec->reloc)
 		return NULL;
 
-	sec = sec->rela;
+	sec = sec->reloc;
 
 	for_offset_range(o, offset, offset + len) {
-		elf_hash_for_each_possible(elf->rela_hash, rela, hash,
+		elf_hash_for_each_possible(elf->reloc_hash, reloc, hash,
 				       sec_offset_hash(sec, o)) {
-			if (rela->sec != sec)
+			if (reloc->sec != sec)
 				continue;
 
-			if (rela->offset >= offset && rela->offset < offset + len) {
-				if (!r || rela->offset < r->offset)
-					r = rela;
+			if (reloc->offset >= offset && reloc->offset < offset + len) {
+				if (!r || reloc->offset < r->offset)
+					r = reloc;
 			}
 		}
 		if (r)
@@ -257,9 +257,9 @@ struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 	return NULL;
 }
 
-struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset)
+struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset)
 {
-	return find_rela_by_dest_range(elf, sec, offset, 1);
+	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
 static int read_sections(struct elf *elf)
@@ -288,7 +288,7 @@ static int read_sections(struct elf *elf)
 		memset(sec, 0, sizeof(*sec));
 
 		INIT_LIST_HEAD(&sec->symbol_list);
-		INIT_LIST_HEAD(&sec->rela_list);
+		INIT_LIST_HEAD(&sec->reloc_list);
 
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
@@ -482,21 +482,21 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
-void elf_add_rela(struct elf *elf, struct rela *rela)
+void elf_add_reloc(struct elf *elf, struct reloc *reloc)
 {
-	struct section *sec = rela->sec;
+	struct section *sec = reloc->sec;
 
-	list_add_tail(&rela->list, &sec->rela_list);
-	elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+	list_add_tail(&reloc->list, &sec->reloc_list);
+	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
 }
 
-static int read_relas(struct elf *elf)
+static int read_relocs(struct elf *elf)
 {
 	struct section *sec;
-	struct rela *rela;
+	struct reloc *reloc;
 	int i;
 	unsigned int symndx;
-	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
+	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->sh.sh_type != SHT_RELA)
@@ -509,44 +509,44 @@ static int read_relas(struct elf *elf)
 			return -1;
 		}
 
-		sec->base->rela = sec;
+		sec->base->reloc = sec;
 
-		nr_rela = 0;
+		nr_reloc = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
-			rela = malloc(sizeof(*rela));
-			if (!rela) {
+			reloc = malloc(sizeof(*reloc));
+			if (!reloc) {
 				perror("malloc");
 				return -1;
 			}
-			memset(rela, 0, sizeof(*rela));
+			memset(reloc, 0, sizeof(*reloc));
 
-			if (!gelf_getrela(sec->data, i, &rela->rela)) {
+			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
 				WARN_ELF("gelf_getrela");
 				return -1;
 			}
 
-			rela->type = GELF_R_TYPE(rela->rela.r_info);
-			rela->addend = rela->rela.r_addend;
-			rela->offset = rela->rela.r_offset;
-			symndx = GELF_R_SYM(rela->rela.r_info);
-			rela->sym = find_symbol_by_index(elf, symndx);
-			rela->sec = sec;
-			if (!rela->sym) {
+			reloc->type = GELF_R_TYPE(reloc->rela.r_info);
+			reloc->addend = reloc->rela.r_addend;
+			reloc->offset = reloc->rela.r_offset;
+			symndx = GELF_R_SYM(reloc->rela.r_info);
+			reloc->sym = find_symbol_by_index(elf, symndx);
+			reloc->sec = sec;
+			if (!reloc->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
 				return -1;
 			}
 
-			elf_add_rela(elf, rela);
-			nr_rela++;
+			elf_add_reloc(elf, reloc);
+			nr_reloc++;
 		}
-		max_rela = max(max_rela, nr_rela);
-		tot_rela += nr_rela;
+		max_reloc = max(max_reloc, nr_reloc);
+		tot_reloc += nr_reloc;
 	}
 
 	if (stats) {
-		printf("max_rela: %lu\n", max_rela);
-		printf("tot_rela: %lu\n", tot_rela);
+		printf("max_reloc: %lu\n", max_reloc);
+		printf("tot_reloc: %lu\n", tot_reloc);
 	}
 
 	return 0;
@@ -572,7 +572,7 @@ struct elf *elf_open_read(const char *name, int flags)
 	elf_hash_init(elf->symbol_name_hash);
 	elf_hash_init(elf->section_hash);
 	elf_hash_init(elf->section_name_hash);
-	elf_hash_init(elf->rela_hash);
+	elf_hash_init(elf->reloc_hash);
 
 	elf->fd = open(name, flags);
 	if (elf->fd == -1) {
@@ -605,7 +605,7 @@ struct elf *elf_open_read(const char *name, int flags)
 	if (read_symbols(elf))
 		goto err;
 
-	if (read_relas(elf))
+	if (read_relocs(elf))
 		goto err;
 
 	return elf;
@@ -631,7 +631,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	memset(sec, 0, sizeof(*sec));
 
 	INIT_LIST_HEAD(&sec->symbol_list);
-	INIT_LIST_HEAD(&sec->rela_list);
+	INIT_LIST_HEAD(&sec->reloc_list);
 
 	s = elf_newscn(elf->elf);
 	if (!s) {
@@ -716,25 +716,25 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	return sec;
 }
 
-struct section *elf_create_rela_section(struct elf *elf, struct section *base)
+struct section *elf_create_reloc_section(struct elf *elf, struct section *base)
 {
-	char *relaname;
+	char *relocname;
 	struct section *sec;
 
-	relaname = malloc(strlen(base->name) + strlen(".rela") + 1);
-	if (!relaname) {
+	relocname = malloc(strlen(base->name) + strlen(".rela") + 1);
+	if (!relocname) {
 		perror("malloc");
 		return NULL;
 	}
-	strcpy(relaname, ".rela");
-	strcat(relaname, base->name);
+	strcpy(relocname, ".rela");
+	strcat(relocname, base->name);
 
-	sec = elf_create_section(elf, relaname, sizeof(GElf_Rela), 0);
-	free(relaname);
+	sec = elf_create_section(elf, relocname, sizeof(GElf_Rela), 0);
+	free(relocname);
 	if (!sec)
 		return NULL;
 
-	base->rela = sec;
+	base->reloc = sec;
 	sec->base = base;
 
 	sec->sh.sh_type = SHT_RELA;
@@ -746,33 +746,33 @@ struct section *elf_create_rela_section(struct elf *elf, struct section *base)
 	return sec;
 }
 
-int elf_rebuild_rela_section(struct section *sec)
+int elf_rebuild_reloc_section(struct section *sec)
 {
-	struct rela *rela;
+	struct reloc *reloc;
 	int nr, idx = 0, size;
-	GElf_Rela *relas;
+	GElf_Rela *relocs;
 
 	nr = 0;
-	list_for_each_entry(rela, &sec->rela_list, list)
+	list_for_each_entry(reloc, &sec->reloc_list, list)
 		nr++;
 
-	size = nr * sizeof(*relas);
-	relas = malloc(size);
-	if (!relas) {
+	size = nr * sizeof(*relocs);
+	relocs = malloc(size);
+	if (!relocs) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relas;
+	sec->data->d_buf = relocs;
 	sec->data->d_size = size;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
-	list_for_each_entry(rela, &sec->rela_list, list) {
-		relas[idx].r_offset = rela->offset;
-		relas[idx].r_addend = rela->addend;
-		relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		relocs[idx].r_offset = reloc->offset;
+		relocs[idx].r_addend = reloc->addend;
+		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
 		idx++;
 	}
 
@@ -815,7 +815,7 @@ void elf_close(struct elf *elf)
 {
 	struct section *sec, *tmpsec;
 	struct symbol *sym, *tmpsym;
-	struct rela *rela, *tmprela;
+	struct reloc *reloc, *tmpreloc;
 
 	if (elf->elf)
 		elf_end(elf->elf);
@@ -829,10 +829,10 @@ void elf_close(struct elf *elf)
 			hash_del(&sym->hash);
 			free(sym);
 		}
-		list_for_each_entry_safe(rela, tmprela, &sec->rela_list, list) {
-			list_del(&rela->list);
-			hash_del(&rela->hash);
-			free(rela);
+		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {
+			list_del(&reloc->list);
+			hash_del(&reloc->hash);
+			free(reloc);
 		}
 		list_del(&sec->list);
 		free(sec);
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index f4fe1d6ea392..6ad759fd778e 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -32,8 +32,8 @@ struct section {
 	GElf_Shdr sh;
 	struct rb_root symbol_tree;
 	struct list_head symbol_list;
-	struct list_head rela_list;
-	struct section *base, *rela;
+	struct list_head reloc_list;
+	struct section *base, *reloc;
 	struct symbol *sym;
 	Elf_Data *data;
 	char *name;
@@ -58,7 +58,7 @@ struct symbol {
 	bool uaccess_safe;
 };
 
-struct rela {
+struct reloc {
 	struct list_head list;
 	struct hlist_node hash;
 	GElf_Rela rela;
@@ -82,7 +82,7 @@ struct elf {
 	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
 	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
 	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(rela_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(reloc_hash, ELF_HASH_BITS);
 };
 
 #define OFFSET_STRIDE_BITS	4
@@ -109,15 +109,15 @@ static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 	return ol;
 }
 
-static inline u32 rela_hash(struct rela *rela)
+static inline u32 reloc_hash(struct reloc *reloc)
 {
-	return sec_offset_hash(rela->sec, rela->offset);
+	return sec_offset_hash(reloc->sec, reloc->offset);
 }
 
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
-struct section *elf_create_rela_section(struct elf *elf, struct section *base);
-void elf_add_rela(struct elf *elf, struct rela *rela);
+struct section *elf_create_reloc_section(struct elf *elf, struct section *base);
+void elf_add_reloc(struct elf *elf, struct reloc *reloc);
 int elf_write(const struct elf *elf);
 void elf_close(struct elf *elf);
 
@@ -126,11 +126,11 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
+struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
+struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-int elf_rebuild_rela_section(struct section *sec);
+int elf_rebuild_reloc_section(struct section *sec);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index c9549988121a..b538a0408cde 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -80,56 +80,56 @@ int create_orc(struct objtool_file *file)
 	return 0;
 }
 
-static int create_orc_entry(struct elf *elf, struct section *u_sec, struct section *ip_relasec,
+static int create_orc_entry(struct elf *elf, struct section *u_sec, struct section *ip_relocsec,
 				unsigned int idx, struct section *insn_sec,
 				unsigned long insn_off, struct orc_entry *o)
 {
 	struct orc_entry *orc;
-	struct rela *rela;
+	struct reloc *reloc;
 
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
 
 	/* populate rela for ip */
-	rela = malloc(sizeof(*rela));
-	if (!rela) {
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
 		perror("malloc");
 		return -1;
 	}
-	memset(rela, 0, sizeof(*rela));
+	memset(reloc, 0, sizeof(*reloc));
 
 	if (insn_sec->sym) {
-		rela->sym = insn_sec->sym;
-		rela->addend = insn_off;
+		reloc->sym = insn_sec->sym;
+		reloc->addend = insn_off;
 	} else {
 		/*
 		 * The Clang assembler doesn't produce section symbols, so we
 		 * have to reference the function symbol instead:
 		 */
-		rela->sym = find_symbol_containing(insn_sec, insn_off);
-		if (!rela->sym) {
+		reloc->sym = find_symbol_containing(insn_sec, insn_off);
+		if (!reloc->sym) {
 			/*
 			 * Hack alert.  This happens when we need to reference
 			 * the NOP pad insn immediately after the function.
 			 */
-			rela->sym = find_symbol_containing(insn_sec,
+			reloc->sym = find_symbol_containing(insn_sec,
 							   insn_off - 1);
 		}
-		if (!rela->sym) {
+		if (!reloc->sym) {
 			WARN("missing symbol for insn at offset 0x%lx\n",
 			     insn_off);
 			return -1;
 		}
 
-		rela->addend = insn_off - rela->sym->offset;
+		reloc->addend = insn_off - reloc->sym->offset;
 	}
 
-	rela->type = R_X86_64_PC32;
-	rela->offset = idx * sizeof(int);
-	rela->sec = ip_relasec;
+	reloc->type = R_X86_64_PC32;
+	reloc->offset = idx * sizeof(int);
+	reloc->sec = ip_relocsec;
 
-	elf_add_rela(elf, rela);
+	elf_add_reloc(elf, reloc);
 
 	return 0;
 }
@@ -137,7 +137,7 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 int create_orc_sections(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
-	struct section *sec, *u_sec, *ip_relasec;
+	struct section *sec, *u_sec, *ip_relocsec;
 	unsigned int idx;
 
 	struct orc_entry empty = {
@@ -181,8 +181,8 @@ int create_orc_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	ip_relasec = elf_create_rela_section(file->elf, sec);
-	if (!ip_relasec)
+	ip_relocsec = elf_create_reloc_section(file->elf, sec);
+	if (!ip_relocsec)
 		return -1;
 
 	/* create .orc_unwind section */
@@ -200,7 +200,7 @@ int create_orc_sections(struct objtool_file *file)
 			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
 						 sizeof(struct orc_entry))) {
 
-				if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
+				if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
 						     insn->sec, insn->offset,
 						     &insn->orc))
 					return -1;
@@ -212,7 +212,7 @@ int create_orc_sections(struct objtool_file *file)
 
 		/* section terminator */
 		if (prev_insn) {
-			if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
+			if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
 					     prev_insn->sec,
 					     prev_insn->offset + prev_insn->len,
 					     &empty))
@@ -222,7 +222,7 @@ int create_orc_sections(struct objtool_file *file)
 		}
 	}
 
-	if (elf_rebuild_rela_section(ip_relasec))
+	if (elf_rebuild_reloc_section(ip_relocsec))
 		return -1;
 
 	return 0;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e74e0189de22..7facd5f659d6 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -72,7 +72,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
 {
-	struct rela *orig_rela, *new_rela;
+	struct reloc *orig_reloc, *new_reloc;
 	unsigned long offset;
 
 	offset = idx * entry->size;
@@ -118,30 +118,30 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		}
 	}
 
-	orig_rela = find_rela_by_dest(elf, sec, offset + entry->orig);
-	if (!orig_rela) {
+	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
+	if (!orig_reloc) {
 		WARN_FUNC("can't find orig rela", sec, offset + entry->orig);
 		return -1;
 	}
-	if (orig_rela->sym->type != STT_SECTION) {
+	if (orig_reloc->sym->type != STT_SECTION) {
 		WARN_FUNC("don't know how to handle non-section rela symbol %s",
-			   sec, offset + entry->orig, orig_rela->sym->name);
+			   sec, offset + entry->orig, orig_reloc->sym->name);
 		return -1;
 	}
 
-	alt->orig_sec = orig_rela->sym->sec;
-	alt->orig_off = orig_rela->addend;
+	alt->orig_sec = orig_reloc->sym->sec;
+	alt->orig_off = orig_reloc->addend;
 
 	if (!entry->group || alt->new_len) {
-		new_rela = find_rela_by_dest(elf, sec, offset + entry->new);
-		if (!new_rela) {
+		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
+		if (!new_reloc) {
 			WARN_FUNC("can't find new rela",
 				  sec, offset + entry->new);
 			return -1;
 		}
 
-		alt->new_sec = new_rela->sym->sec;
-		alt->new_off = (unsigned int)new_rela->addend;
+		alt->new_sec = new_reloc->sym->sec;
+		alt->new_off = (unsigned int)new_reloc->addend;
 
 		/* _ASM_EXTABLE_EX hack */
 		if (alt->new_off >= 0x7ffffff0)
-- 
2.20.1

