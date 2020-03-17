Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540CC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B931620738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mYmzHNSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCQRMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45066 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tt6sgdo4IF9Jb2w0j4f0C0e7MxgYHI3OVniGA7tRkPQ=; b=mYmzHNSmLNibLNt6BALLUQfwoe
        RvM+LWtm2fzUBRPlZI/tbPfHknFr/Yp8kDoELpsQ5RKM4++pgAz4ALkkxmVLPnvsrOkXq0oiGT3b6
        lHXuVeOxgL2KPTGMpsrAQz5VilvrKKkzjvPqISh5oexByZo7HopGHyaepxMudGsePFC8344Bz3o5E
        a5vg8XunqPfA1GwU/jUKpLzy5ep5a8wKkiiRhb9vJGmDs+knXlniw+PVqRqMZMZ0DUZ0JX0figAdw
        EXzU70dZmohsGkW4G7XRZKjiV8yP/JVy6brKkf6XCixdEQwuYZpmG3OD9Yx8hc8lIJlIWcvNrj0N5
        9Gb5SGzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFky-0003if-4K; Tue, 17 Mar 2020 17:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF8993060EF;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CCA5D264FDB18; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170910.058669716@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 05/19] objtool: Optimize find_symbol_by_index()
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol index is object wide, not per section, so it makes no sense
to have the symbol_hash be part of the section object. By moving it to
the elf object we avoid the linear sections iteration.

This reduces the runtime of objtool on vmlinux.o from over 3 hours (I
gave up) to a few minutes. The defconfig vmlinux.o has around 20k
sections.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   13 +++++--------
 tools/objtool/elf.h |    3 +--
 2 files changed, 6 insertions(+), 10 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -46,13 +46,11 @@ static struct section *find_section_by_i
 
 static struct symbol *find_symbol_by_index(struct elf *elf, unsigned int idx)
 {
-	struct section *sec;
 	struct symbol *sym;
 
-	list_for_each_entry(sec, &elf->sections, list)
-		hash_for_each_possible(sec->symbol_hash, sym, hash, idx)
-			if (sym->idx == idx)
-				return sym;
+	hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
+		if (sym->idx == idx)
+			return sym;
 
 	return NULL;
 }
@@ -166,7 +164,6 @@ static int read_sections(struct elf *elf
 		INIT_LIST_HEAD(&sec->symbol_list);
 		INIT_LIST_HEAD(&sec->rela_list);
 		hash_init(sec->rela_hash);
-		hash_init(sec->symbol_hash);
 
 		list_add_tail(&sec->list, &elf->sections);
 
@@ -299,7 +296,7 @@ static int read_symbols(struct elf *elf)
 		}
 		sym->alias = alias;
 		list_add(&sym->list, entry);
-		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
+		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
 	}
 
 	/* Create parent/child links for any cold subfunctions */
@@ -425,6 +422,7 @@ struct elf *elf_read(const char *name, i
 	}
 	memset(elf, 0, sizeof(*elf));
 
+	hash_init(elf->symbol_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -486,7 +484,6 @@ struct section *elf_create_section(struc
 	INIT_LIST_HEAD(&sec->symbol_list);
 	INIT_LIST_HEAD(&sec->rela_list);
 	hash_init(sec->rela_hash);
-	hash_init(sec->symbol_hash);
 
 	list_add_tail(&sec->list, &elf->sections);
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -27,7 +27,6 @@ struct section {
 	struct list_head list;
 	GElf_Shdr sh;
 	struct list_head symbol_list;
-	DECLARE_HASHTABLE(symbol_hash, 8);
 	struct list_head rela_list;
 	DECLARE_HASHTABLE(rela_hash, 16);
 	struct section *base, *rela;
@@ -71,7 +70,7 @@ struct elf {
 	int fd;
 	char *name;
 	struct list_head sections;
-	DECLARE_HASHTABLE(rela_hash, 16);
+	DECLARE_HASHTABLE(symbol_hash, 20);
 };
 
 


