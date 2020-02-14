Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E57C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5220637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700918;
	bh=1cIvgbQumL/bZuCtORG9WNL/02NREKUgNOvzr9i7L+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yI08iTWpmmI2lN0cCKX0l0OUVPyHO2Nu6Bk8xzk+mWPz4QThkZMlaKoMJ3wKbQlHg
	 kGRlYOfo5QKn1ML93yY0MfbRCfjmBupaSJ4JrKoi+fHvZqNaZTAUgnFqMi2MTsB7jL
	 lRV3TOegCYRAmahXLaktDT8ZNgNDHRKVnl4faVIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbgBNRV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391434AbgBNQKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC2F222C2;
        Fri, 14 Feb 2020 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696613;
        bh=1cIvgbQumL/bZuCtORG9WNL/02NREKUgNOvzr9i7L+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePwXe+Aqo+rGoLg5vMIyNDk6RS9LHORs255TIJRksS0fxvnfDximFTDFSGXDzF6r6
         bmK3KyKpp7mu9Hg4ssEWEoiVdOoDGlSMxqukBngSqGqv0PaJdkxntOQr6zs/FMgJ3v
         TBBZhO6LPZ+Qse4abRNkPPj+HErt2vIDUxgJvXrA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 396/459] alarmtimer: Make alarmtimer platform device child of RTC device
Date:   Fri, 14 Feb 2020 11:00:46 -0500
Message-Id: <20200214160149.11681-396-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit c79108bd19a8490315847e0c95ac6526fcd8e770 ]

The alarmtimer_suspend() function will fail if an RTC device is on a bus
such as SPI or i2c and that RTC device registers and probes after
alarmtimer_init() registers and probes the 'alarmtimer' platform device.

This is because system wide suspend suspends devices in the reverse order
of their probe. When alarmtimer_suspend() attempts to program the RTC for a
wakeup it will try to program an RTC device on a bus that has already been
suspended.

Move the alarmtimer device registration to happen when the RTC which is
used for wakeup is registered. Register the 'alarmtimer' platform device as
a child of the RTC device too, so that it can be guaranteed that the RTC
device won't be suspended when alarmtimer_suspend() is called.

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200124055849.154411-2-swboyd@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/alarmtimer.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4b11f0309eee4..b97401f6bc232 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct wakeup_source *__ws;
+	struct platform_device *pdev;
 	int ret = 0;
 
 	if (rtcdev)
@@ -99,9 +100,11 @@ static int alarmtimer_rtc_add_device(struct device *dev,
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
@@ -112,10 +115,14 @@ static int alarmtimer_rtc_add_device(struct device *dev,
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
@@ -876,8 +883,7 @@ static struct platform_driver alarmtimer_driver = {
  */
 static int __init alarmtimer_init(void)
 {
-	struct platform_device *pdev;
-	int error = 0;
+	int error;
 	int i;
 
 	alarmtimer_rtc_timer_init();
@@ -900,15 +906,7 @@ static int __init alarmtimer_init(void)
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
2.20.1

