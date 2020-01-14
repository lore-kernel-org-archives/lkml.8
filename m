Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F9C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CFB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXln9CA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgANDUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:20:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44960 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgANDUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:20:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so5857580pfw.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 19:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7enSy5yO1zc4/x2iYCSBodO+b8I86GUmPZZYkYcYuc=;
        b=eXln9CA87x/wuqSwIxtYr70UNROQAt9tSzRpy3wIkz2NLnZ/8XG7mu9tQPA7VxruIt
         +BOiGYB3r5gAGM/TnOsSijWHjfnoioBHZpe2RvMjVqjco/HLUoYJOWddUBxFcWmNlm8u
         m4bPMbta+LGC58d1rE3L8+EGdcrzhAAQvlMd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7enSy5yO1zc4/x2iYCSBodO+b8I86GUmPZZYkYcYuc=;
        b=lJFRcdL5L6Js/jT/xgL3qBlv9rLK8EXmEWE9ngQ42pX+r7sfuXL/V2dXOvGd49ZOoB
         tOHEpsjaF4bhQ/UIKn7LkCVNEPvArqwUA+GJDvnd1+Iawhg05QOsWg9brfoyEoGtkAhx
         fOMyCkGq7uBvFV2UDT6HdSw2U4nxYKfRMY2kbCAtqKkzIKzZczAGMFdY5tRD1TSstYCX
         shtNHfljzzPk2ekIUG4fNkrnea0O/YIs28WBYL9GD/OXa1FZYuVxl5IvYSMH2q1FEUxv
         ibF3JDfPVagW8Lz9tIpRBk+YNMnATfEnS1UOdrYyvevNgMQJ2RTL/TRqsPyEK8aJEQ7N
         JIsw==
X-Gm-Message-State: APjAAAXhqp0TQ3c7WZcbWo062aF7aiWohvALAdlfaFOotdfbRqP/tz62
        CeBJQXsYEA/QtfH9W+BVP7cAcw==
X-Google-Smtp-Source: APXvYqw9p7Iq+if/ytw+UkFAZGHx6AD/YoVLUvEQ0B5i0wEa15dgGeoHywTCUETGiVe/urexMAyl4A==
X-Received: by 2002:a62:3304:: with SMTP id z4mr21979359pfz.79.1578972006474;
        Mon, 13 Jan 2020 19:20:06 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u10sm15183545pgg.41.2020.01.13.19.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 19:20:06 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v5 2/2] mfd: cros_ec: Add cros-usbpd-notify subdevice
Date:   Mon, 13 Jan 2020 19:10:58 -0800
Message-Id: <20200114031056.44502-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200114031056.44502-1-pmalani@chromium.org>
References: <20200114031056.44502-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cros-usbpd-notify driver as a subdevice on platforms that
support the EC_FEATURE_USB_PD EC feature flag and don't have the
ACPI PD notification device defined.

This driver allows other cros-ec devices to receive PD event
notifications from the Chrome OS Embedded Controller (EC) via a
notification chain.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v5:
- Updated the IS_ENABLED() check to check for CONFIG_OF instead of
  !CONFIG_ACPI according to upstream comments.

Changes in v4:
- Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
  mfd_cell and used an IS_ENABLED() check.
- Changed commit title and description slightly to reflect change in
  code.

 drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index c4b977a5dd966..d0c28a4c10ad0 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014 Google, Inc.
  */
 
+#include <linux/kconfig.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
@@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-logger", },
 };
 
+static const struct mfd_cell cros_usbpd_notify_cells[] = {
+	{ .name = "cros-usbpd-notify", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -202,6 +207,23 @@ static int ec_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * The PD notifier driver cell is separate since it only needs to be
+	 * explicitly added on platforms that don't have the PD notifier ACPI
+	 * device entry defined.
+	 */
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
+			retval = mfd_add_hotplug_devices(ec->dev,
+					cros_usbpd_notify_cells,
+					ARRAY_SIZE(cros_usbpd_notify_cells));
+			if (retval)
+				dev_err(ec->dev,
+					"failed to add PD notify devices: %d\n",
+					retval);
+		}
+	}
+
 	/*
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
-- 
2.25.0.rc1.283.g88dfdc4193-goog

