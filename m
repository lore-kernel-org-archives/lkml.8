Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D78C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E5D2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RwpVKEgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgEVCoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:44:46 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:5797
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbgEVCop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdndsT9aqB18mI1qNEykWuBCpqg5N+RYvy8Ipjuu0WfgbJe7MXfYHRiqmql4jbM2JJWvUkG6r12cQxGPhPvnsgi7kztA+FEun6tXa03bkYkyOhUKbabeXe8e5evG4JHTomo7c9sJXNOYrS3nYTYw8PigTAFcny/Apy+CMoQwnupC7nYk63ZuE7MUz2GnI5/3klbohqTdxfN3qXuvXyss/Zi2pA19NSKNZ3gsVzBzSbav/3qjbWkeu5AYTq69b7Doted0bC17BOZcfD5Rr+qhs9Ny+806zPuyuIIaPH4hm7sdA/9Q+fNYIl8b5F4ZO+7V+ti1e2LSY5krgWJH47jc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcueDrUqi1UomUnJUpQM4UwF2jbdiWcHhBDsG6Js25I=;
 b=L/YpDwH4ycX2d9uDyAk8Ra2ho3rj9MwJqhy/5zy3NTMSY09l/YdC0gKH8dk730XcTw/epJwuYTUmq0P0hHQPxWyqCxXLyic5gqwunkJSOggcFpyggFf3huu1EO6ViUdEyRB8dd71mfEu5SShvTDbkoMC3nWJggbQO9eX0F5VSV2rJf2cUEKPbmj8OerrFmfJV6ZU2XIz871tuikrDj9PCtZwx00vJ1ff3BMKvLysIgxDNbF/r7oHN6wTh59HwUU0BDEBpcCCkvMLCPXONyui3C7dELcRkxABqRW29oSjO1wZ+PeTNcA0I7pqHUzdTqeqDkz5btQXMc1Ttv0sL3EeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcueDrUqi1UomUnJUpQM4UwF2jbdiWcHhBDsG6Js25I=;
 b=RwpVKEgWAZlFzuHgl7iwOZCYP7JIWzh5+odhvOwpuNyS8E5z9o7n454kMbyDXbMWRwwt0NpZeH1OOX1mSGRKFXSnxOxKiRMcqdaGRPzVkZO7kumnmTKkst1P66FU+YiU1rvq/zuVKL+aCDM6WjR1JfsypCT08ra105Kz8U/wSVg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6365.eurprd04.prod.outlook.com (2603:10a6:803:120::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 02:44:41 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 02:44:41 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, anson.huang@nxp.com, peng.fan@nxp.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v3 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2 voltage range
Date:   Fri, 22 May 2020 18:44:51 +0800
Message-Id: <1590144291-18526-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
References: <1590144291-18526-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 02:44:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00d3f00c-e6e1-4c49-6dcd-08d7fdfa13c9
X-MS-TrafficTypeDiagnostic: VE1PR04MB6365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB636593B16F6F8D79F9CF48AC89B40@VE1PR04MB6365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2ZutoW7Nii8vbYSyjkCBfyQnSWIXrhw1iHn/e+fVmMw675zprQ8u9TRWhtX+zt2lzdj8Le1Qy1hJdsZfyYNE+90zvLpwkuq7VBSuq1Nkg5d7dDlJkuz7LVN9BVy27GuKYiWvoBmtifCCTSEKFm61V43n3XhSA16szd2ErHh86LyQuZEA36zpKEhxL73to1hUy1cLsjKqOWLzVPoh++5GfbA56a9b1UMeUCEVMZwrKIlReIVNQSQpVHa5gS4vldpMCp6xfQyabDXsIa7dV9xZRp2fHfe2M2RfPh/D/ulsDG/+WGiZIyekslXzAF4NL2m2ernSv0WA9/Shu+zNEGXUA5lf1dBz9iTxTWXa5YMPVrxsWNPTjgBbYJBx2wUpIoycvLwYxkzzcaab0wwOGfMkU0RAiRAzFYRmWNiOf7AFBecfBink2d7KfuJFqtKePRFgZAJFVPPmpLHuFzOfU15YnCVQU7wndItwi6V92DEhqsABXbDWdJY75TvgHLOKyMT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(8676002)(6506007)(4326008)(2906002)(6512007)(52116002)(6636002)(6666004)(186003)(66946007)(6486002)(8936002)(2616005)(36756003)(956004)(16526019)(5660300002)(26005)(316002)(86362001)(66556008)(478600001)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HNetlR84k4kdlxinzqZ/XgyMaDjlTryIzBbCLPDSSOaObkctiqpnqLyk0zyjcjzN/a11qvRozgNFHdA3jE6zuoM2vMgIuHHA8Ui6DX+0aTezb3UD3q01tnimUOKn8NN1IVJ8PociFrxRX+N3PD9Fg0PRy1f91ZoWJHpKK46LQeg57zaBf5G/5SvTi7LkI1X3FHU2D01a6vMYcjDHVI/Q3Ogfs63fdh9638hrVOQawnCJ/knBxDtee9Qa6KltJS05nISMc3gdRuIlD3kcUHnv3geSOP/VWY3HWXgH69aVPS8n7AcIZBd1DfN8lp+Tc2QvFXqZgykN90RqfE5usjyYhHDzYyhqp85tcQZZZ9z8QBCuM0bn2PWBwKsJsVzbzWWe/Zz/+jvuD4bYswZd0DHfFe7nmUFVK0ngGTLIyxs4lPh19Bey8ElDWr8witHZI0q8qpJp5emaMHMIlypL2dGPTuFL974rOAP8W+35XCcylOY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3f00c-e6e1-4c49-6dcd-08d7fdfa13c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 02:44:41.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOjYPf/h6aUCWFMk4so3EjNLg5ESy+yemDLi3ZleDaj2w/gGywJKKX7iKxDH1pPlH57gTVqEVZJ+CdjUiCw0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct ldo1 voltage range from wrong high group(3.0V~3.3V) to low group
(1.6V~1.9V) because the ldo1 should be 1.8V. Actually, two voltage groups
have been supported at bd718x7-regulator driver, hence, just corrrect the
voltage range to 1.6V~3.3V. For ldo2@0.8V, correct voltage range too.
Otherwise, ldo1 would be kept @3.0V and ldo2@0.9V which violate i.mx8mn
datasheet as the below warning log in kernel:

[    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
[    0.999196] LDO2: Bringing 800000uV into 900000-900000uV

Fixes: 3e44dd09736d ("arm64: dts: imx8mn-ddr4-evk: Add rohm,bd71847 PMIC support")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.7.4

