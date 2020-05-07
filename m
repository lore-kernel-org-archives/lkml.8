Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E613D206B9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEGP2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:28:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A92C05BD43;
        Thu,  7 May 2020 08:28:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWiRs-00057R-3f; Thu, 07 May 2020 17:28:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABB061C001A;
        Thu,  7 May 2020 17:28:31 +0200 (CEST)
Date:   Thu, 07 May 2020 15:28:31 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix infinite loop in find_jump_table()
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <378b51c9d9c894dc3294bc460b4b0869e950b7c5.1588110291.git.jpoimboe@redhat.com>
References: <378b51c9d9c894dc3294bc460b4b0869e950b7c5.1588110291.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158886531158.8414.1142535737378207630.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     1119d265bc20226c241e5540fc8a246d9e30b272
Gitweb:        https://git.kernel.org/tip/1119d265bc20226c241e5540fc8a246d9e30b272
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 28 Apr 2020 16:45:16 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 May 2020 17:22:31 +02:00

objtool: Fix infinite loop in find_jump_table()

Kristen found a hang in objtool when building with -ffunction-sections.

It was caused by evergreen_pcie_gen2_enable.cold() being laid out
immediately before evergreen_pcie_gen2_enable().  Since their "pfunc" is
always the same, find_jump_table() got into an infinite loop because it
didn't recognize the boundary between the two functions.

Fix that with a new prev_insn_same_sym() helper, which doesn't cross
subfunction boundaries.

Reported-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/378b51c9d9c894dc3294bc460b4b0869e950b7c5.1588110291.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b170fd..0e8f9a3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -72,6 +72,17 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
 
+static struct instruction *prev_insn_same_sym(struct objtool_file *file,
+					       struct instruction *insn)
+{
+	struct instruction *prev = list_prev_entry(insn, list);
+
+	if (&prev->list != &file->insn_list && prev->func == insn->func)
+		return prev;
+
+	return NULL;
+}
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn;							\
@@ -1050,8 +1061,8 @@ static struct rela *find_jump_table(struct objtool_file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list != &file->insn_list && insn->func && insn->func->pfunc == func;
-	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+	     insn && insn->func && insn->func->pfunc == func;
+	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
 			break;
