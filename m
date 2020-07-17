Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB487C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D5920717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mWMyhw3i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbZM+uXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGQUAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:00:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgGQUAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:19 -0400
Date:   Fri, 17 Jul 2020 20:00:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiCwFg3+N6w7BgpdTC3q2ig2n6Ttjqwxdvx7BMmCOTI=;
        b=mWMyhw3irWKrJQMcsJ17rI7OffZMX6rHm+NpCUknrBQ8qlyDl9t4HOkeJnj9k2wSmdpjtp
        9YuAb000ENiV/Sd/AVPRtMBUvdsE3rGzKej3DWHyBK/K5UVoUJTveF/12b91qT2dsnkiub
        BAlwSyS4NZuKEx3GwypSmkRcCV4/ojJe5UXxYh+vWjYPyae8fGdxBfZKRTWd+9IS2EeoMz
        ED9SfL9z0IZRnO5YpJQN96ccp1MwLtSvOpmQU6MoFsmvmJBCd9Y5+75i287ntAFUdwDl3r
        h8oLO4ow5PbCoC1In9QhKPCo9GxWL5LP6hYo54wQe7erl5kHTHTuwRHz84vY2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iiCwFg3+N6w7BgpdTC3q2ig2n6Ttjqwxdvx7BMmCOTI=;
        b=MbZM+uXcW+VogFrsLD+6jSpBS2HFSzALwL7bZ8YzCso2dAdpdR55TeoxlImhYMfqxCuaIH
        HhAPV8uH+yUm1ZDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Reuse next expiry cache after nohz exit
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-9-frederic@kernel.org>
References: <20200717140551.29076-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601744.4006.18407986100047143357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     90d52f65f303091be17b5f4ffab7090b2064b4a1
Gitweb:        https://git.kernel.org/tip/90d52f65f303091be17b5f4ffab7090b2064b4a1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:23 +02:00

timers: Reuse next expiry cache after nohz exit

Now that the next expiry it tracked unconditionally when a timer is added,
this information can be reused on a tick firing after exiting nohz.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-9-frederic@kernel.org

---
 kernel/time/timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 76fd964..13f48ee 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1706,13 +1706,11 @@ static int collect_expired_timers(struct timer_base *base,
 	 * the next expiring timer.
 	 */
 	if ((long)(now - base->clk) > 2) {
-		unsigned long next = __next_timer_interrupt(base);
-
 		/*
 		 * If the next timer is ahead of time forward to current
 		 * jiffies, otherwise forward to the next expiry time:
 		 */
-		if (time_after(next, now)) {
+		if (time_after(base->next_expiry, now)) {
 			/*
 			 * The call site will increment base->clk and then
 			 * terminate the expiry loop immediately.
@@ -1720,7 +1718,7 @@ static int collect_expired_timers(struct timer_base *base,
 			base->clk = now;
 			return 0;
 		}
-		base->clk = next;
+		base->clk = base->next_expiry;
 	}
 	return __collect_expired_timers(base, heads);
 }
