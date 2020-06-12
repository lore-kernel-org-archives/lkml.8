Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34536C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127EA20792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WxrqkciN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFLMGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:06:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53832 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1591963590; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=VD1lYp851tEOX4dOM9B2+TveG6z7jeQIId2w1xa70ys=;
        b=WxrqkciNWOfuttyELtwbtPk+/F1p08zytlofkozjNh8fy99rVkwry5GyUjT1OaqmWU5sQE
        h+b3nUvdnK1PuB7zF7DqU32ERmz7aKbElGFOgC9ftssBV88AFPx9hqA/Nyn3hFIyAhqTEw
        vIuWV8cKeBjgEBBtfh+Oud9iIjhRydM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     od@zcrc.me, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] pinctrl: ingenic: Add ingenic,jz4725b-gpio compatible string
Date:   Fri, 12 Jun 2020 14:06:09 +0200
Message-Id: <20200612120609.12730-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string to support the GPIO chips on the JZ4725B SoC.
There was already a compatible string for the pinctrl node, but not for
the individual GPIO chip nodes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    The Ingenic pinctrl devicetree documentation will be properly
    updated in a separate patchset.

 drivers/pinctrl/pinctrl-ingenic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 6a8d44504f94..0f624ba7075d 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -2292,6 +2292,7 @@ static const struct regmap_config ingenic_pinctrl_regmap_config = {
 
 static const struct of_device_id ingenic_gpio_of_match[] __initconst = {
 	{ .compatible = "ingenic,jz4740-gpio", },
+	{ .compatible = "ingenic,jz4725b-gpio", },
 	{ .compatible = "ingenic,jz4760-gpio", },
 	{ .compatible = "ingenic,jz4770-gpio", },
 	{ .compatible = "ingenic,jz4780-gpio", },
-- 
2.27.0

