Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCCAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3290207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgESSof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgESSoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:44:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EFBC08C5C1;
        Tue, 19 May 2020 11:44:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Dv-0006de-DD; Tue, 19 May 2020 20:44:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F07CC1C047E;
        Tue, 19 May 2020 20:44:15 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:15 -0000
From:   "tip-bot2 for Muchun Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpuacct: Use __this_cpu_add() instead of
 this_cpu_ptr()
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200507031039.32615-1-songmuchun@bytedance.com>
References: <20200507031039.32615-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Message-ID: <158991385587.17951.10383414133329155280.tip-bot2@tip-bot2>
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

Commit-ID:     12aa2587388de6697fd2e585ae6a90f70249540b
Gitweb:        https://git.kernel.org/tip/12aa2587388de6697fd2e585ae6a90f70249540b
Author:        Muchun Song <songmuchun@bytedance.com>
AuthorDate:    Thu, 07 May 2020 11:10:39 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:13 +02:00

sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()

The cpuacct_charge() and cpuacct_account_field() are called with
rq->lock held, and this means preemption(and IRQs) are indeed
disabled, so it is safe to use __this_cpu_*() to allow for better
code-generation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200507031039.32615-1-songmuchun@bytedance.com
---
 kernel/sched/cpuacct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb103..6448b04 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -347,7 +347,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
+		__this_cpu_add(ca->cpuusage->usages[index], cputime);
 
 	rcu_read_unlock();
 }
@@ -363,7 +363,7 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
 
 	rcu_read_lock();
 	for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
-		this_cpu_ptr(ca->cpustat)->cpustat[index] += val;
+		__this_cpu_add(ca->cpustat->cpustat[index], val);
 	rcu_read_unlock();
 }
 
