Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4F9C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5A82080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgAJR3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:29:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgAJR3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:29:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DEAABB25C;
        Fri, 10 Jan 2020 17:29:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     phil@raspberrypi.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm283x: Unify CMA configuration
Date:   Fri, 10 Jan 2020 18:29:35 +0100
Message-Id: <20200110172935.19709-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of the Raspberry Pi 4 we were forced to explicitly
configure CMA's location, since arm64 defaults it into the ZONE_DMA32
memory area, which is not good enough to perform DMA operations on that
device. To bypass this limitation a dedicated CMA DT node was created,
explicitly indicating the acceptable memory range and size.

That said, compatibility between boards is a must on the Raspberry Pi
ecosystem so this creates a common CMA DT node so as for DT overlays to
be able to update CMA's properties regardless of the board being used.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

If this doesn't make it into v5.5 I'd be tempted to add:
Fixes: d98a8dbdaec6 ("ARM: dts: bcm2711: force CMA into first GB of memory")

 arch/arm/boot/dts/bcm2711.dtsi | 33 +++++++++++++--------------------
 arch/arm/boot/dts/bcm283x.dtsi | 13 +++++++++++++
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 8687534d4528..c8e4041308e0 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -12,26 +12,6 @@ / {
 
 	interrupt-parent = <&gicv2>;
 
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges;
-
-		/*
-		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
-		 * that's not good enough for the BCM2711 as some devices can
-		 * only address the lower 1G of memory (ZONE_DMA).
-		 */
-		linux,cma {
-			compatible = "shared-dma-pool";
-			size = <0x2000000>; /* 32MB */
-			alloc-ranges = <0x0 0x00000000 0x40000000>;
-			reusable;
-			linux,cma-default;
-		};
-	};
-
-
 	soc {
 		/*
 		 * Defined ranges:
@@ -869,6 +849,19 @@ pin-rts {
 	};
 };
 
+&rmem {
+	#address-cells = <2>;
+};
+
+&cma {
+	/*
+	 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
+	 * that's not good enough for the BCM2711 as some devices can
+	 * only address the lower 1G of memory (ZONE_DMA).
+	 */
+	alloc-ranges = <0x0 0x00000000 0x40000000>;
+};
+
 &i2c0 {
 	compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
 	interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 839491628e87..6128baed83c2 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -30,6 +30,19 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	rmem: reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x4000000>; /* 64MB */
+			reusable;
+			linux,cma-default;
+		};
+	};
+
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <0>;
-- 
2.24.1

