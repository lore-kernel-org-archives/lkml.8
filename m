Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827722071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWNDqXpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgAXF66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:58:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37251 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgAXF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:58:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so334597plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 21:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfbjFWjKlyIUWbTzmu548CXTUA2naK3rPF6VrU9QECo=;
        b=SWNDqXpiydsIjYofBcIHPxHKNTZBP/kobtQR4FzmUg3oVjDMwwXuQa+6HXNuyuKPuN
         PJOcmdOvObPWPEQ6vfH0cKYF/KvBf8WE6+Wfus2zWzonF2v+FlPER7mupABE84jAz3vb
         hns7p4SB42f3wNXgBEv9IS8sRCWEqM85/UIFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfbjFWjKlyIUWbTzmu548CXTUA2naK3rPF6VrU9QECo=;
        b=M1MeDWoEnwynXwEZMXlF2HycWV2p60pQQ2RW3OSzS0msbfwf7lligJ9/kKRgkM1j8e
         1zo1q10VAq5Z8xD9+8B6THmyO7XET7FLzm62Z5B3bM/AqBdGmFDo7bGtq0RIaixLLhfK
         21tH5qgwlpDYc8/8sXeerPFR668n1hQJKghB9aiDsO6DhooL1W0bNz/ZzXFyaw3ZRiYO
         9tfMr+CI9EecrG9/Pu2XYfBbwN+fC0y1w20gkEkrqQ7e9MlLtMh14z4E2tbviSSoriG2
         QBPN75sM1/FYadDUa6pmVZRm+KxkDwOyASeqkmd03YMAUJ0XnKXbij0464a5Uxw2HWHr
         Kg0A==
X-Gm-Message-State: APjAAAXkC8k4R+R03G+nTATtlIdSb4gIa+6sblhAfxVrZn1I0q9F9GUc
        fLPwdX7kPk+hrCfVjBuGOa/wbA==
X-Google-Smtp-Source: APXvYqw2OCgTdjemsJV6244ktkN9DbdxBu4iw/OlHW0uOJuGzZCAoxYcwiGGlm5uiFLCJgzAomn/UQ==
X-Received: by 2002:a17:90a:6545:: with SMTP id f5mr1570794pjs.42.1579845532469;
        Thu, 23 Jan 2020 21:58:52 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c184sm4701457pfa.39.2020.01.23.21.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 21:58:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 2/4] alarmtimer: Use wakeup source from alarmtimer platform device
Date:   Thu, 23 Jan 2020 21:58:47 -0800
Message-Id: <20200124055849.154411-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124055849.154411-1-swboyd@chromium.org>
References: <20200124055849.154411-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the wakeup source that can be associated with the 'alarmtimer'
platform device instead of registering another one by hand.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 205365906137..395d4a6db1b2 100644
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
 		ret = -1;
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

