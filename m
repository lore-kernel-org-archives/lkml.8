Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DDFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C342070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgCZKJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRC-00046L-G7; Thu, 26 Mar 2020 11:08:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0EFB11C0440;
        Thu, 26 Mar 2020 11:08:34 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:33 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize find_symbol_by_name()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.676865656@infradead.org>
References: <20200324160924.676865656@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731363.28353.8741952438283038310.tip-bot2@tip-bot2>
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

Commit-ID:     cdb3d057a17d56363a831e486ea39e4c389a6cf9
Gitweb:        https://git.kernel.org/tip/cdb3d057a17d56363a831e486ea39e4c389a6cf9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 10:17:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:30 +01:00

objtool: Optimize find_symbol_by_name()

Perf showed that find_symbol_by_name() takes time; add a symbol name
hash.

This shaves another second off of objtool on vmlinux.o runtime, down
to 15 seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.676865656@infradead.org
---
 tools/objtool/elf.c | 10 +++++-----
 tools/objtool/elf.h |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 07db4df..43abae7 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -203,13 +203,11 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 
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
@@ -524,6 +523,7 @@ struct elf *elf_read(const char *name, int flags)
 	memset(elf, 0, sizeof(*elf));
 
 	hash_init(elf->symbol_hash);
+	hash_init(elf->symbol_name_hash);
 	hash_init(elf->section_hash);
 	hash_init(elf->section_name_hash);
 	INIT_LIST_HEAD(&elf->sections);
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index d18f466..3088d92 100644
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
