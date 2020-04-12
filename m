Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C87C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBC20753
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 01:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwPTvAUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDLBeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 21:34:00 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40566 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDLBeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 21:34:00 -0400
Received: by mail-qv1-f65.google.com with SMTP id k9so2818236qvw.7;
        Sat, 11 Apr 2020 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3nQaM43k9Rklf2xLNnAGkRhKH0gN0HpijPYsLTLZdM=;
        b=AwPTvAUITiOJF80dM/rPAHATDeQ3GU/8cDAo/hNSm4EOixAspTDZ53W/ovEXabIXJP
         e0xUYfwOywrkk9NqihZ14MIAOHUhXmTwoQsbk0GAGjO98BJAnpUk9DdqI1HNB2FQAjUI
         4pH3/Yb/3y+UnAxVViaohluOE0a8zpMYnGerS8s4wIe+fCtRTh2Kjxx9Ci7RpiP3AbNN
         GO88B3Ft2D0KY+4FC1mRrbhHu8yq40rZLboGWpdk2e2cvGB+OG3S73cHpUcKEYeYTT0K
         pCzrZ1tQKwokXPE2RzleSzlhvv52z5xs2Ah7M8BPGQKvrq9QnWEqMsqdzrYneMcA+uJX
         Zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3nQaM43k9Rklf2xLNnAGkRhKH0gN0HpijPYsLTLZdM=;
        b=lQd3bbPFEfYQEaQIYB3V59nO1Giacdkmt/p8PCBizIk1LDJ0a4N34P+bVjiLIpjdCb
         LEq3gXSljg1RfPZZJF7J42WxuYXCjDB/nLzQQnWRCacnkJaLpCudPieXH8jE1iKHKxnQ
         GNTCiHe0DWvRDotddcV8iUPb4kJh4aLHIHZKj4Fn3Py2hN87o9obsEbjdLMv2KyHwUgr
         iJAv+O+Oa4qCqd+QZjoFcQ00Ev0nGsckGAd4O/UOYUcm9iUyn8g/0cf/9kEFIhfBCZGI
         dx+QF4NK3c5fZBon5xNCZ0pPuySFusNM/vK9n+DG+GpXBB2b+5cLQrn3p5r44N3Kdj/t
         lobg==
X-Gm-Message-State: AGi0PuYcx6FnvpNX4aiVqZXvPb1PtZ9VcZKsS9NF5dJTUkssTWs/gweT
        cC3eu5xx4u/dEJ9nlubHFWHQcxQngVY=
X-Google-Smtp-Source: APiQypJiEV0RnRUmTyA/JuKefTQfZz6CM0s4Ym1Yzm4HZEMGiidJ3sWyRm1wpigUBRrhybZ2bO6rIQ==
X-Received: by 2002:a0c:f70d:: with SMTP id w13mr11652746qvn.118.1586655239720;
        Sat, 11 Apr 2020 18:33:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id n92sm4965192qtd.68.2020.04.11.18.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 18:33:59 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpiolib: of: Improve gpiolib-of support pull up/down on expanders
Date:   Sat, 11 Apr 2020 20:33:51 -0500
Message-Id: <20200412013352.674506-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using GPIO expanders attached to I2C ports, their set_config function
needs to be passed a config setting which contains options to enable pull
up or pull down bias feature.  In order to set this config properly,
the gpio parser needs to handle GPIO_PULL_UP and GPIO_PULL_DOWN.

This patch enables the flags corresponding to GPIO_PULL_UP and
GPIO_PULL_DOWN.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index c6d30f73df07..bf17afb1f66d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -344,6 +344,12 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 	if (transitory)
 		lflags |= GPIO_TRANSITORY;
 
+	if (flags & OF_GPIO_PULL_UP)
+		lflags |= GPIO_PULL_UP;
+
+	if (flags & OF_GPIO_PULL_DOWN)
+		lflags |= GPIO_PULL_DOWN;
+
 	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
 		gpiod_put(desc);
@@ -585,6 +591,10 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 		*lflags |= GPIO_ACTIVE_LOW;
 	if (xlate_flags & OF_GPIO_TRANSITORY)
 		*lflags |= GPIO_TRANSITORY;
+	if (xlate_flags & OF_GPIO_PULL_UP)
+		*lflags |= GPIO_PULL_UP;
+	if (xlate_flags & OF_GPIO_PULL_DOWN)
+		*lflags |= GPIO_PULL_DOWN;
 
 	if (of_property_read_bool(np, "input"))
 		*dflags |= GPIOD_IN;
-- 
2.25.1

