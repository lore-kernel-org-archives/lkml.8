Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A722C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454AB20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbgFYLxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404265AbgFYLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84511C061573;
        Thu, 25 Jun 2020 04:53:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRY-0005pt-0H; Thu, 25 Jun 2020 13:53:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8F35D1C0092;
        Thu, 25 Jun 2020 13:53:23 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:23 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/cfs: change initial value of runnable_avg
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200624154422.29166-1-vincent.guittot@linaro.org>
References: <20200624154422.29166-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <159308600329.16989.15117119529654032761.tip-bot2@tip-bot2>
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

Commit-ID:     68f7b5cc835de7d5b6c7696533c126018171e793
Gitweb:        https://git.kernel.org/tip/68f7b5cc835de7d5b6c7696533c126018171e793
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Jun 2020 17:44:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:38 +02:00

sched/cfs: change initial value of runnable_avg

Some performance regression on reaim benchmark have been raised with
  commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")

The problem comes from the init value of runnable_avg which is initialized
with max value. This can be a problem if the newly forked task is finally
a short task because the group of CPUs is wrongly set to overloaded and
tasks are pulled less agressively.

Set initial value of runnable_avg equals to util_avg to reflect that there
is no waiting time so far.

Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200624154422.29166-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbcb2f7..658aa7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
-	sa->runnable_avg = cpu_scale;
+	sa->runnable_avg = sa->util_avg;
 
 	if (p->sched_class != &fair_sched_class) {
 		/*
