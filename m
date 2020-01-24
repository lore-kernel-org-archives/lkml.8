Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74FC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6902071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OmAoAQqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgAXF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:58:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34020 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgAXF6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:58:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so582107pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 21:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLyiBXlGV6jZOd3VC8mJmKYT808UfysWbmHEUDfowZw=;
        b=OmAoAQqJiMGay1zFGW3xDqZFZslq2dz+HPYbI2l6FgkCGPKc9nbjCokWk6wGm6FFO4
         YwLAWJNDbZYiBNNAbHhIhNhmIIVHOJqHJzle/LdI6llXBzPpifdIyCZ2nj0hu0oUCCRT
         dmUzGBxmheTjrU+/89HJ47uPsJIdQzMODvcrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLyiBXlGV6jZOd3VC8mJmKYT808UfysWbmHEUDfowZw=;
        b=Fv165NFJFeTvdTtXMKOhvIjiwDQX7OVq4mMMizOHEMIJgLEu8APpn/KrOkaD3CyepA
         Xh2Ia5WvkXerRiH1qIyuQSp/gfyFc5WLKybJh+ZqSeGE6wmQFowhm78IryjM9nTA1/C3
         8lNeMgOdb0ER7uKsyA/c34j1CjZwuSOcHDrnqSkiVw4Nupsu0kcHbQ2DGC+PNOO7OR7M
         hNRL1p2aiI+LYuAmuePMk7YCuDdn0WOp0JWPuIDbXcZtHCu5sa57ubepLo0OyBdwGSJV
         lcbgCrPitRVdUzx7uZCHcnnOAqH3LqNuceKZkccjnKwO/U2yD0oIUmsrC8L+3JHOlm+t
         dncw==
X-Gm-Message-State: APjAAAVQl4e2XDnQqbipFB0MN+u9kBOE5GygTGiQlCMUqDX51qGjtyoJ
        rKTuSdFdFm6Oj5Ahjud8ZX+yLQ==
X-Google-Smtp-Source: APXvYqzoTNoTJ85qwKB6LE3upowjGSPeFb/lhh6IWaDcYCt1VXOzrehCH3K1P+qK/uI/Ok4ZV5AwBg==
X-Received: by 2002:aa7:8b17:: with SMTP id f23mr1801659pfd.197.1579845531587;
        Thu, 23 Jan 2020 21:58:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c184sm4701457pfa.39.2020.01.23.21.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 21:58:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/4] alarmtimer: Make alarmtimer platform device child of RTC device
Date:   Thu, 23 Jan 2020 21:58:46 -0800
Message-Id: <20200124055849.154411-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124055849.154411-1-swboyd@chromium.org>
References: <20200124055849.154411-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alarmtimer_suspend() function will fail if an RTC device is on a bus
such as SPI or i2c and that RTC device registers and probes after
alarmtimer_init() registers and probes the 'alarmtimer' platform device.
This is because system wide suspend suspends devices in the reverse
order of their probe. When alarmtimer_suspend() attempts to program the
RTC for a wakeup it will try to program an RTC device on a bus that has
already been suspended.

Let's move the alarmtimer device registration to be when the RTC we use
for wakeup is registered. Register the 'alarmtimer' platform device as a
child of the RTC device too, so that we can be guaranteed that the RTC
device won't be suspended when alarmtimer_suspend() is called.

Reported-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 9dc7a0913190..205365906137 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -91,6 +91,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct wakeup_source *__ws;
+	struct platform_device *pdev;
 	int ret = 0;
 
 	if (rtcdev)
@@ -102,9 +103,11 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		return -1;
 
 	__ws = wakeup_source_register(dev, "alarmtimer");
+	pdev = platform_device_register_data(dev, "alarmtimer",
+					     PLATFORM_DEVID_AUTO, NULL, 0);
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
-	if (!rtcdev) {
+	if (__ws && !IS_ERR(pdev) && !rtcdev) {
 		if (!try_module_get(rtc->owner)) {
 			ret = -1;
 			goto unlock;
@@ -115,10 +118,14 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		get_device(dev);
 		ws = __ws;
 		__ws = NULL;
+		pdev = NULL;
+	} else {
+		ret = -1;
 	}
 unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
+	platform_device_unregister(pdev);
 	wakeup_source_unregister(__ws);
 
 	return ret;
@@ -905,8 +912,7 @@ static void get_boottime_timespec(struct timespec64 *tp)
  */
 static int __init alarmtimer_init(void)
 {
-	struct platform_device *pdev;
-	int error = 0;
+	int error;
 	int i;
 
 	alarmtimer_rtc_timer_init();
@@ -931,15 +937,7 @@ static int __init alarmtimer_init(void)
 	if (error)
 		goto out_if;
 
-	pdev = platform_device_register_simple("alarmtimer", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		error = PTR_ERR(pdev);
-		goto out_drv;
-	}
 	return 0;
-
-out_drv:
-	platform_driver_unregister(&alarmtimer_driver);
 out_if:
 	alarmtimer_rtc_interface_remove();
 	return error;
-- 
Sent by a computer, using git, on the internet

