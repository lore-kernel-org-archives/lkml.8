Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BBC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5728C20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgCZKIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50206 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgCZKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRF-00048b-Oy; Thu, 26 Mar 2020 11:08:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 58D5C1C0440;
        Thu, 26 Mar 2020 11:08:37 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize find_symbol_by_index()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.261852348@infradead.org>
References: <20200324160924.261852348@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731694.28353.9998242041502951523.tip-bot2@tip-bot2>
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

Commit-ID:     65fb11a7f6aeae678043738d06248a4e21f4e4e4
Gitweb:        https://git.kernel.org/tip/65fb11a7f6aeae678043738d06248a4e21f4e4e4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Mar 2020 18:39:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:28 +01:00

objtool: Optimize find_symbol_by_index()

The symbol index is object wide, not per section, so it makes no sense
to have the symbol_hash be part of the section object. By moving it to
the elf object we avoid the linear sections iteration.

This reduces the runtime of objtool on vmlinux.o from over 3 hours (I
gave up) to a few minutes. The defconfig vmlinux.o has around 20k
sections.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.261852348@infradead.org
---
 tools/objtool/elf.c | 13 +++++--------
 tools/objtool/elf.h |  3 +--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index cc4601c..b188b3e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -46,13 +46,11 @@ static struct section *find_section_by_index(struct elf *elf,
 
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
@@ -166,7 +164,6 @@ static int read_sections(struct elf *elf)
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
@@ -425,6 +422,7 @@ struct elf *elf_read(const char *name, int flags)
 	}
 	memset(elf, 0, sizeof(*elf));
 
+	hash_init(elf->symbol_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -486,7 +484,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	INIT_LIST_HEAD(&sec->symbol_list);
 	INIT_LIST_HEAD(&sec->rela_list);
 	hash_init(sec->rela_hash);
-	hash_init(sec->symbol_hash);
 
 	list_add_tail(&sec->list, &elf->sections);
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index a196325..1222980 100644
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
 
 
