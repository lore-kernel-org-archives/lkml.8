Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48790C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2350C2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgCZKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRE-00047J-AV; Thu, 26 Mar 2020 11:08:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DEBB51C0478;
        Thu, 26 Mar 2020 11:08:35 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize find_section_by_name()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.440174280@infradead.org>
References: <20200324160924.440174280@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731555.28353.11326523921308261337.tip-bot2@tip-bot2>
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

Commit-ID:     ae358196fac3a0b4d2a7d47a4f401e3421027b03
Gitweb:        https://git.kernel.org/tip/ae358196fac3a0b4d2a7d47a4f401e3421027b03
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 09:32:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:29 +01:00

objtool: Optimize find_section_by_name()

In order to avoid yet another linear search of (20k) sections, add a
name based hash.

This reduces objtool runtime on vmlinux.o by some 10s to around 35s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.440174280@infradead.org
---
 tools/objtool/elf.c | 10 +++++++++-
 tools/objtool/elf.h |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 9007713..20fe40d 100644
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
 
@@ -202,6 +207,7 @@ static int read_sections(struct elf *elf)
 
 		list_add_tail(&sec->list, &elf->sections);
 		hash_add(elf->section_hash, &sec->hash, sec->idx);
+		hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 	}
 
 	if (stats)
@@ -441,6 +447,7 @@ struct elf *elf_read(const char *name, int flags)
 
 	hash_init(elf->symbol_hash);
 	hash_init(elf->section_hash);
+	hash_init(elf->section_name_hash);
 	INIT_LIST_HEAD(&elf->sections);
 
 	elf->fd = open(name, flags);
@@ -581,6 +588,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 
 	list_add_tail(&sec->list, &elf->sections);
 	hash_add(elf->section_hash, &sec->hash, sec->idx);
+	hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
 
 	return sec;
 }
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 8c272eb..ac7c46f 100644
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
 
 
