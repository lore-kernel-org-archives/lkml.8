Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F2C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC4720719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhJGWj51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgCPI3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:29:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgCPI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:29:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so9509007pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XoP+srWl8SMi8ME7E8J0z0jrymSLuVtgaOt9BSrS2Lo=;
        b=dhJGWj51/N03rIS4wKXDNhmOaM6UnPNG+Wt85ubeB/ZOH5dRqtuUyiQs/6n2wtiJwX
         ERYQv500bcuY1KRY/kZ7MDUd4so7EA8roFaON4zK7a3gCVBeDJqqOsn+PHIGBBF+1ZaB
         ivlGdCprgn4GD6oLgKHaE9Na8sGF0ScEzVKCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XoP+srWl8SMi8ME7E8J0z0jrymSLuVtgaOt9BSrS2Lo=;
        b=D7G5D1+/cAkx7SFMvqEhHMqnrVItQ08MWzrl8kFY7ZFCZcCUrmInt3IcCokGgKIKfp
         R30yIv6FgGUSgC0JJcPVun5j3433mKXtepJAVsDlBsuAv6K8/JOHLSfmkLQU1XD4jsIZ
         I6Ek45cpCPgjxqzyNqN7i9RN5USheloEeMTFD0/0aiH+lbssswfNreQtQ0auiYRLc7pC
         TUGgwT8txNu2keJPage2l8/ZFN3sQVvpv07hUqgv8vWRp0a74C9Wq6fYg2TCWDyrJJnl
         RU1Ughqnal+OpJf6OaWPC1LiEK+KiKCI+j4vU6d5JtIPs7UupgGIXXXqRIsTMXpknhOq
         R88g==
X-Gm-Message-State: ANhLgQ03wo0hImJrfLLvI706atfMw8OW5kHwQgZaBNq2Qr1UgFfH0LaN
        dCIetrNtLz25ObHi9MHmfKQaFhHhY+w=
X-Google-Smtp-Source: ADFU+vuJqSwUwdlKcFpaH4S+Us2miDxu7scOYcj24greW1Pyf8QOtTKxg57OaSxEykYWly4qZ2+1rA==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr26720634pfm.149.1584347342528;
        Mon, 16 Mar 2020 01:29:02 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p8sm7867846pff.26.2020.03.16.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:29:02 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 2/3] platform/chrome: notify: Amend ACPI driver to plat
Date:   Mon, 16 Mar 2020 01:28:32 -0700
Message-Id: <20200316082831.242516-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316082831.242516-1-pmalani@chromium.org>
References: <20200316082831.242516-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ACPI driver into the equivalent platform driver, with the
same ACPI match table as before. This allows the device driver to access
the parent platform EC device and its cros_ec_device struct, which will
be required to communicate with the EC to pull PD Host event information
from it.

Also change the ACPI driver name to "cros-usbpd-notify-acpi" so that
there is no confusion between it and the "regular" platform driver on
platforms that have both CONFIG_ACPI and CONFIG_OF enabled.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Removed unrequired adev pointer checks, and a dev_info print.

 drivers/platform/chrome/cros_usbpd_notify.c | 71 +++++++++++++++++----
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 99cc245354ae7..5507d93c0ce7b 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 
 #define DRV_NAME "cros-usbpd-notify"
+#define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
 #define ACPI_DRV_NAME "GOOG0003"
 
 static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
@@ -54,14 +55,61 @@ EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
 
 #ifdef CONFIG_ACPI
 
-static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
+static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
 {
+	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
+}
+
+static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
+{
+	struct cros_usbpd_notify_data *pdnotify;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	struct cros_ec_device *ec_dev;
+	acpi_status status;
+
+	adev = ACPI_COMPANION(dev);
+
+	pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
+	if (!pdnotify)
+		return -ENOMEM;
+
+	/* Get the EC device pointer needed to talk to the EC. */
+	ec_dev = dev_get_drvdata(dev->parent);
+	if (!ec_dev) {
+		/*
+		 * We continue even for older devices which don't have the
+		 * correct device heirarchy, namely, GOOG0003 is a child
+		 * of GOOG0004.
+		 */
+		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
+	}
+
+	pdnotify->dev = dev;
+	pdnotify->ec = ec_dev;
+
+	status = acpi_install_notify_handler(adev->handle,
+					     ACPI_ALL_NOTIFY,
+					     cros_usbpd_notify_acpi,
+					     pdnotify);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "Failed to register notify handler %08x\n",
+			 status);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
+static int cros_usbpd_notify_remove_acpi(struct platform_device *pdev)
 {
-	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
+				   cros_usbpd_notify_acpi);
+
+	return 0;
 }
 
 static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
@@ -70,14 +118,13 @@ static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
 
-static struct acpi_driver cros_usbpd_notify_acpi_driver = {
-	.name = DRV_NAME,
-	.class = DRV_NAME,
-	.ids = cros_usbpd_notify_acpi_device_ids,
-	.ops = {
-		.add = cros_usbpd_notify_add_acpi,
-		.notify = cros_usbpd_notify_acpi,
+static struct platform_driver cros_usbpd_notify_acpi_driver = {
+	.driver = {
+		.name = DRV_NAME_PLAT_ACPI,
+		.acpi_match_table = cros_usbpd_notify_acpi_device_ids,
 	},
+	.probe = cros_usbpd_notify_probe_acpi,
+	.remove = cros_usbpd_notify_remove_acpi,
 };
 
 #endif /* CONFIG_ACPI */
@@ -157,7 +204,7 @@ static int __init cros_usbpd_notify_init(void)
 		return ret;
 
 #ifdef CONFIG_ACPI
-	acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
+	platform_driver_register(&cros_usbpd_notify_acpi_driver);
 #endif
 	return 0;
 }
@@ -165,7 +212,7 @@ static int __init cros_usbpd_notify_init(void)
 static void __exit cros_usbpd_notify_exit(void)
 {
 #ifdef CONFIG_ACPI
-	acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
+	platform_driver_unregister(&cros_usbpd_notify_acpi_driver);
 #endif
 	platform_driver_unregister(&cros_usbpd_notify_plat_driver);
 }
-- 
2.25.1.481.gfbce0eb801-goog

