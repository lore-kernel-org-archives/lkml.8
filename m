Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE59C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7152207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgH1NT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:19:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44063 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgH1NRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:17:54 -0400
X-Originating-IP: 90.89.180.255
Received: from lhopital-XPS-13-9360.home (lfbn-tou-1-1372-bdcst.w90-89.abo.wanadoo.fr [90.89.180.255])
        (Authenticated sender: kevin.lhopital@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPA id 2AD0CFF80D;
        Fri, 28 Aug 2020 13:17:51 +0000 (UTC)
From:   =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
To:     linux-media@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org, yong.deng@magewell.com, mchehab+samsung@kernel.org,
        p.zabel@pengutronix.de, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com,
        =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= 
        <kevin.lhopital@bootlin.com>
Subject: [PATCH v2 4/4] ARM: dts: sun8i: a83t: Add support for the MIPI CSI-2 in CSI node
Date:   Fri, 28 Aug 2020 15:17:36 +0200
Message-Id: <20200828131737.12483-5-kevin.lhopital@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828131737.12483-1-kevin.lhopital@bootlin.com>
References: <20200828131737.12483-1-kevin.lhopital@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in the CSI device node the MIPI CSI2 clocks, interrupt and
increase the memory size in order to add the support of the
MIPI CSI-2 for A83T

Signed-off-by: Kévin L'hôpital <kevin.lhopital@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 53c38deb8a08..5e6421eb8e28 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1025,12 +1025,15 @@
 
 		csi: camera@1cb0000 {
 			compatible = "allwinner,sun8i-a83t-csi";
-			reg = <0x01cb0000 0x1000>;
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x01cb0000 0x2000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_CSI>,
 				 <&ccu CLK_CSI_SCLK>,
-				 <&ccu CLK_DRAM_CSI>;
-			clock-names = "bus", "mod", "ram";
+				 <&ccu CLK_DRAM_CSI>,
+				 <&ccu CLK_MIPI_CSI>,
+				 <&ccu CLK_CSI_MISC>;
+			clock-names = "bus", "mod", "ram", "mipi", "misc";
 			resets = <&ccu RST_BUS_CSI>;
 			status = "disabled";
 
-- 
2.17.1

