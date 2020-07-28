Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC39C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4212075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZRJKx1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgG1Nmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:42:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730069AbgG1Nmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595943754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=d1H2TqJa+xnwL6Sscbi4oBQam2i37LFg06gHTI5VeII=;
        b=LZRJKx1eTwds5BGuhlfghgGnjeYk66gmVGdvIJCss7oB3+lcNqJdsp8bnv0sXT9LXc20rA
        Qlr0WcAXeIuew+e5EyqNLny6vZzFm3jat8zLYOQDqWgAjuUkXYHR+TPxYDzBOXUYDAvbwL
        ck2aPtnI2G21wIzqcEuoFm1Q8vQ/UfE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-l7T28TDxMqiUkQWTGMV1GQ-1; Tue, 28 Jul 2020 09:42:33 -0400
X-MC-Unique: l7T28TDxMqiUkQWTGMV1GQ-1
Received: by mail-qk1-f200.google.com with SMTP id t82so12689649qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d1H2TqJa+xnwL6Sscbi4oBQam2i37LFg06gHTI5VeII=;
        b=TRaNyDANlD28KjN9Um551ZOuDprXV50feipbJqWszqBvw0e4oqUEsDRoh/1xTNYa3W
         DnmOkHo/hWr2Aktvcf7Uew4pbiTvEkRxOy6YXff/J5hooN8ta1En7ev6tFuCOyHNM1j2
         hze9pZ0bzTbXYaUY03iOZXJ+mNhgyu8yjpsfxJp1df2Wi1eqzgkTGtO3ZLOb9iW/msnN
         822XoSEOEAlHJtwmTlVXdI4TmTZL0c2LY0uX3XQ/LU++BJ6SN4quOeQJ6JslDjSHOK2a
         QUpnMBSwvP8t91JF5AwrqxbsCZy7M6XbP6NNRQxbM4upUhs65gkAiaG1l1I3Y8fkeCuU
         VuJw==
X-Gm-Message-State: AOAM530c/hbbVE1Wsb7H9oQ3ntS3xKx9u/CSGARUQfptsUdwP2LM1/Y4
        Na6GYbMAjQ5y5E0s6yEbxKpWLqLqugQMeD2WSfswn3dyxg2oJMTPDQKi7iY9SQFOOnPQjJ/T+YK
        0Rq2rqwOUGz6116vtaPsNbG/1
X-Received: by 2002:ac8:4cc2:: with SMTP id l2mr19233693qtv.130.1595943752830;
        Tue, 28 Jul 2020 06:42:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjoBZqluR8LTz0WpQlDuqfrVZK7AmZoX8oS/5fepe6D+QCGMesvqo/QSjTRIUOkRc+AysTQg==
X-Received: by 2002:ac8:4cc2:: with SMTP id l2mr19233674qtv.130.1595943752568;
        Tue, 28 Jul 2020 06:42:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 71sm13879623qkk.125.2020.07.28.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 06:42:32 -0700 (PDT)
From:   trix@redhat.com
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        frank.rowand@sony.com, geert+renesas@glider.be
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] gpiolib: of: reset name variable in of_gpiochip_add_hog
Date:   Tue, 28 Jul 2020 06:42:26 -0700
Message-Id: <20200728134226.27592-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

gpiolib-of.c:664:9: warning: 2nd function call argument
  is an uninitialized value [core.CallAndMessage]
        ret = gpiod_hog(desc, name, lflags, dflags);

name is sometimes set by of_parse_own_gpio
name is always used by gpiod_hog

So it is necessary to reset name so an old value is
not mistakenly used by gpiod_hog.

Fixes: bc21077e084b ("gpio: of: Extract of_gpiochip_add_hog()")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpio/gpiolib-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index bd31dd3b6a75..277ada41d04a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -657,6 +657,7 @@ static int of_gpiochip_add_hog(struct gpio_chip *chip, struct device_node *hog)
 	int ret;
 
 	for (i = 0;; i++) {
+		name = NULL;
 		desc = of_parse_own_gpio(hog, chip, i, &name, &lflags, &dflags);
 		if (IS_ERR(desc))
 			break;
-- 
2.18.1

