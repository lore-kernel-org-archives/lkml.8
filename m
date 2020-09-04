Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1566C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2186206E7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OSJLrqQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIDPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgIDPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C2C061238
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so7154979wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcRR0cvj/PHR5JcTPOP5KmS/Yg2MBZu1qA5qfQNGk0A=;
        b=OSJLrqQlcETqpO5qPErz470rrP4H38PM0Pt8IMETO0NAQJtD9YhqhPpbnjVgO6z5Pc
         zFTnWa4ltyNBOIYyvM+4tgoe3kWJWGZqE++V+EWXWa7BQTeJRGUXB+RdjUucwaB8vcA8
         a87JibEI+hux9ZIBnOWbmMRMtjtepM2P3EDk7RX7CdRquBDpTnwVnZks1Czho5gigPzO
         ZBW5pug6/6n5xkuc53cIUj/ofUMQo9ZoeuLagXDiIzxELjsil7e+coJ8Ky5yYDlrwcXU
         cOpD7DsDHXxX3RQEoBjI4dZ0NGVoglP+yauppUuvEEQIuJHNgVPXVtwRoCNu/iQqYXLn
         CGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcRR0cvj/PHR5JcTPOP5KmS/Yg2MBZu1qA5qfQNGk0A=;
        b=MocIsrWNsd0RknE7AdVR0DYqweIkFvXkozLgG8AMauIhpSDs/xpi7ApXLrzbYYQOAe
         Z2tWS5Dmxf4/O3ZY9NeByFwPbxb8wjVrtth1xPxUini2UBOJyPOXy7X1NUA4O/3tXFb0
         r8/NFtcNUZ83FdaeiETQf6fNF+QU8uIwUiqUvvZ+V8znEQSCyt/uKVBtmSzN41uRg5bv
         9OqCRIqqwb7Rq4ZFiC0TWzF4cLtI3wMwvAm+C0dFA8XqWVY8Cqoww5jDKfHaIzDuWlsJ
         BPqZKGOSoURXaVSzCQUmouVxmm2mZOBNgIsuVtEHwSeLmjsXs25r+VrZU/6XywkNnZAl
         5c6g==
X-Gm-Message-State: AOAM533eoeqWlLnAbGP4umybEpq2vRzHNK9A/qDnaOYSQfrjVrs6Aw9z
        AifSlCMmYkOkEOZn1yXdjyDR/Q==
X-Google-Smtp-Source: ABdhPJzydKpw4Z5FsNZ+t0aMz2hV1ayLaJITUh07WUEGRLKoHkz5Fpef/XIauwVmwQp52xf/HGURHw==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr8314372wre.361.1599234398291;
        Fri, 04 Sep 2020 08:46:38 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/23] gpiolib: switch to simpler IDA interface
Date:   Fri,  4 Sep 2020 17:45:30 +0200
Message-Id: <20200904154547.3836-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
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
index 15c99cf560ee..591777bc2285 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -471,7 +471,7 @@ static void gpiodevice_release(struct device *dev)
 	struct gpio_device *gdev = dev_get_drvdata(dev);
 
 	list_del(&gdev->list);
-	ida_simple_remove(&gpio_ida, gdev->id);
+	ida_free(&gpio_ida, gdev->id);
 	kfree_const(gdev->label);
 	kfree(gdev->descs);
 	kfree(gdev);
@@ -582,7 +582,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		gc->of_node = gdev->dev.of_node;
 #endif
 
-	gdev->id = ida_simple_get(&gpio_ida, 0, 0, GFP_KERNEL);
+	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
 	if (gdev->id < 0) {
 		ret = gdev->id;
 		goto err_free_gdev;
@@ -753,7 +753,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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

