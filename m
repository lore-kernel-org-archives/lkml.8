Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71373C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D58324968
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgEASXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730700AbgEASWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E41C061A0C;
        Fri,  1 May 2020 11:22:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIq-0003fz-CD; Fri, 01 May 2020 20:22:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D85E1C04DD;
        Fri,  1 May 2020 20:22:22 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:22 -0000
From:   "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: UNWIND_HINT_RET_OFFSET should not check
 registers
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200407073142.20659-3-alexandre.chartre@oracle.com>
References: <20200407073142.20659-3-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Message-ID: <158835734207.8414.4101263536708269303.tip-bot2@tip-bot2>
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

Commit-ID:     c721b3f80faebc7891211fa82de303eebadfed15
Gitweb:        https://git.kernel.org/tip/c721b3f80faebc7891211fa82de303eebadfed15
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Tue, 07 Apr 2020 09:31:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:32 +02:00

objtool: UNWIND_HINT_RET_OFFSET should not check registers

UNWIND_HINT_RET_OFFSET will adjust a modified stack. However if a
callee-saved register was pushed on the stack then the stack frame
will still appear modified. So stop checking registers when
UNWIND_HINT_RET_OFFSET is used.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200407073142.20659-3-alexandre.chartre@oracle.com
---
 tools/objtool/check.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8af8de2..068897d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1507,6 +1507,14 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
+	/*
+	 * If there is a ret offset hint then don't check registers
+	 * because a callee-saved register might have been pushed on
+	 * the stack.
+	 */
+	if (ret_offset)
+		return false;
+
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)
