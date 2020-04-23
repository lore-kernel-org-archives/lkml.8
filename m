Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05117C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5CB216FD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDWHtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgDWHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA70C08ED7D;
        Thu, 23 Apr 2020 00:49:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc3-0008Kn-78; Thu, 23 Apr 2020 09:49:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DDF5D1C0244;
        Thu, 23 Apr 2020 09:49:34 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add STT_NOTYPE noinstr validation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.465335884@infradead.org>
References: <20200416115119.465335884@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817443.28353.16866104738472527338.tip-bot2@tip-bot2>
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

Commit-ID:     932f8e987bfdcfc2365177978a30fdc0d6f6bd60
Gitweb:        https://git.kernel.org/tip/932f8e987bfdcfc2365177978a30fdc0d6f6bd60
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 23 Mar 2020 18:26:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:51 +02:00

objtool: Add STT_NOTYPE noinstr validation

Make sure to also check STT_NOTYPE symbols for noinstr violations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.465335884@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 46 +++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f49bf83..0d9f9cf 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -229,10 +229,18 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void clear_insn_state(struct insn_state *state)
+static void init_insn_state(struct insn_state *state, struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
+
+	/*
+	 * We need the full vmlinux for noinstr validation, otherwise we can
+	 * not correctly determine insn->call_dest->sec (external symbols do
+	 * not have a section).
+	 */
+	if (vmlinux && sec)
+		state->noinstr = sec->noinstr;
 }
 
 /*
@@ -2354,24 +2362,34 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	return 0;
 }
 
-static int validate_unwind_hints(struct objtool_file *file)
+static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 {
 	struct instruction *insn;
-	int ret, warnings = 0;
 	struct insn_state state;
+	int ret, warnings = 0;
 
 	if (!file->hints)
 		return 0;
 
-	clear_insn_state(&state);
+	init_insn_state(&state, sec);
 
-	for_each_insn(file, insn) {
+	if (sec) {
+		insn = find_insn(file, sec, 0);
+		if (!insn)
+			return 0;
+	} else {
+		insn = list_first_entry(&file->insn_list, typeof(*insn), list);
+	}
+
+	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
 		}
+
+		insn = list_next_entry(insn, list);
 	}
 
 	return warnings;
@@ -2518,19 +2536,11 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	struct symbol *func;
 	int warnings = 0;
 
-	/*
-	 * We need the full vmlinux for noinstr validation, otherwise we can
-	 * not correctly determine insn->call_dest->sec (external symbols do
-	 * not have a section).
-	 */
-	if (vmlinux)
-		state.noinstr = sec->noinstr;
-
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
 
-		clear_insn_state(&state);
+		init_insn_state(&state, sec);
 		state.cfi.cfa = initial_func_cfi.cfa;
 		memcpy(&state.cfi.regs, &initial_func_cfi.regs,
 		       CFI_NUM_REGS * sizeof(struct cfi_reg));
@@ -2545,12 +2555,16 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 static int validate_vmlinux_functions(struct objtool_file *file)
 {
 	struct section *sec;
+	int warnings = 0;
 
 	sec = find_section_by_name(file->elf, ".noinstr.text");
 	if (!sec)
 		return 0;
 
-	return validate_section(file, sec);
+	warnings += validate_section(file, sec);
+	warnings += validate_unwind_hints(file, sec);
+
+	return warnings;
 }
 
 static int validate_functions(struct objtool_file *file)
@@ -2635,7 +2649,7 @@ int check(const char *_objname, bool orc)
 		goto out;
 	warnings += ret;
 
-	ret = validate_unwind_hints(&file);
+	ret = validate_unwind_hints(&file, NULL);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
