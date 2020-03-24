Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1779C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC27208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dI5/OYrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgCXQLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VzSvA3H3CtLI2jEExgV9tF0oxsVn/g+hxdJmjnFUXlM=; b=dI5/OYrXZpzAs6HCqEOT/bqfnC
        Vo2Tk6ecw2mQGirbqQuYyyY0y2kN+yPvwhGMsg+shiqElLYrSmrny6C1gZHNXlPQ2DDmvBIK6R2xx
        r1/86Z7wd0ozz8OWe/Mx5S2FlInjFBjUPFDDYrxmjx50trJx03llOPqqmk7aR90o0QdQ4LZBEv5W6
        HNNd25hnuGSX4WuvnGBJ7WEwBbYk6B0LZsUsXqvAOeckgVTq8fSEEDHAduk/9rGVLXU3hcGkUjN75
        4NYEaHaWvxBntTYMNuVYyNkF0a3rRzh9oetQFQhxJGvLB03mgom75wVN0G0DCTjXlBxzrU18YBcBF
        eU9OJWUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9L-0006bX-LG; Tue, 24 Mar 2020 16:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E2A03072CD;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 478EC29A490F3; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.739153726@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 14/26] objtool: Optimize read_sections()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf showed that __hash_init() is a significant portion of
read_sections(), so instead of doing a per section rela_hash, use an
elf-wide rela_hash.

Statistics show us there are about 1.1 million relas, so size it
accordingly.

This reduces the objtool on vmlinux.o runtime to a third, from 15 to 5
seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c   |   18 +++++++++---------
 tools/objtool/elf.c     |   24 ++++++++++++++----------
 tools/objtool/elf.h     |   21 +++++++++++++++++----
 tools/objtool/orc_gen.c |    9 +++++----
 tools/objtool/special.c |    4 ++--
 5 files changed, 47 insertions(+), 29 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -587,8 +587,8 @@ static int add_jump_destinations(struct
 		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
-		rela = find_rela_by_dest_range(insn->sec, insn->offset,
-					       insn->len);
+		rela = find_rela_by_dest_range(file->elf, insn->sec,
+					       insn->offset, insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
 			dest_off = insn->offset + insn->len + insn->immediate;
@@ -684,8 +684,8 @@ static int add_call_destinations(struct
 		if (insn->type != INSN_CALL)
 			continue;
 
-		rela = find_rela_by_dest_range(insn->sec, insn->offset,
-					       insn->len);
+		rela = find_rela_by_dest_range(file->elf, insn->sec,
+					       insn->offset, insn->len);
 		if (!rela) {
 			dest_off = insn->offset + insn->len + insn->immediate;
 			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
@@ -814,7 +814,7 @@ static int handle_group_alt(struct objto
 		 */
 		if ((insn->offset != special_alt->new_off ||
 		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
-		    find_rela_by_dest_range(insn->sec, insn->offset, insn->len)) {
+		    find_rela_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
@@ -1084,8 +1084,8 @@ static struct rela *find_jump_table(stru
 		    break;
 
 		/* look for a relocation which references .rodata */
-		text_rela = find_rela_by_dest_range(insn->sec, insn->offset,
-						    insn->len);
+		text_rela = find_rela_by_dest_range(file->elf, insn->sec,
+						    insn->offset, insn->len);
 		if (!text_rela || text_rela->sym->type != STT_SECTION ||
 		    !text_rela->sym->sec->rodata)
 			continue;
@@ -1114,7 +1114,7 @@ static struct rela *find_jump_table(stru
 		 * should reference text in the same function as the original
 		 * instruction.
 		 */
-		table_rela = find_rela_by_dest(table_sec, table_offset);
+		table_rela = find_rela_by_dest(file->elf, table_sec, table_offset);
 		if (!table_rela)
 			continue;
 		dest_insn = find_insn(file, table_rela->sym->sec, table_rela->addend);
@@ -1250,7 +1250,7 @@ static int read_unwind_hints(struct objt
 	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
 		hint = (struct unwind_hint *)sec->data->d_buf + i;
 
-		rela = find_rela_by_dest(sec, i * sizeof(*hint));
+		rela = find_rela_by_dest(file->elf, sec, i * sizeof(*hint));
 		if (!rela) {
 			WARN("can't find rela for unwind_hints[%d]", i);
 			return -1;
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -212,8 +212,8 @@ struct symbol *find_symbol_by_name(struc
 	return NULL;
 }
 
-struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
-				     unsigned int len)
+struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+				     unsigned long offset, unsigned int len)
 {
 	struct rela *rela;
 	unsigned long o;
@@ -221,17 +221,22 @@ struct rela *find_rela_by_dest_range(str
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
@@ -261,7 +266,6 @@ static int read_sections(struct elf *elf
 
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
@@ -526,6 +530,7 @@ struct elf *elf_read(const char *name, i
 	hash_init(elf->symbol_name_hash);
 	hash_init(elf->section_hash);
 	hash_init(elf->section_name_hash);
+	hash_init(elf->rela_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -586,7 +591,6 @@ struct section *elf_create_section(struc
 
 	INIT_LIST_HEAD(&sec->symbol_list);
 	INIT_LIST_HEAD(&sec->rela_list);
-	hash_init(sec->rela_hash);
 
 	s = elf_newscn(elf->elf);
 	if (!s) {
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
@@ -90,9 +103,9 @@ struct symbol *find_func_by_offset(struc
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
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -81,7 +81,7 @@ int create_orc(struct objtool_file *file
 	return 0;
 }
 
-static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
+static int create_orc_entry(struct elf *elf, struct section *u_sec, struct section *ip_relasec,
 				unsigned int idx, struct section *insn_sec,
 				unsigned long insn_off, struct orc_entry *o)
 {
@@ -109,9 +109,10 @@ static int create_orc_entry(struct secti
 	rela->addend = insn_off;
 	rela->type = R_X86_64_PC32;
 	rela->offset = idx * sizeof(int);
+	rela->sec = ip_relasec;
 
 	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(ip_relasec->rela_hash, &rela->hash, rela->offset);
+	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
 
 	return 0;
 }
@@ -182,7 +183,7 @@ int create_orc_sections(struct objtool_f
 			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
 						 sizeof(struct orc_entry))) {
 
-				if (create_orc_entry(u_sec, ip_relasec, idx,
+				if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
 						     insn->sec, insn->offset,
 						     &insn->orc))
 					return -1;
@@ -194,7 +195,7 @@ int create_orc_sections(struct objtool_f
 
 		/* section terminator */
 		if (prev_insn) {
-			if (create_orc_entry(u_sec, ip_relasec, idx,
+			if (create_orc_entry(file->elf, u_sec, ip_relasec, idx,
 					     prev_insn->sec,
 					     prev_insn->offset + prev_insn->len,
 					     &empty))
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -118,7 +118,7 @@ static int get_alt_entry(struct elf *elf
 		}
 	}
 
-	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
+	orig_rela = find_rela_by_dest(elf, sec, offset + entry->orig);
 	if (!orig_rela) {
 		WARN_FUNC("can't find orig rela", sec, offset + entry->orig);
 		return -1;
@@ -133,7 +133,7 @@ static int get_alt_entry(struct elf *elf
 	alt->orig_off = orig_rela->addend;
 
 	if (!entry->group || alt->new_len) {
-		new_rela = find_rela_by_dest(sec, offset + entry->new);
+		new_rela = find_rela_by_dest(elf, sec, offset + entry->new);
 		if (!new_rela) {
 			WARN_FUNC("can't find new rela",
 				  sec, offset + entry->new);


