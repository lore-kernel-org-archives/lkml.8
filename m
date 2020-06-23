Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C874C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A86C20786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgFWCxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:53:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:32948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbgFWCve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AA97AE71;
        Tue, 23 Jun 2020 02:51:30 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 02/29] soc: Add Realtek DHC chip info driver for RTD1195 and RTD1295
Date:   Tue, 23 Jun 2020 04:50:39 +0200
Message-Id: <20200623025106.31273-3-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a soc bus driver to print chip model and revision details.

Revisions from downstream drivers/soc/realtek/rtd{119x,129x}/rtk_chip.c.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Added entry to MAINTAINERS
 * Changed chip_id and chip_rev from u32 to u16, based on reg field definitions
 * Added error return path for get_name for deferred probing, reordered code
 
 MAINTAINERS                  |   1 +
 drivers/soc/Kconfig          |   1 +
 drivers/soc/Makefile         |   1 +
 drivers/soc/realtek/Kconfig  |  13 +++
 drivers/soc/realtek/Makefile |   2 +
 drivers/soc/realtek/chip.c   | 181 +++++++++++++++++++++++++++++++++++
 6 files changed, 199 insertions(+)
 create mode 100644 drivers/soc/realtek/Kconfig
 create mode 100644 drivers/soc/realtek/Makefile
 create mode 100644 drivers/soc/realtek/chip.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 78adbc3cc101..ff0ee48fee6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2311,6 +2311,7 @@ F:	Documentation/devicetree/bindings/soc/realtek/
 F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
+F:	drivers/soc/realtek/
 
 ARM/RENESAS ARM64 ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 425ab6f7e375..925647993119 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -11,6 +11,7 @@ source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
+source "drivers/soc/realtek/Kconfig"
 source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 36452bed86ef..cdcf00bbad10 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
 obj-y				+= amlogic/
 obj-y				+= qcom/
+obj-y				+= realtek/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
diff --git a/drivers/soc/realtek/Kconfig b/drivers/soc/realtek/Kconfig
new file mode 100644
index 000000000000..be75c1889c61
--- /dev/null
+++ b/drivers/soc/realtek/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+if ARCH_REALTEK || COMPILE_TEST
+
+config REALTEK_SOC
+	tristate "Realtek chip info"
+	default ARCH_REALTEK
+	select SOC_BUS
+	help
+	  Say 'y' here to enable support for SoC info on Realtek RTD1195 and
+	  RTD1295 SoC families.
+	  If unsure, say 'n'.
+
+endif
diff --git a/drivers/soc/realtek/Makefile b/drivers/soc/realtek/Makefile
new file mode 100644
index 000000000000..49900273905b
--- /dev/null
+++ b/drivers/soc/realtek/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+obj-$(CONFIG_REALTEK_SOC) += chip.o
diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
new file mode 100644
index 000000000000..c4650d512c91
--- /dev/null
+++ b/drivers/soc/realtek/chip.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek Digital Home Center System-on-Chip info
+ *
+ * Copyright (c) 2017-2020 Andreas Färber
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define REG_SB2_CHIP_ID		0x200
+#define REG_SB2_CHIP_INFO	0x204
+
+#define SB2_CHIP_ID_CHIP_ID		GENMASK(15, 0)
+
+#define SB2_CHIP_INFO_REVISE_ID		GENMASK(31, 16)
+
+struct dhc_soc_revision {
+	const char *name;
+	u16 chip_rev;
+};
+
+static const struct dhc_soc_revision rtd1195_revisions[] = {
+	{ "A", 0x0000 },
+	{ "B", 0x0001 },
+	{ "C", 0x0002 },
+	{ "D", 0x0003 },
+	{ }
+};
+
+static const struct dhc_soc_revision rtd1295_revisions[] = {
+	{ "A00", 0x0000 },
+	{ "A01", 0x0001 },
+	{ "B00", 0x0002 },
+	{ "B01", 0x0003 },
+	{ }
+};
+
+struct dhc_soc {
+	u16 chip_id;
+	const char *family;
+	const char *(*get_name)(struct device *dev, const struct dhc_soc *s);
+	const struct dhc_soc_revision *revisions;
+	const char *codename;
+};
+
+static const char *default_name(struct device *dev, const struct dhc_soc *s)
+{
+	return s->family;
+}
+
+static const struct dhc_soc dhc_soc_families[] = {
+	{ 0x6329, "RTD1195", default_name, rtd1195_revisions, "Phoenix" },
+	{ 0x6421, "RTD1295", default_name, rtd1295_revisions, "Kylin" },
+};
+
+static const struct dhc_soc *dhc_soc_by_chip_id(u16 chip_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dhc_soc_families); i++) {
+		const struct dhc_soc *family = &dhc_soc_families[i];
+
+		if (family->chip_id == chip_id)
+			return family;
+	}
+	return NULL;
+}
+
+static const char *dhc_soc_rev(const struct dhc_soc *family, u16 chip_rev)
+{
+	if (family) {
+		const struct dhc_soc_revision *rev = family->revisions;
+
+		while (rev && rev->name) {
+			if (rev->chip_rev == chip_rev)
+				return rev->name;
+			rev++;
+		}
+	}
+	return "unknown";
+}
+
+static int dhc_soc_probe(struct platform_device *pdev)
+{
+	const struct dhc_soc *s;
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *node;
+	struct regmap *regmap;
+	u16 chip_id, chip_rev;
+	unsigned int val;
+	int ret;
+
+	regmap = syscon_node_to_regmap(pdev->dev.of_node->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, REG_SB2_CHIP_ID, &val);
+	if (ret)
+		return ret;
+	chip_id = FIELD_GET(SB2_CHIP_ID_CHIP_ID, val);
+
+	ret = regmap_read(regmap, REG_SB2_CHIP_INFO, &val);
+	if (ret)
+		return ret;
+	chip_rev = FIELD_GET(SB2_CHIP_INFO_REVISE_ID, val);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	node = of_find_node_by_path("/");
+	of_property_read_string(node, "model", &soc_dev_attr->machine);
+	of_node_put(node);
+
+	s = dhc_soc_by_chip_id(chip_id);
+
+	if (likely(s && s->get_name)) {
+		soc_dev_attr->soc_id = s->get_name(&pdev->dev, s);
+		if (IS_ERR(soc_dev_attr->soc_id))
+			return PTR_ERR(soc_dev_attr->soc_id);
+	} else
+		soc_dev_attr->soc_id = "unknown";
+
+	soc_dev_attr->revision = dhc_soc_rev(s, chip_rev);
+
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Realtek %s",
+		(s && s->codename) ? s->codename :
+		((s && s->family) ? s->family : "Digital Home Center"));
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	platform_set_drvdata(pdev, soc_dev);
+
+	pr_info("%s %s (0x%04x) rev %s (0x%04x) detected\n",
+		soc_dev_attr->family, soc_dev_attr->soc_id, (u32)chip_id,
+		soc_dev_attr->revision, (u32)chip_rev);
+
+	return 0;
+}
+
+static int dhc_soc_remove(struct platform_device *pdev)
+{
+	struct soc_device *soc_dev = platform_get_drvdata(pdev);
+
+	soc_device_unregister(soc_dev);
+
+	return 0;
+}
+
+static const struct of_device_id dhc_soc_dt_ids[] = {
+	 { .compatible = "realtek,rtd1195-chip" },
+	 { }
+};
+
+static struct platform_driver dhc_soc_driver = {
+	.probe = dhc_soc_probe,
+	.remove = dhc_soc_remove,
+	.driver = {
+		.name = "dhc-soc",
+		.of_match_table	= dhc_soc_dt_ids,
+	},
+};
+module_platform_driver(dhc_soc_driver);
+
+MODULE_DESCRIPTION("Realtek DHC SoC identification driver");
+MODULE_LICENSE("GPL");
-- 
2.26.2

