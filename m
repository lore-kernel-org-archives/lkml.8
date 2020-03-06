Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF1C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95148222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgCFNHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:07:43 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36368 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgCFNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:07:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 37A948030707;
        Fri,  6 Mar 2020 13:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qVCK_Moqb4Eg; Fri,  6 Mar 2020 16:07:36 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] soc: bt1: Add Baikal-T1 L2-cache Control Block driver
Date:   Fri, 6 Mar 2020 16:07:21 +0300
In-Reply-To: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130737.37A948030707@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Baikal-T1 SoC provides a way to tune the MIPS P5600 CM2 L2-cache
performance up. It can be done by changing the L2-RAM Data/Tag/WS
latencies in a dedicated register exposed by the system controller.
The driver added by this commit provides a dts properties-based and
sysfs-based interface for it.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 drivers/soc/baikal-t1/Kconfig  |  12 ++
 drivers/soc/baikal-t1/Makefile |   1 +
 drivers/soc/baikal-t1/l2-ctl.c | 325 +++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/soc/baikal-t1/l2-ctl.c

diff --git a/drivers/soc/baikal-t1/Kconfig b/drivers/soc/baikal-t1/Kconfig
index a021abea102f..b23675d4a097 100644
--- a/drivers/soc/baikal-t1/Kconfig
+++ b/drivers/soc/baikal-t1/Kconfig
@@ -34,4 +34,16 @@ config BT1_APB_EHB
 
 	  If unsure, say N.
 
+config BT1_L2_CTL
+	bool "Baikal-T1 CM2 L2 Cache Control Block"
+	depends on SOC_BAIKAL_T1 && OF
+	help
+	  Baikal-T1 CPU is based on the MIPS P5600 Warrior IP-core. The CPU
+	  resides Coherency Manager V2 with embedded 1MB L2-cache. It's
+	  possible to tune the L2 cache performance up by setting the data,
+	  tags and way-select latencies. This driver provides a dts
+	  properties-based and sysfs interface for it.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/soc/baikal-t1/Makefile b/drivers/soc/baikal-t1/Makefile
index ffb035600e01..70918b79e17f 100644
--- a/drivers/soc/baikal-t1/Makefile
+++ b/drivers/soc/baikal-t1/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_BT1_AXI_EHB) += axi-ehb.o
 obj-$(CONFIG_BT1_APB_EHB) += apb-ehb.o
+obj-$(CONFIG_BT1_L2_CTL) += l2-ctl.o
diff --git a/drivers/soc/baikal-t1/l2-ctl.c b/drivers/soc/baikal-t1/l2-ctl.c
new file mode 100644
index 000000000000..2136b9b8bad5
--- /dev/null
+++ b/drivers/soc/baikal-t1/l2-ctl.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 CM2 L2-cache Control Block driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/sysfs.h>
+#include <linux/of.h>
+
+#include "common.h"
+
+#define L2_CTL_REG			0x0
+#define L2_CTL_DATA_STALL_FLD		0
+#define L2_CTL_DATA_STALL_MASK		GENMASK(1, L2_CTL_DATA_STALL_FLD)
+#define L2_CTL_TAG_STALL_FLD		2
+#define L2_CTL_TAG_STALL_MASK		GENMASK(3, L2_CTL_TAG_STALL_FLD)
+#define L2_CTL_WS_STALL_FLD		4
+#define L2_CTL_WS_STALL_MASK		GENMASK(5, L2_CTL_WS_STALL_FLD)
+#define L2_CTL_SET_CLKRATIO		BIT(13)
+#define L2_CTL_CLKRATIO_LOCK		BIT(31)
+
+#define L2_CTL_STALL_MIN		0
+#define L2_CTL_STALL_MAX		3
+#define L2_CTL_STALL_SET_DELAY_US	1
+#define L2_CTL_STALL_SET_TOUT_US	1000
+
+/*
+ * struct l2_ctl - Baikal-T1 L2 Control block private data.
+ * @dev: Pointer to the device structure.
+ * @reg: Regmap of the control register.
+ */
+struct l2_ctl {
+	struct device *dev;
+
+	struct regmap *reg;
+};
+
+/*
+ * enum l2_ctl_stall - Baikal-T1 L2-cache-RAM stall identifier.
+ * @L2_WSSTALL: Way-select latency.
+ * @L2_TAGSTALL: Tag latency.
+ * @L2_DATASTALL: Data latency.
+ */
+enum l2_ctl_stall {
+	L2_WS_STALL,
+	L2_TAG_STALL,
+	L2_DATA_STALL
+};
+
+/*
+ * struct l2_ctl_device_attribute - Baikal-T1 L2-cache device attribute.
+ * @dev_attr: Actual sysfs device attribute.
+ * @id: L2-cache stall field identifier.
+ */
+struct l2_ctl_device_attribute {
+	struct device_attribute dev_attr;
+	enum l2_ctl_stall id;
+};
+#define to_l2_ctl_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct l2_ctl_device_attribute, dev_attr)
+
+#define L2_CTL_ATTR_RW(_name, _prefix, _id) \
+	struct l2_ctl_device_attribute l2_ctl_attr_##_name = \
+		{ __ATTR(_name, 0644, _prefix##_show, _prefix##_store),	_id }
+
+static int l2_ctl_get_latency(struct l2_ctl *l2, enum l2_ctl_stall id, u32 *val)
+{
+	u32 data = 0;
+	int ret;
+
+	ret = regmap_read(l2->reg, L2_CTL_REG, &data);
+	if (ret)
+		return ret;
+
+	switch (id) {
+	case L2_WS_STALL:
+		*val = BT1_GET_FLD(L2_CTL_WS_STALL, data);
+		break;
+	case L2_TAG_STALL:
+		*val = BT1_GET_FLD(L2_CTL_TAG_STALL, data);
+		break;
+	case L2_DATA_STALL:
+		*val = BT1_GET_FLD(L2_CTL_DATA_STALL, data);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int l2_ctl_set_latency(struct l2_ctl *l2, enum l2_ctl_stall id, u32 val)
+{
+	u32 mask = 0, data = 0;
+	int ret;
+
+	val = clamp_val(val, L2_CTL_STALL_MIN, L2_CTL_STALL_MAX);
+
+	switch (id) {
+	case L2_WS_STALL:
+		data = BT1_SET_FLD(L2_CTL_WS_STALL, 0, val);
+		mask = L2_CTL_WS_STALL_MASK;
+		break;
+	case L2_TAG_STALL:
+		data = BT1_SET_FLD(L2_CTL_TAG_STALL, 0, val);
+		mask = L2_CTL_TAG_STALL_MASK;
+		break;
+	case L2_DATA_STALL:
+		data = BT1_SET_FLD(L2_CTL_DATA_STALL, 0, val);
+		mask = L2_CTL_DATA_STALL_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data |= L2_CTL_SET_CLKRATIO;
+	mask |= L2_CTL_SET_CLKRATIO;
+
+	ret = regmap_update_bits(l2->reg, L2_CTL_REG, mask, data);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(l2->reg, L2_CTL_REG, data,
+					data & L2_CTL_CLKRATIO_LOCK,
+					L2_CTL_STALL_SET_DELAY_US,
+					L2_CTL_STALL_SET_TOUT_US);
+}
+
+static void l2_ctl_clear_data(void *data)
+{
+	struct l2_ctl *l2 = data;
+	struct platform_device *pdev = to_platform_device(l2->dev);
+
+	platform_set_drvdata(pdev, NULL);
+}
+
+static struct l2_ctl *l2_ctl_create_data(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct l2_ctl *l2;
+	int ret;
+
+	l2 = devm_kzalloc(dev, sizeof(*l2), GFP_KERNEL);
+	if (!l2)
+		return ERR_PTR(-ENOMEM);
+
+	ret = devm_add_action(dev, l2_ctl_clear_data, l2);
+	if (ret) {
+		dev_err(dev, "Can't add L2 CTL data clear action\n");
+		return ERR_PTR(ret);
+	}
+
+	l2->dev = dev;
+	platform_set_drvdata(pdev, l2);
+
+	return l2;
+}
+
+static int l2_ctl_request_reg(struct l2_ctl *l2)
+{
+	l2->reg = device_node_to_regmap(l2->dev->of_node);
+	if (IS_ERR(l2->reg)) {
+		dev_err(l2->dev, "Couldn't get L2 CTL register map\n");
+		return PTR_ERR(l2->reg);
+	}
+
+	return 0;
+}
+
+static int l2_ctl_of_parse_property(struct l2_ctl *l2, enum l2_ctl_stall id,
+				    const char *propname)
+{
+	int ret = 0;
+	u32 data;
+
+	if (of_property_read_u32(l2->dev->of_node, propname, &data)) {
+		ret = l2_ctl_set_latency(l2, id, data);
+		if (ret)
+			dev_err(l2->dev, "Invalid value of '%s'\n", propname);
+	}
+
+	return ret;
+}
+
+static int l2_ctl_of_parse(struct l2_ctl *l2)
+{
+	int ret;
+
+	ret = l2_ctl_of_parse_property(l2, L2_WS_STALL, "be,l2-ws-latency");
+	if (ret)
+		return ret;
+
+	ret = l2_ctl_of_parse_property(l2, L2_TAG_STALL, "be,l2-tag-latency");
+	if (ret)
+		return ret;
+
+	return l2_ctl_of_parse_property(l2, L2_DATA_STALL,
+					"be,l2-data-latency");
+}
+
+static ssize_t l2_ctl_latency_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct l2_ctl_device_attribute *devattr = to_l2_ctl_dev_attr(attr);
+	struct l2_ctl *l2 = dev_get_drvdata(dev);
+	u32 data;
+	int ret;
+
+	ret = l2_ctl_get_latency(l2, devattr->id, &data);
+	if (ret)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", data);
+}
+
+static ssize_t l2_ctl_latency_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct l2_ctl_device_attribute *devattr = to_l2_ctl_dev_attr(attr);
+	struct l2_ctl *l2 = dev_get_drvdata(dev);
+	u32 data;
+	int ret;
+
+	if (kstrtouint(buf, 0, &data) < 0)
+		return -EINVAL;
+
+	ret = l2_ctl_set_latency(l2, devattr->id, data);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static L2_CTL_ATTR_RW(l2_ws_latency, l2_ctl_latency, L2_WS_STALL);
+static L2_CTL_ATTR_RW(l2_tag_latency, l2_ctl_latency, L2_TAG_STALL);
+static L2_CTL_ATTR_RW(l2_data_latency, l2_ctl_latency, L2_DATA_STALL);
+
+static struct attribute *l2_ctl_sysfs_attrs[] = {
+	&l2_ctl_attr_l2_ws_latency.dev_attr.attr,
+	&l2_ctl_attr_l2_tag_latency.dev_attr.attr,
+	&l2_ctl_attr_l2_data_latency.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(l2_ctl_sysfs);
+
+static void l2_ctl_remove_sysfs(void *data)
+{
+	struct l2_ctl *l2 = data;
+
+	device_remove_groups(l2->dev, l2_ctl_sysfs_groups);
+}
+
+static int l2_ctl_init_sysfs(struct l2_ctl *l2)
+{
+	int ret;
+
+	ret = device_add_groups(l2->dev, l2_ctl_sysfs_groups);
+	if (ret) {
+		dev_err(l2->dev, "Failed to create L2 CTL sysfs nodes\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(l2->dev, l2_ctl_remove_sysfs, l2);
+	if (ret)
+		dev_err(l2->dev, "Can't add L2 CTL sysfs remove action\n");
+
+	return ret;
+}
+
+static int l2_ctl_probe(struct platform_device *pdev)
+{
+	struct l2_ctl *l2;
+	int ret;
+
+	l2 = l2_ctl_create_data(pdev);
+	if (IS_ERR(l2))
+		return PTR_ERR(l2);
+
+	ret = l2_ctl_request_reg(l2);
+	if (ret)
+		return ret;
+
+	ret = l2_ctl_of_parse(l2);
+	if (ret)
+		return ret;
+
+	ret = l2_ctl_init_sysfs(l2);
+	if (ret)
+		return ret;
+
+	dev_info(l2->dev, "L2-cache control driver installed\n");
+
+	return 0;
+}
+
+static const struct of_device_id l2_ctl_of_match[] = {
+	{ .compatible = "be,bt1-l2-ctl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, l2_ctl_of_match);
+
+static struct platform_driver l2_ctl_driver = {
+	.probe = l2_ctl_probe,
+	.driver = {
+		.name = "bt1-l2-ctl",
+		.of_match_table = of_match_ptr(l2_ctl_of_match)
+	}
+};
+module_platform_driver(l2_ctl_driver);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 L2-cache driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

