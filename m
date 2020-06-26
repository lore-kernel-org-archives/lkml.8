Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A084206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KoEiu9Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFZQ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgFZQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:56:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6402C03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:55:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so10145284wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sza+GT2lqcd6jmiOYegQQQLgqoPbDI9CeS4XhKI3V1o=;
        b=KoEiu9OdEBcBWWP+UosBbqAfR1V47vQAzO8kl+t1wgf0SG1vI7+YdJmA7Wys11RMex
         ZMXx+mBH/viOzmxJj160qrt0OrYr92gNS4xmUzOC0X2/dr2qeiQ9Ece18Tbq0Z5Vk1id
         nR2RNxEZXUeZerlrtFotgtBYWJ8eEaiSmCMBwCfcc1ATLbcrhsZ8bpf7kr8CyoZUNofo
         Fi7UswHyjnS7p4q/0aqVUk7v6CvzEAoU6wozvFuFBFvguMxBvB/zm+AhU0+cgp15Uxj/
         qtstFFn3hZZFA0q7vM3b0/m5UxZcjGWJk6ec5oB+LU1JDjH1Nszdn/6NnI6Zu21L7NUw
         P3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sza+GT2lqcd6jmiOYegQQQLgqoPbDI9CeS4XhKI3V1o=;
        b=hidGd6+n0fzTOm2LOloQgNsdM8CdNSa8d0X+GBp5nOMcjD1qosPG/UZ/JiWAlm/Hiz
         QMUUwuymKso6YafoZuDGDI2nCSIVi5REHKqJoh4UkiWIk/offaLXUIjybpj16t58YRCO
         34aQNSsE55xqJNL6mwIpEeGAW9kVYFKHCej3q6nkK29+7/WpUVFRb17d2KgItDo0IP14
         X1dz6j7Zl7yhjec4HcVRHKGneuvxqusSiUCl3Gz5r2ajksCl5rCCDbV7aD8wGqmwHmwL
         LO55HCFGaZrwgbUwFWDYMsg5tuQ/msGuPmmNMphCVk25xnWCBd1SbVkUr2vYCS76T2S1
         cq7A==
X-Gm-Message-State: AOAM533TuWdW5MRwt1z5rSdtWiAaFlVFajuTrzrKvJBbhfbEagNGGDsh
        REoLnJR5WO+nEGSWUMaabJYFMg==
X-Google-Smtp-Source: ABdhPJzCV6/MN+xqvykEQMSCCNNo3cu4VV3JYPC+A7Y7onUQZRBgd+j3p7NkVTzX64hm46KgPbdFjA==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr5051129wrb.118.1593190558547;
        Fri, 26 Jun 2020 09:55:58 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id x5sm18654706wmg.2.2020.06.26.09.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:55:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/5] hwmon: pmbus: use more devres helpers
Date:   Fri, 26 Jun 2020 18:55:35 +0200
Message-Id: <20200626165535.7662-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200626165535.7662-1-brgl@bgdev.pl>
References: <20200626165535.7662-1-brgl@bgdev.pl>
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
---
 drivers/hwmon/pmbus/pmbus_core.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index a420877ba533..af74504647b8 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1022,9 +1022,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
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
@@ -2538,7 +2538,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 	ret = pmbus_find_attributes(client, data);
 	if (ret)
-		goto out_kfree;
+		return ret;
 
 	/*
 	 * If there are no attributes, something is wrong.
@@ -2546,35 +2546,27 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
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
 
@@ -2585,7 +2577,6 @@ int pmbus_do_remove(struct i2c_client *client)
 	debugfs_remove_recursive(data->debugfs);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	kfree(data->group.attrs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
-- 
2.26.1

