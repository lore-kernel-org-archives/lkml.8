Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FECEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E207920738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WfObDEQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEUD0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:26:08 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:48098
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbgEUD0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYMrWzT+TzJlzKKv2e37OZiYdkponL79tXkISo2+NV2ixq0LqpbLwW8OazZb8cR+ymiMm9YhlKHy8Fy+UXBoqC/S4cPMuipj0mvIwv3wT2KSuu1PPBKnC4UjAikqaHvWgFQlDfSsmL8zMUANT1nRGCgIP3mVU6cioO0xOBVAGBZIhw8Yn+eHSraCkICHjKODaIJ/8iBxglAfejsuGE2+5wfrvSFg6g90wjz259MjEcVP6kunD6yINBu2EbJofZjBEppFOdGYtVSv0GcezdinW16SVuif4pMv3tZqNAJkvulEKHvAj42OjT9pSEWa1oToZR7EI4lgbwh2oKU2uFEYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ6nBurTxl+xqtlAIKZPuwCc/z/pi5b75SebjLmEs2g=;
 b=Y5p7Q6xZK94oMimnS8xb+m3k+13lVL5MVXFGZw4G40FMNThEsBsBxIgJGyN45v/W9JHDQPyCu0FPmHaElqOaXE8Bf8lkYC2J9E6DvEFPBIKMgdsqaZviaYB0UYJ0ZewG9ZA0tjFEYHrk/D3r6m+8KFBeODon6yFO12GCFioTQ5Gj2NWizrNP+9NyXyqcQ+cdIg8vmaf9DWyrfuVrl6dH2upkZ+FtNETLP8yjTsz+tGDozF9/BbBocyvQzFWnKSOBniZYF1M8MlhTfe6pd+9u6UIxPSUjXvnfTY4IAHNdHnxBtlbrm4BO4mhJaC8FY0YIK7vjALaMDGbyJtTSjVgfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ6nBurTxl+xqtlAIKZPuwCc/z/pi5b75SebjLmEs2g=;
 b=WfObDEQK3OUlvp+2UPpQz0XQCFv/k82H9bynJr605XJUZq9IiSLr1sbMev2mA42n903fOcP7fQGtp5BNBb41alRnheCQIqtT8QA1q7gkfY+nN2LUBq76hYYLW/8WW4lokUkbXsssOfmjC+FcgLyFWMOuh0DXEGfKCivkg7FNOEA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6383.eurprd04.prod.outlook.com (2603:10a6:803:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 21 May
 2020 03:26:04 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:26:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2 voltage range
Date:   Thu, 21 May 2020 19:26:08 +0800
Message-Id: <1590060368-2282-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590060368-2282-1-git-send-email-yibin.gong@nxp.com>
References: <1590060368-2282-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0132.apcprd03.prod.outlook.com (2603:1096:4:91::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.11 via Frontend Transport; Thu, 21 May 2020 03:26:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22cf99d1-047a-46e3-3e86-08d7fd36b155
X-MS-TrafficTypeDiagnostic: VE1PR04MB6383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6383C67CC13E26186605890F89B70@VE1PR04MB6383.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mz0pjSMfmBFfNEyBHQP6avYljqkvAkm338KDDEt+q7HAROvh4grP/+Mcpz7l416dxJl5m0DQXzKoqCtX4I0Q8DGLbcIw+7wqV2C59ejeQbwzXZJ7h2moeWOa0mvY3yWRTk9dEjc2FrBtW1cnb91gFycJNThzwvO9yiPSfFDYXj8AhSLa7cybKOoO5y2EaIHYA0QLrESOPORYLAO67bCK7nhTyHTZFiyWBh0yfdQzr++aksfQ+WfoY3rO2nbNKSXKjwfZihkrAWysR6tOPA0a1EvDV/EuOwTxxFi5MZPo9RF453UIkMazuZvV9QDN1+c0uuHXy87u7ZdN4X0sNMEC9SjFFerJLFA++YNlGDa29XSiBiBoO7b6PluS1OEb6uxevyLXy09GLP7L2W1BWjV9VH1LuG2yjoRieuoPgPySOI6oxWSGOqVAieRe+pvwJHQuwLlntTlgo6UGodNjnlUb6kb0Gbm3n7YrKTsynuH+TAtkJFxJq1n0fo/zBDl0ti2p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(8936002)(5660300002)(8676002)(186003)(16526019)(2906002)(86362001)(66476007)(956004)(6512007)(6486002)(6636002)(2616005)(66946007)(66556008)(478600001)(316002)(52116002)(4326008)(36756003)(26005)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: U3Eq77B6iNfKIMnoPHUiJPjt95hyfrdLygUOrV8wutk4q0unrrfMbGEVqGhV2BIEFUaeBIV4Ui/Awe5iHwhI/K09cVUK9yMpKipr1ywbqIoSe7Bm80iOXWcAFn39x12XZUPpDtEcdiLyNy777gaProetiJqTFd06ARcnrBM1051clHxq0QEN9OFpSgzS26S34QpyefwJTPtdpZbSRElHgSFwbbYd4JQjrnJKQMm+nzgUy3giujtzcucTT5/fLlNfRWlE9MkpFT4G2w0yED3IkjXxHBc1FDRswk8M/S2ggklEkZXqVo2Q+SK66A3Dk5qfH1nctV8qrCsy+/+IIzIlWNp+914k06h8KmUYG5bknx/41bDynRk1lkDAlTjsUUAz6tfh8gzFWLDiCEFhSE8CEAthU0E9xzLq8FzLqpNIRKhiB6tJ3IgqxYyNljSlcjh3z1t3c0Pb7qZPQ1Hh0MVLGfgPDBzGyCtWQbjCrVOTfqdguSFkqtU5/VwWZqChR7hW
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf99d1-047a-46e3-3e86-08d7fd36b155
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:26:04.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrONGm8bhfeg7szGaBozAhA7g9MRDEuDXp7pvQgrcgA/SHJvLJz4T9W4hUtD8GeL9M9DN5QxdWZR/N1iuhnfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct ldo1 voltage range from wrong high group(3.0v~3.3v) to low group
(1.6v~1.9v) because the ldo1 should be 1.8v. Actually, two voltage groups
have been supported at bd718x7-regulator driver, hence, just corrrect the
voltage range to 1.6v~3.3v. For ldo2@0.8v, correct voltage range too.
Otherwise, ldo1 would be kept @3.0v and ldo2@0.9v which violate i.mx8mm
datasheet as the below warning log in kernel:

[    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
[    0.999196] LDO2: Bringing 800000uV into 900000-900000uV

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts      | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index d07e0e6..a1e5483 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -113,7 +113,7 @@
 
 			ldo1_reg: LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <3000000>;
+				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
@@ -121,7 +121,7 @@
 
 			ldo2_reg: LDO2 {
 				regulator-name = "LDO2";
-				regulator-min-microvolt = <900000>;
+				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
 				regulator-always-on;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 61f3519..117ff4b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -13,6 +13,15 @@
 	compatible = "fsl,imx8mn-evk", "fsl,imx8mn";
 };
 
+&ecspi1 {
+	status = "okay";
+spidev0: spi@0 {
+	compatible = "ge,achc";
+	reg = <0>;
+	spi-max-frequency = <1000000>;
+	};
+};
+
 &A53_0 {
 	/delete-property/operating-points-v2;
 };
-- 
2.7.4

