Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49385C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228DD20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJm46TyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgCPI2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:28:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32769 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgCPI2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:28:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id m5so9342052pgg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gx3YkUnn8PTCcIqA5lQ3klyJvqgSaFdzr80LYDD5oyg=;
        b=CJm46TyQYAdV7C6hKYCPZup69IaRdd51HPbuWUy07chs4wu5LeyLPMEfE1PlSHo6or
         +0VijVpPRh+t+mswUdDrIW+n9eUDAAlBS9VvXQs096KhQCtjxYwDuyyISByjtgtTGodC
         1kM6gSU62voyncEHjeXUckrw1bXA9FLyzr6S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gx3YkUnn8PTCcIqA5lQ3klyJvqgSaFdzr80LYDD5oyg=;
        b=J4D5fDHU3q3tE3TA5efBwZIZfcFku+gvCk6LJDZec7qHcLloALlBzjfFEtWhI9ADsk
         gyKABH7lV5Ta66jIWKpg75B9LhzsghG0vLPQz55+H4RFwaXSeqOCZfJUu/QoOo4sXvp2
         +vgzR8B/oST7wrZ1VLZwliKyfDGXROExeNN1JdUHVWPr6A461h0c86wHGkc6s4YmCrLO
         t+mNYq7/lodAGzvDbTTtoFzV1RHRYSc+lfh7X67Kgj+7CAX9ttb/wJALFPhuTW/AsPX5
         oxCfxAMDq2FOjpMvjd52xhV5qLwHnTGX7JgM6XYVIaSqeua1CllssHtb9ZzlubmX7wPd
         Rx1g==
X-Gm-Message-State: ANhLgQ1fnZ5Jl94tjx1nAhcDhNfjnV7FQtXralI741x6UuDEODtaDr93
        eYy9+x6b3U51Y+uX3INqyWCDB0i+OfI=
X-Google-Smtp-Source: ADFU+vsyI70hHbyJLy9fCHFkInzii7OOKu3L3PXnc9rAGKep3yUISTcE9efqVx8ZFDk+f1Fh3aWBeg==
X-Received: by 2002:a63:e316:: with SMTP id f22mr26158105pgh.54.1584347333021;
        Mon, 16 Mar 2020 01:28:53 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p8sm7867846pff.26.2020.03.16.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:28:52 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 1/3] platform/chrome: notify: Add driver data struct
Date:   Mon, 16 Mar 2020 01:28:30 -0700
Message-Id: <20200316082831.242516-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316082831.242516-1-pmalani@chromium.org>
References: <20200316082831.242516-1-pmalani@chromium.org>
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

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Removed unnecessary dev_info print at the end of probe.

 drivers/platform/chrome/cros_usbpd_notify.c | 28 ++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 3851bbd6e9a39..99cc245354ae7 100644
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
@@ -98,18 +104,21 @@ static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
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
@@ -122,10 +131,11 @@ static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
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
2.25.1.481.gfbce0eb801-goog

