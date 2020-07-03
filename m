Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D038C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90C420884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dkYhkScD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGCIGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:06:05 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:40128
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbgGCIGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9xNR90DsOuX14flHlmG7Wl4fLuOJM9TsiDV0na9/ts7FdnttYGRxIqQuiHIKmG9RSxFgYIvf04Hno7+jiIHo7Ipn1md34BjvRv6qKzAyzmqVnth3S8UDOs976XGsWKl2+djl19PDmJGoQi9ZEwVwN5KwkH+11u4o6FckWLTJ1TfUnyqJ1dbOIzTa6lSV/rM5WKAlFOqCIids9FS0AOt1zk5uQbFBnOZfqUuW/BEonRSDRq8VT6g+HsQdbeDInqeBHknZ7T4nWAkSYmpxiGeoKeRE6zJU1C62MnC/5IdFi3XSzRh51A85mupKr/RKObBNzGOrRclNJEuDaKsy6iprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU3HOonPFW03LpdtWfjDvYKUozaaKvRwmMxDOeBtCuQ=;
 b=btDF5RhGfTwTQ63udDChMJpeChZ2RVSWba/NSpu0FcEnHhNSmPhJzMvE+N5CtzlonX03Y7D6kVJr7ScwU0VMfvSYUWvvfbXvn5zsdG0qqwTKXlgtlvqQQF6LfV/oCgu1GTCRxraOHcJvIOEnoIWMUL+25TY/UKR78q9jWeL4nt+P7HKc7SYuxK1CCF2nqQQ00j5Xs4MwlmXtnLeTVc6ERJqpJChnkZOWXJgf4SnngYSCdRnwGckdXM0XdhZFRjadlG11rn5SCRU8ErpTQWpQd+LpoYRaAGkSnj4iP1Q3ij0upKsE6bvw6GR6UeqUFp35nVUZOUg0jF+6umMHFaesbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU3HOonPFW03LpdtWfjDvYKUozaaKvRwmMxDOeBtCuQ=;
 b=dkYhkScDGWMElIXet1LGPvkFJkjRVVBrdZSkiUCFzjoXtP6JWMthYo7RnyMUXYTsAnD+iYIs4EWAP7uTV6kTaqNMIgeUiimpOn5PONae/rCmU3cVy+8kY8e76oH6mP9cuuxkEn0aKx4mWAFL+UgNU+w81FRgMX0PMLm0UZyCeik=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 08:05:27 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 08:05:27 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, anson.huang@nxp.com,
        festevam@gmail.com, s.hauer@pengutronix.de, john.lee@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v2 3/4] arm64: dts: imx8mn-evk: add pca9450 for i.mx8mn-evk board
Date:   Sat,  4 Jul 2020 00:19:37 +0800
Message-Id: <1593793178-9737-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 08:05:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4132ecb-3af0-47e8-abfc-08d81f27d8bb
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23025E727C12D76724E12307896A0@VI1PR0401MB2302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FzQTUsRpr16dzgR2SDfccL1MWCZnVCWf+ihQ66gMCyca8IvCURVP3S7YlfH7PaTz7yOZRZ2VsoVZIvhH3QWuUTSE9pCLjlHaBv+UbflCjxVO2gCc4yI67h5d5MJiL7OV7+E7W6v5x3G0HzjAkHOMtRcFXKYffafEoknv/86QHrNTFwAU5dj0fYoRtrurGyfH1mIDNLgOE8jcGtA44KR+pv5EPdWFABpXOAenEqTujgriZbo9UABJNRWcYykW/R1/4q26VcZxawHj24GswJlTmmSwj7UKm6X390ua6x+qoWcafTPO5AnQ4Rrf48OdogP38r0wKsTcCAO4w7//XeABt4UHpwSfDsXFy+LNldMQwbK2dbuyJkAtGz9MdGr2UPdw8Jv+zKh1Xh+Z8Hh5zdoKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(7416002)(6512007)(8676002)(6636002)(6666004)(8936002)(86362001)(52116002)(478600001)(5660300002)(16526019)(316002)(6506007)(2906002)(4326008)(2616005)(83380400001)(66556008)(26005)(186003)(66946007)(36756003)(956004)(6486002)(66476007)(921003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vLuWEieK3SS6766cK7C3ctJ81zaVa+2/pUBd2Q++iDBVcdKJizYvWyvcPcnYnLQsvUliLVnrzCnMQxgLBizziv2HEwu/g6tAplQTUM3N2AuIpbvy5Hjka1UZCGjOYmrZRuwAurSEubm3es67sB1OB48NeYUQTlgkI3J9YuAZEhdjjmtK6GCBa88BOT22zPxnKlzGKEQA4YeJRKliZZfjY5K8Stg95FgARBYU1YrFqjvUGfRZjofVqqCMI8otwSZQLxWzGGoGR4XItBGVp9spGZsqKkmuHXcee7QHUkdHGIPcoLPZa5CWnSrh2I9UNMgkYQgsQGJqbhgYhF2N4iHH/vexwGHVJjBQsGns0ChgPBMm1DxPrVWjkqHS3zBAOKvkx1AgJa1mKPvdDCK96ftkl3sE/DgL0fuscnhCc2OYmjMeRSIBGqLRqfPAd6R9b8vlvNKZDmv6MGiZ09xD8pMV3mhvY4X/i9bMhUWs4fnf+s0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4132ecb-3af0-47e8-abfc-08d81f27d8bb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:05:27.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkE+jXZrSPOok8UQZY6L0j4P/FgapbTc1LflwooXPq5ELLanOaA1lST9TXrAnHoiV9rJFTS57TLQpD88LFesmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pca9450 pmic driver for i.mx8mn-evk board.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts  | 96 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  6 ++
 2 files changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 61f3519..b846526 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -13,6 +13,102 @@
 	compatible = "fsl,imx8mn-evk", "fsl,imx8mn";
 };
 
+&i2c1 {
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450b";
+		reg = <0x25>;
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 GPIO_ACTIVE_LOW>;
+
+		regulators {
+			buck1: BUCK1{
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
 &A53_0 {
 	/delete-property/operating-points-v2;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 85fc0aa..98f5324 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -223,6 +223,12 @@
 		>;
 	};
 
+	pinctrl_pmic: pmicirq {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-- 
2.7.4

