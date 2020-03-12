Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B1C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782FE206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GWxmVFjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCLV5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:57:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60312 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/L9eHrHXGyEVcHCfrvWgMPLqOyJpGy+5KNYTRqq2jxA=; b=GWxmVFjEQe74xwtJ0GwqZN5Utf
        Ku+8CjhNLG/7oHHB/HLoyXG8XkOwlg9RYmRwCnOK+0zx1LC4qnx1y2tl5Amz1pDCrLLIBTyuw5Sin
        dR6r7U5yDZG5LSrY14Q9hkpbzAQuhlsU29sh0DM7JOBB1LB0q5NgWFszo8905irAiuoeXR/6Asv8R
        edcruwCK4dSpl+4+11/H+ZkyoEFfAFso3xkN4SdYiDyFYvMyAnbQ8cqv1qW40zgFsgArM6XntANrX
        k4phhuphAyiwZrTBma3+zebXqOCBHUUBgPwXB2ktWwWK4T1gPetWIfR6NanqgNgMm/Bge2HOpKnie
        UEHMjUPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCVpe-0004FH-66; Thu, 12 Mar 2020 21:57:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06DAB98114E; Thu, 12 Mar 2020 22:57:31 +0100 (CET)
Date:   Thu, 12 Mar 2020 22:57:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC][PATCH v2 16/16] objtool: Optimize !vmlinux.o again
Message-ID: <20200312215730.GC5086@worktop.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.346616828@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312135042.346616828@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out I lost a refresh on this one.

---
Subject: objtool: Optimize !vmlinux.o again
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Mar 12 14:29:38 CET 2020

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
---
 tools/objtool/elf.c |   51 ++++++++++++++++++++++++++++++++++-----------------
 tools/objtool/elf.h |    4 ++--
 2 files changed, 36 insertions(+), 19 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -27,6 +27,22 @@ static inline u32 str_hash(const char *s
 	return jhash(str, strlen(str), 0);
 }
 
+static inline int elf_hash_bits(void)
+{
+	return vmlinux ? 20 : 16;
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
 
@@ -194,7 +210,7 @@ struct symbol *find_symbol_by_name(struc
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
 		if (!strcmp(sym->name, name))
 			return sym;
 
@@ -213,7 +229,7 @@ struct rela *find_rela_by_dest_range(str
 	sec = sec->rela;
 
 	for (o = offset & RELA_STRIDE_MASK; o < offset + len; o += RELA_STRIDE) {
-		hash_for_each_possible(sec->elf->rela_hash, rela, hash,
+		elf_hash_for_each_possible(sec->elf->rela_hash, rela, hash,
 				       __rela_hash(o, sec->idx)) {
 			if (rela->sec != sec)
 				continue;
@@ -300,8 +316,8 @@ static int read_sections(struct elf *elf
 		}
 		sec->len = sec->sh.sh_size;
 
-		hash_add(elf->section_hash, &sec->hash, sec->idx);
-		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 	}
 
 	if (stats)
@@ -387,8 +403,8 @@ static int read_symbols(struct elf *elf)
 			entry = &sym->sec->symbol_list;
 		list_add(&sym->list, entry);
 
-		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-		hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
 	}
 
 	if (stats)
@@ -497,7 +513,7 @@ static int read_relas(struct elf *elf)
 			}
 
 			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+			elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -524,15 +540,16 @@ struct elf *elf_read(const char *name, i
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
@@ -671,7 +688,7 @@ struct section *elf_create_section(struc
 	shstrtab->len += strlen(name) + 1;
 	shstrtab->changed = true;
 
-	hash_add(elf->section_hash, &sec->hash, sec->idx);
+	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
 
 	return sec;
 }
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -81,8 +81,8 @@ struct elf {
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
 	DECLARE_HASHTABLE(symbol_name_hash, 20);
-	DECLARE_HASHTABLE(section_hash, 16);
-	DECLARE_HASHTABLE(section_name_hash, 16);
+	DECLARE_HASHTABLE(section_hash, 20);
+	DECLARE_HASHTABLE(section_name_hash, 20);
 	DECLARE_HASHTABLE(rela_hash, 20);
 };
 

