Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BEC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2A520776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCTM6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgCTM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDv-0003iS-Hr; Fri, 20 Mar 2020 13:58:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0CD821C22BE;
        Fri, 20 Mar 2020 13:58:03 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:02 -0000
From:   "tip-bot2 for Tao Zhou" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix condition of avg_load calculation
Cc:     Tao Zhou <ouwen210@hotmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158470908271.28353.7933643223235675222.tip-bot2@tip-bot2>
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

Commit-ID:     6c8116c914b65be5e4d6f66d69c8142eb0648c22
Gitweb:        https://git.kernel.org/tip/6c8116c914b65be5e4d6f66d69c8142eb0648c22
Author:        Tao Zhou <ouwen210@hotmail.com>
AuthorDate:    Thu, 19 Mar 2020 11:39:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:20 +01:00

sched/fair: Fix condition of avg_load calculation

In update_sg_wakeup_stats(), the comment says:

Computing avg_load makes sense only when group is fully
busy or overloaded.

But, the code below this comment does not check like this.

>From reading the code about avg_load in other functions, I
confirm that avg_load should be calculated in fully busy or
overloaded case. The comment is correct and the checking
condition is wrong. So, change that condition.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Signed-off-by: Tao Zhou <ouwen210@hotmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/Message-ID:
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 783356f..d7fb20a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8631,7 +8631,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 	 * Computing avg_load makes sense only when group is fully busy or
 	 * overloaded
 	 */
-	if (sgs->group_type < group_fully_busy)
+	if (sgs->group_type == group_fully_busy ||
+		sgs->group_type == group_overloaded)
 		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
 				sgs->group_capacity;
 }
