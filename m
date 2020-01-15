Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6994DC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E974222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgAOMW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:22:29 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57949 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbgAOMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:22:27 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EC983C0008;
        Wed, 15 Jan 2020 12:22:24 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 4/7] arm64: dts: meson-axg: Add PCIE PHY nodes
Date:   Wed, 15 Jan 2020 13:29:05 +0100
Message-Id: <20200115122908.16954-5-repk@triplefau.lt>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115122908.16954-1-repk@triplefau.lt>
References: <20200115122908.16954-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable both PCIE and shared MIPI/PCIE PHY nodes in order to make PCIE
reliable on AXG SoC.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 04803c3bccfa..d5c3885d4b14 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1104,6 +1104,12 @@ hiubus: bus@ff63c000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
 
+			mpphy: phy@0 {
+				compatible = "amlogic,axg-mipi-pcie-phy";
+				reg = <0x0 0x0 0x0 0xc>;
+				#phy-cells = <1>;
+			};
+
 			sysctrl: system-controller@0 {
 				compatible = "amlogic,meson-axg-hhi-sysctrl",
 					     "simple-mfd", "syscon";
@@ -1356,6 +1362,13 @@ tdmout_c: audio-controller@580 {
 			};
 		};
 
+		pcie_phy: bus@ff644000 {
+			compatible = "amlogic,axg-pcie-phy";
+			reg = <0x0 0xff644000 0x0 0x1c>;
+			resets = <&reset RESET_PCIE_PHY>;
+			#phy-cells = <0>;
+		};
+
 		aobus: bus@ff800000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff800000 0x0 0x100000>;
-- 
2.24.1

