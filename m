Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E34AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90A520714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nD6EP7wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCQRMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45258 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgCQRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tfdcDtil5Nt59vLV9ltnZU6hYowx1oRrojhUVCyo+Og=; b=nD6EP7wMKH8CAdwb3lr9Z2mKr0
        F8R7PORxVu8b4Cassg5tCKNoOthxqv6SOUfZCe0Grbwm99djZOA/plGYEAHmucHuY0X/azzifNMwL
        WXetKB1bzZVYKkE73eEEKmD1cGkCdsPxcMdJ/HMgtbQ76wENvMFsTyXI8zLXwn8q2VAY1DohiaJ3c
        qinAMGzoAs8CWjPhnEQPwzP7HSWR6Fq7GemGcZKhKkzix7+0mkAwuS1+nrGqhFeBLGRyEade8NqDk
        0KOknJNU0rBsF6C6WN8Ai2Mp44UnNUoZ5fUtD8XR2G/H3l89Bvtq4Z4hQRsEV1bkL3pQYV4/mBMDX
        JFJoqiqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl1-0003jN-4g; Tue, 17 Mar 2020 17:11:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36F6E30743A;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2718520B16496; Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Message-Id: <20200317170910.819744197@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 17/19] objtool: Optimize !vmlinux.o again
References: <20200317170234.897520633@infradead.org>
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
 
@@ -205,7 +221,7 @@ struct symbol *find_symbol_by_name(struc
 {
 	struct symbol *sym;
 
-	hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
 		if (!strcmp(sym->name, name))
 			return sym;
 
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
@@ -504,7 +520,7 @@ static int read_relas(struct elf *elf)
 			}
 
 			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
+			elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -531,15 +547,16 @@ struct elf *elf_read(const char *name, i
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
@@ -676,8 +693,8 @@ struct section *elf_create_section(struc
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
@@ -80,8 +80,8 @@ struct elf {
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
 	DECLARE_HASHTABLE(symbol_name_hash, 20);
-	DECLARE_HASHTABLE(section_hash, 16);
-	DECLARE_HASHTABLE(section_name_hash, 16);
+	DECLARE_HASHTABLE(section_hash, 20);
+	DECLARE_HASHTABLE(section_name_hash, 20);
 	DECLARE_HASHTABLE(rela_hash, 20);
 };
 


