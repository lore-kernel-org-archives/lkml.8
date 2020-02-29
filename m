Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B71FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A3921D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgB2Utz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:49:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgB2Utz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:49:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j893Z-0004jA-5V; Sat, 29 Feb 2020 21:49:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE3831C21A3;
        Sat, 29 Feb 2020 21:49:52 +0100 (CET)
Date:   Sat, 29 Feb 2020 20:49:52 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: cpu_clock_sample_group() no
 longer needs siglock
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158300939258.28353.113131585377048578.tip-bot2@tip-bot2>
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

Commit-ID:     6d022b20c011a75df24d2be90d22769d1d4461d0
Gitweb:        https://git.kernel.org/tip/6d022b20c011a75df24d2be90d22769d1d4461d0
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Fri, 28 Feb 2020 11:08:45 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 29 Feb 2020 21:44:45 +01:00

posix-cpu-timers: cpu_clock_sample_group() no longer needs siglock

As of e78c3496790e ("time, signal: Protect resource use statistics with
seqlock") cpu_clock_sample_group() no longer needs siglock protection so
remove the stale comment.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/posix-cpu-timers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 8ff6da7..46cc188 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -336,9 +336,7 @@ static void __thread_group_cputime(struct task_struct *tsk, u64 *samples)
 /*
  * Sample a process (thread group) clock for the given task clkid. If the
  * group's cputime accounting is already enabled, read the atomic
- * store. Otherwise a full update is required.  Task's sighand lock must be
- * held to protect the task traversal on a full update. clkid is already
- * validated.
+ * store. Otherwise a full update is required.  clkid is already validated.
  */
 static u64 cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
 				  bool start)
