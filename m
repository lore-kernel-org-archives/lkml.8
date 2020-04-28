Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B069AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9142120730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD1Vsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:48:33 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45678 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1Vsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:48:32 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTY5f-0000df-CT; Tue, 28 Apr 2020 15:48:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTY5e-0001mX-HZ; Tue, 28 Apr 2020 15:48:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <20200428180540.GB29960@redhat.com>
        <87mu6v70in.fsf_-_@x220.int.ebiederm.org>
Date:   Tue, 28 Apr 2020 16:45:16 -0500
In-Reply-To: <87mu6v70in.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 16:39:44 -0500")
Message-ID: <87ftcn709f.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTY5e-0001mX-HZ;;;mid=<87ftcn709f.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YRFQ4RI9aGkdk8fxRwEOjHQ36OWDX+Bg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v1 1/4] posix-cpu-timer: Tidy up group_leader logic in lookup_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Replace has_group_leader_pid with thread_group_leader.  Years ago Oleg
suggested changing thread_group_leader to has_group_leader_pid to handle
races.  Looking at the code then and now I don't see how it ever helped.
Especially as then the code really did need to be the
thread_group_leader.

Today it doesn't make a difference if thread_group_leader races with
de_thread as the task returned from lookup_task in the non-thread case
is just used to find values in task->signal.

Since the races with de_thread have never been handled revert
has_group_header_pid to thread_group_leader for clarity.

Update the comment in lookup_task to remove implementation details that
are no longer true and to mention task->signal instead of task->sighand,
as the relevant cpu timer details are all in task->signal.

Ref: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Ref: c0deae8c9587 ("posix-cpu-timers: Rcu_read_lock/unlock protect find_task_by_vpid call")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2fd3b3fa68bf..e4051e417bcb 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -69,12 +69,8 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
 	if (gettime) {
 		/*
 		 * For clock_gettime(PROCESS) the task does not need to be
-		 * the actual group leader. tsk->sighand gives
+		 * the actual group leader. task->signal gives
 		 * access to the group's clock.
-		 *
-		 * Timers need the group leader because they take a
-		 * reference on it and store the task pointer until the
-		 * timer is destroyed.
 		 */
 		return (p == current || thread_group_leader(p)) ? p : NULL;
 	}
@@ -82,7 +78,7 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
 	/*
 	 * For processes require that p is group leader.
 	 */
-	return has_group_leader_pid(p) ? p : NULL;
+	return thread_group_leader(p) ? p : NULL;
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,
-- 
2.20.1

