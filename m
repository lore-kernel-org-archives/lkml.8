Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3050C2158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582880;
	bh=gRvA4RA6qMcH6wSnGVRJgIELsFKdf6nOsc4b+itrtws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIhL2v7ytDP5SSstUrPDDLnY1kDUauUdIX7bPu7fQg8c5rnH3V18N6Lx69iGARIFD
	 kFkakx0ou6yFhC8RlNx2UUASZEDBMRCogHtQjw8OGALbT42kbuJlIG0iwapTqOHWL9
	 G64MNcohrO6Rar4Y+xUvWNG7snKvOneQQYgtLwI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405480AbgFSQH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391715AbgFSPIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:08:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D64820776;
        Fri, 19 Jun 2020 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579295;
        bh=gRvA4RA6qMcH6wSnGVRJgIELsFKdf6nOsc4b+itrtws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIbL3xkRbOZeqUbKyVeBgCRWhjnzfG8hbrFigHJkE1+BwrRJh+qfT8vFitBKlRItE
         GQ6KM8cj5ZjmBQ+2iCk+pKxs8Yp+A1djGd7fbE4wq6Z/e7NGU274df+BxO1t74f5Gk
         E58IFjqmClX+TKyU79UshJIJMBRK3k4ik6Y2zvOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/261] exit: Move preemption fixup up, move blocking operations down
Date:   Fri, 19 Jun 2020 16:31:32 +0200
Message-Id: <20200619141653.776524383@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 586b58cac8b4683eb58a1446fbc399de18974e40 ]

With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
non-preemptible context look untidy; after the main oops, the kernel prints
a "sleeping function called from invalid context" report because
exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
fixup.

It looks like the same thing applies to profile_task_exit() and
kcov_task_exit().

Fix it by moving the preemption fixup up and the calls to
profile_task_exit() and kcov_task_exit() down.

Fixes: 1dc0fffc48af ("sched/core: Robustify preemption leak checks")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200305220657.46800-1-jannh@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 22dfaac9e48c..fa46977b9c07 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -713,8 +713,12 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
-	profile_task_exit(tsk);
-	kcov_task_exit(tsk);
+	/*
+	 * We can get here from a kernel oops, sometimes with preemption off.
+	 * Start by checking for critical errors.
+	 * Then fix up important state like USER_DS and preemption.
+	 * Then do everything else.
+	 */
 
 	WARN_ON(blk_needs_flush_plug(tsk));
 
@@ -732,6 +736,16 @@ void __noreturn do_exit(long code)
 	 */
 	set_fs(USER_DS);
 
+	if (unlikely(in_atomic())) {
+		pr_info("note: %s[%d] exited with preempt_count %d\n",
+			current->comm, task_pid_nr(current),
+			preempt_count());
+		preempt_count_set(PREEMPT_ENABLED);
+	}
+
+	profile_task_exit(tsk);
+	kcov_task_exit(tsk);
+
 	ptrace_event(PTRACE_EVENT_EXIT, code);
 
 	validate_creds_for_do_exit(tsk);
@@ -749,13 +763,6 @@ void __noreturn do_exit(long code)
 
 	exit_signals(tsk);  /* sets PF_EXITING */
 
-	if (unlikely(in_atomic())) {
-		pr_info("note: %s[%d] exited with preempt_count %d\n",
-			current->comm, task_pid_nr(current),
-			preempt_count());
-		preempt_count_set(PREEMPT_ENABLED);
-	}
-
 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
 		sync_mm_rss(tsk->mm);
-- 
2.25.1



