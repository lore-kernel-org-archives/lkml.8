Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0234EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D00207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgESSob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgESSoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:44:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D3C08C5C0;
        Tue, 19 May 2020 11:44:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Ds-0006dk-Ps; Tue, 19 May 2020 20:44:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 625B11C0480;
        Tue, 19 May 2020 20:44:16 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:16 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize enqueue_task_fair()
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200513135502.4672-1-vincent.guittot@linaro.org>
References: <20200513135502.4672-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <158991385628.17951.11829788536387109935.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d148be69e3a0eaa9d029a3c51b545e322116a99
Gitweb:        https://git.kernel.org/tip/7d148be69e3a0eaa9d029a3c51b545e322116a99
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 13 May 2020 15:55:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:13 +02:00

sched/fair: Optimize enqueue_task_fair()

enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
throttled which means that se can't be NULL in such case and we can move
the label after the if (!se) statement. Futhermore, the latter can be
removed because se is always NULL when reaching this point.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200513135502.4672-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a58874..4e58686 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5512,28 +5512,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                        list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-enqueue_throttle:
-	if (!se) {
-		add_nr_running(rq, 1);
-		/*
-		 * Since new tasks are assigned an initial util_avg equal to
-		 * half of the spare capacity of their CPU, tiny tasks have the
-		 * ability to cross the overutilized threshold, which will
-		 * result in the load balancer ruining all the task placement
-		 * done by EAS. As a way to mitigate that effect, do not account
-		 * for the first enqueue operation of new tasks during the
-		 * overutilized flag detection.
-		 *
-		 * A better way of solving this problem would be to wait for
-		 * the PELT signals of tasks to converge before taking them
-		 * into account, but that is not straightforward to implement,
-		 * and the following generally works well enough in practice.
-		 */
-		if (flags & ENQUEUE_WAKEUP)
-			update_overutilized_status(rq);
+	/* At this point se is NULL and we are at root level*/
+	add_nr_running(rq, 1);
 
-	}
+	/*
+	 * Since new tasks are assigned an initial util_avg equal to
+	 * half of the spare capacity of their CPU, tiny tasks have the
+	 * ability to cross the overutilized threshold, which will
+	 * result in the load balancer ruining all the task placement
+	 * done by EAS. As a way to mitigate that effect, do not account
+	 * for the first enqueue operation of new tasks during the
+	 * overutilized flag detection.
+	 *
+	 * A better way of solving this problem would be to wait for
+	 * the PELT signals of tasks to converge before taking them
+	 * into account, but that is not straightforward to implement,
+	 * and the following generally works well enough in practice.
+	 */
+	if (flags & ENQUEUE_WAKEUP)
+		update_overutilized_status(rq);
 
+enqueue_throttle:
 	if (cfs_bandwidth_used()) {
 		/*
 		 * When bandwidth control is enabled; the cfs_rq_throttled()
