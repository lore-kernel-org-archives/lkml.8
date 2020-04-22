Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67B6C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEAE2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDVWYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8CC03C1A9;
        Wed, 22 Apr 2020 15:24:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnB-0001Kw-D2; Thu, 23 Apr 2020 00:24:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 634B81C0178;
        Thu, 23 Apr 2020 00:24:28 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:27 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Also consider .entry.text as noinstr
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.525037514@infradead.org>
References: <20200416115119.525037514@infradead.org>
MIME-Version: 1.0
Message-ID: <158759426781.28353.17950951303867293555.tip-bot2@tip-bot2>
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

Commit-ID:     b164b813e866b98387815eec40c6653a2edbc38a
Gitweb:        https://git.kernel.org/tip/b164b813e866b98387815eec40c6653a2edbc38a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Mar 2020 17:18:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:08 +02:00

objtool: Also consider .entry.text as noinstr

Consider all of .entry.text as noinstr. This gets us coverage across
the PTI boundary. While we could add everything .noinstr.text into
.entry.text that would bloat the amount of code in the user mapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.525037514@infradead.org
---
 tools/objtool/check.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f51c325..89b208c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -266,7 +266,8 @@ static int decode_instructions(struct objtool_file *file)
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;
 
-		if (!strcmp(sec->name, ".noinstr.text"))
+		if (!strcmp(sec->name, ".noinstr.text") ||
+		    !strcmp(sec->name, ".entry.text"))
 			sec->noinstr = true;
 
 		for (offset = 0; offset < sec->len; offset += insn->len) {
@@ -2087,7 +2088,7 @@ static inline const char *call_dest_name(struct instruction *insn)
 static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    (!insn->call_dest || insn->call_dest->sec != insn->sec)) {
+	    (!insn->call_dest || !insn->call_dest->sec->noinstr)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -2574,11 +2575,16 @@ static int validate_vmlinux_functions(struct objtool_file *file)
 	int warnings = 0;
 
 	sec = find_section_by_name(file->elf, ".noinstr.text");
-	if (!sec)
-		return 0;
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
 
-	warnings += validate_section(file, sec);
-	warnings += validate_unwind_hints(file, sec);
+	sec = find_section_by_name(file->elf, ".entry.text");
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
 
 	return warnings;
 }
