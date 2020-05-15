Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0130CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90FF207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEORXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726715AbgEORXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:23:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A7C061A0C;
        Fri, 15 May 2020 10:23:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZe2v-0005Tj-RU; Fri, 15 May 2020 19:22:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 73D2A1C007F;
        Fri, 15 May 2020 19:22:53 +0200 (CEST)
Date:   Fri, 15 May 2020 17:22:53 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allow no-op CFI ops in alternatives
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158956337331.17951.10214359711364574854.tip-bot2@tip-bot2>
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

Commit-ID:     ab3852ab5cb8fd2e2c5bfa176e5f953353836907
Gitweb:        https://git.kernel.org/tip/ab3852ab5cb8fd2e2c5bfa176e5f953353836907
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 08 May 2020 12:34:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 May 2020 10:35:12 +02:00

objtool: Allow no-op CFI ops in alternatives

Randy reported a false-positive:

  arch/x86/hyperv/hv_apic.o: warning: objtool: hv_apic_write()+0x25: alternative modifies stack

What happens is that:

	alternative_io("movl %0, %P1", "xchgl %0, %P1", X86_BUG_11AP,
 13d:   89 9d 00 d0 7f ff       mov    %ebx,-0x803000(%rbp)

decodes to an instruction with CFI-ops because it modifies RBP.
However, due to this being a !frame-pointer build, that should not in
fact change the CFI state.

So instead of dis-allowing any CFI-op, verify the op would've actually
changed the CFI state.

Fixes: 7117f16bf460 ("objtool: Fix ORC vs alternatives")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/objtool/check.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 32dea5f..196a551 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2060,17 +2060,18 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 	struct stack_op *op;
 
 	list_for_each_entry(op, &insn->stack_ops, list) {
+		struct cfi_state old_cfi = state->cfi;
 		int res;
 
-		if (insn->alt_group) {
-			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
-			return -1;
-		}
-
 		res = update_cfi_state(insn, &state->cfi, op);
 		if (res)
 			return res;
 
+		if (insn->alt_group && memcmp(&state->cfi, &old_cfi, sizeof(struct cfi_state))) {
+			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
+			return -1;
+		}
+
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
 				state->uaccess_stack = 1;
