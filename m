Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75C22078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664710;
	bh=HvvRqZwkh6QFAxuP2/osGSKcmwJD2DscUKII0BRZplw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s77qp3FSn39IuaicDmK5sm69zCbXM7MU/r+ZTv34wCEasr9AxEA29IQ0ommdWFGkJ
	 TPZS4AYl2XzHkGxCUZm6KyLcBTnLN4UiXRBr9leSdChB4PDnvR0YbU/nudVcD1z34a
	 lRDDtFuijeC40J4cODaTUPZ/h3qsNsnyK35UblbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgFHXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgFHXGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D46420853;
        Mon,  8 Jun 2020 23:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657601;
        bh=HvvRqZwkh6QFAxuP2/osGSKcmwJD2DscUKII0BRZplw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swwSbdITupFVkO66bA/IrlyzbWeKGZFDEQTNEShqwzkAfRTrR/gE+PiczdQZ15tlb
         wtfPUv+fJ+2hpfPnXCIFYhHm7L1mh2rFISJ9Woti9x1IUt7edM6d+Y/Pir2PmpQzzI
         JvZPIrQgyCm+J82hK5sNb3iX/xrVgiDm7LDnwBpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 027/274] sched/fair: Refill bandwidth before scaling
Date:   Mon,  8 Jun 2020 19:02:00 -0400
Message-Id: <20200608230607.3361041-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaixin Chang <changhuaixin@linux.alibaba.com>

[ Upstream commit 5a6d6a6ccb5f48ca8cf7c6d64ff83fd9c7999390 ]

In order to prevent possible hardlockup of sched_cfs_period_timer()
loop, loop count is introduced to denote whether to scale quota and
period or not. However, scale is done between forwarding period timer
and refilling cfs bandwidth runtime, which means that period timer is
forwarded with old "period" while runtime is refilled with scaled
"quota".

Move do_sched_cfs_period_timer() before scaling to solve this.

Fixes: 2e8e19226398 ("sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup")
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200420024421.22442-3-changhuaixin@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3e5b54715b..2ae7e30ccb33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5170,6 +5170,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
+
 		if (++count > 3) {
 			u64 new, old = ktime_to_ns(cfs_b->period);
 
@@ -5199,8 +5201,6 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			/* reset count so we don't come right back in here */
 			count = 0;
 		}
-
-		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-- 
2.25.1

