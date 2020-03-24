Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AADC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022042080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyEjpKqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgCXQNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:13:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LNpyFY6b8XWj6ubZzravys+8EHpOltiuVP2rLApomHQ=; b=nyEjpKqkjfU4uWjTm1mR6VNJuY
        zSV5E1ASlhva1f5uBDpqzz1U4XAdN7t9w+oSs95jpeVvlFwOdR5MSu1+Qxiv0rcqkhe6LYOp0yAcV
        Xcetv4tn9uLaAEtqlN3ZxrqHK/EuC0VlirzzyLqrjOZUvxdp9wyB3dRufBHf0KWYY6j4wZetgC2lP
        kgcZ1QLZs911lz/zKeJrRukcoKzbWCmpR+O9yRUv01BpsUGE3QSl0rDXbI21wQwzhlZDQEvQEEZUt
        8+75HiWNAwhw4Xh6EIhRp+5ixKS9Bnn2fYhmLKveMTBMmf0xG+VfbTgVM87Ne4vF08mnLtpllggvJ
        aPYOZD5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9M-0000C6-VN; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E23B3072A4;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 43EFC29A490F1; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.676865656@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 13/26] objtool: Optimize find_symbol_by_name()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf showed that find_symbol_by_name() takes time; add a symbol name
hash.

This shaves another second off of objtool on vmlinux.o runtime, down
to 15 seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c |   10 +++++-----
 tools/objtool/elf.h |    2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -203,13 +203,11 @@ struct symbol *find_func_containing(stru
 
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
 {
-	struct section *sec;
 	struct symbol *sym;
 
-	list_for_each_entry(sec, &elf->sections, list)
-		list_for_each_entry(sym, &sec->symbol_list, list)
-			if (!strcmp(sym->name, name))
-				return sym;
+	hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+		if (!strcmp(sym->name, name))
+			return sym;
 
 	return NULL;
 }
@@ -386,6 +384,7 @@ static int read_symbols(struct elf *elf)
 			entry = &sym->sec->symbol_list;
 		list_add(&sym->list, entry);
 		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+		hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
 	}
 
 	if (stats)
@@ -524,6 +523,7 @@ struct elf *elf_read(const char *name, i
 	memset(elf, 0, sizeof(*elf));
 
 	hash_init(elf->symbol_hash);
+	hash_init(elf->symbol_name_hash);
 	hash_init(elf->section_hash);
 	hash_init(elf->section_name_hash);
 	INIT_LIST_HEAD(&elf->sections);
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -47,6 +47,7 @@ struct symbol {
 	struct list_head list;
 	struct rb_node node;
 	struct hlist_node hash;
+	struct hlist_node name_hash;
 	GElf_Sym sym;
 	struct section *sec;
 	char *name;
@@ -77,6 +78,7 @@ struct elf {
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
+	DECLARE_HASHTABLE(symbol_name_hash, 20);
 	DECLARE_HASHTABLE(section_hash, 16);
 	DECLARE_HASHTABLE(section_name_hash, 16);
 };


