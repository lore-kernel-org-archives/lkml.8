Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA991C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A549020775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgCZKI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgCZKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRK-00049F-ME; Thu, 26 Mar 2020 11:08:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E0041C0440;
        Thu, 26 Mar 2020 11:08:39 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:38 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Rename func_for_each_insn()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.024341229@infradead.org>
References: <20200324160924.024341229@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731884.28353.2586659115330507007.tip-bot2@tip-bot2>
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

Commit-ID:     dbf4aeb0a494020644507459c2446e632cba1a05
Gitweb:        https://git.kernel.org/tip/dbf4aeb0a494020644507459c2446e632cba1a05
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Mar 2020 18:24:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:27 +01:00

objtool: Rename func_for_each_insn()

There is func_for_each_insn() and func_for_each_insn_all(), the both
iterate the instructions, but the first uses symbol offset/length
while the second uses insn->func.

Rename func_for_each_insn() to sym_for_eac_insn() because it iterates
on symbol information.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.024341229@infradead.org
---
 tools/objtool/check.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index da17b5a..564ea1d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -77,17 +77,17 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	     insn;							\
 	     insn = next_insn_same_func(file, insn))
 
-#define func_for_each_insn(file, func, insn)				\
-	for (insn = find_insn(file, func->sec, func->offset);		\
+#define sym_for_each_insn(file, sym, insn)				\
+	for (insn = find_insn(file, sym->sec, sym->offset);		\
 	     insn && &insn->list != &file->insn_list &&			\
-		insn->sec == func->sec &&				\
-		insn->offset < func->offset + func->len;		\
+		insn->sec == sym->sec &&				\
+		insn->offset < sym->offset + sym->len;			\
 	     insn = list_next_entry(insn, list))
 
-#define func_for_each_insn_continue_reverse(file, func, insn)		\
+#define sym_for_each_insn_continue_reverse(file, sym, insn)		\
 	for (insn = list_prev_entry(insn, list);			\
 	     &insn->list != &file->insn_list &&				\
-		insn->sec == func->sec && insn->offset >= func->offset;	\
+		insn->sec == sym->sec && insn->offset >= sym->offset;	\
 	     insn = list_prev_entry(insn, list))
 
 #define sec_for_each_insn_from(file, insn)				\
@@ -286,7 +286,7 @@ static int decode_instructions(struct objtool_file *file)
 				return -1;
 			}
 
-			func_for_each_insn(file, func, insn)
+			sym_for_each_insn(file, func, insn)
 				insn->func = func;
 		}
 	}
@@ -2064,7 +2064,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 				i = insn;
 				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
+				sym_for_each_insn_continue_reverse(file, func, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
