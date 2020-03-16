Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106EFC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D782520663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShJTMTlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgCPJCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:02:47 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:23307
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730152AbgCPJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEKOeh6yAtFhtAjAI6j3VVLHU4ngEjLXXDbUcTnG9lbzKI9B+vMpW2UpeAflm+WzaguKJVUeU5qMtAEI1griO6NO978SPQVIpKWkkn6hOs55+lFPuG6W3MlH/SYsI9RkNA+2BHrEebWTckM1F3gwmGqvTGKjFzwAimi8kzvYvdQRVT3V+sdoRb0seE2+FiTWjxbqaXSXAgU2XtWXiGUUgEK0LyYV7Czfz2TPga+L5Yfp7ZCxnsGBJO4S3XUe3wWIl39foR8S5nxptT1hdRR+P6JGhh8X4s7APJOYGRCDd3SJwf3jPtvC/jM4XFXNRV+FSjTbKS6FZ/wgDi5KbiVRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DybavP3i85ng06H4iREbLPAYZErvJ8NosgtwtwVJi8M=;
 b=HdPg31Nv4p+pnD4fMr5b3MMKesKn2xVU7l/SWWlO0eTxyOu57vx4NYR5GDZTIXM7KuFt2ZlNBVc37XwIGQPeUAFiVMyV8V7n58+rjnqZCX79gOg3Oqv8Zs+bodDf7yAis1eSXAa2XM0jrgN+eQj6QURTNr81Ew4BbEFvZShAjAejcr3E3ShLcPZEjzslQA7ggZ5uTM4o2Qgjg5PQP/ONsmrMNBkV2QLrqXKZqk+nMWIE28xaLU86mZ37c0sd3oO56y2PuLIp8xHLa9/NRpsoKCpKXye1gLBNgD4vtnMBscdkJpdaCxAL0D9avPpDSL6Cv8l8P6IOMlUpeeRLWaviqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DybavP3i85ng06H4iREbLPAYZErvJ8NosgtwtwVJi8M=;
 b=ShJTMTlIzCqGtXEKXANqJH6al6Ng6ehi9ddSPiLf+jxo53x4y6YsNDAfBgUxxieR/lR8dwFU0S+BZFYVUXmeb3640xoQYeWMQBLSJ+xBBU3bUxRXI3YwGoaID6GtHnjd4NmPukuOW4aMmROuiO8TJSY7f2Wb8Iv5GTosFY6sIuo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7169.eurprd04.prod.outlook.com (10.186.130.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 09:02:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 09:02:43 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/4] ARM: dts: imx7ulp: add pmc node
Date:   Mon, 16 Mar 2020 16:55:42 +0800
Message-Id: <1584348944-19633-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
References: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0126.apcprd06.prod.outlook.com
 (2603:1096:1:1d::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0126.apcprd06.prod.outlook.com (2603:1096:1:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 09:02:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b672b19-6abe-4702-7180-08d7c988c957
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:|AM0PR04MB7169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB7169467D7539223D60740F9788F90@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(9686003)(6512007)(4326008)(16526019)(8936002)(81156014)(81166006)(8676002)(2906002)(86362001)(316002)(26005)(186003)(956004)(2616005)(69590400007)(6666004)(36756003)(4744005)(6506007)(66946007)(66556008)(66476007)(478600001)(5660300002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7169;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqkyZcUzlKfalqAEQp4mZgEne63AL7lJ70LHmjfn+vfrVRAABrGOaPsRLFhZitfCs6y8PuTZWXvlhRRJPWZ91Em8MfdRjZac9qMvSMsmR6QufQTcGSbdhudn47JoP6fEDsfZ8Qpc5PkO8DSb3v2QB+FCZn8HvG6gNBdy3Dtov9WuFQmV+b0R8wd9M50HlAMSbPLlDfAU/XiIKz8YbKuvZhGejS3idOVUCKtyXJBs7dBEqiWpFFXZyf2C+CoRde934L6QEFk5yntpeK2VnguJrc6QtQzFLjRaZJoagqx3sbnEcBMTceDKG6KcZgwC3L4wrNonMgmqfJ1ONY+i7HAhdlxb/OsQU4jawM9nfAW3ERlCrnELBvF2n3FH9Rd8QJ4t2xamch+r2/1Xci1ava2YGoIiMELWLu81tJTC5qzV9z3WuHsXpnTGi74TAzL4J/SGpEzYLq1EUVTrToIGSLdwzskhv1j+Oiyh4e94wSxuyeTbfRGFkIkUxthQGbrzYgtb
X-MS-Exchange-AntiSpam-MessageData: wpvSxyl+MAtTI2KiHMcd5XJPecFmmxAfUKVRzisiZg+aUsuX8/TYHw6YJrA0DO+J6WSG/N7k6pfvELnCfJiK711Q6LcxLJ3Pnp1g6Fy+sPC3VXZ1xGTmg3aDIzArvx8GFm6UKovzDy3JfWspzxYSnQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b672b19-6abe-4702-7180-08d7c988c957
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 09:02:43.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs3NkqcVuKMhlhL9cpFo+8Nx10jadjtiOdmCH692EEYzLkTOF46CALpVkvzZG8rTtXX3OyYKglEgd/wprO/nhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP pmc0/1 node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index f7c4878534c8..bc9d692c0530 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,11 @@
 			assigned-clock-parents = <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
 		};
 
+		pmc1: pmc1@40400000 {
+			compatible = "fsl,imx7ulp-pmc1";
+			reg = <0x40400000 0x1000>;
+		};
+
 		smc1: clock-controller@40410000 {
 			compatible = "fsl,imx7ulp-smc1";
 			reg = <0x40410000 0x1000>;
@@ -447,6 +452,11 @@
 		reg = <0x41080000 0x80000>;
 		ranges;
 
+		pmc0: pmc0@410a1000 {
+			compatible = "fsl,imx7ulp-pmc0";
+			reg = <0x410a1000 0x1000>;
+		};
+
 		sim: sim@410a3000 {
 			compatible = "fsl,imx7ulp-sim", "syscon";
 			reg = <0x410a3000 0x1000>;
-- 
2.16.4

