Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB0BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F28E20724
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGBFpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:45:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60773 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGBFpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:45:09 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jqs1y-0005Ov-3f; Thu, 02 Jul 2020 05:45:06 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     anthony.wong@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] leds: core: Flush scheduled work for system suspend
Date:   Thu,  2 Jul 2020 13:45:00 +0800
Message-Id: <20200702054500.11251-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes LED won't be turned off by LED_CORE_SUSPENDRESUME flag upon
system suspend.

led_set_brightness_nopm() uses schedule_work() to set LED brightness.
However, there's no guarantee that the scheduled work gets executed
because no one flushes the work.

So flush the scheduled work to make sure LED gets turned off.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use flush_work() instead.

 drivers/leds/led-class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3363a6551a70..cc3929f858b6 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -173,6 +173,7 @@ void led_classdev_suspend(struct led_classdev *led_cdev)
 {
 	led_cdev->flags |= LED_SUSPENDED;
 	led_set_brightness_nopm(led_cdev, 0);
+	flush_work(&led_cdev->set_brightness_work);
 }
 EXPORT_SYMBOL_GPL(led_classdev_suspend);
 
-- 
2.17.1

