Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F90C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE682075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pZSCdYsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgFVVq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:46:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:34258 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbgFVVq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1592862376; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSFfecEJZ2Br9jQI/s7igbpy7SV0eFCH93xlSkAnB1I=;
        b=pZSCdYsq3KfcyqRF5UgqTA2x0HMJ29OH1l3ITs89cXYN1dORtxkfkTKoreOPGr886xYg0W
        FBex0WdHxgL71F5kxQTQ1ikKVvrheb7huWVd4f+JB9n+q3k7dS/sMLgxsQmpPZxq5ctdZc
        KjSDgeDQqztsO5bB9nmOzlvFBK3jNCo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Henrique?= <johnnyonflame@hotmail.com>
Subject: [PATCH 2/2] pinctrl: ingenic: Properly detect GPIO direction when configured for IRQ
Date:   Mon, 22 Jun 2020 23:45:48 +0200
Message-Id: <20200622214548.265417-2-paul@crapouillou.net>
In-Reply-To: <20200622214548.265417-1-paul@crapouillou.net>
References: <20200622214548.265417-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAT1 register contains information about the IRQ type (edge/level)
for input GPIOs with IRQ enabled, and the direction for non-IRQ GPIOs.
So it makes sense to read it only if the GPIO has no interrupt
configured, otherwise input GPIOs configured for level IRQs are
misdetected as output GPIOs.

Cc: stable@vger.kernel.org
Fixes: ebd6651418b6 ("pinctrl: ingenic: Implement .get_direction for GPIO chips")
Reported-by: João Henrique <johnnyonflame@hotmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 241e563d5814..a8d1b53ec4c1 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -1958,7 +1958,8 @@ static int ingenic_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 	unsigned int pin = gc->base + offset;
 
 	if (jzpc->info->version >= ID_JZ4760) {
-		if (ingenic_get_pin_config(jzpc, pin, JZ4760_GPIO_PAT1))
+		if (ingenic_get_pin_config(jzpc, pin, JZ4760_GPIO_INT) ||
+		    ingenic_get_pin_config(jzpc, pin, JZ4760_GPIO_PAT1))
 			return GPIO_LINE_DIRECTION_IN;
 		return GPIO_LINE_DIRECTION_OUT;
 	}
-- 
2.27.0

