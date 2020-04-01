Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD433C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D78214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbgDAPfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:35:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgDAPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:35:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: myjosserand)
        with ESMTPSA id 3B75028A107
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, mylene.josserand@collabora.com,
        kernel@collabora.com, kever.yang@rock-chips.com,
        geert@linux-m68k.org
Subject: [PATCH v2 1/2] soc: rockchip: Register a soc_device to retrieve revision
Date:   Wed,  1 Apr 2020 17:35:12 +0200
Message-Id: <20200401153513.423683-2-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401153513.423683-1-mylene.josserand@collabora.com>
References: <20200401153513.423683-1-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determine which revision of rk3288 by checking the HDMI version.
According to the Rockchip BSP kernel/u-boot, on rk3288w, the HDMI
revision equals 0x1A which is not the case for the rk3288.

As these SOC have some differences, this driver will help us
to know on which revision we are by using 'soc_device' registration
to be able to use 'soc_device_match' to detect rk3288/rk3288w.

Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
---
 drivers/soc/rockchip/Makefile |   1 +
 drivers/soc/rockchip/rk3288.c | 125 ++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 drivers/soc/rockchip/rk3288.c

diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index afca0a4c4b72..9dbf12913512 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -2,5 +2,6 @@
 #
 # Rockchip Soc drivers
 #
+obj-$(CONFIG_ARCH_ROCKCHIP) += rk3288.o
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
 obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
diff --git a/drivers/soc/rockchip/rk3288.c b/drivers/soc/rockchip/rk3288.c
new file mode 100644
index 000000000000..83379ba2b31b
--- /dev/null
+++ b/drivers/soc/rockchip/rk3288.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Collabora Ltd
+ * Author: Mylene Josserand <mylene.josserand@collabora.com>
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/sys_soc.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define RK3288_HDMI_REV_REG	0x04
+#define RK3288W_HDMI_REV	0x1A
+
+enum rk3288_soc_rev {
+	RK3288_SOC_REV_NOT_DETECT,
+	RK3288_SOC_REV_RK3288,
+	RK3288_SOC_REV_RK3288W,
+};
+
+static int rk3288_revision(void)
+{
+	static int revision = RK3288_SOC_REV_NOT_DETECT;
+	struct device_node *dn;
+	void __iomem *hdmi_base;
+
+	if (revision != RK3288_SOC_REV_NOT_DETECT)
+		return revision;
+
+	dn = of_find_compatible_node(NULL, NULL, "rockchip,rk3288-dw-hdmi");
+	if (!dn) {
+		pr_err("%s: Couldn't find HDMI node\n", __func__);
+		return -EINVAL;
+	}
+
+	hdmi_base = of_iomap(dn, 0);
+	of_node_put(dn);
+
+	if (!hdmi_base) {
+		pr_err("%s: Couldn't map %pOF regs\n", __func__,
+		       hdmi_base);
+		return -ENXIO;
+	}
+
+	if (readl_relaxed(hdmi_base + RK3288_HDMI_REV_REG)
+	    == RK3288W_HDMI_REV)
+		revision = RK3288_SOC_REV_RK3288W;
+	else
+		revision = RK3288_SOC_REV_RK3288;
+
+	iounmap(hdmi_base);
+
+	return revision;
+}
+
+static const char *rk3288_socinfo_revision(u32 rev)
+{
+	const char *soc_rev;
+
+	switch (rev) {
+	case RK3288_SOC_REV_RK3288:
+		soc_rev = "RK3288";
+		break;
+
+	case RK3288_SOC_REV_RK3288W:
+		soc_rev = "RK3288w";
+		break;
+
+	case RK3288_SOC_REV_NOT_DETECT:
+		soc_rev = "";
+		break;
+
+	default:
+		soc_rev = "unknown";
+		break;
+	}
+
+	return kstrdup_const(soc_rev, GFP_KERNEL);
+}
+
+static const struct of_device_id rk3288_soc_match[] = {
+	{ .compatible = "rockchip,rk3288", },
+	{ }
+};
+
+static int __init rk3288_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, rk3288_soc_match);
+	if (!np)
+		return -ENODEV;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Rockchip";
+	soc_dev_attr->soc_id = "RK32xx";
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	of_node_put(np);
+
+	soc_dev_attr->revision = rk3288_socinfo_revision(rk3288_revision());
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree_const(soc_dev_attr->revision);
+		kfree_const(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	dev_info(soc_device_to_device(soc_dev), "Rockchip %s %s detected\n",
+		 soc_dev_attr->soc_id, soc_dev_attr->revision);
+
+	return 0;
+}
+postcore_initcall(rk3288_soc_init);
-- 
2.25.1

