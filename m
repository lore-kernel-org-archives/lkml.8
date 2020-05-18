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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5244C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7925220758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8cMGoHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgERCeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERCeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:34:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00095C061A0C;
        Sun, 17 May 2020 19:34:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so6658568lfg.6;
        Sun, 17 May 2020 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owseaUgVdUp1iGU/MsdkGUhcwERmtg+0Eo8UVFbYquc=;
        b=K8cMGoHLGPLARM/xf/iQMQnxmR0KqEfQlR2C8gEcdd9CoEHsMANbT8//2DQpbdWHSz
         TrtkFpL9wlFfM6WRxH/Ko/bzfT4mbUPWF2L8lorBLweXv/+qzzOXo9Rgmn965cf7qTnY
         9c43iq5d4BqU2KFdPV3Zb2GzHNL1czjt9pj9ws7EqVvLFX0l8gcxooDdhywmnKh3RXFE
         RVrtLTDD1poCjTH8W36si5cskA+Ju9UIj3vi6sHSh/vgrmRG/piSsVbdOUA4jPuHuDyj
         +dNPznwKL7GzdqF8wgJhLXpj/PimBs2edjD3iiThdyGbU1Xgv2wL6vmTyfuDf2eOr3Ax
         q4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=owseaUgVdUp1iGU/MsdkGUhcwERmtg+0Eo8UVFbYquc=;
        b=WuFBR74HW3lFpgE3Q4IGf/+CCiH6luT2Q+xnbb5xQ8zgOgZQJU0I/rYGoVq/S5293G
         trk8reRa4N7L1OUNQF/yAqB0zaCYdbthTSCSxwFCw7lX87PugIhd6OY8apz1P7gQshEN
         KBmfUjDwcL3qxiCX12sYG3Jqj/8V3SQuk54qIeiSHQMV59gGPq1YXzDhyZPG61pTup3G
         6RzcZti3RYgbVuWFrwFHtcEAUlMjU1w5BaTSexMmmJM9NE79afWJl1t1Wsqpy7O1QBVP
         od2n/Z1iLa4vGMuxWfxe+c/W5gNJrNpY6QrxnDe3Op6XSXf79IQjPt2aOvsN26n5Y0rL
         VhfA==
X-Gm-Message-State: AOAM533qYhVvJmMjsHg94YElgpkPURIaBwtxow22pKA1f4+Aiv62LcvP
        y0uFwXvpDf/0RM7t/3JoOvs=
X-Google-Smtp-Source: ABdhPJwxMJ7EXFpl+00vKxDmDBV9spx2n6CyQOO7iUeCnmT6WXAp2z4vfLrWthNud3hvPFyuqz8e8A==
X-Received: by 2002:a19:6914:: with SMTP id e20mr3440674lfc.27.1589769257453;
        Sun, 17 May 2020 19:34:17 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l25sm5937498lfh.71.2020.05.17.19.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:34:16 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 3/5] arm64: dts: meson-g12b-gtking: add initial device-tree
Date:   Mon, 18 May 2020 02:34:02 +0000
Message-Id: <20200518023404.15166-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518023404.15166-1-christianshewitt@gmail.com>
References: <20200518023404.15166-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
board with an S922X chip.

- 4GB LPDDR4 RAM
- 64GB eMMC storage
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- HDMI 2.1 video
- S/PDIF optical output
- Analogue audio output
- 1x USB 2.0 port
- 2x USB 3.0 ports
- IR receiver
- 1x micro SD card slot

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-gtking.dts    | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 01e32415e252..66691090b30c 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-tanix-tx5max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
new file mode 100644
index 000000000000..eeb7bc5539ef
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -0,0 +1,145 @@
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
+	model = "Beelink GT-King";
+
+	spdif_dit: audio-codec-1 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
+	sound {
+		compatible = "amlogic,axg-sound-card";
+		model = "G12B-GTKING";
+		audio-aux-devs = <&tdmout_b>;
+		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
+				"SPDIFOUT IN 2", "FRDDR_C OUT 3";
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
+		/* spdif hdmi or toslink interface */
+		dai-link-4 {
+			sound-dai = <&spdifout>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_A>;
+			};
+		};
+
+		/* spdif hdmi interface */
+		dai-link-5 {
+			sound-dai = <&spdifout_b>;
+
+			codec {
+				sound-dai = <&tohdmitx TOHDMITX_SPDIF_IN_B>;
+			};
+		};
+
+		/* hdmi glue */
+		dai-link-6 {
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
+&spdifout {
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&spdifout_b {
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

