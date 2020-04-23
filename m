Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16BBC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA40B21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgDWHvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgDWHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027DC03C1AF;
        Thu, 23 Apr 2020 00:49:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc2-0008JS-8Y; Thu, 23 Apr 2020 09:49:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D8AE81C0244;
        Thu, 23 Apr 2020 09:49:33 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:33 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Constify 'struct elf *' parameters
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422103205.61900-2-mingo@kernel.org>
References: <20200422103205.61900-2-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <158762817342.28353.2046272086047746312.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     894e48cada64ec384873fad4fe1b0d0c7de31a29
Gitweb:        https://git.kernel.org/tip/894e48cada64ec384873fad4fe1b0d0c7de31a29
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 22 Apr 2020 12:32:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Apr 2020 08:34:18 +02:00

objtool: Constify 'struct elf *' parameters

In preparation to parallelize certain parts of objtool, map out which uses
of various data structures are read-only vs. read-write.

As a first step constify 'struct elf' pointer passing, most of the secondary
uses of it in find_symbol_*() methods are read-only.

Also, while at it, better group the 'struct elf' handling methods in elf.h.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200422103205.61900-2-mingo@kernel.org
---
 tools/objtool/elf.c | 10 +++++-----
 tools/objtool/elf.h | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f26bb3e..fab5534 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -127,7 +127,7 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
 	return 0;
 }
 
-struct section *find_section_by_name(struct elf *elf, const char *name)
+struct section *find_section_by_name(const struct elf *elf, const char *name)
 {
 	struct section *sec;
 
@@ -217,7 +217,7 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
-struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
+struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 {
 	struct symbol *sym;
 
@@ -228,7 +228,7 @@ struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
 	return NULL;
 }
 
-struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len)
 {
 	struct rela *rela, *r = NULL;
@@ -257,7 +257,7 @@ struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
 	return NULL;
 }
 
-struct rela *find_rela_by_dest(struct elf *elf, struct section *sec, unsigned long offset)
+struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset)
 {
 	return find_rela_by_dest_range(elf, sec, offset, 1);
 }
@@ -769,7 +769,7 @@ int elf_rebuild_rela_section(struct section *sec)
 	return 0;
 }
 
-int elf_write(struct elf *elf)
+int elf_write(const struct elf *elf)
 {
 	struct section *sec;
 	Elf_Scn *s;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 2811d04..a55bcde 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -114,22 +114,22 @@ static inline u32 rela_hash(struct rela *rela)
 }
 
 struct elf *elf_read(const char *name, int flags);
-struct section *find_section_by_name(struct elf *elf, const char *name);
+struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
+struct section *elf_create_rela_section(struct elf *elf, struct section *base);
+void elf_add_rela(struct elf *elf, struct rela *rela);
+int elf_write(const struct elf *elf);
+void elf_close(struct elf *elf);
+
+struct section *find_section_by_name(const struct elf *elf, const char *name);
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
-struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
+struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest(struct elf *elf, struct section *sec, unsigned long offset);
-struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
+struct rela *find_rela_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
+struct rela *find_rela_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-struct section *elf_create_section(struct elf *elf, const char *name, size_t
-				   entsize, int nr);
-struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 int elf_rebuild_rela_section(struct section *sec);
-int elf_write(struct elf *elf);
-void elf_close(struct elf *elf);
-void elf_add_rela(struct elf *elf, struct rela *rela);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
