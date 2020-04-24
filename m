Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA32CC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6142075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgDXCrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:47:43 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:8540 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDXCrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:47:43 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 5F729106A2C;
        Fri, 24 Apr 2020 10:47:38 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     christophe.leroy@c-s.fr, oss@buserror.net, kernel@vivo.com,
        robh@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3,5/5] powerpc: sysdev: support userspace access of fsl_85xx_sram
Date:   Thu, 23 Apr 2020 19:45:54 -0700
Message-Id: <20200424024554.30709-6-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424024554.30709-1-wenhu.wang@vivo.com>
References: <20200424024554.30709-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVOSUtCQkJCS0NPT0xJTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6GDo6NTg3NFYVOCoULww8
        S08wCRpVSlVKTkNMTUJNT05CS09PVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUxPS043Bg++
X-HM-Tid: 0a71aa155c469374kuws5f729106a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New module which registers its memory allocation and free APIs to the
sram_dynamic module, which would create a device of struct sram_device
type to act as an interface for user level applications to access the
backend hardware device, fsl_85xx_cache_sram, which is drived by the
FSL_85XX_CACHE_SRAM module.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
---
 .../powerpc/include/asm/fsl_85xx_cache_sram.h |  4 ++
 arch/powerpc/platforms/85xx/Kconfig           | 10 +++++
 arch/powerpc/sysdev/Makefile                  |  1 +
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h     |  6 +++
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c     | 12 ++++++
 arch/powerpc/sysdev/fsl_85xx_sram_uapi.c      | 39 +++++++++++++++++++
 6 files changed, 72 insertions(+)
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_sram_uapi.c

diff --git a/arch/powerpc/include/asm/fsl_85xx_cache_sram.h b/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
index 0235a0447baa..99cb7e202c38 100644
--- a/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
+++ b/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
@@ -26,6 +26,10 @@ struct mpc85xx_cache_sram {
 	unsigned int size;
 	rh_info_t *rh;
 	spinlock_t lock;
+
+#ifdef CONFIG_FSL_85XX_SRAM_UAPI
+	struct device *dev;
+#endif
 };
 
 extern void mpc85xx_cache_sram_free(void *ptr);
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index fa3d29dcb57e..3a6f6af973eb 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -16,6 +16,16 @@ if FSL_SOC_BOOKE
 
 if PPC32
 
+config FSL_85XX_SRAM_UAPI
+	tristate "Freescale MPC85xx SRAM UAPI Support"
+	depends on FSL_SOC_BOOKE && SRAM_DYNAMIC
+	select FSL_85XX_CACHE_SRAM
+	help
+	  This registers a device of struct sram_device type which would act as
+	  an interface for user level applications to access the Freescale 85xx
+	  Cache-SRAM memory dynamically, meaning allocate on demand dynamically
+	  while they are running.
+
 config FSL_85XX_CACHE_SRAM
 	bool
 	select PPC_LIB_RHEAP
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index cb5a5bd2cef5..e71f82f0d2c3 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_FSL_CORENET_RCPM)	+= fsl_rcpm.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
+obj-$(CONFIG_FSL_85XX_SRAM_UAPI)	+= fsl_85xx_sram_uapi.o
 obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o fsl_rmu.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
index ce370749add9..4930784d9852 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
@@ -10,6 +10,8 @@
 #ifndef __FSL_85XX_CACHE_CTLR_H__
 #define __FSL_85XX_CACHE_CTLR_H__
 
+#include <linux/platform_device.h>
+
 #define L2CR_L2FI		0x40000000	/* L2 flash invalidate */
 #define L2CR_L2IO		0x00200000	/* L2 instruction only */
 #define L2CR_SRAM_ZERO		0x00000000	/* L2SRAM zero size */
@@ -81,6 +83,10 @@ struct sram_parameters {
 	phys_addr_t sram_offset;
 };
 
+#ifdef CONFIG_FSL_85XX_SRAM_UAPI
+extern struct mpc85xx_cache_sram *mpc85xx_get_cache_sram(void);
+#endif
+
 extern int instantiate_cache_sram(struct platform_device *dev,
 		struct sram_parameters sram_params);
 extern void remove_cache_sram(struct platform_device *dev);
diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index 3de5ac8382c0..0156ea63a3a2 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -23,6 +23,14 @@
 
 struct mpc85xx_cache_sram *cache_sram;
 
+
+#ifdef CONFIG_FSL_85XX_SRAM_UAPI
+struct mpc85xx_cache_sram *mpc85xx_get_cache_sram(void)
+{
+	return cache_sram;
+}
+#endif
+
 void *mpc85xx_cache_sram_alloc(unsigned int size,
 				phys_addr_t *phys, unsigned int align)
 {
@@ -115,6 +123,10 @@ int instantiate_cache_sram(struct platform_device *dev,
 	rh_attach_region(cache_sram->rh, 0, cache_sram->size);
 	spin_lock_init(&cache_sram->lock);
 
+#ifdef CONFIG_FSL_85XX_SRAM_UAPI
+	cache_sram->dev = &dev->dev;
+#endif
+
 	dev_info(&dev->dev, "[base:0x%llx, size:0x%x] configured and loaded\n",
 		(unsigned long long)cache_sram->base_phys, cache_sram->size);
 
diff --git a/arch/powerpc/sysdev/fsl_85xx_sram_uapi.c b/arch/powerpc/sysdev/fsl_85xx_sram_uapi.c
new file mode 100644
index 000000000000..60190bf3c8e9
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_85xx_sram_uapi.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
+ * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
+ * All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sram_dynamic.h>
+#include <asm/fsl_85xx_cache_sram.h>
+#include "fsl_85xx_cache_ctlr.h"
+
+static struct sram_api mpc85xx_sram_api = {
+	.name = "mpc85xx_sram",
+	.alloc = mpc85xx_cache_sram_alloc,
+	.free = mpc85xx_cache_sram_free,
+};
+
+static int __init mpc85xx_sram_uapi_init(void)
+{
+	struct mpc85xx_cache_sram *sram = mpc85xx_get_cache_sram();
+
+	if (!sram)
+		return -ENODEV;
+
+	return sram_register_device(sram->dev, &mpc85xx_sram_api);
+}
+subsys_initcall(mpc85xx_sram_uapi_init);
+
+static void __exit mpc85xx_sram_uapi_exit(void)
+{
+	sram_unregister_device(&mpc85xx_sram_api);
+}
+module_exit(mpc85xx_sram_uapi_exit);
+
+MODULE_AUTHOR("Wang Wenhu <wenhu.wang@vivo.com>");
+MODULE_DESCRIPTION("MPC85xx SRAM User-Space API Support");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

