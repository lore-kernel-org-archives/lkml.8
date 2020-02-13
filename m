Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1F020661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608987;
	bh=BRGdb39o6KiX1GYeb77oPg7kviPZ0igBxsr75tLPU5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D35fkwLijEDkqBrDBrpTLI4C4UDv5GdDGKicdKfQeqSdniUDzBrSo+npBgJS29H9V
	 xMTYdOPKZB1Sh2bLUADKV/sFEVqAA+X/oSy2KNNl6oJK2W2/tB4vWE/oBENOIBvaph
	 dXmVUIPWr+zaqF+lYA9kejOAQTRcl+tsxaszmO74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgBMPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387621AbgBMP0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:39 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC40222C2;
        Thu, 13 Feb 2020 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607599;
        bh=BRGdb39o6KiX1GYeb77oPg7kviPZ0igBxsr75tLPU5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XBySZyfOkGU/w/2PC9hnPgxnTLcJUvnJa0CLKLO//cqbJqMhkc8N9mDEbSEPnNAA
         PPOCJFc05siZkd23+Ok3yagu6z6Y0Nkx2nETuYFXs/O7Qmz8NC8dQb1IFPHPfklQj0
         m324eZJ9Yjhm2y1Y5Y7l0ON7C9RImFkZpRyc0ZoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brandon Maier <Brandon.Maier@collins.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 17/52] gpio: zynq: Report gpio direction at boot
Date:   Thu, 13 Feb 2020 07:20:58 -0800
Message-Id: <20200213151817.875907127@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <Brandon.Maier@collins.com>

commit 6169005ceb8c715582eca70df3912cd2b351ede2 upstream

The Zynq's gpios can be configured by the bootloader. But Linux will
erroneously report all gpios as inputs unless we implement
get_direction().

Signed-off-by: Brandon Maier <Brandon.Maier@collins.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-zynq.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index a9238fb150131..5dec96155814b 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -357,6 +357,28 @@ static int zynq_gpio_dir_out(struct gpio_chip *chip, unsigned int pin,
 	return 0;
 }
 
+/**
+ * zynq_gpio_get_direction - Read the direction of the specified GPIO pin
+ * @chip:	gpio_chip instance to be worked on
+ * @pin:	gpio pin number within the device
+ *
+ * This function returns the direction of the specified GPIO.
+ *
+ * Return: 0 for output, 1 for input
+ */
+static int zynq_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
+{
+	u32 reg;
+	unsigned int bank_num, bank_pin_num;
+	struct zynq_gpio *gpio = gpiochip_get_data(chip);
+
+	zynq_gpio_get_bank_pin(pin, &bank_num, &bank_pin_num, gpio);
+
+	reg = readl_relaxed(gpio->base_addr + ZYNQ_GPIO_DIRM_OFFSET(bank_num));
+
+	return !(reg & BIT(bank_pin_num));
+}
+
 /**
  * zynq_gpio_irq_mask - Disable the interrupts for a gpio pin
  * @irq_data:	per irq and chip data passed down to chip functions
@@ -829,6 +851,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->free = zynq_gpio_free;
 	chip->direction_input = zynq_gpio_dir_in;
 	chip->direction_output = zynq_gpio_dir_out;
+	chip->get_direction = zynq_gpio_get_direction;
 	chip->base = of_alias_get_id(pdev->dev.of_node, "gpio");
 	chip->ngpio = gpio->p_data->ngpio;
 
-- 
2.20.1



