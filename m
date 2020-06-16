Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F253C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B04E20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgFPMXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgFPMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA3AC08C5C5;
        Tue, 16 Jun 2020 05:22:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbJ-0004iW-8a; Tue, 16 Jun 2020 14:22:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 13F5C1C06FE;
        Tue, 16 Jun 2020 14:21:54 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:53 -0000
From:   "tip-bot2 for Marcelo Tosatti" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kthread: Switch to cpu_possible_mask
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527142909.23372-2-frederic@kernel.org>
References: <20200527142909.23372-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159231011385.16989.15305912016989181408.tip-bot2@tip-bot2>
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

Commit-ID:     043eb8e1051143a24811e6f35c276e35ae8247b6
Gitweb:        https://git.kernel.org/tip/043eb8e1051143a24811e6f35c276e35ae8247b6
Author:        Marcelo Tosatti <mtosatti@redhat.com>
AuthorDate:    Wed, 27 May 2020 16:29:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:03 +02:00

kthread: Switch to cpu_possible_mask

Next patch will switch unbound kernel threads mask to
housekeeping_cpumask(), a subset of cpu_possible_mask. So in order to
ease bisection, lets first switch kthreads default affinity from
cpu_all_mask to cpu_possible_mask.

It looks safe to do so as cpu_possible_mask seem to be initialized
at setup_arch() time, way before kthreadd is created.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200527142909.23372-2-frederic@kernel.org
---
 kernel/kthread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 8e3d2d7..b86d37c 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -383,7 +383,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 * The kernel thread should not inherit these properties.
 		 */
 		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task, cpu_all_mask);
+		set_cpus_allowed_ptr(task, cpu_possible_mask);
 	}
 	kfree(create);
 	return task;
@@ -608,7 +608,7 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, "kthreadd");
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, cpu_all_mask);
+	set_cpus_allowed_ptr(tsk, cpu_possible_mask);
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
