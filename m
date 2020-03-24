Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D99C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773812080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hsfkJlhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgCXQLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgCXQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZvN9GjJ3zOzLq7K2fe+zbCC8LyIraqY/rI2wdvy4nEg=; b=hsfkJlhe2UuWjHkjMwzEy2CGO4
        NV4BHBDSXbUIxfMf8hWNuqA0K1xWBbJDxCXacaz94UGyNpB9YA1r51DaMYhLZTbq+FpxrJYvrdjZQ
        7DLAPHPsy2FHO4qXInu5ajAcIEqtnOtRMJjKQCzUxhwnX1AgkDW6qsGawYwteb5K+n8KkFWgf3tLU
        7iu/13SEjIm9D8hF5S5vKItyNq8c0aRX7eTimlN/dXRGhO27jBTYl1FjXwElgekV0pQVoRP5uLDd1
        IyNcgpOrIL3jtWtO8EgUo1ssb2zL1+ePlRpIg1UujvY7xQ/czfkL130nAai8gFhCxGsele6pSQg9j
        Sps+/Mew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9L-0000Bl-J0; Tue, 24 Mar 2020 16:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4677A30708D;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3673729A490F9; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.499016559@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 10/26] objtool: Optimize find_symbol_*() and read_symbols()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of:

  read_symbols(), find_symbol_by_offset(), find_symbol_containing(),
  find_containing_func()

do a linear search of the symbols. Add an RB tree to make it go
faster.

This about halves objtool runtime on vmlinux.o, from 34s to 18s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Build |    5 +
 tools/objtool/elf.c |  194 ++++++++++++++++++++++++++++++++++++----------------
 tools/objtool/elf.h |    3 
 3 files changed, 144 insertions(+), 58 deletions(-)

--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -11,6 +11,7 @@ objtool-y += objtool.o
 objtool-y += libstring.o
 objtool-y += libctype.o
 objtool-y += str_error_r.o
+objtool-y += librbtree.o
 
 CFLAGS += -I$(srctree)/tools/lib
 
@@ -25,3 +26,7 @@ $(OUTPUT)libctype.o: ../lib/ctype.c FORC
 $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)librbtree.o: ../lib/rbtree.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -27,6 +27,90 @@ static inline u32 str_hash(const char *s
 	return jhash(str, strlen(str), 0);
 }
 
+static void rb_add(struct rb_root *tree, struct rb_node *node,
+		   int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (cmp(node, parent) < 0)
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+static struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
+			       int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+static struct rb_node *rb_next_match(struct rb_node *node, const void *key,
+				    int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+#define rb_for_each(tree, node, key, cmp) \
+	for ((node) = rb_find_first((tree), (key), (cmp)); \
+	     (node); (node) = rb_next_match((node), (key), (cmp)))
+
+static int symbol_to_offset(struct rb_node *a, const struct rb_node *b)
+{
+	struct symbol *sa = rb_entry(a, struct symbol, node);
+	struct symbol *sb = rb_entry(b, struct symbol, node);
+
+	if (sa->offset < sb->offset)
+		return -1;
+	if (sa->offset > sb->offset)
+		return 1;
+
+	if (sa->len < sb->len)
+		return -1;
+	if (sa->len > sb->len)
+		return 1;
+
+	sa->alias = sb;
+
+	return 0;
+}
+
+static int symbol_by_offset(const void *key, const struct rb_node *node)
+{
+	const struct symbol *s = rb_entry(node, struct symbol, node);
+	const unsigned long *o = key;
+
+	if (*o < s->offset)
+		return -1;
+	if (*o > s->offset + s->len)
+		return 1;
+
+	return 0;
+}
+
 struct section *find_section_by_name(struct elf *elf, const char *name)
 {
 	struct section *sec;
@@ -63,47 +147,69 @@ static struct symbol *find_symbol_by_ind
 
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 {
-	struct symbol *sym;
+	struct rb_node *node;
 
-	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type != STT_SECTION && sym->offset == offset)
-			return sym;
+	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+		struct symbol *s = rb_entry(node, struct symbol, node);
+
+		if (s->offset == offset && s->type != STT_SECTION)
+			return s;
+	}
 
 	return NULL;
 }
 
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 {
-	struct symbol *sym;
+	struct rb_node *node;
 
-	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type == STT_FUNC && sym->offset == offset)
-			return sym;
+	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+		struct symbol *s = rb_entry(node, struct symbol, node);
+
+		if (s->offset == offset && s->type == STT_FUNC)
+			return s;
+	}
 
 	return NULL;
 }
 
-struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
+struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
 {
-	struct section *sec;
-	struct symbol *sym;
+	struct rb_node *node;
 
-	list_for_each_entry(sec, &elf->sections, list)
-		list_for_each_entry(sym, &sec->symbol_list, list)
-			if (!strcmp(sym->name, name))
-				return sym;
+	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+		struct symbol *s = rb_entry(node, struct symbol, node);
+
+		if (s->type != STT_SECTION)
+			return s;
+	}
 
 	return NULL;
 }
 
-struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
+struct symbol *find_containing_func(struct section *sec, unsigned long offset)
 {
+	struct rb_node *node;
+
+	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+		struct symbol *s = rb_entry(node, struct symbol, node);
+
+		if (s->type == STT_FUNC)
+			return s;
+	}
+
+	return NULL;
+}
+
+struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
+{
+	struct section *sec;
 	struct symbol *sym;
 
-	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type != STT_SECTION &&
-		    offset >= sym->offset && offset < sym->offset + sym->len)
-			return sym;
+	list_for_each_entry(sec, &elf->sections, list)
+		list_for_each_entry(sym, &sec->symbol_list, list)
+			if (!strcmp(sym->name, name))
+				return sym;
 
 	return NULL;
 }
@@ -130,18 +236,6 @@ struct rela *find_rela_by_dest(struct se
 	return find_rela_by_dest_range(sec, offset, 1);
 }
 
-struct symbol *find_containing_func(struct section *sec, unsigned long offset)
-{
-	struct symbol *func;
-
-	list_for_each_entry(func, &sec->symbol_list, list)
-		if (func->type == STT_FUNC && offset >= func->offset &&
-		    offset < func->offset + func->len)
-			return func;
-
-	return NULL;
-}
-
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
@@ -225,8 +319,9 @@ static int read_sections(struct elf *elf
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *sec;
-	struct symbol *sym, *pfunc, *alias;
-	struct list_head *entry, *tmp;
+	struct symbol *sym, *pfunc;
+	struct list_head *entry;
+	struct rb_node *pnode;
 	int symbols_nr, i;
 	char *coldstr;
 
@@ -245,7 +340,7 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
 		memset(sym, 0, sizeof(*sym));
-		alias = sym;
+		sym->alias = sym;
 
 		sym->idx = i;
 
@@ -283,29 +378,12 @@ static int read_symbols(struct elf *elf)
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
-		/* sorted insert into a per-section list */
-		entry = &sym->sec->symbol_list;
-		list_for_each_prev(tmp, &sym->sec->symbol_list) {
-			struct symbol *s;
-
-			s = list_entry(tmp, struct symbol, list);
-
-			if (sym->offset > s->offset) {
-				entry = tmp;
-				break;
-			}
-
-			if (sym->offset == s->offset) {
-				if (sym->len && sym->len == s->len && alias == sym)
-					alias = s;
-
-				if (sym->len >= s->len) {
-					entry = tmp;
-					break;
-				}
-			}
-		}
-		sym->alias = alias;
+		rb_add(&sym->sec->symbol_tree, &sym->node, symbol_to_offset);
+		pnode = rb_prev(&sym->node);
+		if (pnode)
+			entry = &rb_entry(pnode, struct symbol, node)->list;
+		else
+			entry = &sym->sec->symbol_list;
 		list_add(&sym->list, entry);
 		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
 	}
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -10,6 +10,7 @@
 #include <gelf.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <linux/rbtree.h>
 #include <linux/jhash.h>
 
 #ifdef LIBELF_USE_DEPRECATED
@@ -29,6 +30,7 @@ struct section {
 	struct hlist_node hash;
 	struct hlist_node name_hash;
 	GElf_Shdr sh;
+	struct rb_root symbol_tree;
 	struct list_head symbol_list;
 	struct list_head rela_list;
 	DECLARE_HASHTABLE(rela_hash, 16);
@@ -43,6 +45,7 @@ struct section {
 
 struct symbol {
 	struct list_head list;
+	struct rb_node node;
 	struct hlist_node hash;
 	GElf_Sym sym;
 	struct section *sec;


