Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81899C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D4206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bs3Z8EtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894441AbgDOIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894417AbgDOIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:24:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC2C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:24:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so17870558wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EobkudjeEirKaGgdWsk/CD8WOleZ+DP3gR06TTwb6wk=;
        b=bs3Z8EtMxZvpBwIchq8UtxwJizaNNzNokP+UGHuSBaEUXq7xAV3QKTkPn+7LwnWe5Y
         BLFOPueN01cLHBquoZTBpIZ0B+3D1yKOgup/T4iQ830/a0A0b4Gq1KTQ6J0uSGE5ndAN
         zZGg3Pd/O+Aqb4sW0MEBlmrOflpSpN07ce+np7CtjWokhkB4AQro2SYH2ouEXegI5Q7H
         wufvnSz62M1BADvZCXRaGK6ZjgcqR5fu8kjcmfcYOEJF2uKYF14ObFvXK8d54HUodunO
         YM4LkMH7/ACPGCwWF46pu634AMxsQoQx4y19p3mOekbiERK+Ws5N4xBSC/cYlNRv/Cli
         xEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EobkudjeEirKaGgdWsk/CD8WOleZ+DP3gR06TTwb6wk=;
        b=KF6RM9CIjNSEsA8BWev+lustyayI2/I3FiJMWfwdXtMrCG16CQZSP8Cpl+UkkoOdLS
         6jqkSThEpAhO8grzZ7TmbTgEPqqoQmt7VSZ5Ug9tcf0aRJFoKr0ZCcDD8LT0WP9S00qb
         q5sAycVa2mgp0FHZVXEegvyf81mABTX5zTK1E9rZ3Jhu+VnscibAni0WjAwqwvivOLZJ
         pc2V7/EmucO5xYgluzpIksqv+umCcbZ2yPoTKtettTB3G/8hFQ+UIdNjTcULQVqY+K7X
         MNMDuGvfjN5iOEjYDFY5DE7bJYk9p3YzMq/lQafGV4UNq3GYofBjTSDu7/TbfZUTe/4e
         3IJw==
X-Gm-Message-State: AGi0PuaXwlZ1Naw6Co0qXN5ZgmA0KzufN5XycmriyVZhUkvmQlrkHmKL
        IG41LEBENlVx5rOLtBNCBaK+vg==
X-Google-Smtp-Source: APiQypL/4wlg57NoVsKljaiL1Y4FqjXf6bqEYqoWKKbjsZoMQY6CN22vxs05pWfQw6mQze9N+ac0dQ==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr4189899wmb.4.1586939041929;
        Wed, 15 Apr 2020 01:24:01 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id w6sm18763373wrm.86.2020.04.15.01.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 01:24:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpiolib: improve the robustness of watch/unwatch ioctl()
Date:   Wed, 15 Apr 2020 10:23:59 +0200
Message-Id: <20200415082359.22152-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This makes the new ioctl() a bit more robust - we now check if a line
is already being watched and return -EBUSY if the user-space tries to
start watching it again. Same for unwatch - return -EBUSY if user-space
tries to unwatch a line that's not being watched.

Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 40f2d7f69be2..29f6abe84d2e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1227,6 +1227,7 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	void __user *ip = (void __user *)arg;
 	struct gpio_desc *desc;
 	__u32 offset;
+	int hwgpio;
 
 	/* We fail any subsequent ioctl():s when the chip is gone */
 	if (!gc)
@@ -1259,13 +1260,19 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(desc))
 			return PTR_ERR(desc);
 
+		hwgpio = gpio_chip_hwgpio(desc);
+
+		if (cmd == GPIO_GET_LINEINFO_WATCH_IOCTL &&
+		    test_bit(hwgpio, priv->watched_lines))
+			return -EBUSY;
+
 		gpio_desc_to_lineinfo(desc, &lineinfo);
 
 		if (copy_to_user(ip, &lineinfo, sizeof(lineinfo)))
 			return -EFAULT;
 
 		if (cmd == GPIO_GET_LINEINFO_WATCH_IOCTL)
-			set_bit(gpio_chip_hwgpio(desc), priv->watched_lines);
+			set_bit(hwgpio, priv->watched_lines);
 
 		return 0;
 	} else if (cmd == GPIO_GET_LINEHANDLE_IOCTL) {
@@ -1280,7 +1287,12 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(desc))
 			return PTR_ERR(desc);
 
-		clear_bit(gpio_chip_hwgpio(desc), priv->watched_lines);
+		hwgpio = gpio_chip_hwgpio(desc);
+
+		if (!test_bit(hwgpio, priv->watched_lines))
+			return -EBUSY;
+
+		clear_bit(hwgpio, priv->watched_lines);
 		return 0;
 	}
 	return -EINVAL;
-- 
2.25.0

