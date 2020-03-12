Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EEAC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A672067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZaFSJ5hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCLNvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:51:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Eo0gdSJQsnf3/CR3ZyWDPBQrlgYlqxkUT+8zjcJOBDQ=; b=ZaFSJ5hLPdmtgq/eD1zh9mmghw
        PfSQpK2gpU3Mrgx/KRHkmZuUEHwuWCAvV6/MAEkl7+JtqXpC9OUM8DK9yd6RX0HSQNbQ1x/OBbyp5
        Rnh9kMqWufyiZ+mb98gdT5l2jPF6hdZuUDFBjWt8/VEEQPzHlFNijhLtGnQyQtT8c8V6y73BWXsjd
        UO5RNjY346B9t/bML48WK3IcYmQhh1++jkQxsuhMBDY3yeWwpop+YOSo+K28P5Uus2WVJiz1slZGu
        OvXhGPpOLG+kD9NbS4hHTwCZRsezUo3vVduq1aWKB29jq9lr7i5zkmTKxdlTlLKb7l0T9k64eUpT1
        TODRdqqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFN-0006Wb-WF; Thu, 12 Mar 2020 13:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44827305EEC;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 262522B92DA1B; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.875820323@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 08/16] Optimize find_section_by_name()
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid yet another linear search of (20k) sections, add a
name based hash.

This reduces objtool runtime on vmlinux.o by some 10s to around 35s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |    9 ++++++++-
 tools/objtool/elf.h |    3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -22,11 +22,16 @@
 
 #define MAX_NAME_LEN 128
 
+static inline u32 str_hash(const char *str)
+{
+	return jhash(str, strlen(str), 0);
+}
+
 struct section *find_section_by_name(struct elf *elf, const char *name)
 {
 	struct section *sec;
 
-	list_for_each_entry(sec, &elf->sections, list)
+	hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
 		if (!strcmp(sec->name, name))
 			return sec;
 
@@ -193,6 +198,7 @@ static int read_sections(struct elf *elf
 		sec->len = sec->sh.sh_size;
 
 		hash_add(elf->section_hash, &sec->hash, sec->idx);
+		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 	}
 
 	if (stats)
@@ -433,6 +439,7 @@ struct elf *elf_read(const char *name, i
 
 	hash_init(elf->symbol_hash);
 	hash_init(elf->section_hash);
+	hash_init(elf->section_name_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -10,6 +10,7 @@
 #include <gelf.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <linux/jhash.h>
 
 #ifdef LIBELF_USE_DEPRECATED
 # define elf_getshdrnum    elf_getshnum
@@ -26,6 +27,7 @@
 struct section {
 	struct list_head list;
 	struct hlist_node hash;
+	struct hlist_node name_hash;
 	GElf_Shdr sh;
 	struct list_head symbol_list;
 	struct list_head rela_list;
@@ -73,6 +75,7 @@ struct elf {
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
 	DECLARE_HASHTABLE(section_hash, 16);
+	DECLARE_HASHTABLE(section_name_hash, 16);
 };
 
 


