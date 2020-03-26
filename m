Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0490C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC06B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCZKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRA-00045R-OJ; Thu, 26 Mar 2020 11:08:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3FAFD1C0440;
        Thu, 26 Mar 2020 11:08:32 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:31 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Re-arrange validate_functions()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.924304616@infradead.org>
References: <20200324160924.924304616@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731184.28353.5517081652261174451.tip-bot2@tip-bot2>
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

Commit-ID:     350994bf95414d6da67a72f27d7ac3832ce3725d
Gitweb:        https://git.kernel.org/tip/350994bf95414d6da67a72f27d7ac3832ce3725d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 23 Mar 2020 20:57:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:31 +01:00

objtool: Re-arrange validate_functions()

In preparation to adding a vmlinux.o specific pass, rearrange some
code. No functional changes intended.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.924304616@infradead.org
---
 tools/objtool/check.c | 52 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0c9c9ad..0bfcb39 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2395,9 +2395,8 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	return false;
 }
 
-static int validate_functions(struct objtool_file *file)
+static int validate_section(struct objtool_file *file, struct section *sec)
 {
-	struct section *sec;
 	struct symbol *func;
 	struct instruction *insn;
 	struct insn_state state;
@@ -2410,36 +2409,45 @@ static int validate_functions(struct objtool_file *file)
 	       CFI_NUM_REGS * sizeof(struct cfi_reg));
 	state.stack_size = initial_func_cfi.cfa.offset;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
+	list_for_each_entry(func, &sec->symbol_list, list) {
+		if (func->type != STT_FUNC)
+			continue;
 
-			if (!func->len) {
-				WARN("%s() is missing an ELF size annotation",
-				     func->name);
-				warnings++;
-			}
+		if (!func->len) {
+			WARN("%s() is missing an ELF size annotation",
+			     func->name);
+			warnings++;
+		}
 
-			if (func->pfunc != func || func->alias != func)
-				continue;
+		if (func->pfunc != func || func->alias != func)
+			continue;
 
-			insn = find_insn(file, sec, func->offset);
-			if (!insn || insn->ignore || insn->visited)
-				continue;
+		insn = find_insn(file, sec, func->offset);
+		if (!insn || insn->ignore || insn->visited)
+			continue;
 
-			state.uaccess = func->uaccess_safe;
+		state.uaccess = func->uaccess_safe;
 
-			ret = validate_branch(file, func, insn, state);
-			if (ret && backtrace)
-				BT_FUNC("<=== (func)", insn);
-			warnings += ret;
-		}
+		ret = validate_branch(file, func, insn, state);
+		if (ret && backtrace)
+			BT_FUNC("<=== (func)", insn);
+		warnings += ret;
 	}
 
 	return warnings;
 }
 
+static int validate_functions(struct objtool_file *file)
+{
+	struct section *sec;
+	int warnings = 0;
+
+	for_each_sec(file, sec)
+		warnings += validate_section(file, sec);
+
+	return warnings;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
