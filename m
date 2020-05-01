Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD40C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D67216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgEASWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730714AbgEASWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C0C061A0E;
        Fri,  1 May 2020 11:22:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIs-0003hi-NI; Fri, 01 May 2020 20:22:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2EA591C081A;
        Fri,  1 May 2020 20:22:23 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:23 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix ORC vs alternatives
Cc:     Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191659.499074346@infradead.org>
References: <20200428191659.499074346@infradead.org>
MIME-Version: 1.0
Message-ID: <158835734305.8414.7228235752870624259.tip-bot2@tip-bot2>
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

Commit-ID:     7117f16bf460ef8cd132e6e80c989677397b4868
Gitweb:        https://git.kernel.org/tip/7117f16bf460ef8cd132e6e80c989677397b4868
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 28 Apr 2020 19:37:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:31 +02:00

objtool: Fix ORC vs alternatives

Jann reported that (for instance) entry_64.o:general_protection has
very odd ORC data:

  0000000000000f40 <general_protection>:
  #######sp:sp+8 bp:(und) type:iret end:0
    f40:       90                      nop
  #######sp:(und) bp:(und) type:call end:0
    f41:       90                      nop
    f42:       90                      nop
  #######sp:sp+8 bp:(und) type:iret end:0
    f43:       e8 a8 01 00 00          callq  10f0 <error_entry>
  #######sp:sp+0 bp:(und) type:regs end:0
    f48:       f6 84 24 88 00 00 00    testb  $0x3,0x88(%rsp)
    f4f:       03
    f50:       74 00                   je     f52 <general_protection+0x12>
    f52:       48 89 e7                mov    %rsp,%rdi
    f55:       48 8b 74 24 78          mov    0x78(%rsp),%rsi
    f5a:       48 c7 44 24 78 ff ff    movq   $0xffffffffffffffff,0x78(%rsp)
    f61:       ff ff
    f63:       e8 00 00 00 00          callq  f68 <general_protection+0x28>
    f68:       e9 73 02 00 00          jmpq   11e0 <error_exit>
  #######sp:(und) bp:(und) type:call end:0
    f6d:       0f 1f 00                nopl   (%rax)

Note the entry at 0xf41. Josh found this was the result of commit:

  764eef4b109a ("objtool: Rewrite alt->skip_orig")

Due to the early return in validate_branch() we no longer set
insn->cfi of the original instruction stream (the NOPs at 0xf41 and
0xf42) and we'll end up with the above weirdness.

In other discussions we realized alternatives should be ORC invariant;
that is, due to there being only a single ORC table, it must be valid
for all alternatives. The easiest way to ensure this is to not allow
any stack modifications in alternatives.

When we enforce this latter observation, we get the property that the
whole alternative must have the same CFI, which we can employ to fix
the former report.

Fixes: 764eef4b109a ("objtool: Rewrite alt->skip_orig")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191659.499074346@infradead.org
---
 tools/objtool/Documentation/stack-validation.txt |  7 +++-
 tools/objtool/check.c                            | 34 ++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index faa47c3..0189039 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -315,6 +315,13 @@ they mean, and suggestions for how to fix them.
       function tracing inserts additional calls, which is not obvious from the
       sources).
 
+10. file.o: warning: func()+0x5c: alternative modifies stack
+
+    This means that an alternative includes instructions that modify the
+    stack. The problem is that there is only one ORC unwind table, this means
+    that the ORC unwind entries must be valid for each of the alternatives.
+    The easiest way to enforce this is to ensure alternatives do not contain
+    any ORC entries, which in turn implies the above constraint.
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4da6bfb..fa9bf36 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1983,6 +1983,11 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 	list_for_each_entry(op, &insn->stack_ops, list) {
 		int res;
 
+		if (insn->alt_group) {
+			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
+			return -1;
+		}
+
 		res = update_cfi_state(insn, &state->cfi, op);
 		if (res)
 			return res;
@@ -2150,6 +2155,30 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 }
 
 /*
+ * Alternatives should not contain any ORC entries, this in turn means they
+ * should not contain any CFI ops, which implies all instructions should have
+ * the same same CFI state.
+ *
+ * It is possible to constuct alternatives that have unreachable holes that go
+ * unreported (because they're NOPs), such holes would result in CFI_UNDEFINED
+ * states which then results in ORC entries, which we just said we didn't want.
+ *
+ * Avoid them by copying the CFI entry of the first instruction into the whole
+ * alternative.
+ */
+static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
+{
+	struct instruction *first_insn = insn;
+	int alt_group = insn->alt_group;
+
+	sec_for_each_insn_continue(file, insn) {
+		if (insn->alt_group != alt_group)
+			break;
+		insn->cfi = first_insn->cfi;
+	}
+}
+
+/*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
  * each instruction and validate all the rules described in
@@ -2200,7 +2229,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		insn->visited |= visited;
 
-		if (!insn->ignore_alts) {
+		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
 			bool skip_orig = false;
 
 			list_for_each_entry(alt, &insn->alts, list) {
@@ -2215,6 +2244,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 			}
 
+			if (insn->alt_group)
+				fill_alternative_cfi(file, insn);
+
 			if (skip_orig)
 				return 0;
 		}
