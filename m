Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3287C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11FD2065F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgHYIyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:54:46 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:16524 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725916AbgHYIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:54:45 -0400
X-IronPort-AV: E=Sophos;i="5.76,351,1592838000"; 
   d="scan'208";a="55250272"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2020 17:54:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 254EC4261C31;
        Tue, 25 Aug 2020 17:54:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] ARM: dts: r8a7742-iwg21m: Add SPI NOR support
Date:   Tue, 25 Aug 2020 09:54:35 +0100
Message-Id: <20200825085435.8744-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SPI NOR device used to boot up the system
to the System on Module DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
Hi all,

This patch is part of series [1], since rest of the patches have been
acked I am just resending patch 3/3 from the series.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=333197

v1->v2
* Dropped #address-cells/#size-cells from flash node.
* Added partitions for flash node.
---
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
index 0f26807f92b8..5621c9ed698f 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
+++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
@@ -35,6 +35,16 @@
 	clock-frequency = <20000000>;
 };
 
+&gpio0 {
+	/* GP0_18 set low to select QSPI. Doing so will disable VIN2 */
+	qspi_en {
+		gpio-hog;
+		gpios = <18 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "QSPI_EN";
+	};
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -70,4 +80,45 @@
 		groups = "mmc1_data4", "mmc1_ctrl";
 		function = "mmc1";
 	};
+
+	qspi_pins: qspi {
+		groups = "qspi_ctrl", "qspi_data2";
+		function = "qspi";
+	};
+};
+
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash: flash@0 {
+		compatible = "sst,sst25vf016b", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bootloader";
+				reg = <0x00000000 0x000c0000>;
+				read-only;
+			};
+			partition@c0000 {
+				label = "env";
+				reg = <0x000c0000 0x00002000>;
+			};
+			partition@c2000 {
+				label = "user";
+				reg = <0x000c2000 0x0013e000>;
+			};
+		};
+	};
 };
-- 
2.17.1

