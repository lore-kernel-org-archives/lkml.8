Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B23C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E0421655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgDVWZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726852AbgDVWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A57C03C1A9;
        Wed, 22 Apr 2020 15:25:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnM-0001OL-T1; Thu, 23 Apr 2020 00:24:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BFC0B1C0178;
        Thu, 23 Apr 2020 00:24:37 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:37 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86,ftrace: Use SIZEOF_PTREGS
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.808485515@infradead.org>
References: <20200416115118.808485515@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427704.28353.4897473371874838717.tip-bot2@tip-bot2>
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

Commit-ID:     fecf897dd09bdba49cdbe69f3defaab0f5f688fb
Gitweb:        https://git.kernel.org/tip/fecf897dd09bdba49cdbe69f3defaab0f5f688fb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Apr 2020 16:50:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:06 +02:00

x86,ftrace: Use SIZEOF_PTREGS

There's a convenient macro for 'SS+8' called FRAME_SIZE. Use it to
clarify things.

(entry/calling.h calls this SIZEOF_PTREGS but we're using
asm/ptrace-abi.h)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.808485515@infradead.org
---
 arch/x86/kernel/ftrace_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 7657dc7..be9aff2 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -23,7 +23,7 @@
 #endif /* CONFIG_FRAME_POINTER */
 
 /* Size of stack used to save mcount regs in save_mcount_regs */
-#define MCOUNT_REG_SIZE		(SS+8 + MCOUNT_FRAME_SIZE)
+#define MCOUNT_REG_SIZE		(FRAME_SIZE + MCOUNT_FRAME_SIZE)
 
 /*
  * gcc -pg option adds a call to 'mcount' in most functions.
@@ -77,7 +77,7 @@
 	/*
 	 * We add enough stack to save all regs.
 	 */
-	subq $(MCOUNT_REG_SIZE - MCOUNT_FRAME_SIZE), %rsp
+	subq $(FRAME_SIZE), %rsp
 	movq %rax, RAX(%rsp)
 	movq %rcx, RCX(%rsp)
 	movq %rdx, RDX(%rsp)
