Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B756C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0747C20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cylVhTMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgETDsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgETDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:48:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n7so619459ybh.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AtQe0x2PAboF4EgZmF/lYmvEUCwziIE6nVFwXxbqycU=;
        b=cylVhTMJbfAKhVcW34A8ZOUsKfXezfHA7OXFF2OrUpJ2HhmfpJPW4Yu2eTSVR43erF
         QSPvdwPgv90y0NurvwYatq14TaKgsPY4HkLkM0mAay2J1lXRfJFzsc4tymYu9sU2sPnJ
         pAoqR9BxcjzudJaeAFJAHT8I2bMWO89H5sVPjyGQO1eWFak2zKM/paYkdxXhbgiC+23d
         fCZL1h34XUpYWLcncj5J3nJ/DpuUadk19CFrzqsSPpF5ALtHXL/8FIQ4c6FH/0IwLB5Z
         5HAWHxHn3568hVNhrmBpB69zISqxvG6DA2Vv1UTTUqiSHAfyEfu6L0ViAUggn1uJFlJX
         knjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AtQe0x2PAboF4EgZmF/lYmvEUCwziIE6nVFwXxbqycU=;
        b=T3BKNGY0uMIAajDMARAInEIaEE6ieh0Rxvr7PKCLTLd4deuss/TN7Jo/pYSwXYEfxT
         YBc2E3IV9fyCIE1zGaEvL4rvxZiHmORDIX4WropF4GpK0PbvC9kOiVQVVRW6EwVzbTBz
         aHfi4b9EPH/WpmCvVqu7QEg5lOM7pxaanrmEQYsZfGS6TFFN9TgSfqk6pQhe7OP77OLu
         tF2BCmxUvkWbO9vNaLfbYY9LY54so3pDu289IPomeW3bZRHV8YohnxyhjHJoKYrYv7ZR
         ucJ8ubLb3qK9bH8M+DWdd4kt/mrCliB2way0966s7IBh0mmi76zIjS43ypyaKzGuMjq8
         PTEw==
X-Gm-Message-State: AOAM532ShEvpVuNpXXcywRc2kGp7yba1cHedSxAuaEfuprBDAjlhRWaq
        nvy/g0CQIHh/em5FQC+M938387GFir6sXM4=
X-Google-Smtp-Source: ABdhPJztYxctXD8A+1N4LYqAI4t6dQEmw51wYsDh5Pb80a8CKF3ekhSmZlmIf7l4EBjnCRXNRuUZ0WWoLpwtFQU=
X-Received: by 2002:a25:8688:: with SMTP id z8mr4266396ybk.396.1589946510159;
 Tue, 19 May 2020 20:48:30 -0700 (PDT)
Date:   Tue, 19 May 2020 20:48:21 -0700
In-Reply-To: <20200520034824.79049-1-saravanak@google.com>
Message-Id: <20200520034824.79049-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200520034824.79049-1-saravanak@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 1/4] driver core: Remove unnecessary is_fwnode_dev variable
 in device_add()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That variable is no longer necessary. Remove it and also fix a minor
typo in comments.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f804e561e0a2..6dbee5885abb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2543,7 +2543,6 @@ int device_add(struct device *dev)
 	struct class_interface *class_intf;
 	int error = -EINVAL;
 	struct kobject *glue_dir = NULL;
-	bool is_fwnode_dev = false;
 
 	dev = get_device(dev);
 	if (!dev)
@@ -2641,11 +2640,6 @@ int device_add(struct device *dev)
 
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 
-	if (dev->fwnode && !dev->fwnode->dev) {
-		dev->fwnode->dev = dev;
-		is_fwnode_dev = true;
-	}
-
 	/*
 	 * Check if any of the other devices (consumers) have been waiting for
 	 * this device (supplier) to be added so that they can create a device
@@ -2654,12 +2648,14 @@ int device_add(struct device *dev)
 	 * This needs to happen after device_pm_add() because device_link_add()
 	 * requires the supplier be registered before it's called.
 	 *
-	 * But this also needs to happe before bus_probe_device() to make sure
+	 * But this also needs to happen before bus_probe_device() to make sure
 	 * waiting consumers can link to it before the driver is bound to the
 	 * device and the driver sync_state callback is called for this device.
 	 */
-	if (is_fwnode_dev)
+	if (dev->fwnode && !dev->fwnode->dev) {
+		dev->fwnode->dev = dev;
 		fw_devlink_link_device(dev);
+	}
 
 	bus_probe_device(dev);
 	if (parent)
-- 
2.26.2.761.g0e0b3e54be-goog

