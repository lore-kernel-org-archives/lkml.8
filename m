Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BCC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E2E21569
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ols3q+JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgD1TTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728363AbgD1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABFC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PyYYE9itb1rp7MicRL9GyWwwFcYn6XCAs8vRtAg1yJw=; b=Ols3q+JWS6cpZ/bUCYHlax+RSq
        zEiWQnRMvgQl0KicGBUq2ysn7WaPj3eU/Vhv7dDaVcRkMDJcThsUNgz9PunEUVKLQkLyLFxSJ+ZhA
        gIEn+LViJJTi8D08R8SN0rX6zSAKMk8+KaL4CiP/JI6pALPztGHetS15bhEBz2y9X7MsdUM9nOc2Z
        t5xdww7TpdkRMA9+/zTQNaPUlBx7M3F+sz/JYA+b7npQGhiZvqySXEmTx6pG7VFWYkJZ0npMehprK
        5HFECknAlG0epDKWjTA4QzdRIimw7Xhl0vrEYSqvppHMOORLqmqnQvOJl/Bgv2XNBFAWex7fslGGD
        8UfdmsEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlQ-0006Vh-65; Tue, 28 Apr 2020 19:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9AC83307601;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7BC1725D01310; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.499074346@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org, Jann Horn <jannh@google.com>
Subject: [PATCH v2 02/14] objtool: Fix ORC vs alternatives
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/Documentation/stack-validation.txt |    7 ++++
 tools/objtool/check.c                            |   34 ++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -315,6 +315,13 @@ they mean, and suggestions for how to fi
       function tracing inserts additional calls, which is not obvious from the
       sources).
 
+10. file.o: warning: func()+0x5c: alternative modifies stack
+
+    This means that an alternative includes instructions that modify the
+    stack. The problem is that there is only one ORC unwind table, this means
+    that the ORC unwind entries must be valid for each of the alternatives.
+    The easiest way to enforce this is to ensure alternative do not contain
+    any ORC entries, which in turn implies the above constraint.
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2001,6 +2001,11 @@ static int handle_insn_ops(struct instru
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
@@ -2177,6 +2182,30 @@ static bool is_branch_to_alternative(str
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
@@ -2234,7 +2263,7 @@ static int validate_branch(struct objtoo
 
 		insn->visited |= visited;
 
-		if (!insn->ignore_alts) {
+		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
 			bool skip_orig = false;
 
 			list_for_each_entry(alt, &insn->alts, list) {
@@ -2249,6 +2278,9 @@ static int validate_branch(struct objtoo
 				}
 			}
 
+			if (insn->alt_group)
+				fill_alternative_cfi(file, insn);
+
 			if (skip_orig)
 				return 0;
 		}


