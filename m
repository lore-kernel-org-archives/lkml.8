Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33478C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1DA207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBxjDSVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATKGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:06:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33509 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:06:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so15623875pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hi+7gFsTmZyrz3ap1i/enKvUy7a27c6rw8lfHWInIaw=;
        b=CBxjDSVLdXpaCInCNxpsY4coBMv8cUmgC3beuQz8Z6aXskVII7LKTYBMC6e/iCZ5ds
         nvgjO+skFYauWJ4o+NAOaNyxRsj1oiGv2fII8lD0N15EktuuGrOmKi9geTWHWx8Yh3LN
         GGFFKS38cPq/oc6hf1hC5mPwQngc+ou1rbL0Fjw4qRMyJBA9fyq8t2Sh8PwkdTLmw386
         lkQ4oZyDGrmUknvDt9LD98DRqLiLEczbHkNSCGGqalVVZTZhK1Xj1coIVvMMneFrXV8b
         MPzRZg9wIEQehV6YobjNLoJZoKf0M8IX+Dz9BI6aJXD+V4QzytP1bREYwDplc2nwDXDn
         VKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hi+7gFsTmZyrz3ap1i/enKvUy7a27c6rw8lfHWInIaw=;
        b=RJ30acGBb182KJG6YYa6kMzXKeY+MTfG6qn6e7kld1bZQSxwitvInDXx9JxYdNE0ZF
         T+m2zs5HJLkW0RP2VjQ3+2fo3LDAvFx3e7UouIbdckPyTlEbYpqYYmLH7a2x3XznwnAj
         Xm3oSNDtqd9OL55bj9GUXgfKHALiKJXn0FTMnaAMruPAoriazN+HKD2t3wpwa8lYf/GM
         69fbKDodwIWfdoyt0+XL8rdXy84DFiZQJBmBi4Zailzsio8b8P2qZ4fbCsY5+UUFmV2b
         qE/us3saqtRaA2D8DQxuiGi9wkYmECg2sQZ/ijE9TxgQbubyH2uWZ4f0EXTV++ToEUVd
         ymhA==
X-Gm-Message-State: APjAAAUJWuHVp2pgLroMD4dj9zJx4KZpQzHO1mCIjjkrJq/eXMFfuXmz
        kA+4H+qGqv3GfYVtC8/lGKs=
X-Google-Smtp-Source: APXvYqyYQpKg+6d38Gxq49vMbkmBl8DS8Q9unx5vrzq4gT/KSVkgYrsut5yX6gd5Ja8utZxpOdZqTQ==
X-Received: by 2002:aa7:949a:: with SMTP id z26mr16152092pfk.98.1579514792120;
        Mon, 20 Jan 2020 02:06:32 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v143sm39206358pfc.71.2020.01.20.02.06.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jan 2020 02:06:31 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org
Cc:     arnd@arndb.de, zhang.lyra@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sc27xx: Add USB charger type detection support
Date:   Mon, 20 Jan 2020 18:05:55 +0800
Message-Id: <cffcf7479885c23fe86a2635895363955d00e7de.1579514485.git.baolin.wang7@gmail.com>
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

