Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F70C34035
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7A9206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="L1flL6Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgBRJnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:43:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33593 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgBRJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:42:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so23115790wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJLLdBI8eSvzBXxk2WonDxxaPfclFHkWN/z2Zz+tXoI=;
        b=L1flL6XqWU4M7oQtBfIfwPtQhIvdy+VOqidwc+iCrhNvPHGfUWj8VoIwaGBvqG9Ur6
         zcbcVnmJ6IdllG9BUggzYIbB71NMRJ2lkEK9y2nctzjtrtgj+4uMZgFi2iDdHiWi/tAP
         f/f6LFs464cgY+XJnpbqb9bhOulcr4g68CdzFkyrEc4AfLGl5KoKwQfKReOlVRSmhp4s
         kiSvssfv4h1nMnmvQtR2cG74FteQ0497Q4Ji0S+4Dd6MLMcve66TsBeGL4ZwuL/kcrWP
         XJhcn1q8vgmi04kNKt+nsH+SWLU6q9Si334XAJeQqyft2JNDCmjai0bQQZgBIJzcqrUf
         SxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJLLdBI8eSvzBXxk2WonDxxaPfclFHkWN/z2Zz+tXoI=;
        b=RoTJ1tpQTxlQzHgzaA/UT4cSuadg0oz5Eg0zGAAafVOnDDt5D3Zp05oF5tMZUW3pZC
         3vU+fyucSQOt3W4RAXfkGTW1J8kM1BODXS9QdhpXWGWEG3B3s5+zUx6Z+iMlQu+s09VH
         zH/7PJTVEy/DYDArdD6fvqs/uL7M9pEXjtl3Io/1R9jn+GJ0+qchD9KjcIx+j/bYfUge
         ldhAfkh5JwGqDDZSb7FCA6TXLbBw1v3F4Ed9x5xCYhAlmDOL0z5jwaphjxpFXzjIzwpu
         67o9lQRQ20EFGRvYOtl2PcuEEOLvzKozwlz2jSHGEdVxJzha4TXzPs905hjHV/dpTMaS
         K2rw==
X-Gm-Message-State: APjAAAUhMG+Nj48FaVXaaPkNf0uoqxKPjPSu3kO2Tj5yQwXbJXzmKOqN
        7NiFDL1bKyXJt15n9ZXwSyzBpA==
X-Google-Smtp-Source: APXvYqz1nBzHiRJhepLQ/Wjne/xscI1ej8VHDh7ccYeXeFP7+XHWMd5f+Q3k2fAhEqceDdthDfeLKQ==
X-Received: by 2002:adf:e781:: with SMTP id n1mr29596110wrm.56.1582018977732;
        Tue, 18 Feb 2020 01:42:57 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id s23sm5351095wra.15.2020.02.18.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:42:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/7] nvmem: fix memory leak in error path
Date:   Tue, 18 Feb 2020 10:42:28 +0100
Message-Id: <20200218094234.23896-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218094234.23896-1-brgl@bgdev.pl>
References: <20200218094234.23896-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to remove the ida mapping when returning from nvmem_register()
with an error.

Cc: <stable@vger.kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ef326f243f36..b0be03d5f240 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -353,7 +353,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(nvmem->wp_gpio))
-		return ERR_CAST(nvmem->wp_gpio);
+		goto err_ida_remove;
 
 
 	kref_init(&nvmem->refcnt);
@@ -430,6 +430,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
+err_ida_remove:
+	ida_simple_remove(&nvmem_ida, nvmem->id);
 
 	return ERR_PTR(rval);
 }
-- 
2.25.0

