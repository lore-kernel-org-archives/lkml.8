Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF524C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40AC2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O82vNF3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgBXJmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:42:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33252 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgBXJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:42:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so9558255wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 01:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se6uVwZcUyEVQTI7VQ6AKAp5xkuS44LPDYDciQyl3tk=;
        b=O82vNF3QqwU7p+lGPjsqdpw1i7j+XuJ8MZsNiIkmrG7MVC9u6AwMxE0cqfHxeJ+rdd
         tcWC1wkiKWJDfAZqgk95DzKAyoIFgwr1kzHjr5u8RkqPtvy1IyocArEV2vnsJV4U7w5m
         re/Aa8x8RbQ8VT+DL0O1KiEIlSQLSOY3CIr96Uj60GbBhlW6HdQd0iIPTu/927HieDNZ
         6B5Q3wdHpuHQfUgj3/wC2Oo/VMoNscNTnnCMDC3pWRrgHlnNfLhGe9SHbUY1KlxpSUUH
         QnRiMS2pdZps8WBFT+lVDK51CFuUpxlMnGoS12C6Svk9gHhTlSlTKlxpIEoWPSBFJkoq
         giQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se6uVwZcUyEVQTI7VQ6AKAp5xkuS44LPDYDciQyl3tk=;
        b=h8yRSgv7lrqIPRYoEEYs+FnlJqNXFqeRKT8oieSrm+MWfjOenjgiMi5N7ojAGXrtuk
         Dvbvm80hJPf7YXQbYTIK4Q/edPjVWN5Fy56+k+pDsNxhnHRCLFp6Rp98J/RJMXNxaM7p
         P49Z0hOz38pkH2Vbt1kLAsH+ca8uUfVk53+trohs2ym1Dxiu9azWS1ubitmnYU2lVTkg
         D8ayvO7L01Mdac6vZr+LnrZIj1X9CWqP3rZklJ16cwymXkjwjG3ZYJA3eAHordbAsrE4
         ZctrbwNTz/L6SAZAVKZlvuH1p6AKtcVFMLWM3+/CVSIiKq1XqJvvRwojpVaI3Zw+7EVm
         2BpA==
X-Gm-Message-State: APjAAAU+OfJzsg/JH0Iq2KJNbMO+AHWHUcIcDTezkfjhjy78fTzZATLs
        Uydph2x3tLqIGOEBwFBqxzgMLA==
X-Google-Smtp-Source: APXvYqxf12lBuwbXbSZ26h3BV1csXjjbVp20n2b9sVxPONCeVBJmqOfyMt8VnTEoh4PD570ZbZhhBw==
X-Received: by 2002:adf:e683:: with SMTP id r3mr69472357wrm.38.1582537325948;
        Mon, 24 Feb 2020 01:42:05 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id t10sm16920730wmi.40.2020.02.24.01.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 01:42:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/3] nvmem: increase the reference count of a gpio passed over config
Date:   Mon, 24 Feb 2020 10:41:58 +0100
Message-Id: <20200224094158.28761-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224094158.28761-1-brgl@bgdev.pl>
References: <20200224094158.28761-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can obtain the write-protect GPIO in nvmem_register() by requesting
it ourselves or by storing the gpio_desc passed in nvmem_config. In the
latter case we need to increase the reference count so that it gets
freed correctly.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index c05c4f4a7b9e..790ec9b5552e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -350,7 +350,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	if (config->wp_gpio)
-		nvmem->wp_gpio = config->wp_gpio;
+		nvmem->wp_gpio = gpiod_ref(config->wp_gpio);
 	else
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-- 
2.25.0

