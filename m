Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A9AC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE2720771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249836;
	bh=aRNIdyFGDEVq5YbckPNv6Oi2knBVAOE2NwnDD8n86kQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYjJa9+woiaWTkaETOroEbNwUPvM2+lT6b+NnX5koU76Ic+BEUPc5oJUw2MYpnNos
	 MP2Pn1HvCHbtHJfBetgN8doGw9m/RloTPQp9dDK5BLsyL+ZcKrNyMy1h2e9C1ns7Yp
	 XrTn/kl4F+GbA8UUB2UK9A4AnuvEnIMoNReVRZsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgHLQaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgHLQaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB1C20838;
        Wed, 12 Aug 2020 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249813;
        bh=aRNIdyFGDEVq5YbckPNv6Oi2knBVAOE2NwnDD8n86kQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hckRolMk/frqldIVx8MbphEyY0rtqnyRrksVVE7bOBIdVDRfz4utioX/h7SYLWEpT
         iXPzSwHW9dYXL3VkggOrF4FXFU2EmSbjViDAxEpzNB4BwKGZaJw5KPVQpKhRz/c2rp
         ub+mRvN5jkbe1mzAN0A94RtUrx/zDVdNDHWinWHU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 05/11] extcon: ptn5150: Use generic "interrupts" property
Date:   Wed, 12 Aug 2020 18:29:52 +0200
Message-Id: <20200812162958.6180-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts do not have to be always GPIO based so instead of expecting
"int-gpios" property and converting the GPIO to an interrupt, just
accept any interrupt via generic "interrupts" property.

Keep support for old "int-gpios" for backware compatibility.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 5f5252752644..12e52ddbd77e 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -239,11 +239,6 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 
 	info->dev = &i2c->dev;
 	info->i2c = i2c;
-	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
-	if (IS_ERR(info->int_gpiod)) {
-		dev_err(dev, "failed to get INT GPIO\n");
-		return PTR_ERR(info->int_gpiod);
-	}
 	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
 	if (IS_ERR(info->vbus_gpiod)) {
 		dev_err(dev, "failed to get VBUS GPIO\n");
@@ -267,22 +262,30 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (info->int_gpiod) {
+	if (i2c->irq > 0) {
+		info->irq = i2c->irq;
+	} else {
+		info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
+		if (IS_ERR(info->int_gpiod)) {
+			dev_err(dev, "failed to get INT GPIO\n");
+			return PTR_ERR(info->int_gpiod);
+		}
+
 		info->irq = gpiod_to_irq(info->int_gpiod);
 		if (info->irq < 0) {
 			dev_err(dev, "failed to get INTB IRQ\n");
 			return info->irq;
 		}
+	}
 
-		ret = devm_request_threaded_irq(dev, info->irq, NULL,
-						ptn5150_irq_handler,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						i2c->name, info);
-		if (ret < 0) {
-			dev_err(dev, "failed to request handler for INTB IRQ\n");
-			return ret;
-		}
+	ret = devm_request_threaded_irq(dev, info->irq, NULL,
+					ptn5150_irq_handler,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					i2c->name, info);
+	if (ret < 0) {
+		dev_err(dev, "failed to request handler for INTB IRQ\n");
+		return ret;
 	}
 
 	/* Allocate extcon device */
-- 
2.17.1

