Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AD620773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQ+8QowK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIBPOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:14:39 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:31663
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbgIBPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8ffsGyFk2AwPnRUhaXvcS9gNFSY6/MklVaTsyLg6qNGu6dEheagVp7FDWIbrP6IYpDCT1DsTVqgaTTa94GkMBypGxr+cvCdhWioM/4PDuuc0fpMrrA1yPW2tQO1PvHTaRAVeo/OL28bx0bDA6D/2fUNJ0J4Gcos8ej9qH8qFt9Q2X+RyAf5tUKTey4jJf5Qa/EDlJvP/3n0CScKQcJqZmMExhMzpj2G8L+Z7/Ss+bazSwqD4y0KTXzYpx48k55S0ye2B0zoEx81YuuCK88mKyivH6WErn6pm1zcF9BCfTsw75EqD9aEp0bNZnNG5PRhqQc7taIMfNrOzIO9DAyuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLBYCGZuEEiY/duxyrOyvH0BLuH7a234wp/NTReaw9A=;
 b=T43SJ73Sbm/+BTJ7DrX6y3bh6cIvr2b66eQeZ+mO/vYBH0i1qytaW8OimxlDbQ+IDEpHZc58wEORPulA00eFMmMnrLbFm6R8qGGCsHBTFYsto613aq1OKbfotERqIFF+4d7H2PvvpTFxJ3QpEjrA+t8QLZcPR4J5XDR47bZm0y6ZCPWQqYJDNDIn2sD29ksDfVrrZQa0QoVjI+tInoNS4X/4XVUdvhKKpoOF0btA5AHNqI00OkS25/w6T+0uTD6n7wcu6ARyht9JFdzE4FUxvlJEqCrlkgJyO4M9/Kv16U9Qksa4th1ZGlof/QujBqgK4I1Ed4WeOmW7i5J2bc9Ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLBYCGZuEEiY/duxyrOyvH0BLuH7a234wp/NTReaw9A=;
 b=aQ+8QowKXTv6yjswmyHiObo0lobm/WzOefVn0Zb+tNcs94M6RZ36JPEv7NRkQIEAEvsK07tAUVfyd0VVOtrRqZ2AjWRH1Nvjnhieg3tcPz3HtqIUYkYLRtZz1E6xHWiLET0xZ2LtqtBpavSAWXm+2hKfoFMIYeqdQcm+NFM6nJw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 15:13:47 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%7]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 15:13:47 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds board
Date:   Wed,  2 Sep 2020 20:43:30 +0530
Message-Id: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0147.apcprd03.prod.outlook.com
 (2603:1096:4:c8::20) To AM7PR04MB6885.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SG2PR03CA0147.apcprd03.prod.outlook.com (2603:1096:4:c8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 15:13:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 022304ee-7c21-469b-2aee-08d84f52ca5d
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB3957EE2A567D159BE871A6CE8E2F0@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwuyNO3WQoq8+fGsvLyjNfZdDKxRUKdgR3q3BYQvWRXNRzyVSkJ1GCRU2TiHmyR0JtlY4EPsS4WjhAhIpRSXX6WnkX5fP65ncvmelR96rpS/i3meeCxRUIy+K/xz3QkS7D2t7Ecc7YIQTKesKYjIWICcCtn11gQDMrES0jOwI3BHn/AR9dio2jgAVzj3GWCcEBFzm/a7Fjzs7TNjD/dbKGv/C4WTsNRCSXq39KeN1b23J2DnRp7GJoy3lilAKuJaET8UNd7YHU+e2+q7IbKw56FMDD2WjfZ5eYFdMTYhJylNOXFMSZcVWxvpUphzRX4Zm9HyaVSQ7gc9u/YGZcFWvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(6486002)(52116002)(8936002)(55236004)(16576012)(36756003)(66556008)(9686003)(54906003)(478600001)(66946007)(8676002)(66476007)(6666004)(5660300002)(86362001)(2616005)(956004)(186003)(4326008)(26005)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MfwtNbAiQ97iOjYk9/Cc7H49pq9l7kMOUsL9fabaBkNHDz8/O/TIC0AR72dtOKmaeMqFmNboHTISh/pHM+QBTyVI4p2n0CuulsDUN3PuwNkIf/0J3PfgVAgj9pgI1tanHMMhv3mb/9olXiSwZPpqO3auOoMzv43QiDZyRNzX1wIF/BN5tOOrFEMZIcXzW0cPqJnuuhkkY8yGJ+UFxnEjBF1Ap3oygCXvju9y+4D0WAoiftDglYWjpiIC7biheFoMlkGrS2QXggruUUC0qTxKcKBOUDz9v3a24srYv5uj5j2bZvFxuXvsoTTYAsFh04IKXG1Biwhj7+OWCDbreE+RdFLpCi69jy1c4FgxTK0u9JKRDuV57VxuEkV0kybdIliecvdrG4PLtz/Qt33SRrjr2FsOqYIE5LwmlOqekdFduEEYf0Dn+BMnTRb+/JGI4B6hPqm4hzOZ/oQ4T3KULkgEa7TgNg8nmWvXjVsVdUScIdL92e6ehnc2pFNqQ7hU1P88cKjX8LfW08VZLU2toYmKXcV5NDQEmmthS4PTsP066MCHl3XA6XXfpA8ey46BhQyl3mF+pla9Jo57a9Vns4s/PsZY6bdUCJuyekmTVe7z/Ih7bYoVGM6bvEHkccefipWZxdbN32ToYHIvw7mVj6DxBQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022304ee-7c21-469b-2aee-08d84f52ca5d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 15:13:47.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KU/wM1Jh2LFTeNnfZxKSwNAm89EB5XP69WodvT8odjERJ8YowcMgSezRMgaqYEaSeYCaN2wCPJIbCDgmB3SLXA31agRr3HoO8cLD0GVbog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Add device tree support for LX2162AQDS board.
LX2162A has same die as of LX2160A with different packaging.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 336 ++++++++++++++++++++++
 2 files changed, 337 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a39f0a1..ab9fbd3 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-clearfog-cx.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
new file mode 100644
index 0000000..a81c6a4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2162AQDS
+//
+// Copyright 2020 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model = "NXP Layerscape LX2162AQDS";
+	compatible = "nxp,lx2162a-qds", "fsl,lx2160a";
+
+	aliases {
+		crypto = &crypto;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "MC34717-3.3VSB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	mdio-mux-1 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mux 0>;
+		mdio-parent-bus = <&emdio1>;
+		#address-cells=<1>;
+		#size-cells = <0>;
+
+		mdio@0 { /* On-board RTL8211F PHY #1 RGMII1*/
+			reg = <0x00>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgmii_phy1: ethernet-phy@1 {
+				compatible = "ethernet-phy-id001c.c916";
+				reg = <0x1>;
+				eee-broken-1000t;
+			};
+		};
+
+		mdio@8 { /* On-board RTL8211F PHY #2 RGMII2*/
+			reg = <0x8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rgmii_phy2: ethernet-phy@2 {
+				compatible = "ethernet-phy-id001c.c916";
+				reg = <0x2>;
+				eee-broken-1000t;
+			};
+		};
+
+		mdio@18 { /* Slot #1 */
+			reg = <0x18>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@19 { /* Slot #2 */
+			reg = <0x19>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1a { /* Slot #3 */
+			reg = <0x1a>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1b { /* Slot #4 */
+			reg = <0x1b>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1c { /* Slot #5 */
+			reg = <0x1c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1d { /* Slot #6 */
+			reg = <0x1d>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1e { /* Slot #7 */
+			reg = <0x1e>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1f { /* Slot #8 */
+			reg = <0x1f>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	mdio-mux-2 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mux 1>;
+		mdio-parent-bus = <&emdio2>;
+		#address-cells=<1>;
+		#size-cells = <0>;
+
+		mdio@0 { /* Slot #1 (secondary EMI) */
+			reg = <0x00>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1 { /* Slot #2 (secondary EMI) */
+			reg = <0x01>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@2 { /* Slot #3 (secondary EMI) */
+			reg = <0x02>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@3 { /* Slot #4 (secondary EMI) */
+			reg = <0x03>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@4 { /* Slot #5 (secondary EMI) */
+			reg = <0x04>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@5 { /* Slot #6 (secondary EMI) */
+			reg = <0x05>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@6 { /* Slot #7 (secondary EMI) */
+			reg = <0x06>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@7 { /* Slot #8 (secondary EMI) */
+			reg = <0x07>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&dpmac17 {
+	phy-handle = <&rgmii_phy1>;
+	phy-connection-type = "rgmii-id";
+};
+
+&dpmac18 {
+	phy-handle = <&rgmii_phy2>;
+	phy-connection-type = "rgmii-id";
+};
+
+&dspi0 {
+	status = "okay";
+
+	dflash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi1 {
+	status = "okay";
+
+	dflash1: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi2 {
+	status = "okay";
+
+	dflash2: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&emdio1 {
+	status = "okay";
+};
+
+&emdio2 {
+	status = "okay";
+};
+
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
+
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	fpga@66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
+			     "simple-mfd";
+		reg = <0x66>;
+
+		mux: mux-controller {
+			compatible = "reg-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
+					<0x54 0x07>; /* 1: reg 0x54, bit 2:0 */
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			power-monitor@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <500>;
+			};
+
+			power-monitor@41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			temperature-sensor@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+				vcc-supply = <&sb_3v3>;
+			};
+
+			rtc@51 {
+				compatible = "nxp,pcf2129";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
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
+&usb0 {
+	status = "okay";
+};
-- 
2.7.4

