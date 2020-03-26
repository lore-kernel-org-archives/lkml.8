Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032B520775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgCZKIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRE-00047r-Pu; Thu, 26 Mar 2020 11:08:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5707A1C0440;
        Thu, 26 Mar 2020 11:08:36 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize find_section_by_index()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.381249993@infradead.org>
References: <20200324160924.381249993@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731598.28353.8097168736160020060.tip-bot2@tip-bot2>
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

Commit-ID:     530389968739883a61192767e1c215653ba4ba2b
Gitweb:        https://git.kernel.org/tip/530389968739883a61192767e1c215653ba4ba2b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Mar 2020 18:43:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:28 +01:00

objtool: Optimize find_section_by_index()

In order to avoid a linear search (over 20k entries), add an
section_hash to the elf object.

This reduces objtool on vmlinux.o from a few minutes to around 45
seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.381249993@infradead.org
---
 tools/objtool/elf.c | 13 ++++++++-----
 tools/objtool/elf.h |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ff29306..9007713 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -38,7 +38,7 @@ static struct section *find_section_by_index(struct elf *elf,
 {
 	struct section *sec;
 
-	list_for_each_entry(sec, &elf->sections, list)
+	hash_for_each_possible(elf->section_hash, sec, hash, idx)
 		if (sec->idx == idx)
 			return sec;
 
@@ -166,8 +166,6 @@ static int read_sections(struct elf *elf)
 		INIT_LIST_HEAD(&sec->rela_list);
 		hash_init(sec->rela_hash);
 
-		list_add_tail(&sec->list, &elf->sections);
-
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
 			WARN_ELF("elf_getscn");
@@ -201,6 +199,9 @@ static int read_sections(struct elf *elf)
 			}
 		}
 		sec->len = sec->sh.sh_size;
+
+		list_add_tail(&sec->list, &elf->sections);
+		hash_add(elf->section_hash, &sec->hash, sec->idx);
 	}
 
 	if (stats)
@@ -439,6 +440,7 @@ struct elf *elf_read(const char *name, int flags)
 	memset(elf, 0, sizeof(*elf));
 
 	hash_init(elf->symbol_hash);
+	hash_init(elf->section_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -501,8 +503,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	INIT_LIST_HEAD(&sec->rela_list);
 	hash_init(sec->rela_hash);
 
-	list_add_tail(&sec->list, &elf->sections);
-
 	s = elf_newscn(elf->elf);
 	if (!s) {
 		WARN_ELF("elf_newscn");
@@ -579,6 +579,9 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	shstrtab->len += strlen(name) + 1;
 	shstrtab->changed = true;
 
+	list_add_tail(&sec->list, &elf->sections);
+	hash_add(elf->section_hash, &sec->hash, sec->idx);
+
 	return sec;
 }
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 1222980..8c272eb 100644
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
 
 
