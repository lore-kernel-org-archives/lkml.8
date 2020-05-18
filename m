Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08347C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C6F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa+sLwXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgERCZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgERCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:25:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C8C061A0C;
        Sun, 17 May 2020 19:25:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so8139944lje.10;
        Sun, 17 May 2020 19:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZobNRLV9OWt6qIUL1QmRkgHnNT9DqVov1qFrkfSpiCI=;
        b=Fa+sLwXFj+6YJYZB5+V59CKynIEG0EI/zUj+KfUX4xmhj8vB9k/z7JNHN8xbvXmYFD
         xfDZYHPB+uVelSfJrpTryuhGjFcZQ7nNUo3+E8wS4G9nSELGNdMxEIvWWazEjXu1l+zc
         3FyAYbtMvOJeFsAhO9lHQzrhvJp48lzG3LDnIj5YrnscpNnY5Pyhtrp/I4+AgwdouMN/
         MSe6UdHngOusWGsmSxXMRMlDakiAFYPFD8N0HKGy/2eTn+gn+jo/G4UMqwWQcFAt92H0
         ldCc11Rc41Qi2S2GpcZHuKDbpQCGBKT18lADXixjVqIvg1lZOg3nphctkMolxdhwH2Az
         ZBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZobNRLV9OWt6qIUL1QmRkgHnNT9DqVov1qFrkfSpiCI=;
        b=ufUai+mF/pbY8Y4F2RP6fUQ9zWEtElsKJa3mJ+3Y7oygfSfatBipsyjIUyrMOglgOP
         1TbLPAhDQsdWLCZHEugJKWfWKRMT+TI+N4gIKkaUXKEQ/iz21KaqhiRNfBWBYVQkD79z
         ViBpJgudGV0zAMARPlDitft5cctTXdulX6vYyHy2MlUU4PD62kzNx/SKirRNUkEkOhih
         lAH7/qFZqx/wx2fh87WmfVk1eGxUVUhm2M7zVuAbxtjrvmS3DDMkjDm21q2RLEb9YUN7
         TlAmlVm9ktMyJbwuJTpTdMm2RiX0nY7wnBPEmKTJKmCDoEzEUwE9nNAJKbGNh2jzKj81
         VQCQ==
X-Gm-Message-State: AOAM530LAYTEma/ROoK57Hg7gJVGrZDZpHPuemqy6M81ejaLpCTn4e8d
        7JLshw8/WmuOdPfRa2VfN8I=
X-Google-Smtp-Source: ABdhPJyTs/i33Mtq1ks1n/wp7BfL4n8MywZwlykIMrasJArCJe8s8j9a/sNJ+A/zXsSEhWD6Bjra9g==
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr9218846ljp.57.1589768750372;
        Sun, 17 May 2020 19:25:50 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m13sm5997306lfk.12.2020.05.17.19.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:25:49 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: meson-g12b-gtking-pro: add initial device-tree
Date:   Mon, 18 May 2020 02:25:31 +0000
Message-Id: <20200518022531.14739-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518022531.14739-1-christianshewitt@gmail.com>
References: <20200518022531.14739-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400
reference board with an S922X chip.

- 4GB LPDDR4 RAM
- 64GB eMMC storage
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- HDMI 2.1 video
- Analogue audio output
- 1x RS232 port
- 2x USB 2.0 port
- 2x USB 3.0 ports
- IR receiver
- 1x micro SD card slot
- 1x Power on/off button

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-g12b-gtking-pro.dts     | 125 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 66691090b30c..38bb1f6e6ef6 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-tanix-tx5max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
new file mode 100644
index 000000000000..f0c56a16af3d
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-w400.dtsi"
+#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+
+/ {
+	compatible = "azw,gtking", "amlogic,g12b";
+	model = "Beelink GT-King Pro";
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		power-button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		white {
+			label = "power:white";
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12B-GTKING-PRO";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT";
+
+		assigned-clocks = <&clkc CLKID_MPLL2>,
+				  <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&frddr_a>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&frddr_b>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&frddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-3 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			dai-tdm-slot-tx-mask-1 = <1 1>;
+			dai-tdm-slot-tx-mask-2 = <1 1>;
+			dai-tdm-slot-tx-mask-3 = <1 1>;
+			mclk-fs = <256>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
+
+			codec {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&arb {
+	status = "okay";
+};
+
+&clkc_audio {
+	status = "okay";
+};
+
+&frddr_a {
+	status = "okay";
+};
+
+&frddr_b {
+	status = "okay";
+};
+
+&frddr_c {
+	status = "okay";
+};
+
+&tdmif_b {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
+&tohdmitx {
+	status = "okay";
+};
-- 
2.17.1

