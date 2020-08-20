Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB09DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BA72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHTC7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:59:52 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:49141 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHTC7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:59:51 -0400
X-QQ-mid: bizesmtp20t1597892367tn1degxx
Received: from localhost.localdomain.info (unknown [103.37.140.45])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 20 Aug 2020 10:59:22 +0800 (CST)
X-QQ-SSF: 01100000002000E0Z000B00A0001000
X-QQ-FEAT: 9W4TTyWj0GPg03owh0ocBhZJGDp9froOm3u11QDwX/8s26Qa2LOKslI420QkJ
        tiIPItLxJfLGJd8H/qu6WvfqP+nGNpFWW4z5K80n8ERPeYIhKSxMxruXEqr9lZe8SGfvUZ+
        YiSnOsoW3NuIkh17v+0jQlYbIt8fV6w1k6wgxaLd8Lac17fceav6Ss53De2cXHWXaKXvwG+
        PcmLujj1JcYVym7KRYKcgd6LXmSFVwLcc181uQu+HL2bH79fJ/j/8IG4texemuS/YEZ06tf
        9MGySk+OWmNnokjs2N0A2mnaBaM3yNFxO9K1Lypt1NP1ekspAvAq/DU0tU+MijDyblOgjfL
        J/exmieKDIM9zLDOOI=
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, w@laoqinren.net
Subject: [PATCH] timer: use raw_spin_unlock_irqrestore and raw_spin_lock_irqsave instead of raw_spin_{lock|unlock}
Date:   Thu, 20 Aug 2020 10:59:17 +0800
Message-Id: <1597892357-1349-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code in function __mod_timer(https://github.com/torvalds/linux/blob/master/kernel/time/timer.c#L961):

994		base = lock_timer_base(timer, &flags);   ----------------------(1)
		forward_timer_base(base);

		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
		    time_before_eq(timer->expires, expires)) {
			ret = 1;
			goto out_unlock;
		}

		clk = base->clk;
		idx = calc_wheel_index(expires, clk, &bucket_expiry);

		/*
		 * Retrieve and compare the array index of the pending
		 * timer. If it matches set the expiry to the new value so a
		 * subsequent call will exit in the expires check above.
		 */
		if (idx == timer_get_idx(timer)) {
			if (!(options & MOD_TIMER_REDUCE))
				timer->expires = expires;
			else if (time_after(timer->expires, expires))
				timer->expires = expires;
			ret = 1;
			goto out_unlock;
		}
	} else {
1021		base = lock_timer_base(timer, &flags); ------------------------(2)
		forward_timer_base(base);
	}

	ret = detach_if_pending(timer, base, false);
	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
		goto out_unlock;

	new_base = get_target_base(base, timer->flags);

	if (base != new_base) {
		/*
		 * We are trying to schedule the timer on the new base.
		 * However we can't change timer's base while it is running,
		 * otherwise del_timer_sync() can't detect that the timer's
		 * handler yet has not finished. This also guarantees that the
		 * timer is serialized wrt itself.
		 */
		if (likely(base->running_timer != timer)) {
			/* See the comment in lock_timer_base() */
			timer->flags |= TIMER_MIGRATING;

1042			raw_spin_unlock(&base->lock); -----------------------(3)
			base = new_base;
			raw_spin_lock(&base->lock); -------------------------(4)
			WRITE_ONCE(timer->flags,
				   (timer->flags & ~TIMER_BASEMASK) | base->cpu);
			forward_timer_base(base);
		}
	}

	debug_timer_activate(timer);

	timer->expires = expires;
	/*
	 * If 'idx' was calculated above and the base time did not advance
	 * between calculating 'idx' and possibly switching the base, only
	 * enqueue_timer() is required. Otherwise we need to (re)calculate
	 * the wheel index via internal_add_timer().
	 */
	if (idx != UINT_MAX && clk == base->clk)
		enqueue_timer(base, timer, idx, bucket_expiry);
	else
		internal_add_timer(base, timer);

out_unlock:
1066	raw_spin_unlock_irqrestore(&base->lock, flags); ---------------------(5)

	return ret;
}

The code in (1)(2) lock the base with raw_spin_lock_irqsave(&base->lock, flag),
if base != new_base,  the code in (3) unlock the old base, the code in (4) lock the
new base. at the end of the function(5), use raw_spin_unlock_irqrestore(&base->lock, flags);
to unlock the new_base.

Consider the following situation:

	CPU0					CPU1
base = lock_timer_base(timer, &flags);								(1)(2)
raw_spin_unlock(&base->lock);									(3)
base = new_base;
					raw_spin_lock(&base->lock);				(4)
					raw_spin_unlock_irqrestore(&base->lock, flags);		(5)

The flags save from CPU0, and restore to CPU1. Is this wrong?

we encountered a kernel panic, and we suspect that it is the problem. How about the following patch to fix.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a16764b..4153766 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1039,9 +1039,9 @@ static struct timer_base *lock_timer_base(struct timer_list *timer,
 			/* See the comment in lock_timer_base() */
 			timer->flags |= TIMER_MIGRATING;
 
-			raw_spin_unlock(&base->lock);
+			raw_spin_unlock_irqrestore(&base->lock, flags);
 			base = new_base;
-			raw_spin_lock(&base->lock);
+			raw_spin_lock_irqsave(&base->lock, flags);
 			WRITE_ONCE(timer->flags,
 				   (timer->flags & ~TIMER_BASEMASK) | base->cpu);
 			forward_timer_base(base);
-- 
1.8.3.1




