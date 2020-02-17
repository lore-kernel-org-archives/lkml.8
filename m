Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C2C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD95F20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="C4pRCrEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBQTyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbgBQTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id r11so21160481wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHHf1AZ6awg6rJEgh/8j8fVolWpvz1BWWO6jH4U66VQ=;
        b=C4pRCrEHMcQUiX8lZV0P4XL69BR8YUU9PP6rWhgtMHuCoWh/myi3b5qfmjy9WocIpy
         DHXBPE8EkUFoOzl9PF+6uf2tZwZGfXt2V+zbIxPIu22QBXucp7J94F+E/Sqg8h7eFSMn
         oQcwixYdX5y01EO75gA+W7p+/slUA7SGbkYZdkvQR87JLbK6Ryiuvj4bWMojUz8wKoy1
         rtL6f/xWlzAcPDAbbDh3V9S9udsvuiHLrmP67RLX+JSdFrX0XrkNN0caJY1jLFMH2oKd
         ek1MynhYu75OejfO1p8clQEfwu48CBL+4xHOiEgQrkgq9sb2JqloRuzL4+ZTVchmKoxs
         bRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHHf1AZ6awg6rJEgh/8j8fVolWpvz1BWWO6jH4U66VQ=;
        b=lX4O5CjpD4DXCVbUIgi4b/tBlNoP6Kx5ezh89zCLHgBKTGQdoRv3IZsW6DCm2CAHCm
         bb7NH8aO8/2o0iJOHoTsueAXewXvUFlzr7H6tLPw8Ex7YnPOWwrh3laF/9EEwpj73sMd
         ny2x2vZZD/F2Z5okiqYy/zjTzK9TsLBBo8/NUytf3HYXQDxqSvMtmvwlhlzg65fbvD3z
         X40I8GApnUQyxQPvdsYzfehVeFFBmVeKcbm89yohGcRknf6PfDOU9qd41O/h6bJYI1Hh
         fi1T9d2/U1H48TfFUcwFeZ/7xRr/qlrwinUnPvAWmQz6COJMpdTGhS+Gh+a5zgMUs/rc
         VFyw==
X-Gm-Message-State: APjAAAXRW1DY6Gs6UbbgIypMfMxTn9TaKTmiawQxnqttGNPb/la0ASLJ
        ZW9e9XI3lbpK6tm9gXoq13VY/A==
X-Google-Smtp-Source: APXvYqycds3+uTkCmmj1bwhdP3qSWBf6e5zvFgV9quta8k08gJuuEtpvCJRiNDNb8sCWbK7ForeUcA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr22826005wrp.378.1581969285841;
        Mon, 17 Feb 2020 11:54:45 -0800 (PST)
Received: from debian-brgl.local (8.165.185.81.rev.sfr.net. [81.185.165.8])
        by smtp.gmail.com with ESMTPSA id v5sm2679469wrv.86.2020.02.17.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:45 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/6] nvmem: release the write-protect pin
Date:   Mon, 17 Feb 2020 20:54:34 +0100
Message-Id: <20200217195435.9309-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217195435.9309-1-brgl@bgdev.pl>
References: <20200217195435.9309-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khouloud Touil <ktouil@baylibre.com>

Put the write-protect GPIO descriptor in nvmem_release() and in the
error path in nvmem_register().

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Reported-by: geert@linux-m68k.org
Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
[Bartosz:
    - also put the gpio in error path in nvmem_register(),
    - tweak the commit message: the GPIO is not auto-released]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 07af9edea9cf..096c7bae9e74 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -72,6 +72,7 @@ static void nvmem_release(struct device *dev)
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	ida_simple_remove(&nvmem_ida, nvmem->id);
+	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
 
@@ -430,6 +431,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
+	gpiod_put(nvmem->wp_gpio);
 err_ida_remove:
 	ida_simple_remove(&nvmem_ida, nvmem->id);
 
-- 
2.25.0

