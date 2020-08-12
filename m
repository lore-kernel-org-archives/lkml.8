Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C139FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AC12080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249827;
	bh=GuxKhABf5nd+bNmYO2713nFRWWYvL9bTfzoRfMGaMxU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouiMPlRxnP74T7Al0XpFr5gdOep5oVshN96MfVlEzwVf60ALAe8ITF6UsONG2fzLi
	 nuWO15be3tPDUBHFNEUu3RgHAzsHVdOQoINquhq6zmpnN8KnkfjoTftOU72qoO4x1C
	 8fPXznGqX2UWt0sbotpzg6cS+KKdBq7TcKZyJN+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgHLQa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgHLQaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD7E207DA;
        Wed, 12 Aug 2020 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249820;
        bh=GuxKhABf5nd+bNmYO2713nFRWWYvL9bTfzoRfMGaMxU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NqZWtyCG63Z1ErQExIZIMv4zoJObfsNVemqQHog5oEF4+hZgM1AtyEFc27+mUT5iU
         8x6JcQ/M+jRkSQvCckE+tSw0YV7PqpHkV7tJveUECzA4DsX0q+LG5uvVBw78yJDcSx
         To4Keg+VxoasYxpPon+eNGwu8LatgQAkg4rwt3gQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 08/11] extcon: ptn5150: Check current USB mode when probing
Date:   Wed, 12 Aug 2020 18:29:55 +0200
Message-Id: <20200812162958.6180-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When machine boots up, the USB could be already in OTG mode.  In such
case there will be no interrupt coming to ptn5150 device and driver will
report default state of nothing connected.  Detection of USB connection
would happen on first unplug of the cable.

Factor out code for checking current connection mode and call it right
after probe so the existing USB mode will be properly reported.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 93 ++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index a57fef384a29..bbb185378e4b 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -5,6 +5,7 @@
 // Based on extcon-sm5502.c driver
 // Copyright (c) 2018-2019 by Vijai Kumar K
 // Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
+// Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
 
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -83,12 +84,50 @@ static const struct regmap_config ptn5150_regmap_config = {
 	.max_register	= PTN5150_REG_END,
 };
 
+static void ptn5150_check_state(struct ptn5150_info *info)
+{
+	unsigned int port_status, reg_data, vbus;
+	int ret;
+
+	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
+	if (ret) {
+		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
+		mutex_unlock(&info->mutex);
+		return;
+	}
+
+	port_status = ((reg_data &
+			PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
+			PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
+
+	switch (port_status) {
+	case PTN5150_DFP_ATTACHED:
+		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, false);
+		gpiod_set_value_cansleep(info->vbus_gpiod, 0);
+		extcon_set_state_sync(info->edev, EXTCON_USB, true);
+		break;
+	case PTN5150_UFP_ATTACHED:
+		extcon_set_state_sync(info->edev, EXTCON_USB, false);
+		vbus = ((reg_data & PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
+			PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
+		if (vbus)
+			gpiod_set_value_cansleep(info->vbus_gpiod, 0);
+		else
+			gpiod_set_value_cansleep(info->vbus_gpiod, 1);
+
+		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, true);
+		break;
+	default:
+		dev_err(info->dev, "Unknown Port status : %x\n", port_status);
+		break;
+	}
+}
+
 static void ptn5150_irq_work(struct work_struct *work)
 {
 	struct ptn5150_info *info = container_of(work,
 			struct ptn5150_info, irq_work);
 	int ret = 0;
-	unsigned int reg_data;
 	unsigned int int_status;
 
 	if (!info->edev)
@@ -96,13 +135,6 @@ static void ptn5150_irq_work(struct work_struct *work)
 
 	mutex_lock(&info->mutex);
 
-	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
-	if (ret) {
-		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
-		mutex_unlock(&info->mutex);
-		return;
-	}
-
 	/* Clear interrupt. Read would clear the register */
 	ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
 	if (ret) {
@@ -116,41 +148,7 @@ static void ptn5150_irq_work(struct work_struct *work)
 
 		cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
 		if (cable_attach) {
-			unsigned int port_status;
-			unsigned int vbus;
-
-			port_status = ((reg_data &
-					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
-					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
-
-			switch (port_status) {
-			case PTN5150_DFP_ATTACHED:
-				extcon_set_state_sync(info->edev,
-						EXTCON_USB_HOST, false);
-				gpiod_set_value_cansleep(info->vbus_gpiod, 0);
-				extcon_set_state_sync(info->edev, EXTCON_USB,
-						true);
-				break;
-			case PTN5150_UFP_ATTACHED:
-				extcon_set_state_sync(info->edev, EXTCON_USB,
-						false);
-				vbus = ((reg_data &
-					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
-					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
-				if (vbus)
-					gpiod_set_value_cansleep(info->vbus_gpiod, 0);
-				else
-					gpiod_set_value_cansleep(info->vbus_gpiod, 1);
-
-				extcon_set_state_sync(info->edev,
-						EXTCON_USB_HOST, true);
-				break;
-			default:
-				dev_err(info->dev,
-					"Unknown Port status : %x\n",
-					port_status);
-				break;
-			}
+			ptn5150_check_state(info);
 		} else {
 			extcon_set_state_sync(info->edev,
 					EXTCON_USB_HOST, false);
@@ -302,6 +300,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return -EINVAL;
 
+	/*
+	 * Update current extcon state if for example OTG connection was there
+	 * before the probe
+	 */
+	mutex_lock(&info->mutex);
+	ptn5150_check_state(info);
+	mutex_unlock(&info->mutex);
+
 	return 0;
 }
 
@@ -334,4 +340,5 @@ subsys_initcall(ptn5150_i2c_init);
 
 MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
 MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

