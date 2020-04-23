Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4882C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C3121707
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDWHuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgDWHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:50:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C4C03C1AB;
        Thu, 23 Apr 2020 00:50:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcL-0008Ue-UQ; Thu, 23 Apr 2020 09:49:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1DC7A1C0493;
        Thu, 23 Apr 2020 09:49:47 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:46 -0000
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove redundant checks on operand type
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158762818659.28353.1639663236117098330.tip-bot2@tip-bot2>
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

Commit-ID:     a70266b5b2e1c4262566a52f2ef16bdcde90f99b
Gitweb:        https://git.kernel.org/tip/a70266b5b2e1c4262566a52f2ef16bdcde90f99b
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 27 Mar 2020 15:28:39 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:49 +02:00

objtool: Remove redundant checks on operand type

POP operations are already in the code path where the destination
operand is OP_DEST_REG. There is no need to check the operand type
again.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b170fd..c18eca1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1715,15 +1715,13 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
-			if (!state->drap && op->dest.type == OP_DEST_REG &&
-			    op->dest.reg == cfa->base) {
+			if (!state->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
 				cfa->base = CFI_SP;
 			}
 
 			if (state->drap && cfa->base == CFI_BP_INDIRECT &&
-			    op->dest.type == OP_DEST_REG &&
 			    op->dest.reg == state->drap_reg &&
 			    state->drap_offset == -state->stack_size) {
 
