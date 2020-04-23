Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0968C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B967721707
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgDWHuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgDWHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B5C02A1A2;
        Thu, 23 Apr 2020 00:49:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcH-0008UT-Mt; Thu, 23 Apr 2020 09:49:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 83AB61C04D1;
        Thu, 23 Apr 2020 09:49:46 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:46 -0000
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Clean instruction state before each
 function validation
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158762818609.28353.2034599219939179134.tip-bot2@tip-bot2>
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

Commit-ID:     0699e551af268c9841a205a3e90dc1615fb63d84
Gitweb:        https://git.kernel.org/tip/0699e551af268c9841a205a3e90dc1615fb63d84
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 27 Mar 2020 15:28:40 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:49 +02:00

objtool: Clean instruction state before each function validation

When a function fails its validation, it might leave a stale state
that will be used for the validation of other functions. That would
cause false warnings on potentially valid functions.

Reset the instruction state before the validation of each individual
function.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c18eca1..5b67d61 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2411,13 +2411,6 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	struct insn_state state;
 	int ret, warnings = 0;
 
-	clear_insn_state(&state);
-
-	state.cfa = initial_func_cfi.cfa;
-	memcpy(&state.regs, &initial_func_cfi.regs,
-	       CFI_NUM_REGS * sizeof(struct cfi_reg));
-	state.stack_size = initial_func_cfi.cfa.offset;
-
 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
 			continue;
@@ -2435,6 +2428,12 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (!insn || insn->ignore || insn->visited)
 			continue;
 
+		clear_insn_state(&state);
+		state.cfa = initial_func_cfi.cfa;
+		memcpy(&state.regs, &initial_func_cfi.regs,
+		       CFI_NUM_REGS * sizeof(struct cfi_reg));
+		state.stack_size = initial_func_cfi.cfa.offset;
+
 		state.uaccess = func->uaccess_safe;
 
 		ret = validate_branch(file, func, insn, state);
