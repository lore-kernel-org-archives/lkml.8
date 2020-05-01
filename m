Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599CCC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F62B2495E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgEASXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730660AbgEASW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D517C08E934;
        Fri,  1 May 2020 11:22:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIn-0003fD-VN; Fri, 01 May 2020 20:22:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 527781C04CD;
        Fri,  1 May 2020 20:22:21 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:21 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make handle_insn_ops() unconditional
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191659.795115188@infradead.org>
References: <20200428191659.795115188@infradead.org>
MIME-Version: 1.0
Message-ID: <158835734130.8414.1839500420306776239.tip-bot2@tip-bot2>
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

Commit-ID:     60041bcd8f5ab560dabf44dc384f58bbeb5a6a30
Gitweb:        https://git.kernel.org/tip/60041bcd8f5ab560dabf44dc384f58bbeb5a6a30
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 24 Apr 2020 16:16:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:32 +02:00

objtool: Make handle_insn_ops() unconditional

Now that every instruction has a list of stack_ops; we can trivially
distinquish those instructions that do not have stack_ops, their list
is empty.

This means we can now call handle_insn_ops() unconditionally.

Suggested-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191659.795115188@infradead.org
---
 tools/objtool/check.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 068897d..6591c2d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2259,6 +2259,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 		}
 
+		if (handle_insn_ops(insn, &state))
+			return 1;
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
@@ -2318,9 +2321,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_EXCEPTION_RETURN:
-			if (handle_insn_ops(insn, &state))
-				return 1;
-
 			/*
 			 * This handles x86's sync_core() case, where we use an
 			 * IRET to self. All 'normal' IRET instructions are in
@@ -2340,8 +2340,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STACK:
-			if (handle_insn_ops(insn, &state))
-				return 1;
 			break;
 
 		case INSN_STAC:
