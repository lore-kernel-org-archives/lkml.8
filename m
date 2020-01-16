Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C1C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3D6207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M27ffA5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAPQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:11:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52869 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgAPQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:11:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so4354268wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zm3EA5ViiDj9vcvdIk454dpypkS7vacCzFaTcvwYLD8=;
        b=M27ffA5yQ2P7fnqwdtqHSl5zYoykpuyuvogdIQnStFenQQRQiUMMKD6VxNjC8mQEEi
         fFPWfV41wXmvFyE9G/9h32R5awNboUtFWhtij0xITH/OA+wye2x5Bu6Kax21m/E2uEEJ
         Zwfpdz1Io4ZHnJFZ7xEfHl7i0TD3UPtRXcHFCfeqLGh8EsUuNVONeMN8N4M4kiv30zSZ
         jBXJYUbghoDnSTSF3dscmyrJQb84Kv+Y28TB5o38SOT+Utu/0gdVdIgDlrjmPCNutnns
         kGd4XGOezyV7eklTZ0uaZlx2G/cVefBqqyH53wXEQOICpzPZ1Ofqj7rhgk10vQm38Y1I
         GggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zm3EA5ViiDj9vcvdIk454dpypkS7vacCzFaTcvwYLD8=;
        b=s/KqyHfqV+PP/KqNqmKcgquXmvn495vxtNCciw0l6nSxGeXrQG9bEOvLj2Lm2LKs6p
         cdNU6U7MRbJf4+vK51bU3v2DWeOEAUeAAoAOVNdF1r7hrhBNblz/V1eGbqzqvBAJq8SW
         3ekS53+TB6gCRlYOT3l9Ex+MgxC4emqDYtnJZv7GuxvO3/j/MOC8ocv+s61CiwOnHSGw
         f0WSDmsCZvjTWvHN3J5Hcf4bNxj9pxXTuNEu1v6pUIh7SkbLWpBCP2VRdzy6VyGJo7ze
         dCUTR1rwsUOzlTV11D03qwrGj98yfHsXfbdSgWJzfiaFmGQRBFnH43gHNJH1+gdtBdMf
         /ajg==
X-Gm-Message-State: APjAAAWVQHY/Bwtdsvv3sVtfBIfS700aLrhitQ0ZI/fMhHffNB01QFbL
        OA/fWAo10MwnUPpoYpM17KA7kg==
X-Google-Smtp-Source: APXvYqxIbpJMrmLk5giJSzR2tQVgsz4xN0R0BX7qy9LqPkb+h6Qv+yAaVe5g6LTkQyuFC2M/jYgIYw==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr76812wmb.113.1579191080105;
        Thu, 16 Jan 2020 08:11:20 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g9sm30075740wro.67.2020.01.16.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:11:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anirudh Ghayal <aghayal@codeaurora.org>,
        Shyam Kumar Thella <sthella@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] nvmem: add QTI SDAM driver
Date:   Thu, 16 Jan 2020 16:11:00 +0000
Message-Id: <20200116161100.30637-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
References: <20200116161100.30637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anirudh Ghayal <aghayal@codeaurora.org>

QTI SDAM driver allows PMIC peripherals to access the shared memory
that is available on QTI PMICs.

Use subsys_initcall as PMIC SDAM NV memory is accessed by multiple PMIC
drivers (charger, fuel gauge) to store/restore data across reboots
required during their initialization.

Signed-off-by: Anirudh Ghayal <aghayal@codeaurora.org>
Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig          |   8 ++
 drivers/nvmem/Makefile         |   2 +
 drivers/nvmem/qcom-spmi-sdam.c | 192 +++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/nvmem/qcom-spmi-sdam.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 73567e922491..35efab1ba8d9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -109,6 +109,14 @@ config QCOM_QFPROM
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_qfprom.
 
+config NVMEM_SPMI_SDAM
+	tristate "SPMI SDAM Support"
+	depends on SPMI
+	help
+	  This driver supports the Shared Direct Access Memory Module on
+	  Qualcomm Technologies, Inc. PMICs. It provides the clients
+	  an interface to read/write to the SDAM module's shared memory.
+
 config ROCKCHIP_EFUSE
 	tristate "Rockchip eFuse Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 9e667823edb3..6b466cd1427b 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -28,6 +28,8 @@ obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
 nvmem_mtk-efuse-y		:= mtk-efuse.o
 obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
 nvmem_qfprom-y			:= qfprom.o
+obj-$(CONFIG_NVMEM_SPMI_SDAM)	+= nvmem_qcom-spmi-sdam.o
+nvmem_qcom-spmi-sdam-y		+= qcom-spmi-sdam.o
 obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
new file mode 100644
index 000000000000..8682cda448d6
--- /dev/null
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/nvmem-provider.h>
+#include <linux/regmap.h>
+
+#define SDAM_MEM_START			0x40
+#define REGISTER_MAP_ID			0x40
+#define REGISTER_MAP_VERSION		0x41
+#define SDAM_SIZE			0x44
+#define SDAM_PBS_TRIG_SET		0xE5
+#define SDAM_PBS_TRIG_CLR		0xE6
+
+struct sdam_chip {
+	struct platform_device		*pdev;
+	struct regmap			*regmap;
+	struct nvmem_config		sdam_config;
+	unsigned int			base;
+	unsigned int			size;
+};
+
+/* read only register offsets */
+static const u8 sdam_ro_map[] = {
+	REGISTER_MAP_ID,
+	REGISTER_MAP_VERSION,
+	SDAM_SIZE
+};
+
+static bool sdam_is_valid(struct sdam_chip *sdam, unsigned int offset,
+				size_t len)
+{
+	unsigned int sdam_mem_end = SDAM_MEM_START + sdam->size - 1;
+
+	if (!len)
+		return false;
+
+	if (offset >= SDAM_MEM_START && offset <= sdam_mem_end
+				&& (offset + len - 1) <= sdam_mem_end)
+		return true;
+	else if ((offset == SDAM_PBS_TRIG_SET || offset == SDAM_PBS_TRIG_CLR)
+				&& (len == 1))
+		return true;
+
+	return false;
+}
+
+static bool sdam_is_ro(unsigned int offset, size_t len)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sdam_ro_map); i++)
+		if (offset <= sdam_ro_map[i] && (offset + len) > sdam_ro_map[i])
+			return true;
+
+	return false;
+}
+
+static int sdam_read(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct sdam_chip *sdam = priv;
+	struct device *dev = &sdam->pdev->dev;
+	int rc;
+
+	if (!sdam_is_valid(sdam, offset, bytes)) {
+		dev_err(dev, "Invalid SDAM offset %#x len=%zd\n",
+			offset, bytes);
+		return -EINVAL;
+	}
+
+	rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val, bytes);
+	if (rc < 0)
+		dev_err(dev, "Failed to read SDAM offset %#x len=%zd, rc=%d\n",
+						offset, bytes, rc);
+
+	return rc;
+}
+
+static int sdam_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct sdam_chip *sdam = priv;
+	struct device *dev = &sdam->pdev->dev;
+	int rc;
+
+	if (!sdam_is_valid(sdam, offset, bytes)) {
+		dev_err(dev, "Invalid SDAM offset %#x len=%zd\n",
+			offset, bytes);
+		return -EINVAL;
+	}
+
+	if (sdam_is_ro(offset, bytes)) {
+		dev_err(dev, "Invalid write offset %#x len=%zd\n",
+			offset, bytes);
+		return -EINVAL;
+	}
+
+	rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val, bytes);
+	if (rc < 0)
+		dev_err(dev, "Failed to write SDAM offset %#x len=%zd, rc=%d\n",
+						offset, bytes, rc);
+
+	return rc;
+}
+
+static int sdam_probe(struct platform_device *pdev)
+{
+	struct sdam_chip *sdam;
+	struct nvmem_device *nvmem;
+	unsigned int val;
+	int rc;
+
+	sdam = devm_kzalloc(&pdev->dev, sizeof(*sdam), GFP_KERNEL);
+	if (!sdam)
+		return -ENOMEM;
+
+	sdam->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!sdam->regmap) {
+		dev_err(&pdev->dev, "Failed to get regmap handle\n");
+		return -ENXIO;
+	}
+
+	rc = of_property_read_u32(pdev->dev.of_node, "reg", &sdam->base);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Failed to get SDAM base, rc=%d\n", rc);
+		return -EINVAL;
+	}
+
+	rc = regmap_read(sdam->regmap, sdam->base + SDAM_SIZE, &val);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Failed to read SDAM_SIZE rc=%d\n", rc);
+		return -EINVAL;
+	}
+	sdam->size = val * 32;
+
+	sdam->sdam_config.dev = &pdev->dev;
+	sdam->sdam_config.name = "spmi_sdam";
+	sdam->sdam_config.id = pdev->id;
+	sdam->sdam_config.owner = THIS_MODULE,
+	sdam->sdam_config.stride = 1;
+	sdam->sdam_config.word_size = 1;
+	sdam->sdam_config.reg_read = sdam_read;
+	sdam->sdam_config.reg_write = sdam_write;
+	sdam->sdam_config.priv = sdam;
+
+	nvmem = devm_nvmem_register(&pdev->dev, &sdam->sdam_config);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev,
+			"Failed to register SDAM nvmem device rc=%ld\n",
+			PTR_ERR(nvmem));
+		return -ENXIO;
+	}
+	dev_dbg(&pdev->dev,
+		"SDAM base=%#x size=%u registered successfully\n",
+		sdam->base, sdam->size);
+
+	return 0;
+}
+
+static const struct of_device_id sdam_match_table[] = {
+	{ .compatible = "qcom,spmi-sdam" },
+	{},
+};
+
+static struct platform_driver sdam_driver = {
+	.driver = {
+		.name = "qcom,spmi-sdam",
+		.of_match_table = sdam_match_table,
+	},
+	.probe		= sdam_probe,
+};
+
+static int __init sdam_init(void)
+{
+	return platform_driver_register(&sdam_driver);
+}
+subsys_initcall(sdam_init);
+
+static void __exit sdam_exit(void)
+{
+	return platform_driver_unregister(&sdam_driver);
+}
+module_exit(sdam_exit);
+
+MODULE_DESCRIPTION("QCOM SPMI SDAM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

