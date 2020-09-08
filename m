Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0B1C2D0E0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9042080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wLd1vszn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbgIHRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:01:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54954 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbgIHRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:00:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088H0Jwn045048;
        Tue, 8 Sep 2020 12:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599584419;
        bh=FmjuH099uiCn3rXvAwwFQmzrrjb4VVYs4/lLE60Nv/I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wLd1vsznDaoSAfqoAKw5uf4m8BsVf2wTtxENbY85IvdHhy9iJwcg3Hv6Bepb7NXjl
         /uq8HIrmP1KPzWtr40fG/QeXFsDjLr5mZRkRAeBElplLmVZSlSTC95fq+qlZW54PGW
         OlLSd2PGepNC5PzLf0uOjXSNbszcjJBgo/qngars=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088H0J4g082815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 12:00:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 12:00:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 12:00:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088H0Iwq112786;
        Tue, 8 Sep 2020 12:00:18 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux and phy defs
Date:   Tue, 8 Sep 2020 19:59:42 +0300
Message-ID: <20200908165942.32368-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908165942.32368-1-grygorii.strashko@ti.com>
References: <20200908165942.32368-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI j7200 EVM base board has TI DP83867 PHY connected to external CPSW
NUSS Port 1 in rgmii-rxid mode.

Hence, add pinmux and Ethernet PHY configuration for TI j7200 SoC MCU
Gigabit Ethernet two ports Switch subsystem (CPSW NUSS).

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index e27069317c4e..f7e6b9b5ef5f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-j7200-som-p0.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	chosen {
@@ -14,6 +15,32 @@
 	};
 };
 
+&wkup_pmx0 {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
+			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x0080, PIN_INPUT, 0) /* MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio1-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
+		>;
+	};
+};
+
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "disabled";
@@ -62,3 +89,21 @@
 	/* UART not brought out */
 	status = "disabled";
 };
+
+&mcu_cpsw {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+};
+
+&davinci_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy0>;
+};
-- 
2.17.1

