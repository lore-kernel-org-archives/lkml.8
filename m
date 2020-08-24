Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966882067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mVpAGo7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHXRjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgHXRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:39:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF4BC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:39:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so9651075wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=mVpAGo7eY6TxDLtJv9VnboajgA8FuB2xAnMl35bzpRxAQpWpsN3EeLbTgDSa95OIj1
         EmS0CB3EIwRjYRC1f/nkxGbzMgAS5OKJTT7nIjyOSnU7LDRA3SoqH9XoMgzc13FuJ3QJ
         z1MvPvWXCjIWXhrZ3sfiX59TU3NjA/gIo1QHwu4PJlf6pYp4XzwlpIoNvGwSIkexbm3u
         S2RBRtBV6HVKx8xLoLEKEyQRhDmX2G9ENHCwY8UZgSWDUjaSzwQK1PkGrHn8wYRNCwJv
         wwEggv2OE1t4UEQ9lNfKweTwN5Zhdt0rhUhAH5CXQwfvIKtu0c4xLA/WRkkBBEJskazW
         3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=JrCw3Gfy7feboOVoXbkcq/aiJzl7roCJSnECwH6+oudQO5Ah8ZHku74I/Hcs4rIyKx
         cxSe4tEQI/CrN/ZpLz0dXudTFHtyO6i+i1OuJNw5TjbuOmI7FmL3jot88nG20+NVW3Zb
         9CC3xUvt5H1mEv1cW7av88GIRm+NK7gm+hZkO4Sp7rPV1R5KrS2dHpMXqZuWnLnF9XEj
         NCS32pU2H4dQYkBvsQNd9rORMizPucI/Bh5kGCsHuXX0U0Zn2O6LmH9lCPiShn/WtF+D
         a1Z/kmqrdDbxXiUZKhv1LdCMEpDYrzx4M3dbICzxj2jxG2stRmyC91vsdT/cjjEr7R7b
         nCGg==
X-Gm-Message-State: AOAM532L8sGXrTelIylg4cbXEi1Ut3DTP6LdNceZj19oUIk2MFbOm9lZ
        JZgd6sDnFedG5Gae9Xr2LM2hlA==
X-Google-Smtp-Source: ABdhPJyqjmDxvzAygJrcC76kK9zKNKJDqWRAsTa16DY8BCJG1oe0jQzsj9BbUtJnHjDRnc4j58m79A==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr6911532wrn.225.1598290745779;
        Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
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
Subject: [PATCH v9 2/3] hwmon: pmbus: use more devres helpers
Date:   Mon, 24 Aug 2020 19:38:58 +0200
Message-Id: <20200824173859.4910-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200824173859.4910-1-brgl@bgdev.pl>
References: <20200824173859.4910-1-brgl@bgdev.pl>
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
index 44535add3a4a..91839979cf6c 100644
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

