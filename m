Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023CC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC83D2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLkvF3VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgHZLSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgHZLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:16:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A24C061574;
        Wed, 26 Aug 2020 04:16:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q3so735201pls.11;
        Wed, 26 Aug 2020 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ulmIBrkE/+2FmnrwC+qCk+BjYqdq5xXkk5I/QcMd7Ug=;
        b=oLkvF3VOgGh86K7PirWAvlZr21eM6vvP8lkcp/hNvc40L+cc1vkos1eZs7uGDtuU6O
         0nSoMTWuUs7YX4n+LkOmMp4qLMT6MHuRmk5iufwLC4VjiRWduXAEZeMSrhSjG4RYM9v5
         QAu9oS5gjfF8mR4fTHUXeergIL9IRaU5Hd05R6y23tNmBNjTGfW/GwojPX6eW+/2FIKR
         XzELJAKWinyn1kGfltVJ5MrolqWWHrx8U86DDehOmY992VhV9C2P5ayHEC5Ow1DfG85j
         40+HjTtx3SSFg2lqiG9gmlLgk1yR94Yj9NE54AqYfsOGeDcwCeV0r9u07dCcfp/FyUz5
         kQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ulmIBrkE/+2FmnrwC+qCk+BjYqdq5xXkk5I/QcMd7Ug=;
        b=AkUTGZSmcmFoPi23vcSHALWygcN9QzoteFjh+S+3rKHRZH9xjmq3Kkon7mBtzH7hsf
         s3QshgU//iDXj8ziqSCC67/X1w2gdZX8Cxqxqd3QdOf11FwoVgRi0vOJ+lWILZTBcuth
         l453+6Ld2vTfBgoxKmnZ1gedoqfS1jPC8kqj0wJXZyOzpuLDUSV4AWHhuCHXXsGi0BTP
         uqI5WiEhwJ/+rGGLOscYGWCcVLo0vdXQCelDptzmhbxqk/DTnJuh/72EnMmMxmt2ROJl
         DnJwffgqDdLC1PM0VPKDkLqblyWto4jlEOXATiB8pHu+d2pII5OYUt2Iy10JyeRsom5z
         aGpg==
X-Gm-Message-State: AOAM530pNC50T7PwbjViD0cFKAUbuuIbysY/IIdlZvgGmCJ1zjSOa0Yg
        COS8vudypRYoL94y9KgQ2ms=
X-Google-Smtp-Source: ABdhPJx8xviM6an+iz3MN8zalmkl6gWPFsIiJr+ZKiBlYZo0MAKUDcdGsr6jM/FtJ1YsPIbTzPG6+g==
X-Received: by 2002:a17:902:ee03:: with SMTP id z3mr11581092plb.301.1598440611944;
        Wed, 26 Aug 2020 04:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:464:1646:7076:aae7:15f:eca9])
        by smtp.gmail.com with ESMTPSA id g129sm2628872pfb.33.2020.08.26.04.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:16:50 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb typec: mt6360: Add support for mt6360 Type-C driver
Date:   Wed, 26 Aug 2020 19:16:41 +0800
Message-Id: <1598440602-8648-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
It works with Type-C Port Controller Manager to provide USB PD
and USB Type-C functionalities.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/usb/typec/tcpm/Kconfig        |   8 ++
 drivers/usb/typec/tcpm/Makefile       |   1 +
 drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index fa3f393..58a64e1 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -27,6 +27,14 @@ config TYPEC_RT1711H
 	  Type-C Port Controller Manager to provide USB PD and USB
 	  Type-C functionalities.
 
+config TYPEC_MT6360
+	tristate "Mediatek MT6360 Type-C driver"
+	depends on MFD_MT6360
+	help
+	  Mediatek MT6360 is a multi-functional IC that includes
+	  USB Type-C. It works with Type-C Port Controller Manager
+	  to provide USB PD and USB Type-C functionalities.
+
 endif # TYPEC_TCPCI
 
 config TYPEC_FUSB302
diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
index a5ff6c8..7592ccb 100644
--- a/drivers/usb/typec/tcpm/Makefile
+++ b/drivers/usb/typec/tcpm/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
 typec_wcove-y			:= wcove.o
 obj-$(CONFIG_TYPEC_TCPCI)	+= tcpci.o
 obj-$(CONFIG_TYPEC_RT1711H)	+= tcpci_rt1711h.o
+obj-$(CONFIG_TYPEC_MT6360)	+= tcpci_mt6360.o
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
new file mode 100644
index 00000000..6a28193
--- /dev/null
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2020 MediaTek Inc.
+//
+// Author: ChiYuan Huang <cy_huang@richtek.com>
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/usb/tcpm.h>
+
+#include "tcpci.h"
+
+#define MT6360_REG_VCONNCTRL1	0x8C
+#define MT6360_REG_MODECTRL2	0x8F
+#define MT6360_REG_SWRESET	0xA0
+#define MT6360_REG_DEBCTRL1	0xA1
+#define MT6360_REG_DRPCTRL1	0xA2
+#define MT6360_REG_DRPCTRL2	0xA3
+#define MT6360_REG_I2CTORST	0xBF
+#define MT6360_REG_RXCTRL2	0xCF
+#define MT6360_REG_CTDCTRL2	0xEC
+
+/* MT6360_REG_VCONNCTRL1 */
+#define MT6360_VCONNCL_ENABLE	BIT(0)
+/* MT6360_REG_RXCTRL2 */
+#define MT6360_OPEN40M_ENABLE	BIT(7)
+/* MT6360_REG_CTDCTRL2 */
+#define MT6360_RPONESHOT_ENABLE	BIT(6)
+
+struct mt6360_tcpc_info {
+	struct tcpci_data tdata;
+	struct tcpci *tcpci;
+	struct device *dev;
+	int irq;
+};
+
+static inline int mt6360_tcpc_read16(struct regmap *regmap,
+				     unsigned int reg, u16 *val)
+{
+	return regmap_raw_read(regmap, reg, val, sizeof(u16));
+}
+
+static inline int mt6360_tcpc_write16(struct regmap *regmap,
+				      unsigned int reg, u16 val)
+{
+	return regmap_raw_write(regmap, reg, &val, sizeof(u16));
+}
+
+static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
+{
+	struct regmap *regmap = tdata->regmap;
+	int ret;
+
+	ret = regmap_write(regmap, MT6360_REG_SWRESET, 0x01);
+	if (ret)
+		return ret;
+
+	/* after reset command, wait 1~2ms to wait IC action */
+	usleep_range(1000, 2000);
+
+	/* write all alert to masked */
+	ret = mt6360_tcpc_write16(regmap, TCPC_ALERT_MASK, 0);
+	if (ret)
+		return ret;
+
+	/* config I2C timeout reset enable , and timeout to 200ms */
+	ret = regmap_write(regmap, MT6360_REG_I2CTORST, 0x8F);
+	if (ret)
+		return ret;
+
+	/* config CC Detect Debounce : 26.7*val us */
+	ret = regmap_write(regmap, MT6360_REG_DEBCTRL1, 0x10);
+	if (ret)
+		return ret;
+
+	/* DRP Toggle Cycle : 51.2 + 6.4*val ms */
+	ret = regmap_write(regmap, MT6360_REG_DRPCTRL1, 4);
+	if (ret)
+		return ret;
+
+	/* DRP Duyt Ctrl : dcSRC: /1024 */
+	ret = mt6360_tcpc_write16(regmap, MT6360_REG_DRPCTRL2, 330);
+	if (ret)
+		return ret;
+
+	/* Enable VCONN Current Limit function */
+	ret = regmap_update_bits(regmap, MT6360_REG_VCONNCTRL1, MT6360_VCONNCL_ENABLE,
+				 MT6360_VCONNCL_ENABLE);
+	if (ret)
+		return ret;
+
+	/* Enable cc open 40ms when pmic send vsysuv signal */
+	ret = regmap_update_bits(regmap, MT6360_REG_RXCTRL2, MT6360_OPEN40M_ENABLE,
+				 MT6360_OPEN40M_ENABLE);
+	if (ret)
+		return ret;
+
+	/* Enable Rpdet oneshot detection */
+	ret = regmap_update_bits(regmap, MT6360_REG_CTDCTRL2, MT6360_RPONESHOT_ENABLE,
+				 MT6360_RPONESHOT_ENABLE);
+	if (ret)
+		return ret;
+
+	/* Set shipping mode off, AUTOIDLE on */
+	return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
+}
+
+static irqreturn_t mt6360_irq(int irq, void *dev_id)
+{
+	struct mt6360_tcpc_info *mti = dev_id;
+
+	return tcpci_irq(mti->tcpci);
+}
+
+static int mt6360_tcpc_probe(struct platform_device *pdev)
+{
+	struct mt6360_tcpc_info *mti;
+	int ret;
+
+	mti = devm_kzalloc(&pdev->dev, sizeof(*mti), GFP_KERNEL);
+	if (!mti)
+		return -ENOMEM;
+
+	mti->dev = &pdev->dev;
+
+	mti->tdata.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!mti->tdata.regmap) {
+		dev_err(&pdev->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	mti->irq = platform_get_irq_byname(pdev, "PD_IRQB");
+	if (mti->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get PD_IRQB irq\n");
+		return mti->irq;
+	}
+
+	mti->tdata.init = mt6360_tcpc_init;
+	mti->tcpci = tcpci_register_port(&pdev->dev, &mti->tdata);
+	if (IS_ERR_OR_NULL(mti->tcpci)) {
+		dev_err(&pdev->dev, "Failed to register tcpci port\n");
+		return PTR_ERR(mti->tcpci);
+	}
+
+	ret = devm_request_threaded_irq(mti->dev, mti->irq, NULL, mt6360_irq, IRQF_ONESHOT,
+					dev_name(&pdev->dev), mti);
+	if (ret) {
+		dev_err(mti->dev, "Failed to register irq\n");
+		tcpci_unregister_port(mti->tcpci);
+		return ret;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+	platform_set_drvdata(pdev, mti);
+
+	return 0;
+}
+
+static int mt6360_tcpc_remove(struct platform_device *pdev)
+{
+	struct mt6360_tcpc_info *mti = platform_get_drvdata(pdev);
+
+	tcpci_unregister_port(mti->tcpci);
+	return 0;
+}
+
+static int __maybe_unused mt6360_tcpc_suspend(struct device *dev)
+{
+	struct mt6360_tcpc_info *mti = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(mti->irq);
+
+	return 0;
+}
+
+static int __maybe_unused mt6360_tcpc_resume(struct device *dev)
+{
+	struct mt6360_tcpc_info *mti = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(mti->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(mt6360_tcpc_pm_ops, mt6360_tcpc_suspend, mt6360_tcpc_resume);
+
+static const struct of_device_id __maybe_unused mt6360_tcpc_of_id[] = {
+	{ .compatible = "mediatek,mt6360-tcpc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt6360_tcpc_of_id);
+
+static struct platform_driver mt6360_tcpc_driver = {
+	.driver = {
+		.name = "mt6360-tcpc",
+		.pm = &mt6360_tcpc_pm_ops,
+		.of_match_table = mt6360_tcpc_of_id,
+	},
+	.probe = mt6360_tcpc_probe,
+	.remove = mt6360_tcpc_remove,
+};
+module_platform_driver(mt6360_tcpc_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("MT6360 USB Type-C Port Controller Interface Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

