Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE304C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAE720774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgCZKJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:09:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgCZKIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRI-00049A-9W; Thu, 26 Mar 2020 11:08:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BFAAC1C048C;
        Thu, 26 Mar 2020 11:08:38 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:38 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Rename func_for_each_insn_all()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.083720147@infradead.org>
References: <20200324160924.083720147@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731844.28353.3388328240594789282.tip-bot2@tip-bot2>
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

Commit-ID:     f0f70adb78108a0cbc321a07133cd78ea4f84699
Gitweb:        https://git.kernel.org/tip/f0f70adb78108a0cbc321a07133cd78ea4f84699
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Mar 2020 18:27:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:27 +01:00

objtool: Rename func_for_each_insn_all()

Now that func_for_each_insn() is available, rename
func_for_each_insn_all(). This gets us:

  sym_for_each_insn()  - iterate on symbol offset/len
  func_for_each_insn() - iterate on insn->func

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.083720147@infradead.org
---
 tools/objtool/check.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 564ea1d..43f7d3c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -72,7 +72,7 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
 
-#define func_for_each_insn_all(file, func, insn)			\
+#define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn;							\
 	     insn = next_insn_same_func(file, insn))
@@ -170,7 +170,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	if (!insn->func)
 		return false;
 
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
@@ -185,7 +185,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * case, the function's dead-end status depends on whether the target
 	 * of the sibling call returns.
 	 */
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		if (is_sibling_call(insn)) {
 			struct instruction *dest = insn->jump_dest;
 
@@ -430,7 +430,7 @@ static void add_ignores(struct objtool_file *file)
 			continue;
 		}
 
-		func_for_each_insn_all(file, func, insn)
+		func_for_each_insn(file, func, insn)
 			insn->ignore = true;
 	}
 }
@@ -1122,7 +1122,7 @@ static void mark_func_jump_tables(struct objtool_file *file,
 	struct instruction *insn, *last = NULL;
 	struct rela *rela;
 
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		if (!last)
 			last = insn;
 
@@ -1157,7 +1157,7 @@ static int add_func_jump_tables(struct objtool_file *file,
 	struct instruction *insn;
 	int ret;
 
-	func_for_each_insn_all(file, func, insn) {
+	func_for_each_insn(file, func, insn) {
 		if (!insn->jump_table)
 			continue;
 
