Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DCC2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDv4bmHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVAkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:40:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37637 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgAVAkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:40:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so2398440pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BBSxtGHIbXzhpvJQJhx+ULuaAqaVvZcH07s9K+0+F0=;
        b=fDv4bmHhy/yji8DGLiIZCc6r9lO7wYGKXo/kc80t6JrCGcJVvP2oLrDAIntpW1Vbvm
         trZKH0BhX7JlB3VuFHWIwpYzeynMvIVdGNaSlx+a01Nh2Tp6lLorSOUFantkOmwfBpdP
         CN3ezMjBAOuMw35ohJLGhyYyRXo5psRjvgIJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BBSxtGHIbXzhpvJQJhx+ULuaAqaVvZcH07s9K+0+F0=;
        b=KMAtt4SsYTHxeNSxZjTRMFohpXM2FxzKi2QbYfwfIzsFZ9b4lJmGeWLRGT/eQeNoy8
         YF4Tu6+xNm/XbhJ3G0/IredqQledxu9469e0GWmYMXnfSKVMUiIyYXu/q6mqcYWu/ZX8
         O+c54992pjPSx7JFQq1LQ+lrpCxBwm8IM0VB6FE1zmEiJRcK6t8tz0SwZiDvIDb9wdty
         nmEUGNQ7J9R8MG4LFjQMTn8qF4yScsAyOKJa7Ahy37dXSWsvSc+hoSgXudjEXNreP+2a
         wNM7CwExkqDrXYJ1Xl8VGzQZHyWrUR8bdxN4m3d2axfxKpaXxU/iPPrgThA2HJGkmV7Y
         vufw==
X-Gm-Message-State: APjAAAVQiIuucvDPaYk+f9H9Q+Ndwl4akJEhp51+CSVHc9YoiY6T6UQX
        Z+e3xGyCsEPncTThYwHGM68I2g==
X-Google-Smtp-Source: APXvYqw5jL/D6Cjm8N0YJE15lZdhSvgnjwXvJMcQ/CKZOuDDeBUqnhINSkNteeK0aCj4dh4cKuglAg==
X-Received: by 2002:a63:e513:: with SMTP id r19mr8429361pgh.326.1579653634279;
        Tue, 21 Jan 2020 16:40:34 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w5sm42094531pgb.78.2020.01.21.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 16:40:33 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Nick Crews <ncrews@chromium.org>,
        Daniel Campello <campello@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Add newlines to printks
Date:   Tue, 21 Jan 2020 16:40:32 -0800
Message-Id: <20200122004032.65008-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk messages all require newlines, or it looks very odd in the log
when messages are not on different lines. Add them.

Cc: Nick Crews <ncrews@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/wilco_ec/core.c          | 2 +-
 drivers/platform/chrome/wilco_ec/keyboard_leds.c | 8 ++++----
 drivers/platform/chrome/wilco_ec/mailbox.c       | 4 ++--
 drivers/platform/chrome/wilco_ec/telemetry.c     | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 2d5f027d8770..5b42992bff38 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -94,7 +94,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
 
 	ret = wilco_ec_add_sysfs(ec);
 	if (ret < 0) {
-		dev_err(dev, "Failed to create sysfs entries: %d", ret);
+		dev_err(dev, "Failed to create sysfs entries: %d\n", ret);
 		goto unregister_rtc;
 	}
 
diff --git a/drivers/platform/chrome/wilco_ec/keyboard_leds.c b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
index 5731d1b60e28..6ce9c6782065 100644
--- a/drivers/platform/chrome/wilco_ec/keyboard_leds.c
+++ b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
@@ -69,7 +69,7 @@ static int send_kbbl_msg(struct wilco_ec_device *ec,
 	ret = wilco_ec_mailbox(ec, &msg);
 	if (ret < 0) {
 		dev_err(ec->dev,
-			"Failed sending keyboard LEDs command: %d", ret);
+			"Failed sending keyboard LEDs command: %d\n", ret);
 		return ret;
 	}
 
@@ -94,7 +94,7 @@ static int set_kbbl(struct wilco_ec_device *ec, enum led_brightness brightness)
 
 	if (response.status) {
 		dev_err(ec->dev,
-			"EC reported failure sending keyboard LEDs command: %d",
+			"EC reported failure sending keyboard LEDs command: %d\n",
 			response.status);
 		return -EIO;
 	}
@@ -147,7 +147,7 @@ static int kbbl_init(struct wilco_ec_device *ec)
 
 	if (response.status) {
 		dev_err(ec->dev,
-			"EC reported failure sending keyboard LEDs command: %d",
+			"EC reported failure sending keyboard LEDs command: %d\n",
 			response.status);
 		return -EIO;
 	}
@@ -179,7 +179,7 @@ int wilco_keyboard_leds_init(struct wilco_ec_device *ec)
 	ret = kbbl_exist(ec, &leds_exist);
 	if (ret < 0) {
 		dev_err(ec->dev,
-			"Failed checking keyboard LEDs support: %d", ret);
+			"Failed checking keyboard LEDs support: %d\n", ret);
 		return ret;
 	}
 	if (!leds_exist)
diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index ced1f9f3dcee..0f98358ea824 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -163,13 +163,13 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
 	}
 
 	if (rs->data_size != EC_MAILBOX_DATA_SIZE) {
-		dev_dbg(ec->dev, "unexpected packet size (%u != %u)",
+		dev_dbg(ec->dev, "unexpected packet size (%u != %u)\n",
 			rs->data_size, EC_MAILBOX_DATA_SIZE);
 		return -EMSGSIZE;
 	}
 
 	if (rs->data_size < msg->response_size) {
-		dev_dbg(ec->dev, "EC didn't return enough data (%u < %zu)",
+		dev_dbg(ec->dev, "EC didn't return enough data (%u < %zu)\n",
 			rs->data_size, msg->response_size);
 		return -EMSGSIZE;
 	}
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 1176d543191a..e06d96fb9426 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -367,7 +367,7 @@ static int telem_device_probe(struct platform_device *pdev)
 	minor = ida_alloc_max(&telem_ida, TELEM_MAX_DEV-1, GFP_KERNEL);
 	if (minor < 0) {
 		error = minor;
-		dev_err(&pdev->dev, "Failed to find minor number: %d", error);
+		dev_err(&pdev->dev, "Failed to find minor number: %d\n", error);
 		return error;
 	}
 
@@ -427,14 +427,14 @@ static int __init telem_module_init(void)
 
 	ret = class_register(&telem_class);
 	if (ret) {
-		pr_err(DRV_NAME ": Failed registering class: %d", ret);
+		pr_err(DRV_NAME ": Failed registering class: %d\n", ret);
 		return ret;
 	}
 
 	/* Request the kernel for device numbers, starting with minor=0 */
 	ret = alloc_chrdev_region(&dev_num, 0, TELEM_MAX_DEV, TELEM_DEV_NAME);
 	if (ret) {
-		pr_err(DRV_NAME ": Failed allocating dev numbers: %d", ret);
+		pr_err(DRV_NAME ": Failed allocating dev numbers: %d\n", ret);
 		goto destroy_class;
 	}
 	telem_major = MAJOR(dev_num);
-- 
Sent by a computer, using git, on the internet

