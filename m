Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB7EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2045D20857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgDVWYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726458AbgDVWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B91C03C1AC;
        Wed, 22 Apr 2020 15:24:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnG-0001Lx-0c; Thu, 23 Apr 2020 00:24:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BFCAD1C0178;
        Thu, 23 Apr 2020 00:24:32 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Optimize !vmlinux.o again
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.167588731@infradead.org>
References: <20200416115119.167588731@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427217.28353.2894925469265699519.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6700867cb19a52db07c4e9e86d51c6c8f01dcf8e
Gitweb:        https://git.kernel.org/tip/6700867cb19a52db07c4e9e86d51c6c8f01dcf8e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 14:29:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:07 +02:00

objtool: Optimize !vmlinux.o again

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
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.167588731@infradead.org
---
 tools/objtool/elf.c     | 62 +++++++++++++++++++++++++++-------------
 tools/objtool/elf.h     | 13 ++++----
 tools/objtool/orc_gen.c |  3 +--
 3 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 03e542d..d384b9e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -27,6 +27,22 @@ static inline u32 str_hash(const char *str)
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
@@ -115,7 +131,7 @@ struct section *find_section_by_name(struct elf *elf, const char *name)
 {
 	struct section *sec;
 
-	hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
 		if (!strcmp(sec->name, name))
 			return sec;
 
@@ -127,7 +143,7 @@ static struct section *find_section_by_index(struct elf *elf,
 {
 	struct section *sec;
 
-	hash_for_each_possible(elf->section_hash, sec, hash, idx)
+	elf_hash_for_each_possible(elf->section_hash, sec, hash, idx)
 		if (sec->idx == idx)
 			return sec;
 
@@ -138,7 +154,7 @@ static struct symbol *find_symbol_by_index(struct elf *elf, unsigned int idx)
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
+	elf_hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
 		if (sym->idx == idx)
 			return sym;
 
@@ -205,7 +221,7 @@ struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
 		if (!strcmp(sym->name, name))
 			return sym;
 
@@ -224,7 +240,7 @@ struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
 	sec = sec->rela;
 
 	for_offset_range(o, offset, offset + len) {
-		hash_for_each_possible(elf->rela_hash, rela, hash,
+		elf_hash_for_each_possible(elf->rela_hash, rela, hash,
 				       sec_offset_hash(sec, o)) {
 			if (rela->sec != sec)
 				continue;
@@ -309,8 +325,8 @@ static int read_sections(struct elf *elf)
 		sec->len = sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
-		hash_add(elf->section_hash, &sec->hash, sec->idx);
-		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 	}
 
 	if (stats)
@@ -404,8 +420,8 @@ static int read_symbols(struct elf *elf)
 		else
 			entry = &sym->sec->symbol_list;
 		list_add(&sym->list, entry);
-		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-		hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
 	}
 
 	if (stats)
@@ -472,6 +488,14 @@ err:
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
@@ -519,8 +543,7 @@ static int read_relas(struct elf *elf)
 				return -1;
 			}
 
-			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+			elf_add_rela(elf, rela);
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -547,15 +570,16 @@ struct elf *elf_read(const char *name, int flags)
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
@@ -692,8 +716,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	shstrtab->changed = true;
 
 	list_add_tail(&sec->list, &elf->sections);
-	hash_add(elf->section_hash, &sec->hash, sec->idx);
-	hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
+	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
 	return sec;
 }
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index eb79cb9..2811d04 100644
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
@@ -127,6 +129,7 @@ struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 int elf_rebuild_rela_section(struct section *sec);
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
+void elf_add_rela(struct elf *elf, struct rela *rela);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 2cf640f..9d2bf2d 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -130,8 +130,7 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	rela->offset = idx * sizeof(int);
 	rela->sec = ip_relasec;
 
-	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+	elf_add_rela(elf, rela);
 
 	return 0;
 }
