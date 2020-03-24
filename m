Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549AAC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ED0208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oON9T2l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgCXQLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgCXQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vZGTNFI1qsH9Qyn4to0UBz3pVYWZFo5oK0ajBpNGby8=; b=oON9T2l8FCWtD42rmjdZCCcfKz
        kWPt9eZig5yKikujiCYoxZG9iit+xQj/l3DGpT3pXsudAFDQP7mEyD7pWDx9gTiiTZdrR3KOljX6c
        ndqIZf+Keze959ayTQkugGR55YL68hr8tN2dn85OZcLU/SV/wQv9rTOwxq9EMeemYVhLPOw37sPyz
        uxpGVWz79XW9t7gQyprDinPELp0L4ZpL0ru4f/9d7NhWZfUjS4lhdqlZ8fd1GDVF1AvI8gq8xu63G
        UjQtIKXrBDT2/M/TqiE4TiU45qw7S6H1KqvPyRplUACg7Azkbmn0shpH5xoZQE1pmGuiaadivEExY
        rABS7JgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9M-0006c1-Uf; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B9AF307444;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5ECCD29A490F9; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160925.107835416@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 20/26] objtool: Optimize !vmlinux.o again
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing kbuild tests to see if the objtool changes affected those I
found that there was a measurable regression:

          pre		  post

  real    1m13.594        1m16.488s
  user    34m58.246s      35m23.947s
  sys     4m0.393s        4m27.312s

Perf showed that for small files the increased hash-table sizes were a
measurable difference. Since we already have -l "vmlinux" to
distinguish between the modes, make it also use a smaller portion of
the hash-tables.

This flips it into a small win:

  real    1m14.143s
  user    34m49.292s
  sys     3m44.746s

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c     |   62 +++++++++++++++++++++++++++++++++---------------
 tools/objtool/elf.h     |   13 ++++++----
 tools/objtool/orc_gen.c |    3 --
 3 files changed, 52 insertions(+), 26 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -27,6 +27,22 @@ static inline u32 str_hash(const char *s
 	return jhash(str, strlen(str), 0);
 }
 
+static inline int elf_hash_bits(void)
+{
+	return vmlinux ? ELF_HASH_BITS : 16;
+}
+
+#define elf_hash_add(hashtable, node, key) \
+	hlist_add_head(node, &hashtable[hash_min(key, elf_hash_bits())])
+
+static void elf_hash_init(struct hlist_head *table)
+{
+	__hash_init(table, 1U << elf_hash_bits());
+}
+
+#define elf_hash_for_each_possible(name, obj, member, key)			\
+	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
+
 static void rb_add(struct rb_root *tree, struct rb_node *node,
 		   int (*cmp)(struct rb_node *, const struct rb_node *))
 {
@@ -115,7 +131,7 @@ struct section *find_section_by_name(str
 {
 	struct section *sec;
 
-	hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
 		if (!strcmp(sec->name, name))
 			return sec;
 
@@ -127,7 +143,7 @@ static struct section *find_section_by_i
 {
 	struct section *sec;
 
-	hash_for_each_possible(elf->section_hash, sec, hash, idx)
+	elf_hash_for_each_possible(elf->section_hash, sec, hash, idx)
 		if (sec->idx == idx)
 			return sec;
 
@@ -138,7 +154,7 @@ static struct symbol *find_symbol_by_ind
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
+	elf_hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
 		if (sym->idx == idx)
 			return sym;
 
@@ -205,7 +221,7 @@ struct symbol *find_symbol_by_name(struc
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
 		if (!strcmp(sym->name, name))
 			return sym;
 
@@ -224,7 +240,7 @@ struct rela *find_rela_by_dest_range(str
 	sec = sec->rela;
 
 	for_offset_range(o, offset, offset + len) {
-		hash_for_each_possible(elf->rela_hash, rela, hash,
+		elf_hash_for_each_possible(elf->rela_hash, rela, hash,
 				       sec_offset_hash(sec, o)) {
 			if (rela->sec != sec)
 				continue;
@@ -309,8 +325,8 @@ static int read_sections(struct elf *elf
 		sec->len = sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
-		hash_add(elf->section_hash, &sec->hash, sec->idx);
-		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 	}
 
 	if (stats)
@@ -394,8 +410,8 @@ static int read_symbols(struct elf *elf)
 		else
 			entry = &sym->sec->symbol_list;
 		list_add(&sym->list, entry);
-		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-		hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
 	}
 
 	if (stats)
@@ -456,6 +472,14 @@ static int read_symbols(struct elf *elf)
 	return -1;
 }
 
+void elf_add_rela(struct elf *elf, struct rela *rela)
+{
+	struct section *sec = rela->sec;
+
+	list_add_tail(&rela->list, &sec->rela_list);
+	elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+}
+
 static int read_relas(struct elf *elf)
 {
 	struct section *sec;
@@ -503,8 +527,7 @@ static int read_relas(struct elf *elf)
 				return -1;
 			}
 
-			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+			elf_add_rela(elf, rela);
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -531,15 +554,16 @@ struct elf *elf_read(const char *name, i
 		perror("malloc");
 		return NULL;
 	}
-	memset(elf, 0, sizeof(*elf));
+	memset(elf, 0, offsetof(struct elf, sections));
 
-	hash_init(elf->symbol_hash);
-	hash_init(elf->symbol_name_hash);
-	hash_init(elf->section_hash);
-	hash_init(elf->section_name_hash);
-	hash_init(elf->rela_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
+	elf_hash_init(elf->symbol_hash);
+	elf_hash_init(elf->symbol_name_hash);
+	elf_hash_init(elf->section_hash);
+	elf_hash_init(elf->section_name_hash);
+	elf_hash_init(elf->rela_hash);
+
 	elf->fd = open(name, flags);
 	if (elf->fd == -1) {
 		fprintf(stderr, "objtool: Can't open '%s': %s\n",
@@ -676,8 +700,8 @@ struct section *elf_create_section(struc
 	shstrtab->changed = true;
 
 	list_add_tail(&sec->list, &elf->sections);
-	hash_add(elf->section_hash, &sec->hash, sec->idx);
-	hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
 	return sec;
 }
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -70,17 +70,19 @@ struct rela {
 	bool jump_table_start;
 };
 
+#define ELF_HASH_BITS	20
+
 struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
 	int fd;
 	char *name;
 	struct list_head sections;
-	DECLARE_HASHTABLE(symbol_hash, 20);
-	DECLARE_HASHTABLE(symbol_name_hash, 20);
-	DECLARE_HASHTABLE(section_hash, 16);
-	DECLARE_HASHTABLE(section_name_hash, 16);
-	DECLARE_HASHTABLE(rela_hash, 20);
+	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(rela_hash, ELF_HASH_BITS);
 };
 
 #define OFFSET_STRIDE_BITS	4
@@ -127,6 +129,7 @@ struct section *elf_create_rela_section(
 int elf_rebuild_rela_section(struct section *sec);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
+void elf_add_rela(struct elf *elf, struct rela *rela);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -111,8 +111,7 @@ static int create_orc_entry(struct elf *
 	rela->offset = idx * sizeof(int);
 	rela->sec = ip_relasec;
 
-	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+	elf_add_rela(elf, rela);
 
 	return 0;
 }


