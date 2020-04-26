Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF3C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A415D2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgDZGsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgDZGsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:48:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99BBC061A0C;
        Sat, 25 Apr 2020 23:48:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSb4n-0008R0-7t; Sun, 26 Apr 2020 08:47:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D9FF11C0178;
        Sun, 26 Apr 2020 08:47:40 +0200 (CEST)
Date:   Sun, 26 Apr 2020 06:47:40 -0000
From:   "tip-bot2 for Miroslav Benes" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Don't skip the first frame for
 inactive tasks
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <7f08db872ab59e807016910acdbe82f744de7065.1587808742.git.jpoimboe@redhat.com>
References: <7f08db872ab59e807016910acdbe82f744de7065.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788366047.28353.10640952841762796164.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f1d9a2abff66aa8156fbc1493abed468db63ea48
Gitweb:        https://git.kernel.org/tip/f1d9a2abff66aa8156fbc1493abed468db63ea48
Author:        Miroslav Benes <mbenes@suse.cz>
AuthorDate:    Sat, 25 Apr 2020 05:03:07 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Apr 2020 12:22:29 +02:00

x86/unwind/orc: Don't skip the first frame for inactive tasks

When unwinding an inactive task, the ORC unwinder skips the first frame
by default.  If both the 'regs' and 'first_frame' parameters of
unwind_start() are NULL, 'state->sp' and 'first_frame' are later
initialized to the same value for an inactive task.  Given there is a
"less than or equal to" comparison used at the end of __unwind_start()
for skipping stack frames, the first frame is skipped.

Drop the equal part of the comparison and make the behavior equivalent
to the frame pointer unwinder.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/7f08db872ab59e807016910acdbe82f744de7065.1587808742.git.jpoimboe@redhat.com
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 45166fd..e9f5a20 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -657,7 +657,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 	/* Otherwise, skip ahead to the user-specified starting frame: */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp <= (unsigned long)first_frame))
+			state->sp < (unsigned long)first_frame))
 		unwind_next_frame(state);
 
 	return;
