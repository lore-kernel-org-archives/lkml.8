Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923CEC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606AD2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQJ7wqr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCLNwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IT3R/wnPJR6ANDGqxsHfySvScSEJgnsZS5Al5B69paY=; b=hQJ7wqr13PtnKd4paDMXZhysg8
        s0k3Cl39ojI9FCFVFT6hxi2O6xk6GvD+S5ALAB2DPeN9nM4diJEDpNFrH2i0MzuFWFnjFkSlrgHah
        9m9lBkWobcIbxp46vvr1HLd9Ljk2tqqjEUjzBySy3+e6a10hltQwlOhWel2vnk7XfMcxkUt4+k4HK
        S19wO+SJmWvuWFD4XXTh4Ea19YQ+iduU3vtZHF0/ZXiAz4pf4+a5dYQTILRuThVQg9uqJXekE/3va
        TWF4cJaIG7RHZlaZ/by1BfKvNMFR0jwP0rBXt2l27xDQ66iN3EzQcvdXW8Yu85mBB2RhYtR+MXcSi
        kCVHxotg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFO-0003Ae-BL; Thu, 12 Mar 2020 13:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5079D30705A;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3C1542B7403AA; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135042.053418319@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 11/16] objtool: Optimize find_symbol_by_name()
References: <20200312134107.700205216@infradead.org>
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
---
 tools/objtool/elf.c |   10 +++++-----
 tools/objtool/elf.h |    2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -134,13 +134,11 @@ struct symbol *find_symbol_by_offset(str
 
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
@@ -365,6 +363,7 @@ static int read_symbols(struct elf *elf)
 		list_add(&sym->list, entry);
 
 		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
+		hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
 	}
 
 	if (stats)
@@ -503,6 +502,7 @@ struct elf *elf_read(const char *name, i
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


