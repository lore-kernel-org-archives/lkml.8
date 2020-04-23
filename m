Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21EBC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F2621569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgDWHtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgDWHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F27BC03C1AB;
        Thu, 23 Apr 2020 00:49:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcC-0008O8-IM; Thu, 23 Apr 2020 09:49:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E30A1C0244;
        Thu, 23 Apr 2020 09:49:39 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:38 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rename struct cfi_state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.986441913@infradead.org>
References: <20200416115118.986441913@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817881.28353.11398874953240347113.tip-bot2@tip-bot2>
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

Commit-ID:     a3608f5954d07a40fb93764dc6d06195fa52eb14
Gitweb:        https://git.kernel.org/tip/a3608f5954d07a40fb93764dc6d06195fa52eb14
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 25 Mar 2020 15:34:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:50 +02:00

objtool: Rename struct cfi_state

There's going to be a new struct cfi_state, rename this one to make
place.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.986441913@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/arch.h            | 2 +-
 tools/objtool/arch/x86/decode.c | 2 +-
 tools/objtool/cfi.h             | 2 +-
 tools/objtool/check.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 55396df..561c316 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -70,7 +70,7 @@ struct stack_op {
 
 struct instruction;
 
-void arch_initial_func_cfi_state(struct cfi_state *state);
+void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3273638..f0d42ad 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -512,7 +512,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	return 0;
 }
 
-void arch_initial_func_cfi_state(struct cfi_state *state)
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
 {
 	int i;
 
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index 1a3e7b8..6faf976 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -18,7 +18,7 @@ struct cfi_reg {
 	int offset;
 };
 
-struct cfi_state {
+struct cfi_init_state {
 	struct cfi_reg cfa;
 	struct cfi_reg regs[CFI_NUM_REGS];
 };
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f10c..538b462 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -27,7 +27,7 @@ struct alternative {
 };
 
 const char *objname;
-struct cfi_state initial_func_cfi;
+struct cfi_init_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
