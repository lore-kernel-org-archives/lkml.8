Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AB6C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1D120714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qof8pY8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgCQRMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgCQRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CdRILchf5uU2/BsWG/A+J4QpBRw1Y5wAURqUf05Wjww=; b=qof8pY8FeTUq6lJ42T2sn0wQU7
        nuJqEFwwCtO5tHWBkTqZB6haTZ0kOXbW4E6WOJdo0Hb/yzvZzM74uKc6KFYzHqsahMp/bGYswKUdF
        G5j3HstnFUHGY7YOfTRRETfCcVX+S6bFhF2Owyz1VdjOFgjE9RVC2j8expfIa+jcL4rozryuAdB81
        2qKvHsU1+W6mZzNLDnCzMe8tanyFlCXd1VTGJ4WeYKdEk2JHnevUhHX7q0vGWntVh7X08lvksjXtJ
        BLphhHZOqxJqV2nXK7NSbYKKm/N60ycFGX0CNtBtYilwhW8UQyAAQyIpfANruFVF56A9SDSTAg6SQ
        8jSPrzeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFkz-0002r8-Vu; Tue, 17 Mar 2020 17:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F355F307087;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB21B264FDB1A; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170910.178947741@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 07/19] objtool: Optimize find_section_by_index()
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a linear search (over 20k entries), add an
section_hash to the elf object.

This reduces objtool on vmlinux.o from a few minutes to around 45
seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   13 ++++++++-----
 tools/objtool/elf.h |    2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -38,7 +38,7 @@ static struct section *find_section_by_i
 {
 	struct section *sec;
 
-	list_for_each_entry(sec, &elf->sections, list)
+	hash_for_each_possible(elf->section_hash, sec, hash, idx)
 		if (sec->idx == idx)
 			return sec;
 
@@ -166,8 +166,6 @@ static int read_sections(struct elf *elf
 		INIT_LIST_HEAD(&sec->rela_list);
 		hash_init(sec->rela_hash);
 
-		list_add_tail(&sec->list, &elf->sections);
-
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
 			WARN_ELF("elf_getscn");
@@ -201,6 +199,9 @@ static int read_sections(struct elf *elf
 			}
 		}
 		sec->len = sec->sh.sh_size;
+
+		list_add_tail(&sec->list, &elf->sections);
+		hash_add(elf->section_hash, &sec->hash, sec->idx);
 	}
 
 	if (stats)
@@ -439,6 +440,7 @@ struct elf *elf_read(const char *name, i
 	memset(elf, 0, sizeof(*elf));
 
 	hash_init(elf->symbol_hash);
+	hash_init(elf->section_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -501,8 +503,6 @@ struct section *elf_create_section(struc
 	INIT_LIST_HEAD(&sec->rela_list);
 	hash_init(sec->rela_hash);
 
-	list_add_tail(&sec->list, &elf->sections);
-
 	s = elf_newscn(elf->elf);
 	if (!s) {
 		WARN_ELF("elf_newscn");
@@ -579,6 +579,9 @@ struct section *elf_create_section(struc
 	shstrtab->len += strlen(name) + 1;
 	shstrtab->changed = true;
 
+	list_add_tail(&sec->list, &elf->sections);
+	hash_add(elf->section_hash, &sec->hash, sec->idx);
+
 	return sec;
 }
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -25,6 +25,7 @@
 
 struct section {
 	struct list_head list;
+	struct hlist_node hash;
 	GElf_Shdr sh;
 	struct list_head symbol_list;
 	struct list_head rela_list;
@@ -71,6 +72,7 @@ struct elf {
 	char *name;
 	struct list_head sections;
 	DECLARE_HASHTABLE(symbol_hash, 20);
+	DECLARE_HASHTABLE(section_hash, 16);
 };
 
 


