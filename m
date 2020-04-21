Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F906C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4720E206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDUQgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:36:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:41402 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUQg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:36:29 -0400
IronPort-SDR: 0fhwsZ9YdfBBEbdgeDtoZKKizCeaoggCkTOcNPAqApPzG3NKYYidjcy6WYIcv/YtTxeFz2iZfe
 QBaUU2tbwPlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:36:28 -0700
IronPort-SDR: cEihd1JnjhZNwQ5c8lFnQOjQJpP8TjKZ0BOUTpH6miKIloGmPNXWCMhSAv+c8TlodtvJifJszC
 WO9TJ9mm0cxQ==
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="429584511"
Received: from dalessan-mobl1.ir.intel.com ([10.252.22.134])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:36:26 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>
Subject: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Date:   Tue, 21 Apr 2020 17:36:18 +0100
Message-Id: <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1587485099.git.daniele.alessandrelli@intel.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Keem Bay bootloader sets up a temporary Isolated Memory Region (IMR) to
protect itself during pre-Linux boot.

This temporary IMR remains active even when control is passed to the
Linux Kernel. It is Kernel responsibility to remove such an IMR during
initialization.

This driver adds such functionality.

The driver is loaded during `early_init`, which should ensure that the
IMR is removed before devices that may try to access the IMR are
initialized.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS                       |  5 ++++
 drivers/soc/Kconfig               |  1 +
 drivers/soc/Makefile              |  1 +
 drivers/soc/keembay/Kconfig       | 22 +++++++++++++++++
 drivers/soc/keembay/Makefile      |  5 ++++
 drivers/soc/keembay/keembay-imr.c | 40 +++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+)
 create mode 100644 drivers/soc/keembay/Kconfig
 create mode 100644 drivers/soc/keembay/Makefile
 create mode 100644 drivers/soc/keembay/keembay-imr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..59f1923a0f25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9194,6 +9194,11 @@ S:	Maintained
 W:	http://lse.sourceforge.net/kdump/
 F:	Documentation/admin-guide/kdump/
 
+KEEMBAY IMR
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+S:	Maintained
+F:	drivers/soc/keembay/keembay-imr.c
+
 KEENE FM RADIO TRANSMITTER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 425ab6f7e375..eeeba3ef7338 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
+source "drivers/soc/keembay/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 36452bed86ef..65c981207283 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -13,6 +13,7 @@ obj-y				+= fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= imx/
 obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
+obj-y				+= keembay/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
 obj-y				+= amlogic/
diff --git a/drivers/soc/keembay/Kconfig b/drivers/soc/keembay/Kconfig
new file mode 100644
index 000000000000..2161bce131b3
--- /dev/null
+++ b/drivers/soc/keembay/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Keem Bay SoC drivers.
+#
+
+menu "Keem Bay SoC drivers"
+
+config KEEMBAY_IMR
+	bool "Clean-up Keem Bay bootloader IMR at boot"
+	depends on ARM64
+	help
+	  This option makes the Kernel clean up the Isolated Memory Region
+	  (IMR) set up by Keem Bay bootloader (U-boot) to protect itself during
+	  early boot.
+
+	  The IMR number to be cleaned up is taken from the device tree
+	  (property 'u-boot-imr' of the 'chosen' node).
+
+	  If you are compiling the Kernel for a Keem Bay SoC select Y,
+	  otherwise select N.
+
+endmenu
diff --git a/drivers/soc/keembay/Makefile b/drivers/soc/keembay/Makefile
new file mode 100644
index 000000000000..dacfdb9f5fc1
--- /dev/null
+++ b/drivers/soc/keembay/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Keem Bay SoC drivers.
+#
+obj-$(CONFIG_KEEMBAY_IMR) += keembay-imr.o
diff --git a/drivers/soc/keembay/keembay-imr.c b/drivers/soc/keembay/keembay-imr.c
new file mode 100644
index 000000000000..eabbdd6e69a7
--- /dev/null
+++ b/drivers/soc/keembay/keembay-imr.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019-2020 Intel Corporation
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+/* Keem Bay SiP SVC for clearing an IMR. */
+#define KMB_SIP_SVC_IMR_CLEAR	0x8200ff13
+
+static int __init clear_imr(u64 imr)
+{
+	struct arm_smccc_res res = { 0 };
+
+	arm_smccc_smc(KMB_SIP_SVC_IMR_CLEAR, imr, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int __init kmb_imr_init(void)
+{
+	u32 imr;
+	int rc;
+
+	rc = of_property_read_u32(of_chosen, "u-boot-imr", &imr);
+	if (rc) {
+		pr_warn("Skipping IMR clean-up: No U-Boot IMR defined in device tree\n");
+		return 0;
+	}
+	pr_info("Disabling Keem Bay U-boot IMR: %u\n", imr);
+
+	return clear_imr(imr);
+}
+early_initcall(kmb_imr_init);
-- 
2.21.1

