Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B53D207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgESSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgESSoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:44:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE961C08C5C0;
        Tue, 19 May 2020 11:44:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Dq-0006c9-7d; Tue, 19 May 2020 20:44:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CED5A1C0178;
        Tue, 19 May 2020 20:44:13 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:13 -0000
From:   "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix enqueue_task_fair() warning some more
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512135222.GC2201@lorien.usersys.redhat.com>
References: <20200512135222.GC2201@lorien.usersys.redhat.com>
MIME-Version: 1.0
Message-ID: <158991385371.17951.7641026996836626730.tip-bot2@tip-bot2>
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

Commit-ID:     b34cb07dde7c2346dec73d053ce926aeaa087303
Gitweb:        https://git.kernel.org/tip/b34cb07dde7c2346dec73d053ce926aeaa087303
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Tue, 12 May 2020 09:52:22 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:10 +02:00

sched/fair: Fix enqueue_task_fair() warning some more

sched/fair: Fix enqueue_task_fair warning some more

The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
did not fully resolve the issues with the rq->tmp_alone_branch !=
&rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
the first for_each_sched_entity loop exits due to on_rq, having incompletely
updated the list.  In this case the second for_each_sched_entity loop can
further modify se. The later code to fix up the list management fails to do
what is needed because se does not point to the sched_entity which broke out
of the first loop. The list is not fixed up because the throttled parent was
already added back to the list by a task enqueue in a parallel child hierarchy.

Address this by calling list_add_leaf_cfs_rq if there are throttled parents
while doing the second for_each_sched_entity loop.

Fixes: fe61468b2cb ("sched/fair: Fix enqueue_task_fair warning")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20200512135222.GC2201@lorien.usersys.redhat.com
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b..c6d57c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5479,6 +5479,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
+
+               /*
+                * One parent has been throttled and cfs_rq removed from the
+                * list. Add it back to not break the leaf list.
+                */
+               if (throttled_hierarchy(cfs_rq))
+                       list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 enqueue_throttle:
