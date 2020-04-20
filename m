Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDFAC54FC9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E672B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDTCos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 22:44:48 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55671 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgDTCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:44:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tw0VEVY_1587350682;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Tw0VEVY_1587350682)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Apr 2020 10:44:45 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, bsegall@google.com,
        chiluk+linux@indeed.com, vincent.guittot@linaro.org,
        pauld@redhead.com, Huaixin Chang <changhuaixin@linux.alibaba.com>
Subject: [PATCH 2/2] sched/fair: Refill bandwidth before scaling
Date:   Mon, 20 Apr 2020 10:44:21 +0800
Message-Id: <20200420024421.22442-3-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent possible hardlockup of sched_cfs_period_timer()
loop, loop count is introduced to denote whether to scale quota and
period or not. However, scale is done between forwarding period timer
and refilling cfs bandwidth runtime, which means that period timer is
forwarded with old "period" while runtime is refilled with scaled
"quota".

Move do_sched_cfs_period_timer() before scaling to solve this.

Fixes: 2e8e19226398 ("sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup")
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..9ace1c5c73a5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5152,6 +5152,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
+
 		if (++count > 3) {
 			u64 new, old = ktime_to_ns(cfs_b->period);
 
@@ -5181,8 +5183,6 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			/* reset count so we don't come right back in here */
 			count = 0;
 		}
-
-		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-- 
2.14.4.44.g2045bb6

