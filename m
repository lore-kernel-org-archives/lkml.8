Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDFDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130EC2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Oy+MLb0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgIDPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgIDPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:46:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6248AC061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so7191478wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1aSHEiYdSd1JWJ6Q0fBo+4tu4psdYuKAXtqnRnr2Its=;
        b=Oy+MLb0IWTb6ZupRszNfTziNTh0ywTx6FlKIT8t2tD8VQIQ/8ByFDmVlrdZpD4yaU6
         31IH6N59+zZpkrotpOwib9cdA0vB5eqHldy11Ogy0Yj9baMhJvEpTHWD66X16BARRyUo
         9oi+Y4JnSREtrRFEf82FblZFb2kcA1dZ/2jowhVHZvBBCnXsaY3ry6kqVkI+8N6U83hg
         +diQ8BySNCXwAfRIv8tEoNm2a/IjEg2BkxnJ4Ul5x0593RtKim/vaEzmKuPTJiqPrQR3
         MYGE9bZtTv8LADfAzsTI9QLyI3COyQ/nt7ZEbNmYBgw7S/vTTttx/NMyKWGN9CVXIiCI
         YLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aSHEiYdSd1JWJ6Q0fBo+4tu4psdYuKAXtqnRnr2Its=;
        b=LBdabt7StmyfOpcVnnDLH5vqXiQu7j0f+buK8Pgb+5/au9n1UmydEv477Wr2L+oPnM
         Ensc5dfURcAgFY5TdwvJQRTtp1+zoq3jqjo8dTRs5aT+I5pRftDZXEj/b1HW1D37Vlzk
         OYk8+Gj+dHhXWMV76yIoqxsJxb6Uwr0+rIzFA8KOzwvu1rAynQez9L35lmK18stzsJaz
         jcc5n3tJxlKSoXCuonqX499VCZe49bv8WLh09REMpAH+SS3AQBIs+VmBW5yQIuP0YgH0
         9nlFq/RxYfbHAgegKhMDGyo6qEgWdUmP7eB1pT3T+M2KYUxO21ptsGmhXonyP5AIhbVa
         zaGA==
X-Gm-Message-State: AOAM531mMjXgeLbkMCVGMiovUZcGI/nXvmF5a+TYg056hZ/roy5Dzl48
        g1rQeRbyDEyIzJtmFiuPadi90g==
X-Google-Smtp-Source: ABdhPJx0xcvEJZJYZh6Boev229NGkoHO5q22dnKA1Z9y/c/DRCXfxt6f5JdAAP6bdUbwd3hUT6ZhlA==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr8219192wrr.273.1599234401059;
        Fri, 04 Sep 2020 08:46:41 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/23] gpio: mockup: use pr_fmt()
Date:   Fri,  4 Sep 2020 17:45:32 +0200
Message-Id: <20200904154547.3836-9-brgl@bgdev.pl>
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

We don't need a custom logging helper. Let's use the standard pr_fmt()
macro which allows us to use all pr_*() routines with custom format.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 349782cdb4d7..73cd51459c2a 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -21,6 +21,9 @@
 
 #include "gpiolib.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt)		GPIO_MOCKUP_NAME ": " fmt
+
 #define GPIO_MOCKUP_NAME	"gpio-mockup"
 #define GPIO_MOCKUP_MAX_GC	10
 /*
@@ -31,8 +34,6 @@
 /* Maximum of three properties + the sentinel. */
 #define GPIO_MOCKUP_MAX_PROP	4
 
-#define gpio_mockup_err(...)	pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
-
 /*
  * struct gpio_pin_status - structure describing a GPIO status
  * @dir:       Configures direction of gpio as "in" or "out"
@@ -549,7 +550,7 @@ static int __init gpio_mockup_init(void)
 
 	err = platform_driver_register(&gpio_mockup_driver);
 	if (err) {
-		gpio_mockup_err("error registering platform driver\n");
+		pr_err("error registering platform driver\n");
 		return err;
 	}
 
@@ -577,7 +578,7 @@ static int __init gpio_mockup_init(void)
 
 		pdev = platform_device_register_full(&pdevinfo);
 		if (IS_ERR(pdev)) {
-			gpio_mockup_err("error registering device");
+			pr_err("error registering device");
 			platform_driver_unregister(&gpio_mockup_driver);
 			gpio_mockup_unregister_pdevs();
 			return PTR_ERR(pdev);
-- 
2.26.1

