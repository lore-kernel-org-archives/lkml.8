Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51716C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3002E20767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636938AbgDOPb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:31:26 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:15290 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636891AbgDOPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:31:21 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id D314C4E1AAF;
        Wed, 15 Apr 2020 23:25:42 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
Date:   Wed, 15 Apr 2020 08:24:42 -0700
Message-Id: <20200415152442.122873-6-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415152442.122873-1-wenhu.wang@vivo.com>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVLSElCQkJCQklITEtNSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6Mjo4Ezg*HghCESkJGQ8a
        Gk8KCkpVSlVKTkNNQk1PSE9ISU9NVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUNOS083Bg++
X-HM-Tid: 0a717e72294f9376kuwsd314c4e1aaf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A driver for freescale 85xx platforms to access the Cache-Sram form
user level. This is extremely helpful for some user-space applications
that require high performance memory accesses.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changes since v1:
 * Addressed comments of Greg K-H
 * Moved kfree(info->name) into uio_info_free_internal()
---
 drivers/uio/Kconfig                   |   8 ++
 drivers/uio/Makefile                  |   1 +
 drivers/uio/uio_fsl_85xx_cache_sram.c | 182 ++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..afd38ec13de0 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -105,6 +105,14 @@ config UIO_NETX
 	  To compile this driver as a module, choose M here; the module
 	  will be called uio_netx.
 
+config UIO_FSL_85XX_CACHE_SRAM
+	tristate "Freescale 85xx Cache-Sram driver"
+	depends on FSL_85XX_CACHE_SRAM
+	help
+	  Generic driver for accessing the Cache-Sram form user level. This
+	  is extremely helpful for some user-space applications that require
+	  high performance memory accesses.
+
 config UIO_FSL_ELBC_GPCM
 	tristate "eLBC/GPCM driver"
 	depends on FSL_LBC
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index c285dd2a4539..be2056cffc21 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
 obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
+obj-$(CONFIG_UIO_FSL_85XX_CACHE_SRAM)	+= uio_fsl_85xx_cache_sram.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
diff --git a/drivers/uio/uio_fsl_85xx_cache_sram.c b/drivers/uio/uio_fsl_85xx_cache_sram.c
new file mode 100644
index 000000000000..fb6903fdaddb
--- /dev/null
+++ b/drivers/uio/uio_fsl_85xx_cache_sram.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
+ * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
+ * All rights reserved.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/uio_driver.h>
+#include <linux/stringify.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <asm/fsl_85xx_cache_sram.h>
+
+#define DRIVER_NAME	"uio_fsl_85xx_cache_sram"
+#define UIO_NAME	"uio_cache_sram"
+
+static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
+	{	.compatible = "uio,fsl,p2020-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p2010-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1020-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1011-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1013-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1022-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,mpc8548-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,mpc8544-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,mpc8572-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,mpc8536-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1021-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1012-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1025-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1016-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1024-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1015-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,p1010-l2-cache-controller",	},
+	{	.compatible = "uio,fsl,bsc9131-l2-cache-controller",	},
+	{},
+};
+
+static void uio_info_free_internal(struct uio_info *info)
+{
+	struct uio_mem *uiomem = &info->mem[0];
+
+	while (uiomem < &info->mem[MAX_UIO_MAPS]) {
+		if (uiomem->size) {
+			mpc85xx_cache_sram_free(uiomem->internal_addr);
+			kfree(uiomem->name);
+		}
+		uiomem++;
+	}
+
+	kfree(info->name);
+}
+
+static int uio_fsl_85xx_cache_sram_probe(struct platform_device *pdev)
+{
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *node = NULL;
+	struct uio_info *info;
+	struct uio_mem *uiomem;
+	const char *dt_name;
+	u32 mem_size;
+	u32 align;
+	void *virt;
+	phys_addr_t phys;
+	int ret = -ENODEV;
+
+	/* alloc uio_info for one device */
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	/* get optional uio name */
+	if (of_property_read_string(parent, "uio_name", &dt_name))
+		dt_name = UIO_NAME;
+
+	info->name = kstrdup(dt_name, GFP_KERNEL);
+	if (!info->name) {
+		ret = -ENOMEM;
+		goto err_info_free;
+	}
+
+	uiomem = &info->mem[0];
+	for_each_child_of_node(parent, node) {
+		ret = of_property_read_u32(node, "cache-mem-size", &mem_size);
+		if (ret) {
+			ret = -EINVAL;
+			goto err_info_free_internel;
+		}
+
+		if (mem_size == 0) {
+			dev_err(&pdev->dev, "cache-mem-size should not be 0\n");
+			ret = -EINVAL;
+			goto err_info_free_internel;
+		}
+
+		align = 2;
+		while (align < mem_size)
+			align *= 2;
+		virt = mpc85xx_cache_sram_alloc(mem_size, &phys, align);
+		if (!virt) {
+			/* mpc85xx_cache_sram_alloc to define the cause */
+			ret = -EINVAL;
+			goto err_info_free_internel;
+		}
+
+		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->addr = phys;
+		uiomem->size = mem_size;
+		uiomem->name = kstrdup(node->name, GFP_KERNEL);;
+		uiomem->internal_addr = virt;
+		++uiomem;
+
+		if (uiomem >= &info->mem[MAX_UIO_MAPS]) {
+			dev_warn(&pdev->dev, "more than %d uio-maps for device.\n",
+				 MAX_UIO_MAPS);
+			break;
+		}
+	}
+
+	while (uiomem < &info->mem[MAX_UIO_MAPS]) {
+		uiomem->size = 0;
+		++uiomem;
+	}
+
+	if (info->mem[0].size == 0) {
+		dev_err(&pdev->dev, "error no valid uio-map configured\n");
+		ret = -EINVAL;
+		goto err_info_free_internel;
+	}
+
+	info->version = "0.1.0";
+
+	/* register uio device */
+	if (uio_register_device(&pdev->dev, info)) {
+		dev_err(&pdev->dev, "uio registration failed\n");
+		ret = -ENODEV;
+		goto err_info_free_internel;
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+err_info_free_internel:
+	uio_info_free_internal(info);
+err_info_free:
+	kfree(info);
+err_out:
+	return ret;
+}
+
+static int uio_fsl_85xx_cache_sram_remove(struct platform_device *pdev)
+{
+	struct uio_info *info = platform_get_drvdata(pdev);
+
+	uio_unregister_device(info);
+
+	uio_info_free_internal(info);
+
+	kfree(info);
+
+	return 0;
+}
+
+static struct platform_driver uio_fsl_85xx_cache_sram = {
+	.probe = uio_fsl_85xx_cache_sram_probe,
+	.remove = uio_fsl_85xx_cache_sram_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table	= uio_mpc85xx_l2ctlr_of_match,
+	},
+};
+
+module_platform_driver(uio_fsl_85xx_cache_sram);
+
+MODULE_AUTHOR("Wang Wenhu <wenhu.wang@vivo.com>");
+MODULE_DESCRIPTION("Freescale MPC85xx Cache-Sram UIO Platform Driver");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

