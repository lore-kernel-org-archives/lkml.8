Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D655C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106A321D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wea5RKCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSIGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:06:15 -0500
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:6073
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:06:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f93elHpcQq060gUNxP9MedsvvCAWWXQXY7FLeHmYGTsV0BVVvb4fhoPl7TVS5qKZlFEMOxv+TJVWukjMU3KAHWok2dTZZVTl6tBFe8dQgO1ymFp5tUpJqX4HjtEx6RxjGH463T+CJWUJI58fwJKcjo3awHnjhYX+N+n09WUB99heAugLb151WC2giRjyO0b8P12WWcAhw4aR6wn5Hp3+xdtZmwkDs34CEuUSWGK1Igq98GTqs5jzUugIKr8uerH2JD4YeZKW0o0sO0bzS08Gt9HO2D2NVpeqxfR99aQDlvWgEhs4eZqGRJhrC+3rv94ZzuMpDm87Xp9jJjD1jhHkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt+E3byxpxw4yGz5p/ITyqcuR31aI8PMY9W1MyE+fLM=;
 b=jhlZy+RdhM09kbt4gxSDkkX874qpXyUqmxKCNX4+VViG7rzjVa0HFHE4AS3Gp0yawE/BlZz0z14EPUVim0natwy9ERd2iCzvNQESCORkno5v9/32x6k6K/rdnQgIli1bkgDBv0aOaRxWVVRxhET2DQWW6+R5uO0C3oHXWHq85YY7JGKw/ZjFvZDbnUl2Xc59i+wFhOWq4HlF4zn5zx7NXOb3oHBCxD4CLNHZvu/xFllwuLtGUKIxMO3Z3uJyC02xb7jRMsyHR5RXnk8PrCQyA5Qxk8H0u1WHuVQ4gz6p7plTNe7xR7nt5AQIi+xrpKokF9G41jRr+xr9parSXA8m/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt+E3byxpxw4yGz5p/ITyqcuR31aI8PMY9W1MyE+fLM=;
 b=Wea5RKCh5He3laRfu8wt24/teRCSRIkjm4TKccvKKbF/thx16pcqcoKh/ri66tTTZysAYLuDVT4/0DXsqllH+cmJv3fJqZnd4R9B+DMNF2TZv7GFRs2b77bO1aZTvYZfGeuMTOKC0kyJk30fgbUs+3VIMC6xTn2x4WHzwgrSL+I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:11 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 02/14] ARM: dts: imx7ulp: add pmc node
Date:   Wed, 19 Feb 2020 15:59:45 +0800
Message-Id: <1582099197-20327-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:07 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25b9cfd0-25cd-4e59-3840-08d7b5129504
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:|AM0PR04MB6401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6401604BB880C26D1B95734C88100@AM0PR04MB6401.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2616005)(81166006)(8676002)(9686003)(4326008)(66476007)(4744005)(8936002)(478600001)(52116002)(6512007)(6506007)(66556008)(69590400006)(81156014)(316002)(86362001)(66946007)(956004)(6666004)(186003)(5660300002)(26005)(6486002)(36756003)(16526019)(2906002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8P4vXpe6ZMrY07bQtsNK4teErsr8uZUAxnS9u9eCa4ljNTXLErhZBlphXtLkNZ/t5a/OmIiV7a8GaIdI9N/Zc4Yak/XgOgm2F3/qfzzk6FkhyY2oEr1yNL6c1WIa4fwVu2glxhtUBRnpbCMvI9FA5XFXka+ZKjJTGYBGmSzZBaO+QKYhbrFoDSC/jsOSuGmX2HDUbcZisCKGA+XaHG4z4SRBCTfnVCKe7ORoBakuZ3skXBY2sZ9KVfbLGG9d1GwYW5O56bpelI15e3AsijQomQt2bs15KWifTyds3dJU+CaMFhgb5r47ru5HHcEwb64+8ZaWFgLLLHfh5o588YKCV8TujhW/6Vxi7FI/riaeeEWAx9pBj/ZV3qHQL38DnvGHJ2sld6mJyJmMe6+SUtPA7qmPxiqyEswdKe3yGgvCzRUQ7GHPrWjbY6ANZBYEHom9Bi2wuQngGtA4as8ZHkKnA0KzHfULeP1DUckkmjmj1Q7uDz19iiFS2Gj1JXqTMhqSs5d2p7OjyuqhbTf1iP4cplQETA6yX/VGK8F7SgRO4zo=
X-MS-Exchange-AntiSpam-MessageData: ceZAaI8fGzzv6ATynXCwXF69/nJG7R09oVM4HqaiNGTOWT2YVHCTHW9L+alvq0WLKO45DtodGJyiwJbarHc8qkRcnECBLwi9hmXv0YxPMrYuLDOjY+5XXn5+4o24Eyt70ZpEqPFG2kM6wUAZrGtY+g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b9cfd0-25cd-4e59-3840-08d7b5129504
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:11.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlbXbn2qRzcpZWlER2DiwDD0s250qNlsc4epRLqHRnelpkyB1mnR9w5oJV48Y1QLFCvLzg4/Mf889rXWLy+FDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
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
index ab91c98f2124..32c218123662 100644
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

