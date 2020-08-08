Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE4CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC902053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930313;
	bh=cytyOljv7NTOTrVBQRiR1DPgvbeXqME725xfguHR8S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PCvhPRinkiAEhVVWxBcC50r4ud8fPfOA5kR/lWKVaqsBMPPCKh4ONKISRiFPEJos6
	 tt4LOtPqUQBsqFgNpTXGPX6o81C9YVRxR675+79PDiBPqAE9aXd6DPifMPYzzGl6NO
	 P+q4vBBbLS9JGoSGytvdKumL4cCzbHDGK/DwqcuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHHXix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbgHHXis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCC420748;
        Sat,  8 Aug 2020 23:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929927;
        bh=cytyOljv7NTOTrVBQRiR1DPgvbeXqME725xfguHR8S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqrO78n2Kwk2Bm9ImsXSzwRNgokuMP5RZIZ8XWA2rNgK6yZjRCBF010dApEZb/dYY
         2r5u/LZS7IjwqhsyOiFcgHkA5CSBTEyoFG37cCHRR0X2e+bwobh+7BwWFqYcYwM/OY
         VRkfB5D8pZy5SWezSvToST9xfV5TzVU3JpZZUTQc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peng Liu <iwtbavbm@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 02/40] sched/fair: Fix NOHZ next idle balance
Date:   Sat,  8 Aug 2020 19:38:06 -0400
Message-Id: <20200808233844.3618823-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233844.3618823-1-sashal@kernel.org>
References: <20200808233844.3618823-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit 3ea2f097b17e13a8280f1f9386c331b326a3dbef ]

With commit:
  'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
rebalance_domains of the local cfs_rq happens before others idle cpus have
updated nohz.next_balance and its value is overwritten.

Move the update of nohz.next_balance for other idles cpus before balancing
and updating the next_balance of local cfs_rq.

Also, the nohz.next_balance is now updated only if all idle cpus got a
chance to rebalance their domains and the idle balance has not been aborted
because of new activities on the CPU. In case of need_resched, the idle
load balance will be kick the next jiffie in order to address remaining
ilb.

Fixes: b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")
Reported-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20200609123748.18636-1-vincent.guittot@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9b16080093be1..20bf1f66733ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9385,7 +9385,12 @@ static void kick_ilb(unsigned int flags)
 {
 	int ilb_cpu;
 
-	nohz.next_balance++;
+	/*
+	 * Increase nohz.next_balance only when if full ilb is triggered but
+	 * not if we only update stats.
+	 */
+	if (flags & NOHZ_BALANCE_KICK)
+		nohz.next_balance = jiffies+1;
 
 	ilb_cpu = find_new_ilb();
 
@@ -9703,6 +9708,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		}
 	}
 
+	/*
+	 * next_balance will be updated only when there is a need.
+	 * When the CPU is attached to null domain for ex, it will not be
+	 * updated.
+	 */
+	if (likely(update_next_balance))
+		nohz.next_balance = next_balance;
+
 	/* Newly idle CPU doesn't need an update */
 	if (idle != CPU_NEWLY_IDLE) {
 		update_blocked_averages(this_cpu);
@@ -9723,14 +9736,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (has_blocked_load)
 		WRITE_ONCE(nohz.has_blocked, 1);
 
-	/*
-	 * next_balance will be updated only when there is a need.
-	 * When the CPU is attached to null domain for ex, it will not be
-	 * updated.
-	 */
-	if (likely(update_next_balance))
-		nohz.next_balance = next_balance;
-
 	return ret;
 }
 
-- 
2.25.1

