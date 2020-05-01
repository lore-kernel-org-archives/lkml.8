Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF20AC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F4E24967
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgEASWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730462AbgEASWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79867C08E934;
        Fri,  1 May 2020 11:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIY-0003WT-F2; Fri, 01 May 2020 20:22:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED4641C0330;
        Fri,  1 May 2020 20:22:05 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:05 -0000
From:   "tip-bot2 for Barret Rhoden" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add cond_resched() to task_function_call()
Cc:     syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com,
        Barret Rhoden <brho@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200414222920.121401-1-brho@google.com>
References: <20200414222920.121401-1-brho@google.com>
MIME-Version: 1.0
Message-ID: <158835732594.8414.10249310108330671272.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2ed6edd33a214bca02bd2b45e3fc3038a059436b
Gitweb:        https://git.kernel.org/tip/2ed6edd33a214bca02bd2b45e3fc3038a059436b
Author:        Barret Rhoden <brho@google.com>
AuthorDate:    Tue, 14 Apr 2020 18:29:20 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:36 +02:00

perf: Add cond_resched() to task_function_call()

Under rare circumstances, task_function_call() can repeatedly fail and
cause a soft lockup.

There is a slight race where the process is no longer running on the cpu
we targeted by the time remote_function() runs.  The code will simply
try again.  If we are very unlucky, this will continue to fail, until a
watchdog fires.  This can happen in a heavily loaded, multi-core virtual
machine.

Reported-by: syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
Signed-off-by: Barret Rhoden <brho@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200414222920.121401-1-brho@google.com
---
 kernel/events/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 52951e9..80cf996 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -95,11 +95,11 @@ static void remote_function(void *data)
  * @info:	the function call argument
  *
  * Calls the function @func when the task is currently running. This might
- * be on the current CPU, which just calls the function directly
+ * be on the current CPU, which just calls the function directly.  This will
+ * retry due to any failures in smp_call_function_single(), such as if the
+ * task_cpu() goes offline concurrently.
  *
- * returns: @func return value, or
- *	    -ESRCH  - when the process isn't running
- *	    -EAGAIN - when the process moved away
+ * returns @func return value or -ESRCH when the process isn't running
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -112,11 +112,16 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	};
 	int ret;
 
-	do {
-		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
-		if (!ret)
-			ret = data.ret;
-	} while (ret == -EAGAIN);
+	for (;;) {
+		ret = smp_call_function_single(task_cpu(p), remote_function,
+					       &data, 1);
+		ret = !ret ? data.ret : -EAGAIN;
+
+		if (ret != -EAGAIN)
+			break;
+
+		cond_resched();
+	}
 
 	return ret;
 }
