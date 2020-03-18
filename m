Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76384C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E1020768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cjGsTtlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCRNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:20:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35170 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCRNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bdWEPe9BsyfChxcijElDFeFwmFUZsoFwqzKzHC61FV0=; b=cjGsTtlcITA2iMkHtZJ8n68Qv3
        OOATlPN9JmkGu69BtFzSPn79wbdXkbXPJeExLaSSImdA8z9bvant1Eswat8cVISwm0PZKO8LrmK5A
        kLg/JFdvyWJLT1Gfdw87UWajDemRn7EUQ3cqVTRi3a07rKYRIeNRDGM1ScYjR1FYkeilVCfLb5CMF
        TxLSjWJGmiYaUULi6ei2E4rglSf9sNxw65R8v8Wts9HifZV6HDz3xd0+n1K0lYV8FAl5v89fM+L9P
        Z5cc7GF2WuDQpZHu8gG/prOyxvK5RDaxR162scAKUsz6Ow45mari+i0jtlDQ/tJggttJ4yoqhWpbD
        MGE+yThw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEYcV-0003RP-5Q; Wed, 18 Mar 2020 13:20:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC98630047A;
        Wed, 18 Mar 2020 14:20:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 908952B4EBEA3; Wed, 18 Mar 2020 14:20:25 +0100 (CET)
Date:   Wed, 18 Mar 2020 14:20:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v2 17/19] objtool: Optimize !vmlinux.o again
Message-ID: <20200318132025.GH20730@hirez.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.819744197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317170910.819744197@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:02:51PM +0100, Peter Zijlstra wrote:
> When doing kbuild tests to see if the objtool changes affected those I
> found that there was a measurable regression:
> 
>           pre		  post
> 
>   real    1m13.594        1m16.488s
>   user    34m58.246s      35m23.947s
>   sys     4m0.393s        4m27.312s
> 
> Perf showed that for small files the increased hash-table sizes were a
> measurable difference. Since we already have -l "vmlinux" to
> distinguish between the modes, make it also use a smaller portion of
> the hash-tables.
> 
> This flips it into a small win:
> 
>   real    1m14.143s
>   user    34m49.292s
>   sys     3m44.746s
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There was one 'elf_' prefixing gone missing. Updated patch below.

---
 tools/objtool/elf.c |   53 ++++++++++++++++++++++++++++++++++------------------
 tools/objtool/elf.h |    4 +--
 2 files changed, 37 insertions(+), 20 deletions(-)

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
@@ -78,8 +78,8 @@ struct elf {
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
 	DECLARE_HASHTABLE(symbol_name_hash, 20);
-	DECLARE_HASHTABLE(section_hash, 16);
-	DECLARE_HASHTABLE(section_name_hash, 16);
+	DECLARE_HASHTABLE(section_hash, 20);
+	DECLARE_HASHTABLE(section_name_hash, 20);
 	DECLARE_HASHTABLE(rela_hash, 20);
 };
 
