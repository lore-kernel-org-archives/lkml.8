Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E820792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yBnRFIXC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odpwU/DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgGVJMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGVJMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:35 -0400
Date:   Wed, 22 Jul 2020 09:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHacWLIcDurmhW0FpN0Glp+owoWiXqtADVgC0S49uas=;
        b=yBnRFIXCaKrROj2E/Ri5sFh2mOuyn/Yd4LkE9maRcWD8UvZWfenMpRFwcHwoVB7ZWk7fmY
        +kmUsnfk8EdezplTz6pv4ekoiKPuRzgmy3Ai9zsnBhecIrLX0Ql1V6zapa/WbMK1NVIQX0
        q+QoBgKvbHr8yfjosYuiaOh3+jK/oN69UNjYHJSZaCsL5J1nSzwJKavECXAHetZQfNRsbp
        jC8Kdat8PEz/z8H87GR7YRnBrVpcSlksvMosxFaJ3aIfSGQxFEKzZ0F/ZzmU81GF85B642
        qefUgjGVcZTMYi+d5G2mnnUeUYx5oOusgYkRdWUQ7ys11RFzIYt9uI0QJB14iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHacWLIcDurmhW0FpN0Glp+owoWiXqtADVgC0S49uas=;
        b=odpwU/DCOIStcbkkx18/2Lrvc7LSRA/XNcYGyzlhvLmm9QdiKZOM20ERPi7hUvDl/6K6xI
        5Db76kXsWH3B3dAw==
From:   "tip-bot2 for Peter Puhov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Cc:     Peter Puhov <peter.puhov@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200714125941.4174-1-peter.puhov@linaro.org>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
MIME-Version: 1.0
Message-ID: <159540914714.4006.8932700488407491684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3edecfef028536cb19a120ec8788bd8a11f93b9e
Gitweb:        https://git.kernel.org/tip/3edecfef028536cb19a120ec8788bd8a11f93b9e
Author:        Peter Puhov <peter.puhov@linaro.org>
AuthorDate:    Tue, 14 Jul 2020 08:59:41 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:04 +02:00

sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal

In slow path, when selecting idlest group, if both groups have type
group_has_spare, only idle_cpus count gets compared.
As a result, if multiple tasks are created in a tight loop,
and go back to sleep immediately
(while waiting for all tasks to be created),
they may be scheduled on the same core, because CPU is back to idle
when the new fork happen.

For example:
sudo perf record -e sched:sched_wakeup_new -- \
                                  sysbench threads --threads=4 run
...
    total number of events:              61582
...
sudo perf script
sysbench 129378 [006] 74586.633466: sched:sched_wakeup_new:
                            sysbench:129380 [120] success=1 CPU:007
sysbench 129378 [006] 74586.634718: sched:sched_wakeup_new:
                            sysbench:129381 [120] success=1 CPU:007
sysbench 129378 [006] 74586.635957: sched:sched_wakeup_new:
                            sysbench:129382 [120] success=1 CPU:007
sysbench 129378 [006] 74586.637183: sched:sched_wakeup_new:
                            sysbench:129383 [120] success=1 CPU:007

This may have negative impact on performance for workloads with frequent
creation of multiple threads.

In this patch we are using group_util to select idlest group if both groups
have equal number of idle_cpus. Comparing the number of idle cpu is
not enough in this case, because the newly forked thread sleeps
immediately and before we select the cpu for the next one.
This is shown in the trace where the same CPU7 is selected for
all wakeup_new events.
That's why, looking at utilization when there is the same number of
CPU is a good way to see where the previous task was placed. Using
nr_running doesn't solve the problem because the newly forked task is not
running and the cpu would not have been idle in this case and an idle
CPU would have been selected instead.

With this patch newly created tasks would be better distributed.

With this patch:
sudo perf record -e sched:sched_wakeup_new -- \
                                    sysbench threads --threads=4 run
...
    total number of events:              74401
...
sudo perf script
sysbench 129455 [006] 75232.853257: sched:sched_wakeup_new:
                            sysbench:129457 [120] success=1 CPU:008
sysbench 129455 [006] 75232.854489: sched:sched_wakeup_new:
                            sysbench:129458 [120] success=1 CPU:009
sysbench 129455 [006] 75232.855732: sched:sched_wakeup_new:
                            sysbench:129459 [120] success=1 CPU:010
sysbench 129455 [006] 75232.856980: sched:sched_wakeup_new:
                            sysbench:129460 [120] success=1 CPU:011

We tested this patch with following benchmarks:
master: 'commit b3a9e3b9622a ("Linux 5.8-rc1")'

100 iterations of: perf bench -f simple futex wake -s -t 128 -w 1
Lower result is better
|         |   BASELINE |   +PATCH |   DELTA (%) |
|---------|------------|----------|-------------|
| mean    |      0.33  |    0.313 |      +5.152 |
| std (%) |     10.433 |    7.563 |             |

100 iterations of: sysbench threads --threads=8 run
Higher result is better
|         |   BASELINE |   +PATCH |   DELTA (%) |
|---------|------------|----------|-------------|
| mean    |   5235.02  | 5863.73  |      +12.01 |
| std (%) |      8.166 |   10.265 |             |

100 iterations of: sysbench mutex --mutex-num=1 --threads=8 run
Lower result is better
|         |   BASELINE |   +PATCH |   DELTA (%) |
|---------|------------|----------|-------------|
| mean    |      0.413 |    0.404 |      +2.179 |
| std (%) |      3.791 |    1.816 |             |

Signed-off-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200714125941.4174-1-peter.puhov@linaro.org
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 98a53a2..2ba8f23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8711,8 +8711,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
 
 	case group_has_spare:
 		/* Select group with most idle CPUs */
-		if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
+		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
 			return false;
+
+		/* Select group with lowest group_util */
+		if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
+			idlest_sgs->group_util <= sgs->group_util)
+			return false;
+
 		break;
 	}
 
