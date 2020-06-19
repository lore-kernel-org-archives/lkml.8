Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFC20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbgFSSg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:36:56 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33192 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbgFSSg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:36:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLsj-0003Gy-Jt; Fri, 19 Jun 2020 12:36:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLsf-0005ZZ-7p; Fri, 19 Jun 2020 12:36:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
Date:   Fri, 19 Jun 2020 13:32:30 -0500
In-Reply-To: <87pn9u6h8c.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 19 Jun 2020 13:30:27 -0500")
Message-ID: <87k1026h4x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmLsf-0005ZZ-7p;;;mid=<87k1026h4x.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX180/W4+QdDu1YmGu7uqp9HqSF67L0PvcJ4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Instead test SIGNAL_GROUP_COREDUMP in signal_group_exit().  This
results in clearer easier to understand logic.  This makes the code
easier to modify in the future as this leaves de_thread as the only
user of group_exit_task.

This is safe because there are only two places that set
SIGNAL_GROUP_COREDUMP.  In one place the code is setting
SIGNAL_GROUP_EXIT and SIGNAL_GROUP_COREDUMP together with the result
that signal_group_exit() will subsequently return true.  In the other
the location which is being changed SIGNAL_GROUP_COREDUMP is being set
along with signal_group_exit, which also causes subsequent calls of
signal_group_exit to return true.

Thus testing SIGNAL_GROUP_COREDUMP in signal_group_exit() results
in no change in behavior.

Only signal_group_exit tests group_exit_task so leaving as NULL
during a coredump and nothing uses the value of group_exit_task
that the coredump sets.  So not setting group_exit_task is
safe during a coredump.

I looked at the commit that introduced this behavior[1] and Oleg
describes that he was setting group_exit_task simply to cause
signal_group_exit to return true.  So no surprises come from the
history.

Cc: Oleg Nesterov <oleg@redhat.com>
[1] 6cd8f0acae34 ("coredump: ensure that SIGKILL always kills the dumping thread")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c                | 2 --
 include/linux/sched/signal.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7237f07ff6be..37b71c72ab3a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -369,7 +369,6 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!signal_group_exit(tsk->signal)) {
 		mm->core_state = core_state;
-		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code, 0);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 	}
@@ -481,7 +480,6 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 	spin_lock_irq(&current->sighand->siglock);
 	if (core_dumped && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |= 0x80;
-	current->signal->group_exit_task = NULL;
 	current->signal->flags = SIGNAL_GROUP_EXIT;
 	spin_unlock_irq(&current->sighand->siglock);
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0ee5e696c5d8..92c72f5db111 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -265,7 +265,7 @@ static inline void signal_set_stop_flags(struct signal_struct *sig,
 /* If true, all threads except ->group_exit_task have pending SIGKILL */
 static inline int signal_group_exit(const struct signal_struct *sig)
 {
-	return	(sig->flags & SIGNAL_GROUP_EXIT) ||
+	return	(sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
 		(sig->group_exit_task != NULL);
 }
 
-- 
2.20.1

