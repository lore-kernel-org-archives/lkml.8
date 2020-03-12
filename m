Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE42C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D014206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEjO029K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCLKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:08:54 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40795 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgCLKIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:08:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id bo3so1029342pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8E8mxYa+FriY8pXwclk7Z4PHwuu7BcZPDLi6RwEnzM=;
        b=NEjO029KDoNC0Djn9JLlduUyHNI/KlEErqnveh/nw3UnVMY2joEsYy9TsjkDmbbuXB
         LhyPtddDN8ulwoA0xDDfiQKA/aF/edCsyWsQuc7oW1ZYVaz/yXc4T+WZzeDXgvVLbPtC
         JrUqvD2+bR5LUVrhCz7HNvhpmh3QnBcCHmSHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8E8mxYa+FriY8pXwclk7Z4PHwuu7BcZPDLi6RwEnzM=;
        b=D4oUrX/QZfc9ulqyisg3URk5tMRMY4cVR0jQMvBvxBcb8elbjQZ8V3HENSCbBKxrfc
         59sAF14NsglqLq2APg9zAhPZ6Sqg1Lg/BNKuJmGwzapG8wNCPUyGi8rbb66JgfevVCbK
         L4+P0DflXEtlEty7xY3IZKbCDd2J7C4Ed0jnQp8KYdcAccJm25AnGoNMBk73QuCg7NH/
         /uDR/xuV9hsq0+TWeE0LBDsd9awje4SUGQR49mLFmPiKU73wnCZs/CpsdjI3ARBo1/xV
         X6FGfmCWdTcerQwsNa/9d9/hvwBkLuunS2dmPkbOIXUt0HC2be4z4RF/U/OwmcpG6qG8
         Rsag==
X-Gm-Message-State: ANhLgQ0Ma9GktEnZJ3r1K0A7EBVVdu9+ePgYZTxtTCQtr2gGrlacarQR
        aIrIvMNQvu97sguENEgYb6Oy7H9L8e0=
X-Google-Smtp-Source: ADFU+vtsFOQ0iIj+KGjDkVLFGiq3xD+0WjGUnzAMh3TLkGB8X12XkyV8b7Xm5A7Kt26bcEqWQo3L/Q==
X-Received: by 2002:a17:90a:208:: with SMTP id c8mr3286851pjc.153.1584007731070;
        Thu, 12 Mar 2020 03:08:51 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s19sm3678368pfh.218.2020.03.12.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:08:50 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/3] platform/chrome: notify: Add driver data struct
Date:   Thu, 12 Mar 2020 03:08:07 -0700
Message-Id: <20200312100809.21153-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200312100809.21153-1-pmalani@chromium.org>
References: <20200312100809.21153-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a device driver data structure, cros_usbpd_notify_data, in
which we can store the notifier block object and pointers to the struct
cros_ec_device and struct device objects.

This will make it more convenient to access these pointers when
executing both platform and ACPI callbacks.

While we are here, also add a dev_info print declaring successful device
registration at the end of the platform probe function.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 30 ++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 3851bbd6e9a39..edcb346024b07 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -16,6 +16,12 @@
 
 static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
 
+struct cros_usbpd_notify_data {
+	struct device *dev;
+	struct cros_ec_device *ec;
+	struct notifier_block nb;
+};
+
 /**
  * cros_usbpd_register_notify - Register a notifier callback for PD events.
  * @nb: Notifier block pointer to register
@@ -98,23 +104,28 @@ static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
-	struct notifier_block *nb;
+	struct cros_usbpd_notify_data *pdnotify;
 	int ret;
 
-	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
-	if (!nb)
+	pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
+	if (!pdnotify)
 		return -ENOMEM;
 
-	nb->notifier_call = cros_usbpd_notify_plat;
-	dev_set_drvdata(dev, nb);
+	pdnotify->dev = dev;
+	pdnotify->ec = ecdev->ec_dev;
+	pdnotify->nb.notifier_call = cros_usbpd_notify_plat;
+
+	dev_set_drvdata(dev, pdnotify);
 
 	ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
-					       nb);
+					       &pdnotify->nb);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register notifier\n");
 		return ret;
 	}
 
+	dev_info(dev, "Chrome EC PD notify device registered.\n");
+
 	return 0;
 }
 
@@ -122,10 +133,11 @@ static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
-	struct notifier_block *nb =
-		(struct notifier_block *)dev_get_drvdata(dev);
+	struct cros_usbpd_notify_data *pdnotify =
+		(struct cros_usbpd_notify_data *)dev_get_drvdata(dev);
 
-	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier, nb);
+	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
+					   &pdnotify->nb);
 
 	return 0;
 }
-- 
2.25.1.696.g5e7596f4ac-goog

