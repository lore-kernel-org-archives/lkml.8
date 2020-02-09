Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3027AC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E652080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBIOG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 09:06:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgBIOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 09:06:55 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j0nEb-0004VU-0y; Sun, 09 Feb 2020 15:06:53 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 931B9103086;
        Sun,  9 Feb 2020 15:06:51 +0100 (CET)
Date:   Sun, 09 Feb 2020 14:02:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] time(r) fixes for 5.6-rc1
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
Message-ID: <158125695732.26104.9630376117953711880.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-02-09

up to:  febac332a819: clocksource: Prevent double add_timer_on() for watchdog_timer


Two small fixes for the time(r) subsystem:

  - Handle a subtle race between the clocksource watchdog and a concurrent
    clocksource watchdog stop/start sequence correctly to prevent a timer
    double add bug.

  - Fix the file path for the core time namespace file.


Thanks,

	tglx

------------------>
Dmitry Safonov (1):
      MAINTAINERS: Correct path to time namespace source file

Konstantin Khlebnikov (1):
      clocksource: Prevent double add_timer_on() for watchdog_timer


 MAINTAINERS               |  2 +-
 kernel/time/clocksource.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 141b8d3e4ca2..3a4163be98da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13267,7 +13267,7 @@ S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	include/linux/time_namespace.h
-F:	kernel/time_namespace.c
+F:	kernel/time/namespace.c
 F:	kernel/time/*timer*
 
 POWER MANAGEMENT CORE
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

