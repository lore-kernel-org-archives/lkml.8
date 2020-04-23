Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D568BC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC1421569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgDWHvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgDWHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F791C08E934;
        Thu, 23 Apr 2020 00:49:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc3-0008LF-Nz; Thu, 23 Apr 2020 09:49:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C7061C0450;
        Thu, 23 Apr 2020 09:49:35 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rearrange validate_section()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.405863817@infradead.org>
References: <20200416115119.405863817@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817498.28353.15802303225309999349.tip-bot2@tip-bot2>
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

Commit-ID:     4b5e2e7ffef87ae864f3f4546ee5753556e7550b
Gitweb:        https://git.kernel.org/tip/4b5e2e7ffef87ae864f3f4546ee5753556e7550b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 23 Mar 2020 21:17:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:51 +02:00

objtool: Rearrange validate_section()

In preparation of further changes, once again break out the loop body.
No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.405863817@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 51 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e201aa1..f49bf83 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2486,12 +2486,37 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	return false;
 }
 
-static int validate_section(struct objtool_file *file, struct section *sec)
+static int validate_symbol(struct objtool_file *file, struct section *sec,
+			   struct symbol *sym, struct insn_state *state)
 {
-	struct symbol *func;
 	struct instruction *insn;
+	int ret;
+
+	if (!sym->len) {
+		WARN("%s() is missing an ELF size annotation", sym->name);
+		return 1;
+	}
+
+	if (sym->pfunc != sym || sym->alias != sym)
+		return 0;
+
+	insn = find_insn(file, sec, sym->offset);
+	if (!insn || insn->ignore || insn->visited)
+		return 0;
+
+	state->uaccess = sym->uaccess_safe;
+
+	ret = validate_branch(file, insn->func, insn, *state);
+	if (ret && backtrace)
+		BT_FUNC("<=== (sym)", insn);
+	return ret;
+}
+
+static int validate_section(struct objtool_file *file, struct section *sec)
+{
 	struct insn_state state;
-	int ret, warnings = 0;
+	struct symbol *func;
+	int warnings = 0;
 
 	/*
 	 * We need the full vmlinux for noinstr validation, otherwise we can
@@ -2505,31 +2530,13 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		if (!func->len) {
-			WARN("%s() is missing an ELF size annotation",
-			     func->name);
-			warnings++;
-		}
-
-		if (func->pfunc != func || func->alias != func)
-			continue;
-
-		insn = find_insn(file, sec, func->offset);
-		if (!insn || insn->ignore || insn->visited)
-			continue;
-
 		clear_insn_state(&state);
 		state.cfi.cfa = initial_func_cfi.cfa;
 		memcpy(&state.cfi.regs, &initial_func_cfi.regs,
 		       CFI_NUM_REGS * sizeof(struct cfi_reg));
 		state.cfi.stack_size = initial_func_cfi.cfa.offset;
 
-		state.uaccess = func->uaccess_safe;
-
-		ret = validate_branch(file, func, insn, state);
-		if (ret && backtrace)
-			BT_FUNC("<=== (func)", insn);
-		warnings += ret;
+		warnings += validate_symbol(file, sec, func, &state);
 	}
 
 	return warnings;
