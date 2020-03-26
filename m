Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34844C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBF920748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgCZKJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCZKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRD-00046v-Uw; Thu, 26 Mar 2020 11:08:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 013CF1C0440;
        Thu, 26 Mar 2020 11:08:35 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Rename find_containing_func()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.558470724@infradead.org>
References: <20200324160924.558470724@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731454.28353.17616231128837111954.tip-bot2@tip-bot2>
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

Commit-ID:     53d20720bbc8718ef86fdfe53dec0accfb593ef8
Gitweb:        https://git.kernel.org/tip/53d20720bbc8718ef86fdfe53dec0accfb593ef8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Mar 2020 10:36:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:29 +01:00

objtool: Rename find_containing_func()

For consistency; we have:

  find_symbol_by_offset() / find_symbol_containing()
  find_func_by_offset()   / find_containing_func()

fix that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.558470724@infradead.org
---
 tools/objtool/elf.c  | 2 +-
 tools/objtool/elf.h  | 2 +-
 tools/objtool/warn.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3a8b426..07db4df 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -187,7 +187,7 @@ struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
-struct symbol *find_containing_func(struct section *sec, unsigned long offset)
+struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index e4a8d68..d18f466 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -91,7 +91,7 @@ struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
 struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
 				     unsigned int len);
-struct symbol *find_containing_func(struct section *sec, unsigned long offset);
+struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t
 				   entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
diff --git a/tools/objtool/warn.h b/tools/objtool/warn.h
index cbb0a02..7799f60 100644
--- a/tools/objtool/warn.h
+++ b/tools/objtool/warn.h
@@ -21,7 +21,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	char *name, *str;
 	unsigned long name_off;
 
-	func = find_containing_func(sec, offset);
+	func = find_func_containing(sec, offset);
 	if (func) {
 		name = func->name;
 		name_off = offset - func->offset;
