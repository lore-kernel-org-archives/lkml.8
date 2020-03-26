Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA08C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B55521556
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgCZKIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50177 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCZKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRB-00045b-VS; Thu, 26 Mar 2020 11:08:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8A5AE1C0470;
        Thu, 26 Mar 2020 11:08:33 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:33 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize read_sections()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.739153726@infradead.org>
References: <20200324160924.739153726@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731317.28353.5284958283548716414.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     8b5fa6bc326bf02f293b5a39a8f5b3de816265d3
Gitweb:        https://git.kernel.org/tip/8b5fa6bc326bf02f293b5a39a8f5b3de816265d3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 11:23:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:30 +01:00

objtool: Optimize read_sections()

Perf showed that __hash_init() is a significant portion of
read_sections(), so instead of doing a per section rela_hash, use an
elf-wide rela_hash.

Statistics show us there are about 1.1 million relas, so size it
accordingly.

This reduces the objtool on vmlinux.o runtime to a third, from 15 to 5
seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.739153726@infradead.org
---
 tools/objtool/check.c   | 18 +++++++++---------
 tools/objtool/elf.c     | 24 ++++++++++++++----------
 tools/objtool/elf.h     | 21 +++++++++++++++++----
 tools/objtool/orc_gen.c |  9 +++++----
 tools/objtool/special.c |  4 ++--
 5 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6df1bae..54a6043 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -569,8 +569,8 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
-		rela = find_rela_by_dest_range(insn->sec, insn->offset,
-					       insn->len);
+		rela = find_rela_by_dest_range(file->elf, insn->sec,
+					       insn->offset, insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
 			dest_off = insn->offset + insn->len + insn->immediate;
@@ -666,8 +666,8 @@ static int add_call_destinations(struct objtool_file *file)
 		if (insn->type != INSN_CALL)
 			continue;
 
-		rela = find_rela_by_dest_range(insn->sec, insn->offset,
-					       insn->len);
+		rela = find_rela_by_dest_range(file->elf, insn->sec,
+					       insn->offset, insn->len);
 		if (!rela) {
 			dest_off = insn->offset + insn->len + insn->immediate;
 			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
@@ -796,7 +796,7 @@ static int handle_group_alt(struct objtool_file *file,
 		 */
 		if ((insn->offset != special_alt->new_off ||
 		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
-		    find_rela_by_dest_range(insn->sec, insn->offset, insn->len)) {
+		    find_rela_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
@@ -1066,8 +1066,8 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		    break;
 
 		/* look for a relocation which references .rodata */
-		text_rela = find_rela_by_dest_range(insn->sec, insn->offset,
-						    insn->len);
+		text_rela = find_rela_by_dest_range(file->elf, insn->sec,
+						    insn->offset, insn->len);
 		if (!text_rela || text_rela->sym->type != STT_SECTION ||
 		    !text_rela->sym->sec->rodata)
 			continue;
@@ -1096,7 +1096,7 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		 * should reference text in the same function as the original
 		 * instruction.
 		 */
-		table_rela = find_rela_by_dest(table_sec, table_offset);
+		table_rela = find_rela_by_dest(file->elf, table_sec, table_offset);
 		if (!table_rela)
 			continue;
 		dest_insn = find_insn(file, table_rela->sym->sec, table_rela->addend);
@@ -1232,7 +1232,7 @@ static int read_unwind_hints(struct objtool_file *file)
 	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
 		hint = (struct unwind_hint *)sec->data->d_buf + i;
 
-		rela = find_rela_by_dest(sec, i * sizeof(*hint));
+		rela = find_rela_by_dest(file->elf, sec, i * sizeof(*hint));
 		if (!rela) {
 			WARN("can't find rela for unwind_hints[%d]", i);
 			return -1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 43abae7..8a0a1bc 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -212,8 +212,8 @@ struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
 	return NULL;
 }
 
-struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
-				     unsigned int len)
+struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+				     unsigned long offset, unsigned int len)
 {
 	struct rela *rela;
 	unsigned long o;
@@ -221,17 +221,22 @@ struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
 	if (!sec->rela)
 		return NULL;
 
-	for (o = offset; o < offset + len; o++)
-		hash_for_each_possible(sec->rela->rela_hash, rela, hash, o)
-			if (rela->offset == o)
+	sec = sec->rela;
+
+	for (o = offset; o < offset + len; o++) {
+		hash_for_each_possible(elf->rela_hash, rela, hash,
+				       sec_offset_hash(sec, o)) {
+			if (rela->sec == sec && rela->offset == o)
 				return rela;
+		}
+	}
 
 	return NULL;
 }
 
-struct rela *find_rela_by_dest(struct section *sec, unsigned long offset)
+struct rela *find_rela_by_dest(struct elf *elf, struct section *sec, unsigned long offset)
 {
-	return find_rela_by_dest_range(sec, offset, 1);
+	return find_rela_by_dest_range(elf, sec, offset, 1);
 }
 
 static int read_sections(struct elf *elf)
@@ -261,7 +266,6 @@ static int read_sections(struct elf *elf)
 
 		INIT_LIST_HEAD(&sec->symbol_list);
 		INIT_LIST_HEAD(&sec->rela_list);
-		hash_init(sec->rela_hash);
 
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
@@ -493,7 +497,7 @@ static int read_relas(struct elf *elf)
 			}
 
 			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(sec->rela_hash, &rela->hash, rela->offset);
+			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -526,6 +530,7 @@ struct elf *elf_read(const char *name, int flags)
 	hash_init(elf->symbol_name_hash);
 	hash_init(elf->section_hash);
 	hash_init(elf->section_name_hash);
+	hash_init(elf->rela_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -586,7 +591,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 
 	INIT_LIST_HEAD(&sec->symbol_list);
 	INIT_LIST_HEAD(&sec->rela_list);
-	hash_init(sec->rela_hash);
 
 	s = elf_newscn(elf->elf);
 	if (!s) {
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 3088d92..dfd2431 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -33,7 +33,6 @@ struct section {
 	struct rb_root symbol_tree;
 	struct list_head symbol_list;
 	struct list_head rela_list;
-	DECLARE_HASHTABLE(rela_hash, 16);
 	struct section *base, *rela;
 	struct symbol *sym;
 	Elf_Data *data;
@@ -81,8 +80,22 @@ struct elf {
 	DECLARE_HASHTABLE(symbol_name_hash, 20);
 	DECLARE_HASHTABLE(section_hash, 16);
 	DECLARE_HASHTABLE(section_name_hash, 16);
+	DECLARE_HASHTABLE(rela_hash, 20);
 };
 
+static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
+{
+	u32 ol = offset, oh = offset >> 32, idx = sec->idx;
+
+	__jhash_mix(ol, oh, idx);
+
+	return ol;
+}
+
+static inline u32 rela_hash(struct rela *rela)
+{
+	return sec_offset_hash(rela->sec, rela->offset);
+}
 
 struct elf *elf_read(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
@@ -90,9 +103,9 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
-				     unsigned int len);
+struct rela *find_rela_by_dest(struct elf *elf, struct section *sec, unsigned long offset);
+struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t
 				   entsize, int nr);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 27a4112..41e4a27 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -81,7 +81,7 @@ int create_orc(struct objtool_file *file)
 	return 0;
 }
 
-static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
+static int create_orc_entry(struct elf *elf, struct section *u_sec, struct section *ip_relasec,
 				unsigned int idx, struct section *insn_sec,
 				unsigned long insn_off, struct orc_entry *o)
 {
@@ -109,9 +109,10 @@ static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
 	rela->addend = insn_off;
 	rela->type = R_X86_64_PC32;
 	rela->offset = idx * sizeof(int);
+	rela->sec = ip_relasec;
 
 	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(ip_relasec->rela_hash, &rela->hash, rela->offset);
+	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
 
 	return 0;
 }
@@ -182,7 +183,7 @@ int create_orc_sections(struct objtool_file *file)
 			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
 						 sizeof(struct orc_entry))) {
 
-				if (create_orc_entry(u_sec, ip_relasec, idx,
+				if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
 						     insn->sec, insn->offset,
 						     &insn->orc))
 					return -1;
@@ -194,7 +195,7 @@ int create_orc_sections(struct objtool_file *file)
 
 		/* section terminator */
 		if (prev_insn) {
-			if (create_orc_entry(u_sec, ip_relasec, idx,
+			if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
 					     prev_insn->sec,
 					     prev_insn->offset + prev_insn->len,
 					     &empty))
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fdbaa61..e74e018 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -118,7 +118,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		}
 	}
 
-	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
+	orig_rela = find_rela_by_dest(elf, sec, offset + entry->orig);
 	if (!orig_rela) {
 		WARN_FUNC("can't find orig rela", sec, offset + entry->orig);
 		return -1;
@@ -133,7 +133,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 	alt->orig_off = orig_rela->addend;
 
 	if (!entry->group || alt->new_len) {
-		new_rela = find_rela_by_dest(sec, offset + entry->new);
+		new_rela = find_rela_by_dest(elf, sec, offset + entry->new);
 		if (!new_rela) {
 			WARN_FUNC("can't find new rela",
 				  sec, offset + entry->new);
