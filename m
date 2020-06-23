Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E51C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29DE20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942580;
	bh=vcR6LGpfOhI4Idz/XKhdS9SIlKJ7a5xE9PmNr/VcKAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLrxs8Ve8Unqh1esZbW5mtcvp7s8UXEUTHZmZD8bI3v4FMACFRPQa4kRgCdQKt926
	 hgpjt/3eHr/XLoQCb0bvXDfNmvyaLqp7+Ra0hi33b6o9TL3ea940iGcZ7oklW+kk/W
	 FLGkS2NqwtReKGeSSQqohHH0/2ym4OjOxIG9enJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgFWUC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbgFWUCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:02:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4990A2078A;
        Tue, 23 Jun 2020 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942573;
        bh=vcR6LGpfOhI4Idz/XKhdS9SIlKJ7a5xE9PmNr/VcKAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqsDH3qjpJ4gR+usDjc7YQLnS+Pso15JStp0THhhN2rqoQBA1/nFbtP0DI69nvwXd
         WZ13gER3yy/RyljExGn9hPm9jXgWCpf2HkNwL0uhubt+a34toTtfJgtWRDs4gAXGIq
         5PjjgINKwNKhnPSecmLOeS5wO6vn6ycTWbq3lWNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 052/477] pinctrl: ocelot: Fix GPIO interrupt decoding on Jaguar2
Date:   Tue, 23 Jun 2020 21:50:49 +0200
Message-Id: <20200623195410.066417371@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Povlsen <lars.povlsen@microchip.com>

[ Upstream commit 0b47afc65453a70bc521e251138418056f65793f ]

This fixes a problem with using the GPIO as an interrupt on Jaguar2
(and similar), as the register layout of the platforms with 64 GPIO's
are pairwise, such that the original offset must be multiplied with
the platform stride.

Fixes: da801ab56ad8 pinctrl: ocelot: add MSCC Jaguar2 support.
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Link: https://lore.kernel.org/r/20200513125532.24585-4-lars.povlsen@microchip.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-ocelot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index ed8eac6c14944..4b99922d6c7e7 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -714,11 +714,12 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	struct irq_chip *parent_chip = irq_desc_get_chip(desc);
 	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
 	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int id_reg = OCELOT_GPIO_INTR_IDENT * info->stride;
 	unsigned int reg = 0, irq, i;
 	unsigned long irqs;
 
 	for (i = 0; i < info->stride; i++) {
-		regmap_read(info->map, OCELOT_GPIO_INTR_IDENT + 4 * i, &reg);
+		regmap_read(info->map, id_reg + 4 * i, &reg);
 		if (!reg)
 			continue;
 
-- 
2.25.1



