Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE0AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449BC20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgCDNYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:24:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:51328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDNYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:24:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28610AAC7;
        Wed,  4 Mar 2020 13:24:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     phil@raspberrypi.org, f.fainelli@gmail.com,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: bcm2711: Move emmc2 into its own bus
Date:   Wed,  4 Mar 2020 14:24:37 +0100
Message-Id: <20200304132437.20164-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on bcm2711's revision its emmc2 controller might have
different DMA constraints. Raspberry Pi 4's firmware will take care of
updating those, but only if a certain alias is found in the device tree.
So, move emmc2 into its own bus, so as not to pollute other devices with
dma-ranges changes and create the emmc2bus alias.

Based in Phil ELwell's downstream implementation.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since v1:
 - Add comment in dt
 - Fix commit title

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  1 +
 arch/arm/boot/dts/bcm2711.dtsi        | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 1d4b589fe233..e26ea9006378 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -20,6 +20,7 @@ memory@0 {
 	};
 
 	aliases {
+		emmc2bus = &emmc2bus;
 		ethernet0 = &genet;
 		pcie0 = &pcie0;
 	};
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index d1e684d0acfd..a91cf68e3c4c 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -241,17 +241,32 @@ pwm1: pwm@7e20c800 {
 			status = "disabled";
 		};
 
+		hvs@7e400000 {
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	/*
+	 * emmc2 has different DMA constraints based on SoC revisions. It was
+	 * moved into its own bus, so as for RPi4's firmware to update them.
+	 * The firmware will find whether the emmc2bus alias is defined, and if
+	 * so, it'll edit the dma-ranges property below accordingly.
+	 */
+	emmc2bus: emmc2bus {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <0x0 0x7e000000  0x0 0xfe000000  0x01800000>;
+		dma-ranges = <0x0 0xc0000000  0x0 0x00000000  0x40000000>;
+
 		emmc2: emmc2@7e340000 {
 			compatible = "brcm,bcm2711-emmc2";
-			reg = <0x7e340000 0x100>;
+			reg = <0x0 0x7e340000 0x100>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clocks BCM2711_CLOCK_EMMC2>;
 			status = "disabled";
 		};
-
-		hvs@7e400000 {
-			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-		};
 	};
 
 	arm-pmu {
-- 
2.25.1

