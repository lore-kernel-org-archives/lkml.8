Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CEBC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8767020738
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H6HBA5Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCLNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46848 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=z+Dn0W7VTxHCyuRkLwcGeNiPWHzdpPJgnpp46SqNHqg=; b=H6HBA5Eh1S6mZmBY8H0bZY8aF8
        kOBqjBQL94A7bAQMy1jvri1vE2hsB79V3VYRMPb0DBn1fXlqJfe763fsedZIiIxvLsFvkXPJexfV6
        Mgvw/xHqDvyNGE/vvL7aDVtoEGqmSbeR+FeMY90I/7l1NtZsvCTAAW+VVdEZYCTmeQBhYgfkOQTbt
        oahuC2r0LOa4nJTV7Tk/nOGPxUpbY47+ZuV/79lKmVk1npakWFowSXarpcd8V93mVG5gSXCNDQFcW
        E7R1t0DIxipKagMcJDdEvMABFwRjZPviiyz/qmNt/XVIYuR0pfAilvkueyjB3I5unVtSxt/PuZttM
        slWvIyKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFO-0003Ad-Ba; Thu, 12 Mar 2020 13:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 505D2307055;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 407AF2B7403DF; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135042.112144649@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 12/16] objtool: Optimize read_sections()
References: <20200312134107.700205216@infradead.org>
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
---
 tools/objtool/elf.c     |   18 ++++++++++++------
 tools/objtool/elf.h     |   18 +++++++++++++++++-
 tools/objtool/orc_gen.c |    3 ++-
 3 files changed, 31 insertions(+), 8 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -210,10 +210,15 @@ struct rela *find_rela_by_dest_range(str
 	if (!sec->rela)
 		return NULL;
 
-	for (o = offset; o < offset + len; o++)
-		hash_for_each_possible(sec->rela->rela_hash, rela, hash, o)
-			if (rela->offset == o)
+	sec = sec->rela;
+
+	for (o = offset; o < offset + len; o++) {
+		hash_for_each_possible(sec->elf->rela_hash, rela, hash,
+				       __rela_hash(o, sec->idx)) {
+			if (rela->sec == sec && rela->offset == o)
 				return rela;
+		}
+	}
 
 	return NULL;
 }
@@ -248,9 +253,9 @@ static int read_sections(struct elf *elf
 		}
 		memset(sec, 0, sizeof(*sec));
 
+		sec->elf = elf;
 		INIT_LIST_HEAD(&sec->symbol_list);
 		INIT_LIST_HEAD(&sec->rela_list);
-		hash_init(sec->rela_hash);
 
 		list_add_tail(&sec->list, &elf->sections);
 
@@ -485,7 +490,7 @@ static int read_relas(struct elf *elf)
 			}
 
 			list_add_tail(&rela->list, &sec->rela_list);
-			hash_add(sec->rela_hash, &rela->hash, rela->offset);
+			hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
 			nr_rela++;
 		}
 		max_rela = max(max_rela, nr_rela);
@@ -518,6 +523,7 @@ struct elf *elf_read(const char *name, i
 	hash_init(elf->symbol_name_hash);
 	hash_init(elf->section_hash);
 	hash_init(elf->section_name_hash);
+	hash_init(elf->rela_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -576,9 +582,9 @@ struct section *elf_create_section(struc
 	}
 	memset(sec, 0, sizeof(*sec));
 
+	sec->elf = elf;
 	INIT_LIST_HEAD(&sec->symbol_list);
 	INIT_LIST_HEAD(&sec->rela_list);
-	hash_init(sec->rela_hash);
 
 	list_add_tail(&sec->list, &elf->sections);
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -25,6 +25,8 @@
 #define ELF_C_READ_MMAP ELF_C_READ
 #endif
 
+struct elf;
+
 struct section {
 	struct list_head list;
 	struct hlist_node hash;
@@ -33,7 +35,7 @@ struct section {
 	struct rb_root symbol_tree;
 	struct list_head symbol_list;
 	struct list_head rela_list;
-	DECLARE_HASHTABLE(rela_hash, 16);
+	struct elf *elf;
 	struct section *base, *rela;
 	struct symbol *sym;
 	Elf_Data *data;
@@ -81,8 +83,22 @@ struct elf {
 	DECLARE_HASHTABLE(symbol_name_hash, 20);
 	DECLARE_HASHTABLE(section_hash, 16);
 	DECLARE_HASHTABLE(section_name_hash, 16);
+	DECLARE_HASHTABLE(rela_hash, 20);
 };
 
+static inline u32 __rela_hash(unsigned long offset, int idx)
+{
+	u32 ol = offset, oh = offset >> 32;
+
+	__jhash_mix(ol, oh, idx);
+
+	return ol;
+}
+
+static inline u32 rela_hash(struct rela *rela)
+{
+	return __rela_hash(rela->offset, rela->sec->idx);
+}
 
 struct elf *elf_read(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -109,9 +109,10 @@ static int create_orc_entry(struct secti
 	rela->addend = insn_off;
 	rela->type = R_X86_64_PC32;
 	rela->offset = idx * sizeof(int);
+	rela->sec = ip_relasec;
 
 	list_add_tail(&rela->list, &ip_relasec->rela_list);
-	hash_add(ip_relasec->rela_hash, &rela->hash, rela->offset);
+	hash_add(ip_relasec->elf->rela_hash, &rela->hash, rela_hash(rela));
 
 	return 0;
 }


