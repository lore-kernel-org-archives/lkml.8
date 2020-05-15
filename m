Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A617E20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgEORW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEORW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:22:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC74C061A0C;
        Fri, 15 May 2020 10:22:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZe2v-0005Tf-0F; Fri, 15 May 2020 19:22:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D6861C007F;
        Fri, 15 May 2020 19:22:52 +0200 (CEST)
Date:   Fri, 15 May 2020 17:22:52 -0000
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: optimize add_dead_ends for split sections
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421220843.188260-3-samitolvanen@google.com>
References: <20200421220843.188260-3-samitolvanen@google.com>
MIME-Version: 1.0
Message-ID: <158956337243.17951.11031763699409258721.tip-bot2@tip-bot2>
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

Commit-ID:     6b5dd716da8fc3aba65e6b7d992dea0cee2f9528
Gitweb:        https://git.kernel.org/tip/6b5dd716da8fc3aba65e6b7d992dea0cee2f9528
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Tue, 21 Apr 2020 15:08:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 May 2020 10:35:13 +02:00

objtool: optimize add_dead_ends for split sections

Instead of iterating through all instructions to find the last
instruction each time .rela.discard.(un)reachable points beyond the
section, use find_insn to locate the last instruction by looking at
the last bytes of the section instead.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421220843.188260-3-samitolvanen@google.com
---
 tools/objtool/check.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 196a551..6b2b458 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -322,6 +322,19 @@ err:
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
@@ -330,7 +343,6 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *sec;
 	struct rela *rela;
 	struct instruction *insn;
-	bool found;
 
 	/*
 	 * By default, "ud2" is a dead end unless otherwise annotated, because
@@ -356,15 +368,8 @@ static int add_dead_ends(struct objtool_file *file)
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
@@ -398,15 +403,8 @@ reachable:
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
