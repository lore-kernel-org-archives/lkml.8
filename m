Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E267C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E37422B4E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FglmhVtA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kg5Gea+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgGSNTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 09:19:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGSNTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 09:19:07 -0400
Date:   Sun, 19 Jul 2020 13:18:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595164746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zcUXWqBAL7fgwe4Wo/hl9Th5LvdaO0PbYOgOnP2nwxc=;
        b=FglmhVtALxvzL5AIAHqMOmq0pSAMIP5viePRCAW/raU55JkdNB4IjEPaVJy8UIxstq/n2G
        jz/8K8mdXQwBsZLzC7PJyPyzpDyVs99ofLvoF5XnnxL5uYYrw9imo1tvrob9ByfNWeQgEO
        a/cU5KhXdr1yiKclxVx3kLj39vm5kPf2/KT0JgtlQfdo6oha4r7CADo1zLIqehAL6QABQz
        Z9BPARpCzMiGnmZdPB5FgQz6WdRLGIwMObaplcWfotg67XhlFA8Q82Vyhktzlg5+H7IANY
        9KFFcPOUtoQOK51RS8XGliChgACKs+G35fVSSMsqm+BHqV4LevfVxD2jHLEROA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595164746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zcUXWqBAL7fgwe4Wo/hl9Th5LvdaO0PbYOgOnP2nwxc=;
        b=Kg5Gea+6bxNvIW0FHDvF0KmeSoCkRbtKLzgafekr3WZGg0XF1txNU3+urjCF//hOmAZalt
        ddhf5CrfuDgkGxCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.8-rc6
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
Message-ID: <159516469255.4147.9121109492857011441.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-07-19

up to:  e2a71bdea816: timer: Fix wheel index calculation on last level

Two fixes for the timer wheel:

 - A timer which is already expired at enqueue time can set the
   base->next_expiry value backwards. As a consequence base->clk can be set
   back as well. This can lead to timers expiring early. Add a sanity check
   to prevent this.

 - When a timer is queued with an expiry time beyond the wheel capacity
   then it should be queued in the bucket of the last wheel level which is
   expiring last. The code adjusts expiry time to the maximum wheel
   capacity, which is only correct when the wheel clock is 0. Aside of that
   the check whether the delta is larger than wheel capacity does not check
   the delta, it checks the expiry value itself. As a result timers can
   expire at random.

   Fix this by checking the right variable and adjust expiry time so it
   becomes base->clock plus capacity which places it into the outmost
   bucket in the last wheel level.

Thanks,

	tglx

------------------>
Frederic Weisbecker (2):
      timer: Prevent base->clk from moving backward
      timer: Fix wheel index calculation on last level


 kernel/time/timer.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 398e6eadb861..df1ff803acc4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -521,8 +521,8 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk)
 		 * Force expire obscene large timeouts to expire at the
 		 * capacity limit of the wheel.
 		 */
-		if (expires >= WHEEL_TIMEOUT_CUTOFF)
-			expires = WHEEL_TIMEOUT_MAX;
+		if (delta >= WHEEL_TIMEOUT_CUTOFF)
+			expires = clk + WHEEL_TIMEOUT_MAX;
 
 		idx = calc_index(expires, LVL_DEPTH - 1);
 	}
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
 

