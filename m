Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFBC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110592070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgCZKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50232 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgCZKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRI-00049r-Tp; Thu, 26 Mar 2020 11:08:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A56E31C0494;
        Thu, 26 Mar 2020 11:08:39 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:39 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Introduce validate_return()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160923.963996225@infradead.org>
References: <20200324160923.963996225@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731933.28353.7307768837288463941.tip-bot2@tip-bot2>
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

Commit-ID:     a92e92d1a749e9bae9828f34f632d56ac2c6d2c3
Gitweb:        https://git.kernel.org/tip/a92e92d1a749e9bae9828f34f632d56ac2c6d2c3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Mar 2020 18:07:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:27 +01:00

objtool: Introduce validate_return()

Trivial 'cleanup' to save one indentation level and match
validate_call().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160923.963996225@infradead.org
---
 tools/objtool/check.c | 64 +++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6b6178e..da17b5a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1975,6 +1975,41 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 	return validate_call(insn, state);
 }
 
+static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
+{
+	if (state->uaccess && !func_uaccess_safe(func)) {
+		WARN_FUNC("return with UACCESS enabled",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (!state->uaccess && func_uaccess_safe(func)) {
+		WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (state->df) {
+		WARN_FUNC("return with DF set",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (func && has_modified_stack_frame(state)) {
+		WARN_FUNC("return with modified stack frame",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	if (state->bp_scratch) {
+		WARN("%s uses BP as a scratch register",
+		     func->name);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2090,34 +2125,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (state.uaccess && !func_uaccess_safe(func)) {
-				WARN_FUNC("return with UACCESS enabled", sec, insn->offset);
-				return 1;
-			}
-
-			if (!state.uaccess && func_uaccess_safe(func)) {
-				WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function", sec, insn->offset);
-				return 1;
-			}
-
-			if (state.df) {
-				WARN_FUNC("return with DF set", sec, insn->offset);
-				return 1;
-			}
-
-			if (func && has_modified_stack_frame(&state)) {
-				WARN_FUNC("return with modified stack frame",
-					  sec, insn->offset);
-				return 1;
-			}
-
-			if (state.bp_scratch) {
-				WARN("%s uses BP as a scratch register",
-				     func->name);
-				return 1;
-			}
-
-			return 0;
+			return validate_return(func, insn, &state);
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
