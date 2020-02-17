Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50808C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2006920718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZWPTKkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBQC1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:27:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46632 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQC1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:27:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id b35so8096953pgm.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 18:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hi+7gFsTmZyrz3ap1i/enKvUy7a27c6rw8lfHWInIaw=;
        b=UZWPTKkz2yeWjLOqQnend4QDDPmTi0GrN0CRBO/JvlH86oQO6n8ha653Xt57EXyyD8
         UC24fJ4hOJmT+/IryGuK/XJsVNtnUlyf3XAzVpRO08BgcHomHC6HiqT2jZw6oRz+fGty
         Zhx4TiXPlQMW7LGqpzLyBUXe0k4A7GHOx6+xHPi6PpzBQW3Zp9mT9cJMqcT0gVfYOH2v
         bVL25HQJ3WY5GzRSxh5aPz4nbO9GMg3n585k1TplwJJinVhhlk8K7mQMPg4HMU3xHtgg
         +FoDGxD0I453gtwDz/dkhMzdaxjepnvP/kTGKUIyiot+i8l9M20gO5IM7hXvQZedghGe
         TjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hi+7gFsTmZyrz3ap1i/enKvUy7a27c6rw8lfHWInIaw=;
        b=oeaG7GC3izY2GsivXLyKZSn67B8M3CwmjRexws1HodvKJ+f8M84cjNlpAJzf0bWeKc
         o2md4/HFOZ6AFN2bJzX+MWvht0DsyaUIxgDVRBvYmbOjsdPySxbNJvOnSfUkgoJcEEHY
         8LciK0bli+QJdJTGZmvZbNYBwD6SsS2mFU7tScRzlGnTWdJOGzgaUu8J6RI/BMP3DLSR
         VcpAohEXHBzs8f9EwZJWPhzpkYboBLjWNFVRGJET9BeA9DoO2LeYZil/kiOymiBW1nVw
         +PEFo2MB9NFc96pqjdg0SsyNKO32Z82qD4tq+RgITNX/zktTYQfYNy/7cxBQuIfOwJML
         rTOQ==
X-Gm-Message-State: APjAAAVr4HuexG1X40K3sXvDUw78LzYusZWNfv/aH72eg6x4giS1jH3B
        nrRqJnMsNCyZ1azXXOqAzPo=
X-Google-Smtp-Source: APXvYqwpw9SjEhxiv5oj9n00gyVCnBmMClgJ4uhmef3ZdwQNnC8ipUBoNX9imEE751uci2k6srhSZQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr14863591pfm.128.1581906453023;
        Sun, 16 Feb 2020 18:27:33 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z29sm6938946pga.0.2020.02.16.18.27.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Feb 2020 18:27:32 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org
Cc:     arnd@arndb.de, zhang.lyra@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mfd: sc27xx: Add USB charger type detection support
Date:   Mon, 17 Feb 2020 10:26:16 +0800
Message-Id: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum SC27XX series PMICs supply the USB charger type detection
function, and related registers are located on the PMIC global registers
region, thus we implement and export this function in the MFD driver for
users to get the USB charger type.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sc27xx-pmic.h |    7 ++++++
 2 files changed, 59 insertions(+)
 create mode 100644 include/linux/mfd/sc27xx-pmic.h

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index c0529a1..ebdf2f1 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <uapi/linux/usb/charger.h>
 
 #define SPRD_PMIC_INT_MASK_STATUS	0x0
 #define SPRD_PMIC_INT_RAW_STATUS	0x4
@@ -17,6 +18,16 @@
 
 #define SPRD_SC2731_IRQ_BASE		0x140
 #define SPRD_SC2731_IRQ_NUMS		16
+#define SPRD_SC2731_CHG_DET		0xedc
+
+/* PMIC charger detection definition */
+#define SPRD_PMIC_CHG_DET_DELAY_US	200000
+#define SPRD_PMIC_CHG_DET_TIMEOUT	2000000
+#define SPRD_PMIC_CHG_DET_DONE		BIT(11)
+#define SPRD_PMIC_SDP_TYPE		BIT(7)
+#define SPRD_PMIC_DCP_TYPE		BIT(6)
+#define SPRD_PMIC_CDP_TYPE		BIT(5)
+#define SPRD_PMIC_CHG_TYPE_MASK		GENMASK(7, 5)
 
 struct sprd_pmic {
 	struct regmap *regmap;
@@ -24,12 +35,14 @@ struct sprd_pmic {
 	struct regmap_irq *irqs;
 	struct regmap_irq_chip irq_chip;
 	struct regmap_irq_chip_data *irq_data;
+	const struct sprd_pmic_data *pdata;
 	int irq;
 };
 
 struct sprd_pmic_data {
 	u32 irq_base;
 	u32 num_irqs;
+	u32 charger_det;
 };
 
 /*
@@ -40,8 +53,46 @@ struct sprd_pmic_data {
 static const struct sprd_pmic_data sc2731_data = {
 	.irq_base = SPRD_SC2731_IRQ_BASE,
 	.num_irqs = SPRD_SC2731_IRQ_NUMS,
+	.charger_det = SPRD_SC2731_CHG_DET,
 };
 
+enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct sprd_pmic *ddata = spi_get_drvdata(spi);
+	const struct sprd_pmic_data *pdata = ddata->pdata;
+	enum usb_charger_type type;
+	u32 val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
+				       (val & SPRD_PMIC_CHG_DET_DONE),
+				       SPRD_PMIC_CHG_DET_DELAY_US,
+				       SPRD_PMIC_CHG_DET_TIMEOUT);
+	if (ret) {
+		dev_err(&spi->dev, "failed to detect charger type\n");
+		return UNKNOWN_TYPE;
+	}
+
+	switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
+	case SPRD_PMIC_CDP_TYPE:
+		type = CDP_TYPE;
+		break;
+	case SPRD_PMIC_DCP_TYPE:
+		type = DCP_TYPE;
+		break;
+	case SPRD_PMIC_SDP_TYPE:
+		type = SDP_TYPE;
+		break;
+	default:
+		type = UNKNOWN_TYPE;
+		break;
+	}
+
+	return type;
+}
+EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
+
 static const struct mfd_cell sprd_pmic_devs[] = {
 	{
 		.name = "sc27xx-wdt",
@@ -181,6 +232,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ddata);
 	ddata->dev = &spi->dev;
 	ddata->irq = spi->irq;
+	ddata->pdata = pdata;
 
 	ddata->irq_chip.name = dev_name(&spi->dev);
 	ddata->irq_chip.status_base =
diff --git a/include/linux/mfd/sc27xx-pmic.h b/include/linux/mfd/sc27xx-pmic.h
new file mode 100644
index 0000000..57e45c0
--- /dev/null
+++ b/include/linux/mfd/sc27xx-pmic.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_MFD_SC27XX_PMIC_H
+#define __LINUX_MFD_SC27XX_PMIC_H
+
+extern enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev);
+
+#endif /* __LINUX_MFD_SC27XX_PMIC_H */
-- 
1.7.9.5

