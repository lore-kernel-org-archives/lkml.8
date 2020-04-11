Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329ACC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AE320757
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PZ/NpT7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDKREI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 13:04:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46182 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgDKREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 13:04:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id f13so5582615wrm.13;
        Sat, 11 Apr 2020 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0q2fKgSBRhLM1xO7rLbH5yRPkbOobCmPZS97hpoNVA0=;
        b=PZ/NpT7+fJNJfMN8f4fzRXEbqHEHmtUZk6vVaXMRrEoo/FHzhgPkhzvoPjlqfFoJOi
         3U2aA26CFcYr4LFkJFbFByB3MM31E2Pouxz+6LNJhMmZ0Me1Wl61n7PGgBueel+BH1sR
         xlrgIOHMVa8Jnd9TS4sJGVCun+h7mELpPtE+R1zunW7VFnLoAc1Zz8khIjw+N+xnEsQN
         YWHC1ijj1Gy7O0lZIrYNoqvCNXccYkcJDHVExZGYxknXNt0pSE9qn14R2pz2ICWWGtdL
         aAuBidR1XlHY1oh48gGVY94BokXCwn6ub2+XhAiCWjq8aqmJPDJwSQgq4TJtWy3GuIIb
         KC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0q2fKgSBRhLM1xO7rLbH5yRPkbOobCmPZS97hpoNVA0=;
        b=JK/9Ln2uix8jo8Ifn1Hj4XBrxX/WwpqkxWu+kzqu0MA2287wE3Fy4IYVQaSu12H1xz
         XwDXfo+qcO3Blr+BYCdvvTTEtovDrYJ+CcgUZOXSFx1wMEBGZ2FO21zxgbwoGP7X7mpb
         O5kIOr2gP1vmML8oC057j94MiMRseqnNeMr5SAhJGCoTTyeBPi0sA5/if0hr0gJWUUfN
         l27sIwtrBREXhK356wlq8Nz7EUbTrhVap5eJjYOoXVcrKrl1XE3AEO00MA0zMyCVs1Xw
         lBSqk1LSyk+VgIl44j/qVon7fOu2hcNJIOZf/XBKkPrr9x0LUhbHecP9E7B8NVtb57ks
         BV+g==
X-Gm-Message-State: AGi0PuYuGbJ7BWpO3Ba2kPsv0TjyEhBC1kBb+XuDGQCqbu3hFcZtxRi7
        vNdqMAOScqfF68Okun8IFWY=
X-Google-Smtp-Source: APiQypKF2Y/xf57pA4qKcjYugTlUoLUad9MGxVceyiUevVDpTs87m0hSyC03IicQqskKxYHznIcN8g==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr11322589wrt.103.1586624644812;
        Sat, 11 Apr 2020 10:04:04 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x18sm7105067wmi.29.2020.04.11.10.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 10:04:04 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 2/2] pinctrl: meson: wire up the gpio_chip's set_config callback
Date:   Sat, 11 Apr 2020 19:03:56 +0200
Message-Id: <20200411170356.1578031-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411170356.1578031-1-martin.blumenstingl@googlemail.com>
References: <20200411170356.1578031-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use gpiochip_generic_config for the gpio_chip's set_config callback so
GPIO flags like GPIO_PULL_UP or GPIO_PULL_DOWN can be used in the board
.dts descriptions.
This is required for some Meson8m2 boards where GPIO_BSD_EN provides the
"MUTE" signal and requires enabling the internal pull-up resistor.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 291f3078e7c7..079f8ee8d353 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -603,6 +603,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 	pc->chip.parent = pc->dev;
 	pc->chip.request = gpiochip_generic_request;
 	pc->chip.free = gpiochip_generic_free;
+	pc->chip.set_config = gpiochip_generic_config;
 	pc->chip.get_direction = meson_gpio_get_direction;
 	pc->chip.direction_input = meson_gpio_direction_input;
 	pc->chip.direction_output = meson_gpio_direction_output;
-- 
2.26.0

