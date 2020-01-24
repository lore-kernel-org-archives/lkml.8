Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD13C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20372077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392090AbgAXUIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:08:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388974AbgAXUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:08:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv5FM-0000vk-Sm; Fri, 24 Jan 2020 21:08:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 04D551C1A6B;
        Fri, 24 Jan 2020 21:08:04 +0100 (CET)
Date:   Fri, 24 Jan 2020 20:08:03 -0000
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Use wakeup source from alarmtimer
 platform device
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200124055849.154411-3-swboyd@chromium.org>
References: <20200124055849.154411-3-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <157989648383.396.16394621686119561048.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7c94caca877b0feeca6f5f7b07d48c508e20d58f
Gitweb:        https://git.kernel.org/tip/7c94caca877b0feeca6f5f7b07d48c508e20d58f
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Thu, 23 Jan 2020 21:58:47 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jan 2020 21:00:21 +01:00

alarmtimer: Use wakeup source from alarmtimer platform device

Use the wakeup source that can be associated with the 'alarmtimer'
platform device instead of registering another one by hand.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200124055849.154411-3-swboyd@chromium.org

---
 kernel/time/alarmtimer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index f0469cc..685ff57 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -58,8 +58,6 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 #endif
 
 #ifdef CONFIG_RTC_CLASS
-static struct wakeup_source *ws;
-
 /* rtc timer and device for setting alarm wakeups at suspend */
 static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
@@ -88,7 +86,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 {
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
-	struct wakeup_source *__ws;
 	struct platform_device *pdev;
 	int ret = 0;
 
@@ -100,12 +97,13 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
 
-	__ws = wakeup_source_register(dev, "alarmtimer");
 	pdev = platform_device_register_data(dev, "alarmtimer",
 					     PLATFORM_DEVID_AUTO, NULL, 0);
+	if (!IS_ERR(pdev))
+		device_init_wakeup(&pdev->dev, true);
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
-	if (__ws && !IS_ERR(pdev) && !rtcdev) {
+	if (!IS_ERR(pdev) && !rtcdev) {
 		if (!try_module_get(rtc->owner)) {
 			ret = -1;
 			goto unlock;
@@ -114,8 +112,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		rtcdev = rtc;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
-		ws = __ws;
-		__ws = NULL;
 		pdev = NULL;
 	} else {
 		ret = -1;
@@ -124,7 +120,6 @@ unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	platform_device_unregister(pdev);
-	wakeup_source_unregister(__ws);
 
 	return ret;
 }
@@ -291,7 +286,7 @@ static int alarmtimer_suspend(struct device *dev)
 		return 0;
 
 	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
-		__pm_wakeup_event(ws, 2 * MSEC_PER_SEC);
+		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
 		return -EBUSY;
 	}
 
@@ -306,7 +301,7 @@ static int alarmtimer_suspend(struct device *dev)
 	/* Set alarm, if in the past reject suspend briefly to handle */
 	ret = rtc_timer_start(rtc, &rtctimer, now, 0);
 	if (ret < 0)
-		__pm_wakeup_event(ws, MSEC_PER_SEC);
+		pm_wakeup_event(dev, MSEC_PER_SEC);
 	return ret;
 }
 
