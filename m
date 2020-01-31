Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D19C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E2E206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="j0zR+NYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgAaQJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:09:04 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35184 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729138AbgAaQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:09:03 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id D0ED82E0DE7;
        Fri, 31 Jan 2020 19:08:59 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id DeVJb1ljZs-8x3iNtbA;
        Fri, 31 Jan 2020 19:08:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580486939; bh=1aXLT5+SB/bptNKZjWrCoUNjRiU5JKNMQljh6/ZDiZg=;
        h=Message-ID:Date:To:From:Subject;
        b=j0zR+NYAvo8uz4XMmqY24v0RRVslqWZ9uba/9qhqxtGnZcfCmW/l25rCkW2iYQPRx
         0D2m7vi7eaZm9mc849fbP4vxqjZ0xjiVKQOe364wUbCF5hRIXmKzxa7lKKWHvcKPBe
         WXenWty/RcXii9IqV7gEKV5u7e0r0Ox/PxKLRYag=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id H9uLvClZpc-8xXCGoQc;
        Fri, 31 Jan 2020 19:08:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] clocksource: fix double add_timer_on() for watchdog_timer
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 31 Jan 2020 19:08:59 +0300
Message-ID: <158048693917.4378.13823603769948933793.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've got couple reports about kernel 4.19 crashes inside QEMU/KVM:

kernel BUG at kernel/time/timer.c:1154!
BUG_ON(timer_pending(timer) || !timer->function) in add_timer_on().

At the same time another cpu got:
general protection fault: 0000 [#1] SMP PTI
of poinson pointer 0xdead000000000200 in:

__hlist_del at include/linux/list.h:681
(inlined by) detach_timer at kernel/time/timer.c:818
(inlined by) expire_timers at kernel/time/timer.c:1355
(inlined by) __run_timers at kernel/time/timer.c:1686
(inlined by) run_timer_softirq at kernel/time/timer.c:1699

Unfortunately kernel logs are badly scrambled, stacktraces are lost.

Printing timer->function before BUG_ON pointed to clocksource_watchdog().

It looks execution of clocksource_watchdog() theoretically could race with
pair clocksource_stop_watchdog() .. clocksource_start_watchdog():

expire_timers()
 detach_timer(timer, true);
  timer->entry.pprev = NULL;
 raw_spin_unlock_irq(&base->lock);
 call_timer_fn
  clocksource_watchdog()

					clocksource_watchdog_kthread() or
					clocksource_unbind()

					spin_lock_irqsave(&watchdog_lock, flags);
					clocksource_stop_watchdog();
					 del_timer(&watchdog_timer);
					 watchdog_running = 0;
					spin_unlock_irqrestore(&watchdog_lock, flags);

					spin_lock_irqsave(&watchdog_lock, flags);
					clocksource_start_watchdog();
					 add_timer_on(&watchdog_timer, ...);
					 watchdog_running = 1;
					spin_unlock_irqrestore(&watchdog_lock, flags);

  spin_lock(&watchdog_lock);
  add_timer_on(&watchdog_timer, ...);
   BUG_ON(timer_pending(timer) || !timer->function);
    timer_pending() -> true
    BUG()

I.e. inside clocksource_watchdog() watchdog_timer could be already armed.

This patch simply checks timer_pending() before calling add_timer_on().
All operations are synchronized by watchdog_lock.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/time/clocksource.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index fff5f64981c6..428beb69426a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -293,8 +293,15 @@ static void clocksource_watchdog(struct timer_list *unused)
 	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
 	if (next_cpu >= nr_cpu_ids)
 		next_cpu = cpumask_first(cpu_online_mask);
-	watchdog_timer.expires += WATCHDOG_INTERVAL;
-	add_timer_on(&watchdog_timer, next_cpu);
+
+	/*
+	 * Arm timer if not already pending: could race with concurrent
+	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
+	 */
+	if (!timer_pending(&watchdog_timer)) {
+		watchdog_timer.expires += WATCHDOG_INTERVAL;
+		add_timer_on(&watchdog_timer, next_cpu);
+	}
 out:
 	spin_unlock(&watchdog_lock);
 }

