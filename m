Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72999C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D12D206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPt7X+RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgFHPpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgFHPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:45:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE9C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 08:45:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so17911929wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d9NEG1bGQJJm6086kHDBuH6vv0F9p403Di6mn3YZmfg=;
        b=CPt7X+RTw5oE3fPq2xRUcGjJq3ltxVlnkg9LVsd3699mbG738GcTRCX9kgBz1lfgDh
         ijugdXzZLVFDBXGB64Piw0MFBnFfgkFzmc2Fcn/QLgXBC2eMq6DMZEPdtNFSpDBkSUYL
         0mylUlKgtuYCEEjapW6o3J5010uBffv3Z9BsKn5MiCr7hc51lQ1BrOSxDrXv91KzrGAl
         IETeKkvBsvSSXbESF8EH8kCItHdxHSbD5XHRgRYh6kpncl9Mizc4ygBQFTSrVulncxo2
         OeTnWpl3B9nhc53Q5VQqLrDsrtq8PhsQfIHnTZNIKryag14mbiKfql3AsxhgHPMaI7c7
         znDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d9NEG1bGQJJm6086kHDBuH6vv0F9p403Di6mn3YZmfg=;
        b=rDwWBCseqEG7dLM7eyapcukbEI80RGyF6cU9KAb0cDmsI+Y+aYvvpcU9PjYKBmdXXW
         fJdQxzuv9m1dapMCYDm3rR25zXXO2LP4SYvnW0qbfAwdkHje4KMBNFu22SildYsOkDLs
         6/Lv4NhBwrKYHcEp44he96WI3NaGb8nGAquVgLsjSMT98c6ojGjZ6edWnJn7x7DLwnXa
         7KYXsJTpWJlZvRnuOQkGGfWkbZzRKvexMUI6e+NwRCi4i7MYXPmDev4GmBaisGxRlYQH
         jmuuys6C6GEnP8JSDvjRRmXO5BOYeCpiiMxJTZke4s1sT91/k4F7srFONhJeQbiFOZl1
         l6ag==
X-Gm-Message-State: AOAM531ZPHY5ogUUlO7voyx9tbzzfgGtKHy+x+Re3OGZp+1ZSomBIL5T
        oFcfrPxuLg7WgTpImBBSt+gj4w==
X-Google-Smtp-Source: ABdhPJxqSfxm70fW3D4+VuDF+OdfPgrtKn1Rs/jaqLkvy6nDX+Q7goN9gsqYaFto381DFAuBP3R9gg==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr23847890wrj.163.1591631141053;
        Mon, 08 Jun 2020 08:45:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d5d1:2db:4014:a4fb])
        by smtp.gmail.com with ESMTPSA id o15sm127877wrv.48.2020.06.08.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:45:39 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, iwtbavbm@gmail.com
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix nohz next idle balance
Date:   Mon,  8 Jun 2020 17:45:31 +0200
Message-Id: <20200608154531.17461-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

I haven't added another patch to kick ilb in case of abort because benchmarks
haven't seen any benefit or some slow decrease of perfomance.

 kernel/sched/fair.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ed04d2a8959..57761f4d58ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10017,7 +10017,12 @@ static void kick_ilb(unsigned int flags)
 {
 	int ilb_cpu;
 
-	nohz.next_balance++;
+	/*
+	 * Increase nohz.next_balance only when if full ilb is triggered but
+	 * not if we only update stats.
+	 */
+	if (flags & NOHZ_BALANCE_KICK)
+		nohz.next_balance++;
 
 	ilb_cpu = find_new_ilb();
 
@@ -10338,6 +10343,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
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
@@ -10358,14 +10371,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
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
2.17.1

