Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60F8C2D0F9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7302920786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892557;
	bh=6A+UnJffvNtJviVbexL14aZ+ErblWEm8XBAuF4tWmpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njvX3l13/jJUuKHFh8wv3qFXkplUuayUPxeHOxqWpP0N5wytk53UExozXWrLbn8yt
	 F3rF55HfBPvDm+BWjqQehT5lmPoQxsyYO2orH/kNrUUSH9UvrhRWKkhgXrHQtxxKut
	 ypKydimB2voaW3cdI8USG2jP88ooeSRe29llLURw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgG0X3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgG0XYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113732173E;
        Mon, 27 Jul 2020 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892250;
        bh=6A+UnJffvNtJviVbexL14aZ+ErblWEm8XBAuF4tWmpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtiZMc3RcbX0tb0he86RNNwAHrjfP5f+VC1J9sZkRo/OLwPq0F5nCxYlrkvHT4u/h
         4m0Ll40z9ORVxFUv6/E+JyzWztO9d3NrryzvqryYGtdon57Yf8wA/UcAd92pAWPLki
         M/IP196EGk/9MZs1gnUwLZtei7x15yw6eXpG4Pzc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 18/25] x86/unwind/orc: Fix ORC for newly forked tasks
Date:   Mon, 27 Jul 2020 19:23:38 -0400
Message-Id: <20200727232345.717432-18-sashal@kernel.org>
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
index 7f969b2d240fd..ec88bbe08a328 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -440,8 +440,11 @@ bool unwind_next_frame(struct unwind_state *state)
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
 	if (!orc) {
@@ -662,6 +665,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp;
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
+		state->signal = (void *)state->ip == ret_from_fork;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
-- 
2.25.1

