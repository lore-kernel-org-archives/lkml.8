Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FD8208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892395;
	bh=vj8lLFK0N7N8kisfDPLGzSJU8Jd3ttz7ITKOef7cXg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=It6CPTI1G3ls+1kFcUCkm4LedcGU4Wh9HYm3Fn/7G5BFI/K9ytD89I70PYWQJoyqW
	 gbjq1eTc+bQHmhlmzgBL06ju48gm181exakyBZos0Eq5/ogKaLJdCOXP5x8HNF0OqI
	 q1zaszI2I+lNGHj9sOrmwqj4bX8stk/dmVE9hW6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgG0XZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgG0XZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:25:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FACB22B40;
        Mon, 27 Jul 2020 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892310;
        bh=vj8lLFK0N7N8kisfDPLGzSJU8Jd3ttz7ITKOef7cXg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NN2wgVAiWit5sWu0HuD6ca7T0bSpflHFKIuUEeyFccU/ZBOxE0Ru0V2EfDW+MayIU
         5kS1HIfUhW5lIFlkBjCQpsm+jrUO64otD5gEJTe6+m1BKiH2P4QEx6gU9e/BVYcqNw
         BuE6MbpTpqRI+YARhD8Jk+jJt9/hWC51AIYq48r4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 08/10] x86/unwind/orc: Fix ORC for newly forked tasks
Date:   Mon, 27 Jul 2020 19:24:56 -0400
Message-Id: <20200727232458.718131-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232458.718131-1-sashal@kernel.org>
References: <20200727232458.718131-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 372a8eaa05998cd45b3417d0e0ffd3a70978211a ]

The ORC unwinder fails to unwind newly forked tasks which haven't yet
run on the CPU.  It correctly reads the 'ret_from_fork' instruction
pointer from the stack, but it incorrectly interprets that value as a
call stack address rather than a "signal" one, so the address gets
incorrectly decremented in the call to orc_find(), resulting in bad ORC
data.

Fix it by forcing 'ret_from_fork' frames to be signal frames.

Reported-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Link: https://lkml.kernel.org/r/f91a8778dde8aae7f71884b5df2b16d552040441.1594994374.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a9a55e76a43f9..a5e2ce931f692 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -346,8 +346,11 @@ bool unwind_next_frame(struct unwind_state *state)
 	/*
 	 * Find the orc_entry associated with the text address.
 	 *
-	 * Decrement call return addresses by one so they work for sibling
-	 * calls and calls to noreturn functions.
+	 * For a call frame (as opposed to a signal frame), state->ip points to
+	 * the instruction after the call.  That instruction's stack layout
+	 * could be different from the call instruction's layout, for example
+	 * if the call was to a noreturn function.  So get the ORC data for the
+	 * call instruction itself.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
 	if (!orc || orc->sp_reg == ORC_REG_UNDEFINED)
@@ -550,6 +553,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp;
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
+		state->signal = (void *)state->ip == ret_from_fork;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
-- 
2.25.1

