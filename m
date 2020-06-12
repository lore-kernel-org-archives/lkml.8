Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CE8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA50D207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFLQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:47:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:47:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CEA1AAD0;
        Fri, 12 Jun 2020 16:47:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 2/5] reset: Add Raspberry Pi 4 firmware reset controller
Date:   Fri, 12 Jun 2020 18:46:30 +0200
Message-Id: <20200612164632.25648-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612164632.25648-1-nsaenzjulienne@suse.de>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raspberry Pi 4's co-processor controls some of the board's HW
initialization process, but it's up to Linux to trigger it when
relevant. Introduce a reset controller capable of interfacing with
RPi4's co-processor that models these firmware initialization routines as
reset lines.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/reset/Kconfig                         | 10 ++++
 drivers/reset/Makefile                        |  1 +
 drivers/reset/reset-raspberrypi.c             | 60 +++++++++++++++++++
 .../reset/raspberrypi,firmware-reset.h        | 13 ++++
 4 files changed, 84 insertions(+)
 create mode 100644 drivers/reset/reset-raspberrypi.c
 create mode 100644 include/dt-bindings/reset/raspberrypi,firmware-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 88d3be1593..d02c1522e5 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -148,4 +148,14 @@ config RESET_IMX7
 	help
 	  Support for reset controller on i.MX7/8 SoCs.
 
+config RESET_RASPBERRYPI
+	bool "Raspberry Pi 4 Firmware Reset Controller Driver"
+	depends on DM_RESET && ARCH_BCM283X
+	default USB_XHCI_PCI
+	help
+	  Raspberry Pi 4's co-processor controls some of the board's HW
+	  initialization process, but it's up to Linux to trigger it when
+	  relevant. This driver provides a reset controller capable of
+	  interfacing with RPi4's co-processor and model these firmware
+	  initialization routines as reset lines.
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 0a044d5d8c..be54dae725 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_RESET_MTMIPS) += reset-mtmips.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_HISILICON) += reset-hisilicon.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
+obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
diff --git a/drivers/reset/reset-raspberrypi.c b/drivers/reset/reset-raspberrypi.c
new file mode 100644
index 0000000000..e2d284e5ac
--- /dev/null
+++ b/drivers/reset/reset-raspberrypi.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Raspberry Pi 4 firmware reset driver
+ *
+ * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+#include <common.h>
+#include <dm.h>
+#include <reset-uclass.h>
+#include <asm/arch/msg.h>
+#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
+
+static int raspberrypi_reset_request(struct reset_ctl *reset_ctl)
+{
+	if (reset_ctl->id >= RASPBERRYPI_FIRMWARE_RESET_NUM_IDS)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int raspberrypi_reset_free(struct reset_ctl *reset_ctl)
+{
+	return 0;
+}
+
+static int raspberrypi_reset_assert(struct reset_ctl *reset_ctl)
+{
+	switch (reset_ctl->id) {
+	case RASPBERRYPI_FIRMWARE_RESET_ID_USB:
+		bcm2711_notify_vl805_reset();
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int raspberrypi_reset_deassert(struct reset_ctl *reset_ctl)
+{
+	return 0;
+}
+
+struct reset_ops raspberrypi_reset_ops = {
+	.request = raspberrypi_reset_request,
+	.rfree = raspberrypi_reset_free,
+	.rst_assert = raspberrypi_reset_assert,
+	.rst_deassert = raspberrypi_reset_deassert,
+};
+
+static const struct udevice_id raspberrypi_reset_ids[] = {
+	{ .compatible = "raspberrypi,firmware-reset" },
+	{ }
+};
+
+U_BOOT_DRIVER(raspberrypi_reset) = {
+	.name = "raspberrypi-reset",
+	.id = UCLASS_RESET,
+	.of_match = raspberrypi_reset_ids,
+	.ops = &raspberrypi_reset_ops,
+};
+
diff --git a/include/dt-bindings/reset/raspberrypi,firmware-reset.h b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
new file mode 100644
index 0000000000..1a4f4c7927
--- /dev/null
+++ b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Nicolas Saenz Julienne
+ * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.com>
+ */
+
+#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
+#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
+
+#define RASPBERRYPI_FIRMWARE_RESET_ID_USB	0
+#define RASPBERRYPI_FIRMWARE_RESET_NUM_IDS	1
+
+#endif
-- 
2.26.2

