Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5477C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D059822247
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDSN5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgDSN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:57:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78002C061A41
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:57:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQASB-0002ml-GC; Sun, 19 Apr 2020 15:57:47 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 11D5BFFBA2;
        Sun, 19 Apr 2020 15:57:47 +0200 (CEST)
Date:   Sun, 19 Apr 2020 13:56:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.7-rc2
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
Message-ID: <158730460342.31269.11473437311616524528.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-19

up to:  94d440d61846: proc, time/namespace: Show clock symbolic names in /proc/pid/timens_offsets


An update for the proc interface of time namespaces: Use symbolic names
instead of clockid numbers. The usability nuisance of numbers was noticed
by Michael when polishing the man page.

Thanks,

	tglx

------------------>
Andrei Vagin (1):
      proc, time/namespace: Show clock symbolic names in /proc/pid/timens_offsets


 fs/proc/base.c          | 14 +++++++++++++-
 kernel/time/namespace.c | 15 ++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6042b646ab27..572898dd16a0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1573,6 +1573,7 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
 	noffsets = 0;
 	for (pos = kbuf; pos; pos = next_line) {
 		struct proc_timens_offset *off = &offsets[noffsets];
+		char clock[10];
 		int err;
 
 		/* Find the end of line and ensure we don't look past it */
@@ -1584,10 +1585,21 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
 				next_line = NULL;
 		}
 
-		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+		err = sscanf(pos, "%9s %lld %lu", clock,
 				&off->val.tv_sec, &off->val.tv_nsec);
 		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
 			goto out;
+
+		clock[sizeof(clock) - 1] = 0;
+		if (strcmp(clock, "monotonic") == 0 ||
+		    strcmp(clock, __stringify(CLOCK_MONOTONIC)) == 0)
+			off->clockid = CLOCK_MONOTONIC;
+		else if (strcmp(clock, "boottime") == 0 ||
+			 strcmp(clock, __stringify(CLOCK_BOOTTIME)) == 0)
+			off->clockid = CLOCK_BOOTTIME;
+		else
+			goto out;
+
 		noffsets++;
 		if (noffsets == ARRAY_SIZE(offsets)) {
 			if (next_line)
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 3b30288793fe..53bce347cd50 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -338,7 +338,20 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 
 static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
 {
-	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+	char *clock;
+
+	switch (clockid) {
+	case CLOCK_BOOTTIME:
+		clock = "boottime";
+		break;
+	case CLOCK_MONOTONIC:
+		clock = "monotonic";
+		break;
+	default:
+		clock = "unknown";
+		break;
+	}
+	seq_printf(m, "%-10s %10lld %9ld\n", clock, ts->tv_sec, ts->tv_nsec);
 }
 
 void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)

