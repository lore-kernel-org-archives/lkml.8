Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E3DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F66820748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgCZKJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgCZKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRB-00045U-3H; Thu, 26 Mar 2020 11:08:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A796F1C0470;
        Thu, 26 Mar 2020 11:08:32 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Optimize find_rela_by_dest_range()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.861321325@infradead.org>
References: <20200324160924.861321325@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731235.28353.5096850462321225657.tip-bot2@tip-bot2>
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

Commit-ID:     74b873e49d92f90deb41d1a2a8fbb70328aebd67
Gitweb:        https://git.kernel.org/tip/74b873e49d92f90deb41d1a2a8fbb70328aebd67
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 11:30:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:31 +01:00

objtool: Optimize find_rela_by_dest_range()

Perf shows there is significant time in find_rela_by_dest(); this is
because we have to iterate the address space per byte, looking for
relocation entries.

Optimize this by reducing the address space granularity.

This reduces objtool on vmlinux.o runtime from 4.8 to 4.4 seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.861321325@infradead.org
---
 tools/objtool/elf.c | 15 +++++++++++----
 tools/objtool/elf.h | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8a0a1bc..09ddc8f 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -215,7 +215,7 @@ struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
 struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len)
 {
-	struct rela *rela;
+	struct rela *rela, *r = NULL;
 	unsigned long o;
 
 	if (!sec->rela)
@@ -223,12 +223,19 @@ struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
 
 	sec = sec->rela;
 
-	for (o = offset; o < offset + len; o++) {
+	for_offset_range(o, offset, offset + len) {
 		hash_for_each_possible(elf->rela_hash, rela, hash,
 				       sec_offset_hash(sec, o)) {
-			if (rela->sec == sec && rela->offset == o)
-				return rela;
+			if (rela->sec != sec)
+				continue;
+
+			if (rela->offset >= offset && rela->offset < offset + len) {
+				if (!r || rela->offset < r->offset)
+					r = rela;
+			}
 		}
+		if (r)
+			return r;
 	}
 
 	return NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index dfd2431..ebbb10c 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -83,9 +83,23 @@ struct elf {
 	DECLARE_HASHTABLE(rela_hash, 20);
 };
 
+#define OFFSET_STRIDE_BITS	4
+#define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
+#define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
+
+#define for_offset_range(_offset, _start, _end)		\
+	for (_offset = ((_start) & OFFSET_STRIDE_MASK);	\
+	     _offset <= ((_end) & OFFSET_STRIDE_MASK);	\
+	     _offset += OFFSET_STRIDE)
+
 static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 {
-	u32 ol = offset, oh = offset >> 32, idx = sec->idx;
+	u32 ol, oh, idx = sec->idx;
+
+	offset &= OFFSET_STRIDE_MASK;
+
+	ol = offset;
+	oh = offset >> 32;
 
 	__jhash_mix(ol, oh, idx);
 
