Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42636C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107102076B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RyZzeDuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107102076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgDMG5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgDMG5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:57:30 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30065.outbound.protection.outlook.com [40.107.3.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D1AC008676
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyDFea9EoQ8NYlo5rvbj4tTSRbaNpRoSvFymDL/4CQ7pDoFfN0z0YCDKaTmV0I9VLV6bzqTY9ZERStcF6fGIw2wLhAqgvyzOEK9ykK0WpsxVLpwj/umebhJ9/E/5b0q2QAvwzVA5XWOgzc2JidIUnNlfnXzTUHGhcm+q86u98rY03ywoCP9gMKFSJYVg+ozF8h+7AjAtLuNbX1U2bo7F2yY7Mrw2QvXsWIAu2RPjQsAtC2o6/LC8NjvPyUoFDaMX25QSgzDuCxYr3pFHN+BfbARrD+9zFgxv9EgKI+P/6hv+3D0BNvAhF5tHlXzM1zIa2dMuAZq4x0h2eJ2orDObPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJtwwi9R8AkYKYGMATprxuv8FqEL0gqBmcz9s4hqO1k=;
 b=NloUC4f9whDFHhLpw9M+oDj2Xvo7LMx+N0OROE+iztTtKva0tv0cIMj4LLm3E5BUT+pTc08k4z362WXNa+RjcabOopvuzmxa7uE4QgI9Nfm8WJv4ZO7w2s9i+AXpVTAT5cOhmlxq8j16oQDmhIhaoi/ekD0i49eIKPp4Qbfza0n105NEppKQHnCnqoV3DrWkm6g2xMas7/8V3pIwpqV8WLubFKX9M3J3OBd7/zH0zIgtJYrBTCpEniW+HlxumCuEENYPfkKxU6SolAGoKv9ZxiaVXi6W/PQOETcHehhhuTBCEPrk6ZEzbqQOzbtGKkSbjEUQMjXl3Z09/Sl5eXEUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJtwwi9R8AkYKYGMATprxuv8FqEL0gqBmcz9s4hqO1k=;
 b=RyZzeDuD6zKXe5EybzLxDd51gEMcWrIcJWtxQMOW962OfAz7Jfjlp8ZXWi6+YGCvJvugFoz3Db2bwxVkKqhgYcs7PfNnKwTUUJJ1++nSvo+PMPkzZIiuqJBa/pUYdKL2CoJl2NV/Z5gsvHmCNVQEcneSRzbPIvuR7UMMl85A2eQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB4564.eurprd04.prod.outlook.com (2603:10a6:208:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 06:57:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 06:57:25 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] ARM: dts: imx7ulp: add pmc node
Date:   Mon, 13 Apr 2020 14:49:06 +0800
Message-Id: <1586760548-23046-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
References: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 06:57:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e615546-2713-44b4-d3ea-08d7df77ec2b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4564:|AM0PR04MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4564A13225FC7A3C860B0C7D88DD0@AM0PR04MB4564.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(4326008)(86362001)(8936002)(478600001)(9686003)(316002)(16526019)(26005)(6512007)(6506007)(6666004)(52116002)(186003)(4744005)(8676002)(81156014)(6486002)(69590400007)(66476007)(66556008)(2616005)(956004)(36756003)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +umwrqagFyXlytNl7OhCXgM0B3y4U8ICVbuCFonB6NK+3u0386EO/gQOQ89hgNBqMhmKVQo83jfHsvtmYhqOKo0W6C+FkTS88taq4sAvY83MQ0XHNuVtHS7wpOf0H0Zz//43oXK2ISgZRyuGO/ox6RTdVwqBLES08771MjWWC8bQni7Gtppcx3XXa7Rmki/7L7MUu7++Owa8OofNqPN8U9mZTuM81n542+jJfSfxg1qHTRCGYS6GFaGIUU5UhveS0ROA0JJTt2BzP/DbNxj8HTwJQOw0Ud9L8Z8ZFpoYjofpP0oHAeyqLVSKoOtMEQUSGcg1u6D/BXyxijHIwQkValIYPkHRNVT1ZTc/IPQ3Cfv/45EAG9fH+kMm3xWNudf0a8VORXZaTiYQx7B9X1TurK164nmX2Q0O/fd01yf+JOU3wAfa/RL3Oavp558st0bHvn+vx0/3ajYqpFdnDv4e58lAdrnQ5wevYurjzLHtt7R+Q9nDKeYB+zMda6k46EbC
X-MS-Exchange-AntiSpam-MessageData: VGEV5e2PBDY+bAzLhkYoqGUMn6WiGZuR8iXAQQPe7lD55UaGD+N118GPulzKdWhcT9RqEN36GfjnQ/3SVf6etAqhy++ty5Y5ZuNbAM9nO+M4+IONv4mWFmhOnq1II39sclW6Cfd8smV123Rz2o+HAg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e615546-2713-44b4-d3ea-08d7df77ec2b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:57:25.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsbSVvIGfmXM1BrjY3DvNUFq0nmiw1oVDno9M+VYTEVQmvq65Tucgp+wx6fXUlCAK347WY0S3vY6nT2LLyw6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP pmc0/1 node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

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

