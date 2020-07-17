Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C0C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60442207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594994770;
	bh=MGr7hTBgNYBC2Wa2mKAhtZR1WrZqEEp+LklgqOmbrwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQb2UKp8G0hTcbuaYcPHa1teADLdLzX+9sOqMoeeVqE+W5TqG1oCJiuRslzzeLUrJ
	 kvcrtlP63owwPcN180ZXnGytE5OYkD6yrq0+2L9g45561SWJCJoNISldgIKnr63uFl
	 wh12lnJCAiqZkr/vWg3B9Ugoeny2Y+GMJkaWFkyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGQOGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgGQOGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:05 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 123712067D;
        Fri, 17 Jul 2020 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994765;
        bh=MGr7hTBgNYBC2Wa2mKAhtZR1WrZqEEp+LklgqOmbrwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PnsJ9KhZ5sQFqjWXQ/baN2TdPkjaRri6254CIjMqhx5pxdZIXwrWfszq3Qolt+J+
         ZHxL/Xj9sSK3fmRYThbaJ+0ne9Z+6wZ9kBBZHSvUKLB/czvJ1kf/S4KXe+FBkgoMbV
         KaoO8cz0XZEtKkc+VN9kda+X0tj4F/QumEiANoGI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 05/12] timer: Add comments about calc_index() ceiling work
Date:   Fri, 17 Jul 2020 16:05:44 +0200
Message-Id: <20200717140551.29076-6-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717140551.29076-1-frederic@kernel.org>
References: <20200717140551.29076-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calc_index() adds 1 unit of the level granularity to the expiry passed
in parameter to ensure that the timer doesn't expire too early. Add a
comment to explain that and the resulting layout in the wheel.

Most-of-the-patch-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2af08a169564..af1c08b0b168 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -156,7 +156,8 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The time start value for each level to select the bucket at enqueue
- * time.
+ * time. We start from the last possible delta of the previous level
+ * so that we can later add an extra LVL_GRAN(n) to n (see calc_index()).
  */
 #define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
 
@@ -490,6 +491,15 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
 static inline unsigned calc_index(unsigned long expires, unsigned lvl,
 				  unsigned long *bucket_expiry)
 {
+
+	/*
+	 * The timer wheel has to guarantee that a timer does not fire
+	 * early. Early expiry can happen due to:
+	 * - Timer is armed at the edge of a tick
+	 * - Truncation of the expiry time in the outer wheel levels
+	 *
+	 * Round up with level granularity to prevent this.
+	 */
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
 	*bucket_expiry = expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
-- 
2.26.2

