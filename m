Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE8C433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D5E2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qhopu08J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgGOJZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbgGOJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:25:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFDC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:25:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so1655184wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=qhopu08JJqyGVWM8MDtpU6JVIWtlkY/NnlnGcBCS+TkqHVlMYZCT1RLk+MEuRYSutJ
         Mz8gNxGSDfTI2Khw6fFC3HZcnjZ6Z+Z5iqmwENLjM4HHIWIMh56/pmcmIBmkgn3H6XMZ
         M6KH8TAg17NgRppYPsBYkQf4jev6BsLcTpXASzlY4SUydRRXOOANPVb6nu0GXXXxZT1U
         vUXWUbvpCu8a/l/dBvForlWP/wA2pJyQJKcjMOlX3Y5uSh1i4gEz0L2GOgugIFGpyQHK
         1n0DYLSdBKCzzAx++x22kXWT9YBkSHuodb5M5K4+W9OauBo41vCiKiCYdQE1/zn9bP0Z
         OUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=aWKqwhAaZFb6Ed9xCBXftstGpVOQP+p6YLajEftNVw0eU/8AEfD3PvyqzQxV/JxpUF
         hMwxfkRhqu5S0x+oeaOeLMSJ1N75zedyxr72KqDXZ1PhQq+RxTeu9X3sv/Ov/lvP6bGO
         +/w3Ji6zKA/7UlyBc1b99g68V1x38R75YQwdcXttXp7Bkg+IGCKH9M8n9KK52dopkO1e
         5Jzg5vi458CCHiiVd+8L/Nm22t1tJtHkSsXAzgSOrGn4BQLSVLRDO1TcmjQB4oBwfLUW
         zWt9sWO+wyrIr7DHDADHNb6puBDPVf3Q0guIRQ+8M46C37F4DwBowAFPxGsh9tXjgS5I
         CLcw==
X-Gm-Message-State: AOAM5334PrqUBpHjneIeR72TS0aixNd+zaiTIhlzl5nWFm0EOiWkUl6O
        opuLDITWR0V7oAwhJVGhvkMD3g==
X-Google-Smtp-Source: ABdhPJwasQoZOdVqFSXYXVkG5h1AH+jFH0hwrRh6njPBhBYy1lP/eR9xcCccJviz2jSBfYaDCl1Kqw==
X-Received: by 2002:adf:facb:: with SMTP id a11mr10840496wrs.277.1594805133522;
        Wed, 15 Jul 2020 02:25:33 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id v11sm12083419wmb.3.2020.07.15.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:25:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 2/3] hwmon: pmbus: use more devres helpers
Date:   Wed, 15 Jul 2020 11:25:27 +0200
Message-Id: <20200715092528.8136-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200715092528.8136-1-brgl@bgdev.pl>
References: <20200715092528.8136-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink pmbus code by using devm_hwmon_device_register_with_groups()
and devm_krealloc() instead of their non-managed variants.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 44535add3a4a1..91839979cf6c1 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1018,9 +1018,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
 {
 	if (data->num_attributes >= data->max_attributes - 1) {
 		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
-		void *new_attrs = krealloc(data->group.attrs,
-					   new_max_attrs * sizeof(void *),
-					   GFP_KERNEL);
+		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
+						new_max_attrs * sizeof(void *),
+						GFP_KERNEL);
 		if (!new_attrs)
 			return -ENOMEM;
 		data->group.attrs = new_attrs;
@@ -2534,7 +2534,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 	ret = pmbus_find_attributes(client, data);
 	if (ret)
-		goto out_kfree;
+		return ret;
 
 	/*
 	 * If there are no attributes, something is wrong.
@@ -2542,35 +2542,27 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	 */
 	if (!data->num_attributes) {
 		dev_err(dev, "No attributes found\n");
-		ret = -ENODEV;
-		goto out_kfree;
+		return -ENODEV;
 	}
 
 	data->groups[0] = &data->group;
 	memcpy(data->groups + 1, info->groups, sizeof(void *) * groups_num);
-	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
-							    data, data->groups);
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+					client->name, data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
 		dev_err(dev, "Failed to register hwmon device\n");
-		goto out_kfree;
+		return PTR_ERR(data->hwmon_dev);
 	}
 
 	ret = pmbus_regulator_register(data);
 	if (ret)
-		goto out_unregister;
+		return ret;
 
 	ret = pmbus_init_debugfs(client, data);
 	if (ret)
 		dev_warn(dev, "Failed to register debugfs\n");
 
 	return 0;
-
-out_unregister:
-	hwmon_device_unregister(data->hwmon_dev);
-out_kfree:
-	kfree(data->group.attrs);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
 
@@ -2580,8 +2572,6 @@ int pmbus_do_remove(struct i2c_client *client)
 
 	debugfs_remove_recursive(data->debugfs);
 
-	hwmon_device_unregister(data->hwmon_dev);
-	kfree(data->group.attrs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
-- 
2.26.1

