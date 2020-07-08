Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E8C20775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIIw4Gn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGHU1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgGHU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:27:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59734C061A0B;
        Wed,  8 Jul 2020 13:27:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so27620003lfh.11;
        Wed, 08 Jul 2020 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQGPvdXbN5vRJ3ODsRMyEJWkiSbzsV1+ScmLfkQB+40=;
        b=RIIw4Gn7TpeB1OJSKa7kxGcs2gUY0lCYEZLM9bTNwBtsaOLmHUTsGewT6Yjh9mRqBE
         gJ9As3nHVUYXK7JfzAO/4KScMj7nslhId1QV+P7iO5KMrlGet/p1OW+Ii7pwQOx0M5qo
         D3RSgR3/vRBySW2pVeZhoI9zOZBExKBoL6RRClfg9CB+I4vbMVxDXppUHpu/VO79Ll1D
         PFlQFt0r6T2p02/SewWJs6vpL+R8o45CLcRzP0vMSr0B7e4qLMhgPSgAHs3ZGyLUf3Ur
         cuAB6KNtroAozY9MbynrjFItZyz9ZOieQ656Km6kuvr6M9qh8vC893lMRymScWVRPrW4
         qEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQGPvdXbN5vRJ3ODsRMyEJWkiSbzsV1+ScmLfkQB+40=;
        b=TX+YmQKVXGkDGZusQynFFuSHLVtuJpHqueK5rLMf491vwy2XZQapeRjK1T/OZOsdO1
         d3y0M9/fkort89lg1yszyBYTQB1yUPkGuzvdgUvvF1xD6LqLuMHXjYB5h5hLPvaRund4
         6eEM1O3rmK9O11Tveo3xZK852uX+/7V1OyiDfxmkwUzxyHPCoQd3OpNeBo0euUa4R1IM
         HBS+uGIfo5LQiqAxgSPeiixzxawCOUjAQJXS6mvNm+PCWQmla4JSx/x/PKYWOcu+tOKR
         JsfD+IuV2CRuNpKbiw4KXu/ro5ymwcZm8Moj/IUPgTKyifH/xi41ZH8Jk0a36GY/QxTu
         F/1Q==
X-Gm-Message-State: AOAM5337h+CyJmQy1ZeqyWJEHwKcrzuziN8Ov/G8uAdyyPPpNEMGBOlA
        0CKAOWe2s8sn7/hWXMs8ZlM=
X-Google-Smtp-Source: ABdhPJy5iVWMh39lOx089/v1Ayc7GrFcBjG4S53xzuI3Cruz5yMke5T9WDSGTYAuUjv1ULsncdWD+g==
X-Received: by 2002:a05:6512:742:: with SMTP id c2mr26955748lfs.108.1594240020873;
        Wed, 08 Jul 2020 13:27:00 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.gmail.com with ESMTPSA id e29sm252568lfc.51.2020.07.08.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 13:27:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] gpio: max77620: Use irqchip template
Date:   Wed,  8 Jul 2020 23:23:54 +0300
Message-Id: <20200708202355.28507-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200708202355.28507-1-digetx@gmail.com>
References: <20200708202355.28507-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change addresses one of the GPIO-core TODOs for the MAX77620 driver
which requires modern drivers to use the irqchip template. Instead of
using the GPIO's irqchip-helpers for creating the IRQ domain, the
gpio_irq_chip structure is now filled by the driver itself and then
gpiochip_add_data() takes care of instantiating the IRQ domain for us.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpio/gpio-max77620.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 9121d2507f60..6c516aa7732d 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -277,6 +277,7 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	if (!mgpio)
 		return -ENOMEM;
 
+	mutex_init(&mgpio->buslock);
 	mgpio->rmap = chip->rmap;
 	mgpio->dev = &pdev->dev;
 
@@ -291,6 +292,11 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	mgpio->gpio_chip.can_sleep = 1;
 	mgpio->gpio_chip.base = -1;
 
+	mgpio->gpio_chip.irq.chip = &max77620_gpio_irqchip;
+	mgpio->gpio_chip.irq.default_type = IRQ_TYPE_NONE;
+	mgpio->gpio_chip.irq.handler = handle_edge_irq;
+	mgpio->gpio_chip.irq.threaded = true;
+
 	platform_set_drvdata(pdev, mgpio);
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &mgpio->gpio_chip, mgpio);
@@ -299,11 +305,6 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mutex_init(&mgpio->buslock);
-
-	gpiochip_irqchip_add_nested(&mgpio->gpio_chip, &max77620_gpio_irqchip,
-				    0, handle_edge_irq, IRQ_TYPE_NONE);
-
 	ret = devm_request_threaded_irq(&pdev->dev, gpio_irq, NULL,
 					max77620_gpio_irqhandler, IRQF_ONESHOT,
 					"max77620-gpio", mgpio);
@@ -312,9 +313,6 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	gpiochip_set_nested_irqchip(&mgpio->gpio_chip, &max77620_gpio_irqchip,
-				    gpio_irq);
-
 	return 0;
 }
 
-- 
2.26.0

