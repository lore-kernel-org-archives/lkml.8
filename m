Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F129BC54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88BC21775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEIKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:44:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46208 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgEIKoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:44:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 081E4200324;
        Sat,  9 May 2020 12:44:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5ED2200102;
        Sat,  9 May 2020 12:44:33 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B0EC840285;
        Sat,  9 May 2020 18:44:29 +0800 (SGT)
From:   Hui Song <hui.song_1@nxp.com>
To:     u-boot@linux.nxdi.nxp.com, jiafei.pan@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        "hui.song" <hui.song_1@nxp.com>
Subject: [PATCH v1 2/3] armv8: gpio: add gpio feature
Date:   Sat,  9 May 2020 18:39:55 +0800
Message-Id: <20200509103956.26038-2-hui.song_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200509103956.26038-1-hui.song_1@nxp.com>
References: <20200509103956.26038-1-hui.song_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "hui.song" <hui.song_1@nxp.com>

add one struct mpc8xxx_gpio_plat to enable gpio feature.

Signed-off-by: hui.song <hui.song_1@nxp.com>
---
 .../include/asm/arch-fsl-layerscape/gpio.h    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-fsl-layerscape/gpio.h

diff --git a/arch/arm/include/asm/arch-fsl-layerscape/gpio.h b/arch/arm/include/asm/arch-fsl-layerscape/gpio.h
new file mode 100644
index 0000000000..d8dd750a72
--- /dev/null
+++ b/arch/arm/include/asm/arch-fsl-layerscape/gpio.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2014 Freescale Semiconductor, Inc.
+ */
+
+/*
+ * Dummy header file to enable CONFIG_OF_CONTROL.
+ * If CONFIG_OF_CONTROL is enabled, lib/fdtdec.c is compiled.
+ * It includes <asm/arch/gpio.h> via <asm/gpio.h>, so those SoCs that enable
+ * OF_CONTROL must have arch/gpio.h.
+ */
+
+#ifndef __ASM_ARCH_MX85XX_GPIO_H
+#define __ASM_ARCH_MX85XX_GPIO_H
+
+struct mpc8xxx_gpio_plat {
+	ulong addr;
+	unsigned long size;
+	uint ngpios;
+};
+
+#endif
-- 
2.17.1

