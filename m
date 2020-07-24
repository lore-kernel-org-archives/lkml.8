Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31342C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CC420748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="MKTrm8RF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGXKjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGXKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:38:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so894500wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzuRpAS8/HJXVbVLylAyBQaGzmpX+rFR9BOvfquNy00=;
        b=MKTrm8RFq3jYoOmAKlCuZn5T4X3dUyv6SahKhXYwy0NIffWYo8Lfht7c59sIvenQzP
         vjtw6/RsPvnRZU0rkHfJ1iCIDTcsRL8emdSy1PHUEPX676EcI5jTrdhy3TBzhjhKPOtr
         gqxTTZHhCM4XtJN90RqXybYY65zg8hKdtMMCLw81jfHtMxqbyUWsm0Bwu+Nvxzf+PP/x
         Cs6wRftrKJ4N3JoNJqKEW8tfFR0RzCk3ZcKY+gYrywvab/+suj7cc/TYEIWr7BekITh2
         sf+FS6BDR7oZxpfrxCNRvMBV8CWefguLDr/USZsF2ZACBS7dhNjRhpsZncgQwgGhAff1
         fCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzuRpAS8/HJXVbVLylAyBQaGzmpX+rFR9BOvfquNy00=;
        b=eR+j0julKpgXHvg6qzvO1OIJSEkfbEmi53dA9vkOAFH+q5F3juOQFEcoLRABVCD+Yq
         ihh9Ve/Rb2U3/yqZtCfH/3Ijs5P1GsrZUrsFbPem3JfRGsGdnA5BOcG96gkJVCGO1xvH
         NMQ7kt25xt1+w+9yOMlYpbV61H66J4HUiM75fiY3IXoRMdo2Ol/t43drOzJPUvw/0k7N
         N6p1ocwNoaLVcQkSej9oAxJ0VoxG50vOdBojkoN8LDJwggWiuFIqWYcgj5T/wbrQTtWW
         pxPcnaE76Lo32aMSMG5uigtjjP3nrncTRsyaAwnRd+YOHCJxtjI4W7xOSYLDIAdZXu2b
         fggQ==
X-Gm-Message-State: AOAM533ger/WtvKsJZa86aUI3lxh9RwiPzXPCEU4/179F4+R/2nHEV7e
        DesouJDlK4yl0xJkWitLSY3VvQ==
X-Google-Smtp-Source: ABdhPJwtYg2leiWigjNBGlHSEpqgwuWkpBIB3GKIA1LeBVEGPNltJUPGNe3lI9nTH1vI6ZuZK0LpVQ==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr8229420wmf.160.1595587137660;
        Fri, 24 Jul 2020 03:38:57 -0700 (PDT)
Received: from lukakovacicapc.local ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id f186sm6526280wmf.29.2020.07.24.03.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:38:56 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: [PATCH 2/4] arm: mvebu: dts: Add CRS305-1G-4S board
Date:   Fri, 24 Jul 2020 12:38:38 +0200
Message-Id: <20200724103840.18994-3-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724103840.18994-1-luka.kovacic@sartura.hr>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MikroTik CRS305-1G-4S board has a switch chip with an integrated
Marvell Prestera 98DX3236 CPU.

This commit includes two board variants, namely the factory
default one and a Bit variant. The Bit variant has a
bigger Macronix flash.

This device tree includes basic Linux support.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Jakov Petrina <jakov.petrina@sartura.hr>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/armada-xp-crs305-1g-4s-bit.dts   |  43 ++++++++
 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts  |  17 +++
 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi | 104 ++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8627a38c4100..f3ac0fb7f244 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1312,6 +1312,8 @@ dtb-$(CONFIG_MACH_ARMADA_39X) += \
 	armada-398-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-axpwifiap.dtb \
+	armada-xp-crs305-1g-4s.dtb \
+	armada-xp-crs305-1g-4s-bit.dtb \
 	armada-xp-crs326-24g-2s.dtb \
 	armada-xp-crs326-24g-2s-bit.dtb \
 	armada-xp-db.dtb \
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts b/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
new file mode 100644
index 000000000000..a022c68dc943
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for MikroTik CRS305-1G-4S+ Bit board
+ *
+ * Copyright (C) 2020 Sartura Ltd.
+ * Author: Luka Kovacic <luka.kovacic@sartura.hr>
+ */
+
+#include "armada-xp-crs305-1g-4s.dtsi"
+
+/ {
+	model = "MikroTik CRS305-1G-4S+ Bit";
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+		m25p,fast-read;
+
+		partition@u-boot {
+			reg = <0x00000000 0x001f0000>;
+			label = "u-boot";
+		};
+		partition@u-boot-env {
+			reg = <0x001f0000 0x00010000>;
+			label = "u-boot-env";
+		};
+		partition@ubi1 {
+			reg = <0x00200000 0x03f00000>;
+			label = "ubi1";
+		};
+		partition@ubi2 {
+			reg = <0x04100000 0x03f00000>;
+			label = "ubi2";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts b/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
new file mode 100644
index 000000000000..010b83b54212
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for MikroTik CRS305-1G-4S+ board
+ *
+ * Copyright (C) 2020 Sartura Ltd.
+ * Author: Luka Kovacic <luka.kovacic@sartura.hr>
+ */
+
+#include "armada-xp-crs305-1g-4s.dtsi"
+
+/ {
+	model = "MikroTik CRS305-1G-4S+";
+};
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi b/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
new file mode 100644
index 000000000000..32fb21b2bf6a
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for CRS305-1G-4S board
+ *
+ * Copyright (C) 2016 Allied Telesis Labs
+ * Copyright (C) 2020 Sartura Ltd.
+ *
+ * Based on armada-xp-db.dts
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
+ */
+
+/dts-v1/;
+#include "armada-xp-98dx3236.dtsi"
+
+/ {
+	model = "CRS305-1G-4S+";
+	compatible = "mikrotik,crs305-1g-4s", "marvell,armadaxp-98dx3236", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x00000000 0 0x20000000>; /* 512 MB */
+	};
+};
+
+&L2 {
+	arm,parity-enable;
+	marvell,ecc-enable;
+};
+
+&devbus_bootcs {
+	status = "okay";
+
+	/* Device Bus parameters are required */
+
+	/* Read parameters */
+	devbus,bus-width    = <16>;
+	devbus,turn-off-ps  = <60000>;
+	devbus,badr-skew-ps = <0>;
+	devbus,acc-first-ps = <124000>;
+	devbus,acc-next-ps  = <248000>;
+	devbus,rd-setup-ps  = <0>;
+	devbus,rd-hold-ps   = <0>;
+
+	/* Write parameters */
+	devbus,sync-enable = <0>;
+	devbus,wr-high-ps  = <60000>;
+	devbus,wr-low-ps   = <60000>;
+	devbus,ale-wr-ps   = <60000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+		m25p,fast-read;
+
+		partition@u-boot {
+			reg = <0x00000000 0x001f0000>;
+			label = "u-boot";
+		};
+		partition@u-boot-env {
+			reg = <0x001f0000 0x00010000>;
+			label = "u-boot-env";
+		};
+		partition@ubi1 {
+			reg = <0x00200000 0x00e00000>;
+			label = "ubi1";
+		};
+	};
+};
-- 
2.26.2

