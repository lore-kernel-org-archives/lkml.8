Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82904C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558AD20691
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ER54Yj70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCLKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:09:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40108 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgCLKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:09:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2472072plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOawryaekQdt/6wC3VrzJls1AgZnMvJZzYIVarTMw9w=;
        b=ER54Yj708eBJr1UIOQpz0gSoHr88nxZLY3J8wERN3dY3cDijbWAeZnrKhjvpdMeJVi
         ch2SURMCNmFBhzSOHzOvIBoBy0Qvqm6etaARAY4HPlVSzTNtJJ//V2avJSRXc2EvnGlm
         qKg6gDG+ywDyeBEpfoYO9wCmowsxKMFWs8vZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOawryaekQdt/6wC3VrzJls1AgZnMvJZzYIVarTMw9w=;
        b=iKi1RKGSBCpelKt83pFZIW8CEOl5k+WNrlpjmnwgj0KZF3FZVg6OYekuS50pCwKno6
         Q2Ulsc7hMs7/hbELz/7b2C0xlXC0eprxmy4EwvIlTaX5izsBnCSf546tRnlgH6dZiLOz
         rdcUb21JPIiXxjxfDV6Yp9rCkIfgRkRaIJ9I3xh+69FSWhHrhL7sNWYPzc18on2bS/mK
         KII5UzGkq00AChBozgjIyy3CAyjre4nGNCtIGu4c+0Qss4gXYVeqcf3BQVX1rAQ+1vdm
         9AhWJhmQHNG8dmgGjmMgxy/nuAlczEWYS3Een8kvVbY+CQvfDdGPFx5sOZ51WqgqGoas
         JXIg==
X-Gm-Message-State: ANhLgQ1CnNiWpA+LHxGg+F8tAkkglm/WEgihgBQuMKuRmgGkzgC1y4V/
        uQixCo95WpK9eA19knUd/KzF+tMCZ2Y=
X-Google-Smtp-Source: ADFU+vuxTDWU2V6eGLEOMhp0LtGwajE8+j0R0cKpyWJuRub5GgM10OJEMmHyhpMll95mmNQKy5yKaA==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr3315074pjb.113.1584007749205;
        Thu, 12 Mar 2020 03:09:09 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s19sm3678368pfh.218.2020.03.12.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:09:08 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/3] platform/chrome: notify: Amend ACPI driver to plat
Date:   Thu, 12 Mar 2020 03:08:09 -0700
Message-Id: <20200312100809.21153-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200312100809.21153-1-pmalani@chromium.org>
References: <20200312100809.21153-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_usbpd_notify.c | 82 ++++++++++++++++++---
 1 file changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index edcb346024b07..d2dbf7017e29c 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 
 #define DRV_NAME "cros-usbpd-notify"
+#define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
 #define ACPI_DRV_NAME "GOOG0003"
 
 static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
@@ -54,14 +55,72 @@ EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
 
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
+	if (!adev) {
+		dev_err(dev, "No ACPI device found.\n");
+		return -ENODEV;
+	}
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
+	dev_info(dev, "Chrome EC PD notify device registered.\n");
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
+	if (!adev) {
+		dev_err(dev, "No ACPI device found.\n");
+		return -ENODEV;
+	}
+
+	acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
+				   cros_usbpd_notify_acpi);
+
+	return 0;
 }
 
 static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
@@ -70,14 +129,13 @@ static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
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
@@ -159,7 +217,7 @@ static int __init cros_usbpd_notify_init(void)
 		return ret;
 
 #ifdef CONFIG_ACPI
-	acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
+	platform_driver_register(&cros_usbpd_notify_acpi_driver);
 #endif
 	return 0;
 }
@@ -167,7 +225,7 @@ static int __init cros_usbpd_notify_init(void)
 static void __exit cros_usbpd_notify_exit(void)
 {
 #ifdef CONFIG_ACPI
-	acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
+	platform_driver_unregister(&cros_usbpd_notify_acpi_driver);
 #endif
 	platform_driver_unregister(&cros_usbpd_notify_plat_driver);
 }
-- 
2.25.1.696.g5e7596f4ac-goog

