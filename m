Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBFC2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633812177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PW143ymq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgIHTiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgIHPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1BC061246
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:12:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so17227269wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrkUEQnkIGFGoNQEVpiI9JVsWjIbZBqpkD8BbZf2zOQ=;
        b=PW143ymqvvugN4bi5TTzJs8LeNJbs5u16TQjl6/VN2bg4e6a5jWm/MbcxnMxZVwgwX
         HavELQkYGfFuXp29hqY2myCHP/ErTH2k4PLhAEnfJabgYzTA7SOtzKTZMNVL/hjOjd5M
         5ZwRUchgYXdbR83oKIjrTaRd72ZFyyJX20InDm3G3rZ42nPgSdXHXB7OdEx/oLa0pjJF
         +UdRV++7E2c02jJ5uhDQpQeXb4lJUJ5JwQfyOJOqKu9mqq0jakcFM2xYC9PP+iMfWq9z
         t7p/gfiCT957lE1TPQUcGKQlhd50/KloYi+X4MidwOQB7OKXefPHVRjEEppTAUyRU/Ik
         zPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrkUEQnkIGFGoNQEVpiI9JVsWjIbZBqpkD8BbZf2zOQ=;
        b=Fx4pY7CnPinHZ++FW1xBuV0LGi3zuc03aecBC/g0CPY0J3pTgkgn0fZPgQhycEkXl0
         Xf1t0Jt0xU37cvUNJH6wAFQmW5cynKQkY6zrI9p2Id7XKSlKq8lnuhbxZvwJA1+dFhee
         hpTEdE8e27j4rmSaS1LVuxe5DQDTr2dCbqdllbfc+RrNo398Gexdro5NFVhmvdzBYXOd
         W4erA4lAg1szTNDoKyIjmV7HGjuJFFxpdODURQVAmDfAdqJ+5tCXn+Ipvzs8QcJ0tkoT
         RIWNSiqGlaICv5QuL+nJBiHgIBDFlXPrxhMa6oK1yue0+t2zdqKxJZVtrM58QFSUyBOI
         9E3w==
X-Gm-Message-State: AOAM532Fks2ycNDCDSGpdmTI3eQQVJ1TAh4CItOfanUF3+qgprw5fbc0
        k40nK0gnz4FoOJRySFyy4b7nuw==
X-Google-Smtp-Source: ABdhPJxX6aEKKbfcibSkGUiwzn+QESAx0tzCBJXX709sOGdeRCmDm2UPrnZVVvx7qrBO+uolnZj/LQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr4338869wml.176.1599570750028;
        Tue, 08 Sep 2020 06:12:30 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id m4sm17596893wro.18.2020.09.08.06.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:12:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpiolib: switch to simpler IDA interface
Date:   Tue,  8 Sep 2020 15:12:25 +0200
Message-Id: <20200908131225.10870-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need to specify any ranges when allocating IDs so we can switch
to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.

ida_simple_get(ida, 0, 0, gfp) is equivalent to
ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
larger than INT_MAX.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 80137c1b3cdc..97f76334ec7e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -426,7 +426,7 @@ static void gpiodevice_release(struct device *dev)
 	struct gpio_device *gdev = dev_get_drvdata(dev);
 
 	list_del(&gdev->list);
-	ida_simple_remove(&gpio_ida, gdev->id);
+	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
 	kfree(gdev->descs);
 	kfree(gdev);
@@ -537,7 +537,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		gc->of_node = gdev->dev.of_node;
 #endif
 
-	gdev->id = ida_simple_get(&gpio_ida, 0, 0, GFP_KERNEL);
+	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
 		ret = gdev->id;
 		goto err_free_gdev;
@@ -705,7 +705,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 err_free_descs:
 	kfree(gdev->descs);
 err_free_ida:
-	ida_simple_remove(&gpio_ida, gdev->id);
+	ida_free(&gpio_ida, gdev->id);
 err_free_gdev:
 	/* failures here can mean systems won't boot... */
 	pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
-- 
2.26.1

