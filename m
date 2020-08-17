Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108D72078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597647805;
	bh=cZA9ZUARN+utcYkCJWoSAM3zaWPeBpxOmpgTjJgh5s8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/xRSnqqqkEhEta8/GP9DWpX230PFCLoTtRWEf8TBMVk0Lvi9OWgn+n0xE+GPw5ID
	 FS8q6TehzP12pdw9LWKyODxOyCcORiqIcsybPPU8YfMH7PiILCRVf7n5toyxHmsCSU
	 M3b+ZTuw3KBxEmgpx5Ap/16gkhbaITKyr82sAi1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHQHDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgHQHA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A2A207FB;
        Mon, 17 Aug 2020 07:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647628;
        bh=cZA9ZUARN+utcYkCJWoSAM3zaWPeBpxOmpgTjJgh5s8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tD4Cr2JesNZLkoLInAuT7zRPnlGs2KbpxEfpPfVFYqhs8MJ/zpMI7culDGiYnTT6v
         XzNbsKqHjbMt39ifPAlL0qdmVqmakqTLQKo9wIHmw2kvf/k1PO/Ikbvf1OYBGb9eyW
         RIG5syYrs+k6kw+ToWuVQPRr3YuC42EM8Qlpy9X8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 05/13] extcon: ptn5150: Use generic "interrupts" property
Date:   Mon, 17 Aug 2020 09:00:01 +0200
Message-Id: <20200817070009.4631-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts do not have to be always GPIO based so instead of expecting
"int-gpios" property and converting the GPIO to an interrupt, just
accept any interrupt via generic "interrupts" property.

Keep support for old "int-gpios" for backward compatibility.

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

