Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B637215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCZKJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50201 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgCZKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRB-00045Y-HH; Thu, 26 Mar 2020 11:08:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 15E651C0440;
        Thu, 26 Mar 2020 11:08:33 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Delete cleanup()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.800720170@infradead.org>
References: <20200324160924.800720170@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731275.28353.8005439987604062029.tip-bot2@tip-bot2>
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

Commit-ID:     8887a86eddd93ca396ca35f7b41fb14ed412f85d
Gitweb:        https://git.kernel.org/tip/8887a86eddd93ca396ca35f7b41fb14ed412f85d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 11 Mar 2020 23:07:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:30 +01:00

objtool: Delete cleanup()

Perf shows we spend a measurable amount of time spend cleaning up
right before we exit anyway. Avoid the needsless work and just
terminate.

This reduces objtool on vmlinux.o runtime from 5.4s to 4.8s

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.800720170@infradead.org
---
 tools/objtool/check.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 54a6043..0c9c9ad 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2458,23 +2458,6 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
-static void cleanup(struct objtool_file *file)
-{
-	struct instruction *insn, *tmpinsn;
-	struct alternative *alt, *tmpalt;
-
-	list_for_each_entry_safe(insn, tmpinsn, &file->insn_list, list) {
-		list_for_each_entry_safe(alt, tmpalt, &insn->alts, list) {
-			list_del(&alt->list);
-			free(alt);
-		}
-		list_del(&insn->list);
-		hash_del(&insn->hash);
-		free(insn);
-	}
-	elf_close(file->elf);
-}
-
 static struct objtool_file file;
 
 int check(const char *_objname, bool orc)
@@ -2542,8 +2525,6 @@ int check(const char *_objname, bool orc)
 	}
 
 out:
-	cleanup(&file);
-
 	if (ret < 0) {
 		/*
 		 *  Fatal error.  The binary is corrupt or otherwise broken in
