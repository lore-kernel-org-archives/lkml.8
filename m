Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4C220706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbgFYA1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:27:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50518 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388297AbgFYA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:27:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7073B201242;
        Thu, 25 Jun 2020 02:27:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49C55201241;
        Thu, 25 Jun 2020 02:27:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 80656402E1;
        Thu, 25 Jun 2020 08:27:25 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, peng.fan@nxp.com,
        aisheng.dong@nxp.com, daniel.baluta@nxp.com,
        franck.lenormand@nxp.com, arnd@arndb.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] firmware: imx: Move i.MX SCU soc driver into imx firmware folder
Date:   Thu, 25 Jun 2020 08:16:04 +0800
Message-Id: <1593044164-32362-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX SCU soc driver depends on SCU firmware driver, so it has to
use platform driver model for proper defer probe operation, since
it has no device binding in DT file, a simple platform device is
created together inside the platform driver. To make it more clean,
we can just move the entire SCU soc driver into imx firmware folder
and initialized by i.MX SCU firmware driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- move soc driver to imx firmware folder instead of merge it into imx firmware driver.
---
 arch/arm64/configs/defconfig       |   1 -
 drivers/firmware/imx/Makefile      |   2 +-
 drivers/firmware/imx/imx-scu-soc.c | 139 ++++++++++++++++++++++++++++++
 drivers/firmware/imx/imx-scu.c     |   4 +
 drivers/soc/imx/Kconfig            |   9 --
 drivers/soc/imx/Makefile           |   1 -
 drivers/soc/imx/soc-imx-scu.c      | 172 -------------------------------------
 include/linux/firmware/imx/sci.h   |   1 +
 8 files changed, 145 insertions(+), 184 deletions(-)
 create mode 100644 drivers/firmware/imx/imx-scu-soc.c
 delete mode 100644 drivers/soc/imx/soc-imx-scu.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ae76fae..35f037f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -854,7 +854,6 @@ CONFIG_OWL_PM_DOMAINS=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_FSL_DPAA=y
 CONFIG_FSL_MC_DPIO=y
-CONFIG_IMX_SCU_SOC=y
 CONFIG_QCOM_AOSS_QMP=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_RMTFS_MEM=m
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 17ea361..b76acba 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
new file mode 100644
index 0000000..fab41a8
--- /dev/null
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+static struct imx_sc_ipc *imx_sc_soc_ipc_handle;
+
+struct imx_sc_msg_misc_get_soc_id {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u32 control;
+			u16 resource;
+		} __packed req;
+		struct {
+			u32 id;
+		} resp;
+	} data;
+} __packed __aligned(4);
+
+struct imx_sc_msg_misc_get_soc_uid {
+	struct imx_sc_rpc_msg hdr;
+	u32 uid_low;
+	u32 uid_high;
+} __packed;
+
+static int imx_scu_soc_uid(u64 *soc_uid)
+{
+	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	*soc_uid = msg.uid_high;
+	*soc_uid <<= 32;
+	*soc_uid |= msg.uid_low;
+
+	return 0;
+}
+
+static int imx_scu_soc_id(void)
+{
+	struct imx_sc_msg_misc_get_soc_id msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_GET_CONTROL;
+	hdr->size = 3;
+
+	msg.data.req.control = IMX_SC_C_ID;
+	msg.data.req.resource = IMX_SC_R_SYSTEM;
+
+	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: get soc info failed, ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	return msg.data.resp.id;
+}
+
+int imx_scu_soc_init(struct device *dev)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	int id, ret;
+	u64 uid = 0;
+	u32 val;
+
+	ret = imx_scu_get_handle(&imx_sc_soc_ipc_handle);
+	if (ret)
+		return ret;
+
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Freescale i.MX";
+
+	ret = of_property_read_string(of_root,
+				      "model",
+				      &soc_dev_attr->machine);
+	if (ret)
+		return ret;
+
+	id = imx_scu_soc_id();
+	if (id < 0)
+		return -EINVAL;
+
+	ret = imx_scu_soc_uid(&uid);
+	if (ret < 0)
+		return -EINVAL;
+
+	/* format soc_id value passed from SCU firmware */
+	val = id & 0x1f;
+	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
+	if (!soc_dev_attr->soc_id)
+		return -ENOMEM;
+
+	/* format revision value passed from SCU firmware */
+	val = (id >> 5) & 0xf;
+	val = (((val >> 2) + 1) << 4) | (val & 0x3);
+	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
+						(val >> 4) & 0xf, val & 0xf);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+
+	soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL,
+						     "%016llX", uid);
+	if (!soc_dev_attr->serial_number)
+		return -ENOMEM;
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_scu_soc_init);
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2ab0482..dca79ca 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -328,6 +328,10 @@ static int imx_scu_probe(struct platform_device *pdev)
 
 	imx_sc_ipc_handle = sc_ipc;
 
+	ret = imx_scu_soc_init(dev);
+	if (ret)
+		dev_warn(dev, "failed to initialize SoC info: %d\n", ret);
+
 	ret = imx_scu_enable_general_irq_channel(dev);
 	if (ret)
 		dev_warn(dev,
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index d515d2c..d49fa63 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -8,15 +8,6 @@ config IMX_GPCV2_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
 
-config IMX_SCU_SOC
-	bool "i.MX System Controller Unit SoC info support"
-	depends on IMX_SCU
-	select SOC_BUS
-	help
-	  If you say yes here you get support for the NXP i.MX System
-	  Controller Unit SoC info module, it will provide the SoC info
-	  like SoC family, ID and revision etc.
-
 config SOC_IMX8M
 	bool "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 4461432..078dc91 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -5,4 +5,3 @@ endif
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_IMX_SCU_SOC) += soc-imx-scu.o
diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
deleted file mode 100644
index 92448ca..0000000
--- a/drivers/soc/imx/soc-imx-scu.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2019 NXP.
- */
-
-#include <dt-bindings/firmware/imx/rsrc.h>
-#include <linux/firmware/imx/sci.h>
-#include <linux/slab.h>
-#include <linux/sys_soc.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-
-#define IMX_SCU_SOC_DRIVER_NAME		"imx-scu-soc"
-
-static struct imx_sc_ipc *soc_ipc_handle;
-
-struct imx_sc_msg_misc_get_soc_id {
-	struct imx_sc_rpc_msg hdr;
-	union {
-		struct {
-			u32 control;
-			u16 resource;
-		} __packed req;
-		struct {
-			u32 id;
-		} resp;
-	} data;
-} __packed __aligned(4);
-
-struct imx_sc_msg_misc_get_soc_uid {
-	struct imx_sc_rpc_msg hdr;
-	u32 uid_low;
-	u32 uid_high;
-} __packed;
-
-static int imx_scu_soc_uid(u64 *soc_uid)
-{
-	struct imx_sc_msg_misc_get_soc_uid msg;
-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
-
-	hdr->ver = IMX_SC_RPC_VERSION;
-	hdr->svc = IMX_SC_RPC_SVC_MISC;
-	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
-	hdr->size = 1;
-
-	ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
-
-	*soc_uid = msg.uid_high;
-	*soc_uid <<= 32;
-	*soc_uid |= msg.uid_low;
-
-	return 0;
-}
-
-static int imx_scu_soc_id(void)
-{
-	struct imx_sc_msg_misc_get_soc_id msg;
-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
-
-	hdr->ver = IMX_SC_RPC_VERSION;
-	hdr->svc = IMX_SC_RPC_SVC_MISC;
-	hdr->func = IMX_SC_MISC_FUNC_GET_CONTROL;
-	hdr->size = 3;
-
-	msg.data.req.control = IMX_SC_C_ID;
-	msg.data.req.resource = IMX_SC_R_SYSTEM;
-
-	ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc info failed, ret %d\n", __func__, ret);
-		return ret;
-	}
-
-	return msg.data.resp.id;
-}
-
-static int imx_scu_soc_probe(struct platform_device *pdev)
-{
-	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
-	int id, ret;
-	u64 uid = 0;
-	u32 val;
-
-	ret = imx_scu_get_handle(&soc_ipc_handle);
-	if (ret)
-		return ret;
-
-	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
-				    GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
-
-	soc_dev_attr->family = "Freescale i.MX";
-
-	ret = of_property_read_string(of_root,
-				      "model",
-				      &soc_dev_attr->machine);
-	if (ret)
-		return ret;
-
-	id = imx_scu_soc_id();
-	if (id < 0)
-		return -EINVAL;
-
-	ret = imx_scu_soc_uid(&uid);
-	if (ret < 0)
-		return -EINVAL;
-
-	/* format soc_id value passed from SCU firmware */
-	val = id & 0x1f;
-	soc_dev_attr->soc_id = devm_kasprintf(&pdev->dev, GFP_KERNEL, "0x%x", val);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
-
-	/* format revision value passed from SCU firmware */
-	val = (id >> 5) & 0xf;
-	val = (((val >> 2) + 1) << 4) | (val & 0x3);
-	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%d.%d",
-						(val >> 4) & 0xf, val & 0xf);
-	if (!soc_dev_attr->revision)
-		return -ENOMEM;
-
-	soc_dev_attr->serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						     "%016llX", uid);
-	if (!soc_dev_attr->serial_number)
-		return -ENOMEM;
-
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		return PTR_ERR(soc_dev);
-
-	return 0;
-}
-
-static struct platform_driver imx_scu_soc_driver = {
-	.driver = {
-		.name = IMX_SCU_SOC_DRIVER_NAME,
-	},
-	.probe = imx_scu_soc_probe,
-};
-
-static int __init imx_scu_soc_init(void)
-{
-	struct platform_device *pdev;
-	struct device_node *np;
-	int ret;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx-scu");
-	if (!np)
-		return -ENODEV;
-
-	of_node_put(np);
-
-	ret = platform_driver_register(&imx_scu_soc_driver);
-	if (ret)
-		return ret;
-
-	pdev = platform_device_register_simple(IMX_SCU_SOC_DRIVER_NAME,
-					       -1, NULL, 0);
-	if (IS_ERR(pdev))
-		platform_driver_unregister(&imx_scu_soc_driver);
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(imx_scu_soc_init);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 3c459f5..22c7657 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -20,4 +20,5 @@ int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
+int imx_scu_soc_init(struct device *dev);
 #endif /* _SC_SCI_H */
-- 
2.7.4

