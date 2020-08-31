Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E11CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530A72073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPLdxWLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgHaIfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:35:11 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:23360
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgHaIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfngLZfRb0/QFwx0ty9BwvciPL/586fpYa/V0f5dOzd3WlytwEYcqFVYiZw3mo5RZOIj4uuyAQkLEVL3jpe8+7cmiY7p2AGQQvfi28rCB5XqVK7ruRom7KWh4pAVvZBvfTz1By09X9//MZ+XFiKvudsmJRhEvRltqKg7Iwf03XmOpFb8M1wPDfAILMF5lJYfmJJPbIXBiojUlyN7kaL5/YRCtJVHBFglj7mdqNPcCVWo5wT9s8CD/SB2UeeBBg1dsjiIJLdEcnXmPCIvnsDaj2f+jIzL6Ji5iXrs3F9QUyWieiwclYIseJSF7xVB9Cvn6IpgiASm6hDFh1QYzqpo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/DbZJA+mzaihhjMc5FS0ODC4nWL0okttLnLM6wrsnQ=;
 b=eMZgUFf70OpOEeuvMPl0HRMlVsiAW2qQGom13Bu2wEXzPZ6r36uhUnavziD80LMlj2pZ69j+sBW9MRo5tm7kCrHjSM/QiG2KjjQTA8G0pyrSzPUzIgD9lwMB1wi3yes2FVjDYe/df3jBwZMLQK7E7MXmsM+QHozskr3cL19SZs+xXm86Jdo9bGKC/HoArIP355xXe6s0VFE2JeXWXw2z6LAEiU0EIGZ/kRUMBturnJsnSXLivGomtOUTFC+zKaEX7WWU1O3i4WZKwvKDxOP1Xh+UoPEvOEZ58aIGav9xgRNvUotQ6LmLrSKhl/0JpVj+rmBYxL/YCJhnXfhVJlmgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/DbZJA+mzaihhjMc5FS0ODC4nWL0okttLnLM6wrsnQ=;
 b=cPLdxWLBprHE3RPSllGFqJTy/WgHzA9Q3W6qiwePe/+rwYEtP/EOb1Y0MpJzNgb4rTLJ8DmcqFfzSvV6/BHmf5OpJarbUVJZEXHi/Xg8PmD6rfvZxodAfeQozERyMvPBD36opJppi4X1C5/O32jScz1lvwOUVJTovI+JlF+E6Q8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6637.eurprd04.prod.outlook.com (2603:10a6:803:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 08:35:00 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 08:35:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        Anson.Huang@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM64: dts: imx8mp-evk: add pca9450 node
Date:   Tue,  1 Sep 2020 00:48:35 +0800
Message-Id: <1598892515-30950-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
References: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 08:34:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18302c12-584f-4d3a-f434-08d84d88bfad
X-MS-TrafficTypeDiagnostic: VE1PR04MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6637E96D91441541639DA68189510@VE1PR04MB6637.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBCOwttmKfPboyLHa1tdqVwXAe9lzpNZtlqC7narFaso2mcbdy/+yig0PyBr2l+Fo3DfbV19DmSAhxYDUvrtKZGRSRwvjqqubqpqMiYI9kAKXAWtJSMSZwvGrm7XJYA1lvFM99ehsTB9mgLxQJ1D3NgIYXW+hUEtHXcRlCEgLfAQT1dCsMMHUe9/haE3GmAbNhhbL+YUwSZe+QXHKqj4WxDccq2bog3gT4ke8FMXZ+T1Lv94MGOQmgMHQF71doSR9zNrFTMGixoswV/t/T/YEFDOJZkrJuh56vE9Y3Gv7tKdPQQ3Gf+iT8CbGS1ieMEIZVbTPZ2ca8c3gN4AqTpgmFeaxeFjAHZP3Y0maQVPqlRujdycvZejhpTonEcetQac
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(316002)(52116002)(36756003)(8676002)(66946007)(6506007)(8936002)(478600001)(6666004)(186003)(16526019)(83380400001)(26005)(4326008)(66476007)(5660300002)(66556008)(7416002)(956004)(2616005)(2906002)(6512007)(6636002)(86362001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2gWDxo5Zm7Y4X08hw2YVcSW1WDLehjnA0Zsmvi0L9C3Gv5cBOGOgq/Ruq1XMu21zO8K8PG+Drl1+VrIc0C5gg9oHBHCH298eUBwpdXo5uDB+3QaVaf1weT8KgVlMuXo4ERgTvDB+6q7fCikUhI5DAuRaZm8hWoQXkm6Etp8YluAmE1tHuzn1sbRxQqwbAcSFahmzqGgeEky4u18i24CervXP3oo/zoXdG1hTPFJzSO1h23D5pd2Vc4DXlR9/2gZ+TCP+LuujHiFXSam7v8iTteEiqK41XDjJUpKmBgoqYi9km0v3CsStAdSAQ6rfSjQra6Pgjooag2i1RlzBfYWkUJW2dKoqsRbf2VhI/G3g9m4F3bbRVue8bhZoXMaDjNACuaxa2n0gPIcIhvfsTkfsSb7sxRSXKeek6A98fVBn+De8GAFDgxLN5QyRzmhjOrb+A68K/Y7tGPK8gwJEDBsOn0AQr4RG2GxJjHa+RAwcC5Dx5wUjzayKEN+i9GbeJqPt5I3aBoAr2EIbkeZXhnerP8o/TJ/vnmtyneX80dI8vIAmGTnAxggLN4f0lAr39dm4Gm3XoHEsc18KPt6u7/kW3TzeDJrC3NSTK9BF1oSMjcOtp7uTcLAHMaPlGoZ0o2UdcxYfSCMxaYKovqfwtRLesQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18302c12-584f-4d3a-f434-08d84d88bfad
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 08:35:00.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0b+MbA5IUTUFJobThIL/fIXIvAhYBbcMqcB5PddnTES8UrPLty7mnRRRNIgbroaAvrIKu6taUoMCFflD+RuaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pca9450c pmic for imx8mp-evk board.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 115 +++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3da1fff..8e000c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -66,6 +66,108 @@
 	};
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pca9450@25 {
+		reg = <0x25>;
+		compatible = "nxp,pca9450c";
+		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 GPIO_ACTIVE_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -152,6 +254,13 @@
 		>;
 	};
 
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
@@ -159,6 +268,12 @@
 		>;
 	};
 
+	pinctrl_pmic: pmicirq {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x41
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
-- 
2.7.4

