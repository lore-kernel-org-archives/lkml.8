Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF5DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E49207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="c/4slGI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGJQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgGJQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:15:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB66C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:15:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so6735732wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=c/4slGI65Q34YtH+SDdFpF7G4+0XGXMuxXkoCPO0M5y54DgTEonMEEKiJ1aX4maZPI
         xexN1w6sXCRbXSjGckFsKvlgHkE9h/JxY7X7PpWmfzew8ZpwwygVNt39AtGUkAj3UmoD
         EBnLrTIEeNsMT8o8DkUgYXXRUT9UhGsXpO0aKxasSaQaHG775NqAS61maxfHI0Tx/Ty0
         loEa4cMkiyYiMAd9t4EYMco07+ehqxY669oGP6mUL2I/eTMjZs1ASyVZAZTpGKcqtnby
         VUlCyJdLU27vsyIXZWrWe04ckJyVBQIiBmwuQ6o04DCbdNooi2BV7v4ZSIb0RPbvLwFT
         GRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=mHmykAABskUQUeaGvlfascOZIculV2wGI74zmjg9e8EKkeXoQdcCvwRxwBU7IxGCCF
         1fbBypfbbMASJiKGTOuH8Q4nW25ddf+5fPUObZcsuMkps4f4aj7w9I9tqtGVXq94bmgH
         oW8dPAf9VnqI/oSl+tVuYAYA70DbBZ13PcZLWFIkM90EUHAiHzMleBehnLVOqssAujdG
         mAE0OwqKfmRfSgaMVq5J9vY/B2NMMTP8g7FRGjiPtlyk0C2UDSqK3Z0JN5p8FErKFqYF
         toW3kBDrAcHdzUVTQFe5dM6bdR2iyzNikT3Bco969TKeOo30nEn7MImzo9WwGbhGpolC
         qLxA==
X-Gm-Message-State: AOAM532XM+pm9DtYQqES04yWsSESNk9Asn9A+O/TIkNjuz8pxIbEMJtO
        Vnp3RWLBvEq8U0aCdEu0qGk1kA==
X-Google-Smtp-Source: ABdhPJwt3IgeUN9TgYJhau5DYs8214C9lbhCSPsS5zQNpuTvCkT++MyByRc627aN9oAdzByltAQl/g==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr6268130wml.25.1594397725779;
        Fri, 10 Jul 2020 09:15:25 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id e8sm11179359wrp.26.2020.07.10.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:15:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/3] hwmon: pmbus: use more devres helpers
Date:   Fri, 10 Jul 2020 18:15:15 +0200
Message-Id: <20200710161516.11625-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200710161516.11625-1-brgl@bgdev.pl>
References: <20200710161516.11625-1-brgl@bgdev.pl>
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

