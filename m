Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B623820781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593565871;
	bh=R+CWRWxBdgS789CBMsWjf9pbxc6lgAm7ICA8umueBE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZX4vTj5VvOCx7o8KWumXABZ2zX6+y0ypzpdmp03mLMlXpbSjrmKy4sx7yOrlE9tW
	 KPPxBKXdZL2ITIPQjQzT+E5VihAxiK8odngaYB5apiFJnt8BgmFaXyBQQnmmlQxNwd
	 fGxYreJ/mXeh/iK9Q3WN7vTXDnYCKYNCcdIsQwcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGABKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGABKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:10:38 -0400
Received: from lenoir.home (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820BD20780;
        Wed,  1 Jul 2020 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593565837;
        bh=R+CWRWxBdgS789CBMsWjf9pbxc6lgAm7ICA8umueBE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUcDog9BnsFUNsBklcERwb/RghMXgW32y9k4yslt55zQpHYGouEz/aXaCWtce6ARs
         ngVpx6oqm9qoD5Pyta8EWHQkFF00MRz/b5ET7qoJoAmV9H8KMdkV4X4BOpKFCAlwtP
         EvRaIuT6IaepEdph6deD3H5lidtI5oqBnRocllyI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Date:   Wed,  1 Jul 2020 03:10:21 +0200
Message-Id: <20200701011030.14324-2-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701011030.14324-1-frederic@kernel.org>
References: <20200701011030.14324-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a timer is enqueued with a negative delta (ie: expiry is below
base->clk), it gets added to the wheel as expiring now (base->clk).

Yet the value that gets stored in base->next_expiry, while calling
trigger_dyntick_cpu(), is the initial timer->expires value. The
resulting state becomes:

	base->next_expiry < base->clk

On the next timer enqueue, forward_timer_base() may accidentally
rewind base->clk. As a possible outcome, timers may expire way too
early, the worst case being that the highest wheel levels get spuriously
processed again.

To prevent from that, make sure that base->next_expiry doesn't get below
base->clk.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 398e6eadb861..9a838d38dbe6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -584,7 +584,15 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	 * Set the next expiry time and kick the CPU so it can reevaluate the
 	 * wheel:
 	 */
-	base->next_expiry = timer->expires;
+	if (time_before(timer->expires, base->clk)) {
+		/*
+		 * Prevent from forward_timer_base() moving the base->clk
+		 * backward
+		 */
+		base->next_expiry = base->clk;
+	} else {
+		base->next_expiry = timer->expires;
+	}
 	wake_up_nohz_cpu(base->cpu);
 }
 
@@ -896,10 +904,13 @@ static inline void forward_timer_base(struct timer_base *base)
 	 * If the next expiry value is > jiffies, then we fast forward to
 	 * jiffies otherwise we forward to the next expiry value.
 	 */
-	if (time_after(base->next_expiry, jnow))
+	if (time_after(base->next_expiry, jnow)) {
 		base->clk = jnow;
-	else
+	} else {
+		if (WARN_ON_ONCE(time_before(base->next_expiry, base->clk)))
+			return;
 		base->clk = base->next_expiry;
+	}
 #endif
 }
 
-- 
2.26.2

