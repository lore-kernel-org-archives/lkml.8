Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6E6C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8E22192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBlTj2pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgCKJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:08:50 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:16064
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbgCKJIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCUU0qkZFdINLZt8vif/RZNodziwhbz3Y2Qmep/TFU6lz7Cpx52JSKV+ybeAybWaCccixsIwcy3mFeJcV9Zaue/MYYUQnabP6gYAs45HMvH6pv49ZawIFzAzvcR5SmLCQLd7KvvMTtwteIj2usCY3ayrJcm2CDVrjqNGl1a2HLD5k+H+W4ytCx++365nKIw7hKQhP+gOc7pSDVaBhEq8wzLLqte65jhxRwoGH6F1jKzvxgR303HZaEKdkyOnAVFCNtuwXIlnOHuifgbVh8CCIwnrh9fKpuK6jbboIVQ6pShvvzaD9iixykDlvvg3pzENxeVcTtcSjzGdtuRtDpsEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixdt3LHc+fLCklQ+sTM2VLiOs+Hr2Ds57nIIbi7NXEw=;
 b=lsUh4viYlVDnn/v/TBSLcN2sP5w/UIeAt+raI3Ebogg+1QPHcBL/OY0GP0DBv2GoB7fomU6Z5/Hu8c/IB/YrhmB8zUWYJwKhAK3YWlmKtZng1ydd2NCkOc54DpwpI3/15BurCltlStuMyLXQWXuWSAnwZDiL8RtQlyCQYG+JSRgKd9dbj/K3lLpdcho7E6ykm//2tLMhutwXRv8m7t9bkBwa/A5Se7AbOw88CI1f5UjiFKO4AAqnYzKqI/fp8NFMfpYojG3XjRUqmuVzRGhLd012SJiUW75qhBT2g9RgnaeU1ns+/pm0x3P6dGMwZEo0r8uDA0cg27VwwP9icjrZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixdt3LHc+fLCklQ+sTM2VLiOs+Hr2Ds57nIIbi7NXEw=;
 b=cBlTj2pmY9vE82iMuY39velG0a9SKufwPfxIGAvwbEUM/2Ybvq2vonedGFTmrzR0soKco4GmqXVlE2v2dP6HPJCjpuw2m2EbCuJcSOx0RDqHLPRQNxYpyTM9Be/yxSlvVCBhoZH70Xgm1YHEmTpPlW+Fa6UxefXg0sR8hnr4RRc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5427.eurprd04.prod.outlook.com (20.178.114.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 09:08:40 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 09:08:40 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] ARM: dts: imx: add nvmem property for cpu0
Date:   Wed, 11 Mar 2020 17:02:06 +0800
Message-Id: <1583917326-5550-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0090.apcprd02.prod.outlook.com (2603:1096:4:90::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 09:08:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6c6d6b4-be58-4acb-1838-08d7c59bca61
X-MS-TrafficTypeDiagnostic: AM0PR04MB5427:|AM0PR04MB5427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5427E8D658B7004944E1E15C88FC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(9686003)(69590400007)(6666004)(6486002)(4326008)(6512007)(6506007)(36756003)(186003)(478600001)(16526019)(2906002)(5660300002)(316002)(81166006)(956004)(86362001)(26005)(8936002)(66556008)(66946007)(52116002)(2616005)(66476007)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5427;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh53RV2pKeIYTeHzHBBriRGfC/4bGDMYQOnjwcNNG4Sgdpf2o5hnPANqa6mM5NuKmxkNoZhn/GX/iNFQK683s4WhHoDBYq1zyHdCoz/6Mu0JxX+pNYz7SFsYv1X2xp8rxgae2EWc807wMwyoQkZUeFZK28cYyXb/vv7n/EhSHsJNONrOKmXy5rQ77OsAkQJmQF4/iS0BUaRy+zLcyIwCMA3h1k7t7hMjHQlylunIAX/BiQKu83avhpYq7VBsH9J7doU0Ps/PDOqRZcFAk0J61hhXSQYEk3cDvQyH84g/1wdyik34m9+tkrh34A1YvKkeFnbBtEkuG3B7g+k3oUuvO0rrgqrV1WrXsVXMtRwP+SBQ7a1c+AjaYRAJ0JxrKvCpwwSqGEJQsNIJGScQQHDwZb+GMBCkTWKXP4VXY/u93WnAcwWPCqBBb6V9aujFSR8cDeOd0e+fhM7BfkmiHMoeHEDAiH19n29rJu43a78Zwx7VolMpW+5O17Hfxvue9EH7
X-MS-Exchange-AntiSpam-MessageData: c6LoGzYu49AEUKa9CzDuijeXgrflm+Nl3POqdFhUT0a3FdPaKXfDeLT12EouKVeWl4hr3ri7q7kjgmsyhjz+dI989X2MOhd+OnJqlpmGy40k6Oq4rzhxvgT2zvqj8qo6+Ww5HpZW5mLMGY0mBnAltw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c6d6b4-be58-4acb-1838-08d7c59bca61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 09:08:40.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaFqdLy7kKhjHvnp2grRe9ZtWXDOhIGi4UQgbfJT6AIPOu64eLx59MJIdfCLCr3OYRCbtDlX4mycCRyfwAmYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add nvmem related property for cpu0, then nvmem API could be used
to read cpu speed grading to avoid directly read OCOTP registers
mapped which could not handle defer probe.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop useless blankline

 arch/arm/boot/dts/imx6dl.dtsi  | 2 ++
 arch/arm/boot/dts/imx6q.dtsi   | 2 ++
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 arch/arm/boot/dts/imx6sl.dtsi  | 8 ++++++++
 arch/arm/boot/dts/imx6sll.dtsi | 6 ++++++
 arch/arm/boot/dts/imx6sx.dtsi  | 6 ++++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4b3a128d9260..055f1d875bac 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -44,6 +44,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0fad13f9d336..d3ba9d4a1290 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -49,6 +49,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		cpu1: cpu@1 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 70fb8b56b1d7..303131200675 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1165,6 +1165,12 @@
 				compatible = "fsl,imx6q-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6QDL_CLK_IIM>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			tzasc@21d0000 { /* TZASC1 */
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c8ec46fe8302..ae75fde8877a 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -74,6 +74,8 @@
 			arm-supply = <&reg_arm>;
 			pu-supply = <&reg_pu>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -953,6 +955,12 @@
 				compatible = "fsl,imx6sl-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SL_CLK_OCOTP>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			audmux: audmux@21d8000 {
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 797f850492fe..6b7fb3cec9f6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -72,6 +72,8 @@
 				 <&clks IMX6SLL_CLK_PLL1_SYS>;
 			clock-names = "arm", "pll2_pfd2_396m", "step",
 				      "pll1_sw", "pll1_sys";
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -791,6 +793,10 @@
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SLL_CLK_OCOTP>;
 
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
+
 				tempmon_calib: calib@38 {
 					reg = <0x38 4>;
 				};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index e47d346a3543..63aa19d81b42 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -87,6 +87,8 @@
 				      "pll1_sw", "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -1058,6 +1060,10 @@
 				reg = <0x021bc000 0x4000>;
 				clocks = <&clks IMX6SX_CLK_OCOTP>;
 
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
+
 				tempmon_calib: calib@38 {
 					reg = <0x38 4>;
 				};
-- 
2.16.4

