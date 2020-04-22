Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35092C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE22173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDVWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgDVWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA21C03C1A9;
        Wed, 22 Apr 2020 15:24:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnR-0001Qf-Un; Thu, 23 Apr 2020 00:24:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD0B41C0178;
        Thu, 23 Apr 2020 00:24:43 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:43 -0000
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Optimize add_dead_ends for split sections
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428334.28353.5687463532873634786.tip-bot2@tip-bot2>
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

Commit-ID:     760da44ec676ec67d855cbdda6b3b2a3ca1f4d99
Gitweb:        https://git.kernel.org/tip/760da44ec676ec67d855cbdda6b3b2a3ca1f4d99
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Tue, 21 Apr 2020 15:08:43 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 21 Apr 2020 18:49:21 -05:00

objtool: Optimize add_dead_ends for split sections

Instead of iterating through all instructions to find the last
instruction each time .rela.discard.(un)reachable points beyond the
section, use find_insn() to locate the last instruction by looking at
the last bytes of the section instead.

This makes processing a -ffunction-sections vmlinux.o faster.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/check.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 276bce3..f4254d4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -303,6 +303,19 @@ err:
 	return ret;
 }
 
+static struct instruction *find_last_insn(struct objtool_file *file,
+					  struct section *sec)
+{
+	struct instruction *insn = NULL;
+	unsigned int offset;
+	unsigned int end = (sec->len > 10) ? sec->len - 10 : 0;
+
+	for (offset = sec->len - 1; offset >= end && !insn; offset--)
+		insn = find_insn(file, sec, offset);
+
+	return insn;
+}
+
 /*
  * Mark "ud2" instructions and manually annotated dead ends.
  */
@@ -311,7 +324,6 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *sec;
 	struct rela *rela;
 	struct instruction *insn;
-	bool found;
 
 	/*
 	 * By default, "ud2" is a dead end unless otherwise annotated, because
@@ -337,15 +349,8 @@ static int add_dead_ends(struct objtool_file *file)
 		if (insn)
 			insn = list_prev_entry(insn, list);
 		else if (rela->addend == rela->sym->sec->len) {
-			found = false;
-			list_for_each_entry_reverse(insn, &file->insn_list, list) {
-				if (insn->sec == rela->sym->sec) {
-					found = true;
-					break;
-				}
-			}
-
-			if (!found) {
+			insn = find_last_insn(file, rela->sym->sec);
+			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",
 				     rela->sym->sec->name, rela->addend);
 				return -1;
@@ -379,15 +384,8 @@ reachable:
 		if (insn)
 			insn = list_prev_entry(insn, list);
 		else if (rela->addend == rela->sym->sec->len) {
-			found = false;
-			list_for_each_entry_reverse(insn, &file->insn_list, list) {
-				if (insn->sec == rela->sym->sec) {
-					found = true;
-					break;
-				}
-			}
-
-			if (!found) {
+			insn = find_last_insn(file, rela->sym->sec);
+			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%x",
 				     rela->sym->sec->name, rela->addend);
 				return -1;
