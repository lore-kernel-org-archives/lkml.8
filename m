Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25474C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108721741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbgCDI52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:57:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:57:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9PqH-0007Aw-5o; Wed, 04 Mar 2020 09:57:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57EE11C20C4;
        Wed,  4 Mar 2020 09:57:24 +0100 (CET)
Date:   Wed, 04 Mar 2020 08:57:23 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Stop disabling timers on mt-exec
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87o8tityzs.fsf@x220.int.ebiederm.org>
References: <87o8tityzs.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <158331224395.28353.17725920486129300292.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b95e31c07c5eb4f5c0769f12b38b0343d7961040
Gitweb:        https://git.kernel.org/tip/b95e31c07c5eb4f5c0769f12b38b0343d7961040
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Fri, 28 Feb 2020 11:15:03 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Mar 2020 09:54:55 +01:00

posix-cpu-timers: Stop disabling timers on mt-exec

The reasons why the extra posix_cpu_timers_exit_group() invocation has been
added are not entirely clear from the commit message.  Today all that
posix_cpu_timers_exit_group() does is stop timers that are tracking the
task from firing.  Every other operation on those timers is still allowed.

The practical implication of this is posix_cpu_timer_del() which could
not get the siglock after the thread group leader has exited (because
sighand == NULL) would be able to run successfully because the timer
was already dequeued.

With that locking issue fixed there is no point in disabling all of the
timers.  So remove this ``tempoary'' hack.

Fixes: e0a70217107e ("posix-cpu-timers: workaround to suppress the problems with mt exec")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87o8tityzs.fsf@x220.int.ebiederm.org


---
 kernel/exit.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 2833ffb..df54631 100644
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
