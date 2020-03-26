Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969E32076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCZKJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50195 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgCZKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRE-00047D-1a; Thu, 26 Mar 2020 11:08:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7928C1C0470;
        Thu, 26 Mar 2020 11:08:35 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize find_symbol_*() and read_symbols()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.499016559@infradead.org>
References: <20200324160924.499016559@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731509.28353.4401078378468206812.tip-bot2@tip-bot2>
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

Commit-ID:     2a362ecc3ec9632aeea4b9a9062db91b2bd9975a
Gitweb:        https://git.kernel.org/tip/2a362ecc3ec9632aeea4b9a9062db91b2bd9975a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 09:34:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:29 +01:00

objtool: Optimize find_symbol_*() and read_symbols()

All of:

  read_symbols(), find_symbol_by_offset(), find_symbol_containing(),
  find_containing_func()

do a linear search of the symbols. Add an RB tree to make it go
faster.

This about halves objtool runtime on vmlinux.o, from 34s to 18s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.499016559@infradead.org
---
 tools/objtool/Build |   5 +-
 tools/objtool/elf.c | 194 ++++++++++++++++++++++++++++++-------------
 tools/objtool/elf.h |   3 +-
 3 files changed, 144 insertions(+), 58 deletions(-)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 8dc4f08..66f44f5 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -11,6 +11,7 @@ objtool-y += objtool.o
 objtool-y += libstring.o
 objtool-y += libctype.o
 objtool-y += str_error_r.o
+objtool-y += librbtree.o
 
 CFLAGS += -I$(srctree)/tools/lib
 
@@ -25,3 +26,7 @@ $(OUTPUT)libctype.o: ../lib/ctype.c FORCE
 $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)librbtree.o: ../lib/rbtree.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 20fe40d..3a8b426 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -27,6 +27,90 @@ static inline u32 str_hash(const char *str)
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
@@ -63,47 +147,69 @@ static struct symbol *find_symbol_by_index(struct elf *elf, unsigned int idx)
 
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
+{
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
 {
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
@@ -130,18 +236,6 @@ struct rela *find_rela_by_dest(struct section *sec, unsigned long offset)
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
@@ -225,8 +319,9 @@ static int read_sections(struct elf *elf)
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
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ac7c46f..e4a8d68 100644
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
