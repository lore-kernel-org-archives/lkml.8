Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD70E246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgB1RRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:17:10 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38402 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:17:10 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jG8-0005zl-St; Fri, 28 Feb 2020 10:17:09 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jG7-00085e-NR; Fri, 28 Feb 2020 10:17:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <87k146vdw3.fsf@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 11:15:03 -0600
In-Reply-To: <87k146vdw3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 11:07:56 -0600")
Message-ID: <87o8tityzs.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7jG7-00085e-NR;;;mid=<87o8tityzs.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/6Mp/s2UzF6BGRfn5dOIV57tKb1lFp07s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 5/5] posix-cpu-timers: Stop disabling timers on mt-exec
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The reasons Oleg added the extra posix_cpu_timers_exit_group are not
entirely clear from his commit message.  Today all that
posix_cpu_timers_exit_group does is stop timers that are tracking the
task from firing.  Every other operation on those timers is still
allowed.

The practical implication of this is posix_cpu_timer_del which could
not get the siglock after the thread group leader has exited (because
sighand == NULL) would be able to run successfully because the timer
was already dequeued.

With that locking issue fixed there is no point in disabling all
of the timers.  So remove Oleg's ``tempoary'' hack.

Fixes: e0a70217107e ("posix-cpu-timers: workaround to suppress the problems with mt exec")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 502b4995b688..c7f32101c2c8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -103,17 +103,8 @@ static void __exit_signal(struct task_struct *tsk)
 
 #ifdef CONFIG_POSIX_TIMERS
 	posix_cpu_timers_exit(tsk);
-	if (group_dead) {
+	if (group_dead)
 		posix_cpu_timers_exit_group(tsk);
-	} else {
-		/*
-		 * This can only happen if the caller is de_thread().
-		 * FIXME: this is the temporary hack, we should teach
-		 * posix-cpu-timers to handle this case correctly.
-		 */
-		if (unlikely(has_group_leader_pid(tsk)))
-			posix_cpu_timers_exit_group(tsk);
-	}
 #endif
 
 	if (group_dead) {
-- 
2.25.0

