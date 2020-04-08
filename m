Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9187C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86409206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDHMUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgDHMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gw-00065N-BO; Wed, 08 Apr 2020 14:20:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E2C931C0131;
        Wed,  8 Apr 2020 14:20:25 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:25 -0000
From:   "tip-bot2 for Aubrey Li" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix negative imbalance in imbalance
 calculation
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
References: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Message-ID: <158634842556.28353.13089181370653976437.tip-bot2@tip-bot2>
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

Commit-ID:     111688ca1c4a43a7e482f5401f82c46326b8ed49
Gitweb:        https://git.kernel.org/tip/111688ca1c4a43a7e482f5401f82c46326b8ed49
Author:        Aubrey Li <aubrey.li@intel.com>
AuthorDate:    Thu, 26 Mar 2020 13:42:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:20 +02:00

sched/fair: Fix negative imbalance in imbalance calculation

A negative imbalance value was observed after imbalance calculation,
this happens when the local sched group type is group_fully_busy,
and the average load of local group is greater than the selected
busiest group. Fix this problem by comparing the average load of the
local and busiest group before imbalance calculation formula.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/1585201349-70192-1-git-send-email-aubrey.li@intel.com
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 95cbd9e..02f323b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9036,6 +9036,14 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
 				sds->total_capacity;
+		/*
+		 * If the local group is more loaded than the selected
+		 * busiest group don't try to pull any tasks.
+		 */
+		if (local->avg_load >= busiest->avg_load) {
+			env->imbalance = 0;
+			return;
+		}
 	}
 
 	/*
