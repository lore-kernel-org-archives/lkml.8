Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA194C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FBA20748
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASfk4mbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgFGQa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgFGQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:30:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BBCC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:30:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a9so13935846ljn.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cA0rxP4uX8r0J5dTgAkrFDikDC5/+iYQEYBegCVDUX8=;
        b=ASfk4mbizWj5L7lpupyxEymymo/ZPFF5KNCbDMYF6Et1/uJaP800Mfx0DoYPGapzb3
         hv+HiIqeR8Jmk4vCo83x/+lGNoqGIhXXzuS7cqSUerNNvoyN+x+fG13WxaDOjJb1P7zY
         Hq00PryzQhJZ5KYXKmAzcJzfwntzokREZ+XswmdY6VcJHEszaNWj2fnnA1Pab+RGwv8b
         hQxJ7lsbe7/eI/X8X/Vo44h3opbHOiIy5xfS29Vu0NQ7uivA+7aD2UN+EMTD/qlmCC+U
         ml+/P1OFSTs+7tzsHv2dzm7qCRG1MvFt5+YpubFXKPhydNo/YV+sVDIvl7zNr8I2E3iJ
         M3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cA0rxP4uX8r0J5dTgAkrFDikDC5/+iYQEYBegCVDUX8=;
        b=dBUm70uVd7VlB5LikSBXDm+rAQqhtEvtFB6VuNSCGpbhyNWlXwEHGqcVlxZ6LAQbtj
         lMmHgKxtsGYmRNn+iRXP595lUP6gDUX1ogEAqq2b1O4EuxmbUgHcvI+lVutiTY9kRqZT
         /WHAC4xU5h30dMPQG5boBQkq3VMWQWIIgqn82Pvwel7LmcCU7iv9r6MQCzC6kTS56RkG
         jOeYRbRQHKnLL14Jd7sjkcBFGsy99zOG0BneuDofpkE0Xrjr/MkN2XJGa1fmcHCqaYjs
         yQmnLb3wM2mXydoevB6nET7G+ZFf1Jml9tU/PU+QH4juajyDylA/z3gbfEMC7BcEAuSD
         B7pw==
X-Gm-Message-State: AOAM531EsnjI5O9vBnkMPYGjSfSSjF7e/5PAK/8pIGh75c7lOEw9Nvv6
        2QpH1dG+TQ/RX4wstm9b94Rsrw==
X-Google-Smtp-Source: ABdhPJyjLyOxmRLxqc1IiL0wIQLnC2WD0apwurqLMvIwHjY92oYJs7K6WG3OlmNqcFSoR6JrCrCN7w==
X-Received: by 2002:a2e:1412:: with SMTP id u18mr9629998ljd.309.1591547450613;
        Sun, 07 Jun 2020 09:30:50 -0700 (PDT)
Received: from localhost.localdomain (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.googlemail.com with ESMTPSA id l7sm1726511ljj.55.2020.06.07.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:30:50 -0700 (PDT)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v4 03/10] media: i2c: imx290: fix reset GPIO pin handling
Date:   Sun,  7 Jun 2020 19:30:18 +0300
Message-Id: <20200607163025.8409-4-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607163025.8409-1-andrey.konovalov@linaro.org>
References: <20200607163025.8409-1-andrey.konovalov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to https://www.kernel.org/doc/Documentation/gpio/consumer.txt,

- all of the gpiod_set_value_xxx() functions operate with the *logical* value.
So in imx290_power_on() the reset signal should be cleared/de-asserted with
gpiod_set_value_cansleep(imx290->rst_gpio, 0), and in imx290_power_off() the
value of 1 must be used to apply/assert the reset to the sensor. In the device
tree the reset pin is described as GPIO_ACTIVE_LOW, and gpiod_set_value_xxx()
functions take this into account,

- when devm_gpiod_get_optional() is called with GPIOD_ASIS, the GPIO is not
initialized, and the direction must be set later; using a GPIO
without setting its direction first is illegal and will result in undefined
behavior. Fix this by using GPIOD_OUT_HIGH instead of GPIOD_ASIS (this asserts
the reset signal to the sensor initially).

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/imx290.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index d0322f9a8856..7b1de1f0c8b7 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -628,7 +628,7 @@ static int imx290_power_on(struct device *dev)
 	}
 
 	usleep_range(1, 2);
-	gpiod_set_value_cansleep(imx290->rst_gpio, 1);
+	gpiod_set_value_cansleep(imx290->rst_gpio, 0);
 	usleep_range(30000, 31000);
 
 	return 0;
@@ -641,7 +641,7 @@ static int imx290_power_off(struct device *dev)
 	struct imx290 *imx290 = to_imx290(sd);
 
 	clk_disable_unprepare(imx290->xclk);
-	gpiod_set_value_cansleep(imx290->rst_gpio, 0);
+	gpiod_set_value_cansleep(imx290->rst_gpio, 1);
 	regulator_bulk_disable(IMX290_NUM_SUPPLIES, imx290->supplies);
 
 	return 0;
@@ -757,7 +757,8 @@ static int imx290_probe(struct i2c_client *client)
 		goto free_err;
 	}
 
-	imx290->rst_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	imx290->rst_gpio = devm_gpiod_get_optional(dev, "reset",
+						   GPIOD_OUT_HIGH);
 	if (IS_ERR(imx290->rst_gpio)) {
 		dev_err(dev, "Cannot get reset gpio\n");
 		ret = PTR_ERR(imx290->rst_gpio);
-- 
2.17.1

