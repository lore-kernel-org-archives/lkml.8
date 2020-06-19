Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F36C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4E7206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579864;
	bh=HvvRqZwkh6QFAxuP2/osGSKcmwJD2DscUKII0BRZplw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UCtRI/bm8OjPFXSFcZarL3Tmljp/OGmpzBSl600eLeHpmCn1BnKBIFkq/7+NX7HR
	 l4I/LzAL7rIwuetSxGKc+gULfJRVqfJF0gHciBQm1oUMWEGjsT/wjzI6KhHVLVRO03
	 X4/RB3YN86ZTBt16Pqj+cLZyIze8f0hDWIbMk+0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbgFSPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404182AbgFSPRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34564217D8;
        Fri, 19 Jun 2020 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579841;
        bh=HvvRqZwkh6QFAxuP2/osGSKcmwJD2DscUKII0BRZplw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFmQWw2OCjuY5MSglCjXDUAl7A+Hm2mA0Kr7wfPayRwJ+lOSMVUo8NJKFSEfV6UWr
         kN+tWpGsmriqSSe2XMf3+Ni4TrqSVJCqG1iGbAE7cErmNBiL+K8usvPZyTmn0e2i6O
         vuSVj//OenVfQvRm0Vbu3zzozBsBAOVNRZBPsaAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 025/376] sched/fair: Refill bandwidth before scaling
Date:   Fri, 19 Jun 2020 16:29:03 +0200
Message-Id: <20200619141711.552881832@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



