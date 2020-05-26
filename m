Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08D520787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEZQhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:37:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DACC03E96D;
        Tue, 26 May 2020 09:37:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdca4-0006ac-9Y; Tue, 26 May 2020 18:37:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DAEC51C00FA;
        Tue, 26 May 2020 18:37:31 +0200 (CEST)
Date:   Tue, 26 May 2020 16:37:31 -0000
From:   "tip-bot2 for Jens Axboe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Don't NUMA balance for kthreads
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk>
References: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk>
MIME-Version: 1.0
Message-ID: <159051105169.17951.7766343551502727932.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     18f855e574d9799a0e7489f8ae6fd8447d0dd74a
Gitweb:        https://git.kernel.org/tip/18f855e574d9799a0e7489f8ae6fd8447d0dd74a
Author:        Jens Axboe <axboe@kernel.dk>
AuthorDate:    Tue, 26 May 2020 09:38:31 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 18:34:58 +02:00

sched/fair: Don't NUMA balance for kthreads

Stefano reported a crash with using SQPOLL with io_uring:

  BUG: kernel NULL pointer dereference, address: 00000000000003b0
  CPU: 2 PID: 1307 Comm: io_uring-sq Not tainted 5.7.0-rc7 #11
  RIP: 0010:task_numa_work+0x4f/0x2c0
  Call Trace:
   task_work_run+0x68/0xa0
   io_sq_thread+0x252/0x3d0
   kthread+0xf9/0x130
   ret_from_fork+0x35/0x40

which is task_numa_work() oopsing on current->mm being NULL.

The task work is queued by task_tick_numa(), which checks if current->mm is
NULL at the time of the call. But this state isn't necessarily persistent,
if the kthread is using use_mm() to temporarily adopt the mm of a task.

Change the task_tick_numa() check to exclude kernel threads in general,
as it doesn't make sense to attempt ot balance for kthreads anyway.

Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/865de121-8190-5d30-ece5-3b097dc74431@kernel.dk
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 538ba5d..da3e5b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2908,7 +2908,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
-	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
+	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
 	/*
