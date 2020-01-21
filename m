Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C22C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6392924656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="keJv9mvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAUTsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:48:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45967 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgAUTsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:48:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so2039297pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPH/l+8hw3X+2SRweCDGnoCi5kFG7zbW84SQPOKqJsY=;
        b=keJv9mvAwwIZ8NG2BLIt6H8OJALqAkODzWi7AiT8rlYzH57fO2hTcszd+rhVZfMl6p
         GILvVsdgmRLxD1Y+hbG88HNhtRFwmAaeFWidQGNE7jVyO6nqmMchL/Ph6Id+2SOOkBLL
         0D5Xo/JQJu7TGxuJ5w1k/VFiRIWaUzY8TeApU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPH/l+8hw3X+2SRweCDGnoCi5kFG7zbW84SQPOKqJsY=;
        b=Q50GA3hki/8O/mJeNJVNWgAzl4nep2mTpsh5jgBFpD49AamWPaeqrMjUyrdqUHqz0B
         wrOAnu3NCQ6GXu+HrahoTdUxRExDyj6hib2H7JU/xkdKPwnvJ9zgxeOU3Gjj1L+eL9D0
         YPl65QOATXCNz/A0Xl0oXEG2WA4V3NSHzm94sHYX+aB5NkE+Hi60at1lnOEet5kxjvB+
         gloCXIVk7zaHuNkzmw+ZbRARUewqgjLhlWRlsJ7Vt4sR1+zj8fQNm3lGQBv9gpU8ow0H
         Jy6dJhjSuqm9d7y0ha595E01Rz+jkhvoLBPMXINfnd3ngm0HQDKfK8CSQ+JZPZIh/D0z
         smvg==
X-Gm-Message-State: APjAAAXn+lXepQ/smS+3pYiwEtWygsUskFZlDDl6yEIVBxrbpK77JWYN
        G8wKX2p3zQQ0LabGttLk9Lopqw==
X-Google-Smtp-Source: APXvYqyVRukVLGNYxmN37P+dHCtO3bKNTDxAuXyZDJz8aRlJp5SsX7Pb3cp71XwTHZTdI6GEo59cqQ==
X-Received: by 2002:a62:6342:: with SMTP id x63mr5996631pfb.103.1579636094112;
        Tue, 21 Jan 2020 11:48:14 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u7sm44004674pfh.128.2020.01.21.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 11:48:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 2/3] alarmtimer: Use wakeup source from alarmtimer platform device
Date:   Tue, 21 Jan 2020 11:48:10 -0800
Message-Id: <20200121194811.145644-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200121194811.145644-1-swboyd@chromium.org>
References: <20200121194811.145644-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wakeup source that can be associated with the 'alarmtimer'
platform device instead of registering another one by hand.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index e1a863b5c0bf..0c9e97054da8 100644
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
@@ -90,7 +88,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 {
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
-	struct wakeup_source *__ws;
 	struct platform_device *pdev;
 	int ret = 0;
 
@@ -102,12 +99,13 @@ static int alarmtimer_rtc_add_device(struct device *dev,
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
@@ -116,8 +114,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		rtcdev = rtc;
 		/* hold a reference so it doesn't go away */
 		get_device(dev);
-		ws = __ws;
-		__ws = NULL;
 		pdev = NULL;
 	} else {
 		ret = - 1;
@@ -126,7 +122,6 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	platform_device_unregister(pdev);
-	wakeup_source_unregister(__ws);
 
 	return ret;
 }
@@ -293,7 +288,7 @@ static int alarmtimer_suspend(struct device *dev)
 		return 0;
 
 	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
-		__pm_wakeup_event(ws, 2 * MSEC_PER_SEC);
+		pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
 		return -EBUSY;
 	}
 
@@ -308,7 +303,7 @@ static int alarmtimer_suspend(struct device *dev)
 	/* Set alarm, if in the past reject suspend briefly to handle */
 	ret = rtc_timer_start(rtc, &rtctimer, now, 0);
 	if (ret < 0)
-		__pm_wakeup_event(ws, MSEC_PER_SEC);
+		pm_wakeup_event(dev, MSEC_PER_SEC);
 	return ret;
 }
 
-- 
Sent by a computer, using git, on the internet

