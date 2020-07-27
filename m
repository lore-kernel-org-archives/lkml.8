Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E0C43446
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F092173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892263;
	bh=k9WgX49UhER9eYl15sr7XTWMTSzUTaFe3tk7B9RNLmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MS4qefQl2paQYelAcJTfldO4GOAZydsavRLu66EddWf/9EVri6Dj6YaKF7aX1u5Sd
	 8gaAbUSu5Bfnau9MVFDLOGeE6UOFyKMYjQCh06e77SM9l5m2Adi1OCDsJGW3YViH4t
	 bCNcL7ADF8+ImgQOWL3kHZtqJKQq3Q2/U/Jrad64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgG0XYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgG0XYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3867D21883;
        Mon, 27 Jul 2020 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892251;
        bh=k9WgX49UhER9eYl15sr7XTWMTSzUTaFe3tk7B9RNLmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVoC36gWoyUVaYlGlu9SYw3GfgoS0fGGziugZ68YoqV66eGEEzdFZsgCVjIC0qejB
         p/TgvgxQX2B0xb1KODFw600ziFPDS1I9tK2pg3RBfrlFs6AnFk3ZBwlkvB9fm/1sXX
         bJMjska1JzVw6nSmwVH5elveDufR4ktI01/PhaXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 19/25] x86/stacktrace: Fix reliable check for empty user task stacks
Date:   Mon, 27 Jul 2020 19:23:39 -0400
Message-Id: <20200727232345.717432-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232345.717432-1-sashal@kernel.org>
References: <20200727232345.717432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 039a7a30ec102ec866d382a66f87f6f7654f8140 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/stacktrace.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 6ad43fc44556e..2fd698e28e4d5 100644
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
 
-- 
2.25.1

