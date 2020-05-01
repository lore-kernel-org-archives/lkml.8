Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179DAC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0052C2496A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgEASWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730459AbgEASWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA5C061A0C;
        Fri,  1 May 2020 11:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIZ-0003Wa-9N; Fri, 01 May 2020 20:22:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2FD31C0085;
        Fri,  1 May 2020 20:22:06 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:06 -0000
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Simplify sched_init()
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200423214443.29994-1-richard.weiyang@gmail.com>
References: <20200423214443.29994-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Message-ID: <158835732689.8414.17699467590439220013.tip-bot2@tip-bot2>
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

Commit-ID:     b1d1779e5ef7a60b192b61fd97201f322e1e9303
Gitweb:        https://git.kernel.org/tip/b1d1779e5ef7a60b192b61fd97201f322e1e9303
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Thu, 23 Apr 2020 21:44:43 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:42 +02:00

sched/core: Simplify sched_init()

Currently root_task_group.shares and cfs_bandwidth are initialized for
each online cpu, which not necessary.

Let's take it out to do it only once.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200423214443.29994-1-richard.weiyang@gmail.com
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f6ae262..b58efb1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6597,6 +6597,8 @@ void __init sched_init(void)
 		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
 
+		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
@@ -6649,7 +6651,6 @@ void __init sched_init(void)
 		init_rt_rq(&rq->rt);
 		init_dl_rq(&rq->dl);
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
 		/*
@@ -6671,7 +6672,6 @@ void __init sched_init(void)
 		 * We achieve this by letting root_task_group's tasks sit
 		 * directly in rq->cfs (i.e root_task_group->se[] = NULL).
 		 */
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
