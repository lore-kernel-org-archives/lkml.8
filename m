Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B207AC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8293B20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF3nhPaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgBZBI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:08:26 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34150 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgBZBI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:08:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id f2so1578575pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSRxDRR3QPnD6JuQNlJ6sV9ISRyrmt4YboW0nA2j284=;
        b=lF3nhPaUVWXf5kzNLk6jWyIu9faR63oYBkMn1CEZg5RkrrCkY7zQKFzQXCVYObbbfN
         54LXPq0209n1zs7QAix/dwsjXZrPlzIRrDH6tZtrXPbae0rXwPzQrXJD/RjUxf5QvAdb
         FyrA9zC1M/oCxnSStu/89EvYdtyyQL3aSWOiR3LYITgdXuK7aMWE93NRnHZfqIVoiopo
         JWt1ViBUMpQyIUvFNzz7zr4YyemDhWQ4HKE8GCnpguWFlhW+ggilnxLLQP09nl+j70cg
         8316ccpDQrOi5Bf1XnKBSWLAeDPDqyD5x+eqJ8XNU20QP3AkMjQ9l52QKUzSz+ctyyg7
         2OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSRxDRR3QPnD6JuQNlJ6sV9ISRyrmt4YboW0nA2j284=;
        b=EtSA+TqrkUaEw2qjAuvbN/wX9jPHomi47b0t1PFQxqE7W7IGdChRhQeAoADvh2XzQq
         7Uu038XBDqPInK85ZEuUtBFc/JahTkK+l6iYokpTXVFQS6NeucyxmKJ5DJtMWAWy8kUf
         xrA2sfYaqihOfZEWd7Dy/fEjTARxVPFoRjS8oAsYq3A89o4qJMPuaE1z3cyvDMCqJIjz
         sAgjMqaWcDyoipxzc1jOENRGnFrfOVaA8ofvQaFO+bz3Yb6I6qUiAH6Ma+PlDiz+oQ7h
         064oIu7VM4GXK9zjylRrGrHq5aUaNbFUdSyF0c6uNvJ9fHTGd9HKweQhW1G6TD5ZaLJR
         DRbA==
X-Gm-Message-State: APjAAAXLzfinl/v3W83R/li+pYwoz3633lBsooo8ekinCiDV1yTXDpCm
        wsC337WIdbMbXlUG784OzpM=
X-Google-Smtp-Source: APXvYqyHJow8kKav0oGHIR31yE3aVuvG9BkoEd02oVkQ/clFawVQlD8gy4qC/7PX43MlFAOl5OoTMQ==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr1240760plp.339.1582679304720;
        Tue, 25 Feb 2020 17:08:24 -0800 (PST)
Received: from D19-03074.biamp.com (tel3187236.lnk.telstra.net. [203.54.172.54])
        by smtp.gmail.com with ESMTPSA id w18sm296386pfq.167.2020.02.25.17.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 17:08:24 -0800 (PST)
From:   Shreyas Joshi <shreyasjoshi15@gmail.com>
X-Google-Original-From: Shreyas Joshi <shreyas.joshi@biamp.com>
To:     lee.jones@linaro.org, Support.Opensource@diasemi.com,
        shreyasjoshi15@gmail.com, Adam.Thomson.Opensource@diasemi.com,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Subject: [PATCH V6] mfd: da9062: Add support for interrupt polarity defined in device tree
Date:   Wed, 26 Feb 2020 11:07:22 +1000
Message-Id: <20200226010722.2042-1-shreyas.joshi@biamp.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The da9062 interrupt handler cannot necessarily be low active.
Add a function to configure the interrupt type based on what is defined in the device tree.
The allowable interrupt type is either low or high level trigger.

Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
---

V6:
  Changed regmap_reg_range to exclude DA9062AA_CONFIG_B for writeable
  Added regmap_reg_range DA9062AA_CONFIG_A for readable

V5:
  Added #define for DA9062_IRQ_HIGH and DA9062_IRQ_LOW 

V4:
  Changed return code to EINVAL rather than EIO for incorrect irq type
  Corrected regmap_update_bits usage
  
V3:
  Changed regmap_write to regmap_update_bits

V2:
  Added function to update the polarity of CONFIG_A IRQ_TYPE
  
 drivers/mfd/da9062-core.c | 44 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 419c73533401..fc30726e2e27 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -21,6 +21,9 @@
 #define	DA9062_REG_EVENT_B_OFFSET	1
 #define	DA9062_REG_EVENT_C_OFFSET	2
 
+#define	DA9062_IRQ_LOW	0
+#define	DA9062_IRQ_HIGH	1
+
 static struct regmap_irq da9061_irqs[] = {
 	/* EVENT A */
 	[DA9061_IRQ_ONKEY] = {
@@ -369,6 +372,33 @@ static int da9062_get_device_type(struct da9062 *chip)
 	return ret;
 }
 
+static u32 da9062_configure_irq_type(struct da9062 *chip, int irq, u32 *trigger)
+{
+	u32 irq_type = 0;
+	struct irq_data *irq_data = irq_get_irq_data(irq);
+
+	if (!irq_data) {
+		dev_err(chip->dev, "Invalid IRQ: %d\n", irq);
+		return -EINVAL;
+	}
+	*trigger = irqd_get_trigger_type(irq_data);
+
+	switch (*trigger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type = DA9062_IRQ_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type = DA9062_IRQ_LOW;
+		break;
+	default:
+		dev_warn(chip->dev, "Unsupported IRQ type: %d\n", *trigger);
+		return -EINVAL;
+	}
+	return regmap_update_bits(chip->regmap, DA9062AA_CONFIG_A,
+			DA9062AA_IRQ_TYPE_MASK,
+			irq_type << DA9062AA_IRQ_TYPE_SHIFT);
+}
+
 static const struct regmap_range da9061_aa_readable_ranges[] = {
 	regmap_reg_range(DA9062AA_PAGE_CON, DA9062AA_STATUS_B),
 	regmap_reg_range(DA9062AA_STATUS_D, DA9062AA_EVENT_C),
@@ -388,6 +418,7 @@ static const struct regmap_range da9061_aa_readable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -417,6 +448,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_A, DA9062AA_VBUCK4_A),
 	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 	regmap_reg_range(DA9062AA_VLDO1_A, DA9062AA_VLDO4_A),
+	regmap_reg_range(DA9062AA_CONFIG_A, DA9062AA_CONFIG_A),
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
@@ -596,6 +628,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
 	int cell_num;
+	u32 trigger_type = 0;
 	int ret;
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(*chip), GFP_KERNEL);
@@ -654,10 +687,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
+	ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to configure IRQ type\n");
+		return ret;
+	}
+
 	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
-			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
-			-1, irq_chip,
-			&chip->regmap_irq);
+			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
+			-1, irq_chip, &chip->regmap_irq);
 	if (ret) {
 		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
 			i2c->irq, ret);
-- 
2.20.1

