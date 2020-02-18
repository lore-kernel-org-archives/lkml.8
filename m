Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D84FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BCD206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RGFLRkCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBRJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:43:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40259 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBRJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:43:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so23046838wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1chfOYLWL1h07j8wUUwG3K0SuI4vOWNOGcjnRZm7XZI=;
        b=RGFLRkCRmqX+afIPsopEE/e29GACfQzRZpbfWZIG1DkCAobJgVx5XURsjYGukrchHf
         sJIetooc/49e/zxdkClGKBy4xylInq1TqVx9mYy/vcsIILbAHIBZcpa9lKBdonfEdqNo
         jnLNJ+qSLyXsMfPoWTgzAnOKwfhFQOwNBIf5q4eg22nBmXmTIsTIMqQr4cBuaXk5jCyx
         rnuurIRFSVOPg/SexOwPbIyGBlFDvggJEQaMCsaKIozjUPmK21Cb5+h4uxO4IeM3BbVb
         1pgjWH8WpyQSAOVcLBpZSFErNEYG4ArBsfidjEYb7kKMgIT97sBAYQdvOypRsnTtDO+n
         owPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1chfOYLWL1h07j8wUUwG3K0SuI4vOWNOGcjnRZm7XZI=;
        b=HSUCaGrN9lUrz7LqVUWthf+4yotHKhuIq1ddQhchsscy+y8rTNQRL26FBl13I+6Luw
         +0CCNXLJz0kT0RiGVY64cF2c4tUx/dOdKNd57WkFRo1D2BPS+4fLGY9KSqQA/BSHTsTd
         q7xlw6q5kRYxFKsRG9oU2ODxYj3XMnUkadRZ7WKhAUWQ/0G8OSL9j6e6eTfYCVixk+xG
         3tGeIv+T+CozLeH5v4E3LZT1Sc89ymaOTkz6EIo9v+YmUps7RLE2kxak35ETYds4+DM1
         QUz/jQ4mHo8oTD2fkBHr4WDHxy3TelSKE5hVO1tPURRnGXA62g3um5t3erG/0oyKFxL4
         QFfw==
X-Gm-Message-State: APjAAAXxmjvMUnZ0yTdRV3vyztY6YUJ1fNP0asK/HcJrruXW/uJqWuiw
        z2aziv6Fp50gU0YlwfZ/y3cxoA==
X-Google-Smtp-Source: APXvYqxGt2GdkMwH8MGvQAzR0h/sReqzUomjbPgsQdTKANWVof2bTVtrIAOj5qwxx5BHGJ+5xAc2mQ==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr27562274wrj.165.1582018982007;
        Tue, 18 Feb 2020 01:43:02 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id s23sm5351095wra.15.2020.02.18.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:43:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/7] nvmem: release the write-protect pin
Date:   Tue, 18 Feb 2020 10:42:32 +0100
Message-Id: <20200218094234.23896-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218094234.23896-1-brgl@bgdev.pl>
References: <20200218094234.23896-1-brgl@bgdev.pl>
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
index c4a6c044b020..e47152e9db34 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -72,6 +72,7 @@ static void nvmem_release(struct device *dev)
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	ida_simple_remove(&nvmem_ida, nvmem->id);
+	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
 
@@ -428,6 +429,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
+	gpiod_put(nvmem->wp_gpio);
 err_ida_remove:
 	ida_simple_remove(&nvmem_ida, nvmem->id);
 err_free_nvmem:
-- 
2.25.0

