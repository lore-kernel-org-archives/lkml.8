Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2272F2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgFOWb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFOWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:31:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F1C08C5C3;
        Mon, 15 Jun 2020 15:31:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkxdo-0006xW-0X; Tue, 16 Jun 2020 00:31:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 72D761C0475;
        Tue, 16 Jun 2020 00:31:43 +0200 (CEST)
Date:   Mon, 15 Jun 2020 22:31:43 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159226030305.16989.1552244615151602334.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     6b643a07a7e41f9e11cfbb9bba4c5c9791ac2997
Gitweb:        https://git.kernel.org/tip/6b643a07a7e41f9e11cfbb9bba4c5c9791ac2997
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 20:09:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:09 +02:00

x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()

The UBSAN instrumentation only inserts external CALLs when things go
'BAD', much like WARN(). So treat them similar to WARN()s for noinstr,
that is: allow them, at the risk of taking the machine down, to get
their message out.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h |  2 +-
 tools/objtool/check.c          | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 85b8d23..14513e8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -199,7 +199,7 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_sanitize_undefined
+	__no_kcsan __no_sanitize_address
 
 #endif /* __KERNEL__ */
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5fbb90a..3e214f8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2190,10 +2190,36 @@ static inline const char *call_dest_name(struct instruction *insn)
 	return "{dynamic}";
 }
 
+static inline bool noinstr_call_dest(struct symbol *func)
+{
+	/*
+	 * We can't deal with indirect function calls at present;
+	 * assume they're instrumented.
+	 */
+	if (!func)
+		return false;
+
+	/*
+	 * If the symbol is from a noinstr section; we good.
+	 */
+	if (func->sec->noinstr)
+		return true;
+
+	/*
+	 * The __ubsan_handle_*() calls are like WARN(), they only happen when
+	 * something 'BAD' happened. At the risk of taking the machine down,
+	 * let them proceed to get the message out.
+	 */
+	if (!strncmp(func->name, "__ubsan_handle_", 15))
+		return true;
+
+	return false;
+}
+
 static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    (!insn->call_dest || !insn->call_dest->sec->noinstr)) {
+	    !noinstr_call_dest(insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
