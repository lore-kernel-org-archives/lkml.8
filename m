Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B231C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EB0221EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052980;
	bh=xPCg/qppnNYd0X4wUKky/6es7Ms3c9iMxBzuit/N0Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y13/bgIVJGRJ+LsCL/Z9bmnJLIyKMkV4km/iVBmd2Bdhhake928UmXYEiaAqcf1EY
	 qxFKnYknyqIDZY8LSBesFksiy5VjxRuU3sc8LhJwiHXlEPk9mcfjOgz0xnQGstkRAC
	 BC1osJ9ZLnidHeQKt5XwoULPWNkmiKGxPV202ngI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgDPQC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895263AbgDPN0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E57221F4;
        Thu, 16 Apr 2020 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043591;
        bh=xPCg/qppnNYd0X4wUKky/6es7Ms3c9iMxBzuit/N0Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hmt7LgbBuZ2vaATh4jN9LHoFNwbKBTd9nRTCGv5ojX2w/OCslfd0GMchzwGrIY2s8
         3gMJnv6WHueKVxSDlZ+ULDp7XGeVtXRa59x1LJNVeU4OymJObQBakADWk4SaWreVkY
         UD99Ljk4W0C9oim5QP4n8V6d7/169RvoooG/gDxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Michael Wang <yun.wang@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/146] sched: Avoid scale real weight down to zero
Date:   Thu, 16 Apr 2020 15:22:41 +0200
Message-Id: <20200416131245.275722512@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Wang <yun.wang@linux.alibaba.com>

[ Upstream commit 26cf52229efc87e2effa9d788f9b33c40fb3358a ]

During our testing, we found a case that shares no longer
working correctly, the cgroup topology is like:

  /sys/fs/cgroup/cpu/A		(shares=102400)
  /sys/fs/cgroup/cpu/A/B	(shares=2)
  /sys/fs/cgroup/cpu/A/B/C	(shares=1024)

  /sys/fs/cgroup/cpu/D		(shares=1024)
  /sys/fs/cgroup/cpu/D/E	(shares=1024)
  /sys/fs/cgroup/cpu/D/E/F	(shares=1024)

The same benchmark is running in group C & F, no other tasks are
running, the benchmark is capable to consumed all the CPUs.

We suppose the group C will win more CPU resources since it could
enjoy all the shares of group A, but it's F who wins much more.

The reason is because we have group B with shares as 2, since
A->cfs_rq.load.weight == B->se.load.weight == B->shares/nr_cpus,
so A->cfs_rq.load.weight become very small.

And in calc_group_shares() we calculate shares as:

  load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
  shares = (tg_shares * load) / tg_weight;

Since the 'cfs_rq->load.weight' is too small, the load become 0
after scale down, although 'tg_shares' is 102400, shares of the se
which stand for group A on root cfs_rq become 2.

While the se of D on root cfs_rq is far more bigger than 2, so it
wins the battle.

Thus when scale_load_down() scale real weight down to 0, it's no
longer telling the real story, the caller will have the wrong
information and the calculation will be buggy.

This patch add check in scale_load_down(), so the real weight will
be >= MIN_SHARES after scale, after applied the group C wins as
expected.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/38e8e212-59a1-64b2-b247-b6d0b52d8dc1@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/sched.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 94bec97bd5e28..5f0eb4565957f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -123,7 +123,13 @@ static inline void cpu_load_update_active(struct rq *this_rq) { }
 #ifdef CONFIG_64BIT
 # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOINT_SHIFT)
 # define scale_load(w)		((w) << SCHED_FIXEDPOINT_SHIFT)
-# define scale_load_down(w)	((w) >> SCHED_FIXEDPOINT_SHIFT)
+# define scale_load_down(w) \
+({ \
+	unsigned long __w = (w); \
+	if (__w) \
+		__w = max(2UL, __w >> SCHED_FIXEDPOINT_SHIFT); \
+	__w; \
+})
 #else
 # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
 # define scale_load(w)		(w)
-- 
2.20.1



