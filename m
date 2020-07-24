Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A287C43600
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82C720748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="lMS0hKsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGXKi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGXKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:38:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so172818wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asNVEYk8KfoZ4vg7N/gD3s4rcXG24Tr1/ayUv6ELQDA=;
        b=lMS0hKsTGuLOzUEs5OuvhgZ8Stjst8miUPMx3B0A9abxrjSNgaKaVtS/0pZQZa3SZf
         Ye6XwdvuS/WCKoxzEA6SV89RC7Liz0J/lkrgrvwMRfSwS8fc3zFStCQx+yfgR+vWo309
         fFb8PXCdeKxJHyOwdmlWtN63viAJXcLaSGyVZ6NxxV9S5vsjjAr3D9CFnzz/2O9OU/2c
         5NjxVsW3ifD6SijmQ08F1Fnb9PDoAIUGj7VFD3PvfYZdiAN4+mpgksweKjvd9VOOhr1z
         +/9tqNXP9hzE7sxVQCJeyRc8ayX5l8EjVU6iCBnu5ezIHwAmRyLjIruHh+H1UvNR5HyU
         NumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asNVEYk8KfoZ4vg7N/gD3s4rcXG24Tr1/ayUv6ELQDA=;
        b=pDEYeaLxakrp8cO7vcbtOPbs5H/vjVu/Qb8TB9aJ5seKiZ9rmSwBHLAgvoVUnnBp6e
         PeoK6628YJBTcgAf5w+IqKMI9b1wRKop4925NLoREu8UKL1D3WsfPKBliwbv3CC0yEY5
         65Ka5HnQlWY+2PVQevumlFAeFSENWph94DfBJBKybgD2U9seN/QW0kyk+MmeQ1t3IbzQ
         /rp1oi6fkDBvj4e3P1C0SL2tiBcxb3ewDswpD8FWdVL2B83MBa4wcyVblu51095J3YVn
         W06gHj3uvdp5XxvWMCPzgF6hvhDElHpgeplcB1rEIvQM7YBP6Hqz+aj1ZKGHd8O5HGKP
         a1Gw==
X-Gm-Message-State: AOAM5329NggjEuM3g4pOBuOV99kVkEe/xmqmqnUE99CnWazyyMglcSBA
        jOwosyeh2qxDVMOOWa6+gfN2Ow==
X-Google-Smtp-Source: ABdhPJx0ZNqiuuhbIiOHn5PgnM0nwGQ+h7ykoniMkeWT2A7yZtkoVyUDBnTbW5mVNDL0oRvX3iICXQ==
X-Received: by 2002:a1c:a181:: with SMTP id k123mr8235759wme.172.1595587135446;
        Fri, 24 Jul 2020 03:38:55 -0700 (PDT)
Received: from lukakovacicapc.local ([2a00:ee2:4b0d:3001:fbc5:498b:ed6d:cfac])
        by smtp.gmail.com with ESMTPSA id f186sm6526280wmf.29.2020.07.24.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:38:54 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: [PATCH 1/4] arm: mvebu: dts: Add CRS326-24G-2S board
Date:   Fri, 24 Jul 2020 12:38:37 +0200
Message-Id: <20200724103840.18994-2-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724103840.18994-1-luka.kovacic@sartura.hr>
References: <20200724103840.18994-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MikroTik CRS326-24G-2S board has a switch chip with an integrated
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
 .../boot/dts/armada-xp-crs326-24g-2s-bit.dts  |  43 ++++++++
 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts |  17 +++
 .../arm/boot/dts/armada-xp-crs326-24g-2s.dtsi | 104 ++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..8627a38c4100 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1312,6 +1312,8 @@ dtb-$(CONFIG_MACH_ARMADA_39X) += \
 	armada-398-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-axpwifiap.dtb \
+	armada-xp-crs326-24g-2s.dtb \
+	armada-xp-crs326-24g-2s-bit.dtb \
 	armada-xp-db.dtb \
 	armada-xp-db-dxbc2.dtb \
 	armada-xp-db-xc3-24g4xg.dtb \
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts b/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
new file mode 100644
index 000000000000..21f442afab1f
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for MikroTik CRS326-24G-2S+ Bit board
+ *
+ * Copyright (C) 2020 Sartura Ltd.
+ * Author: Luka Kovacic <luka.kovacic@sartura.hr>
+ */
+
+#include "armada-xp-crs326-24g-2s.dtsi"
+
+/ {
+	model = "MikroTik CRS326-24G-2S+ Bit";
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
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts b/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
new file mode 100644
index 000000000000..83aef43f66d5
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for MikroTik CRS326-24G-2S+ board
+ *
+ * Copyright (C) 2020 Sartura Ltd.
+ * Author: Luka Kovacic <luka.kovacic@sartura.hr>
+ */
+
+#include "armada-xp-crs326-24g-2s.dtsi"
+
+/ {
+	model = "MikroTik CRS326-24G-2S+";
+};
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi b/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
new file mode 100644
index 000000000000..f3e1a25ca5f2
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for CRS326-24G-2S board
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
+	model = "CRS326-24G-2S+";
+	compatible = "mikrotik,crs326-24g-2s", "marvell,armadaxp-98dx3236", "marvell,armada-370-xp";
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

