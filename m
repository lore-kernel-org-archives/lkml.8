Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52367C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A820658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0o6P5s5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ThnfCRmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgGVVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgGVVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:55:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79671C0619E1;
        Wed, 22 Jul 2020 14:55:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:55:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595454936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onB23TV72snXsM4Kk96d5u93DsT0lvJ0OrxNxUiy8sE=;
        b=p0o6P5s5BhdLlp7pKo4s6PmgWr+C9miZGU0gCo8LtmjeDMKEON1TUpaN/IcnRCjZLc22TD
        nfYe1D1ykPnGi2WFB9/J8a1BfqxGqQQhEUXIQJ4eOG8X5JNxHbNONJ8/ow/Vs0GzYelEZf
        p85qxdTPsDnLv5wsbHQ/15wKwyrUCHZ0idXQUKKiPcSbhxSuzFexCWo3GeJy9u6dMyGCdX
        4x5nQjubva1HfG20SziXeDB4kCgTf8kDWFr4rVAIAlrWzxek5o59WtBa3ICaPAmmJ6PSqb
        Ji2P+BzNucC43+MLBJyV5J9glJFyJ800lMP0QM6csi/fqRrejNeXoqYwDcpPmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595454936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onB23TV72snXsM4Kk96d5u93DsT0lvJ0OrxNxUiy8sE=;
        b=ThnfCRmojj4756uQOXu4tU+8xR4DYwcdu9i8JkV7KolVSHgqd7Tyrb/gh6K/8uYYw1tBK1
        GaPUy/amx7HMn2Ag==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/stacktrace: Fix reliable check for empty user
 task stacks
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f136a4e5f019219cbc4f4da33b30c2f44fa65b84.1594994374.git.jpoimboe@redhat.com>
References: <f136a4e5f019219cbc4f4da33b30c2f44fa65b84.1594994374.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <159545493605.4006.17560256116826409394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     039a7a30ec102ec866d382a66f87f6f7654f8140
Gitweb:        https://git.kernel.org/tip/039a7a30ec102ec866d382a66f87f6f7654f8140
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 17 Jul 2020 09:04:26 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 22 Jul 2020 23:47:47 +02:00

x86/stacktrace: Fix reliable check for empty user task stacks

If a user task's stack is empty, or if it only has user regs, ORC
reports it as a reliable empty stack.  But arch_stack_walk_reliable()
incorrectly treats it as unreliable.

That happens because the only success path for user tasks is inside the
loop, which only iterates on non-empty stacks.  Generally, a user task
must end in a user regs frame, but an empty stack is an exception to
that rule.

Thanks to commit 71c95825289f ("x86/unwind/orc: Fix error handling in
__unwind_start()"), unwind_start() now sets state->error appropriately.
So now for both ORC and FP unwinders, unwind_done() and !unwind_error()
always means the end of the stack was successfully reached.  So the
success path for kthreads is no longer needed -- it can also be used for
empty user tasks.

Reported-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Link: https://lkml.kernel.org/r/f136a4e5f019219cbc4f4da33b30c2f44fa65b84.1594994374.git.jpoimboe@redhat.com

---
 arch/x86/kernel/stacktrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 6ad43fc..2fd698e 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -58,7 +58,6 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			 * or a page fault), which can make frame pointers
 			 * unreliable.
 			 */
-
 			if (IS_ENABLED(CONFIG_FRAME_POINTER))
 				return -EINVAL;
 		}
@@ -81,10 +80,6 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 	if (unwind_error(&state))
 		return -EINVAL;
 
-	/* Success path for non-user tasks, i.e. kthreads and idle tasks */
-	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
-		return -EINVAL;
-
 	return 0;
 }
 
