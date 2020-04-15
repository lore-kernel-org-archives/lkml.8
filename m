Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3486C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E6E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEnhZBBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370429AbgDOMuq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:50:46 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:34628
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S370364AbgDOMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:49:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaTxKtJZtl4YCHMldnqY4MJnQP2MFtN6qObp1Ff47vni1SvorzaYg162yqBhV5UCyJPyTChTZ00zlC/OoU/5JSEN7utNKTm1dz/xpoE1jCtGDUAH/0wb0zF3UkBc3VCk3sI8+LZFqFvD5wwcs0vx1PBc06fo6BmDJvkM1n1WLmEuMAt53BEiJODnF4awfuMqx6ZiOtcIcoLlkgLcexuXFcG7KrBjpVTA4zgcnqSsnlJXeJ7Oc4qqDthehvQMWOOh7g6ibnk9JVCXW13YpPFnf1ZZH+gNg/9Zmv+Zj0yHu9w8JhKekeUganS2m6OVd4F2Ll1az7CRv7v3iOI3CQjUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+9PXBCAMyE3JNz/XEu4o0HEVcPTs3bbzwdLXVpVwI=;
 b=IgO/cB1AVIvzjPO4O8YYQF/OOjmW4tsXMFBWWZhjaTGWncjJ0ujtStsCetfu9VxUzu2XykVhbt0gOi833bMtBK5v6LK+jQCRvSOUv1fqPwRcnS8csKOxCT4uMISGLI+vHpjQq2RH5GXi5kaPci0ujqFcI8y01mfkW+XcBxXT/t7Vyw6fEGcKKjYHRsFgenUy2qhDE9Pr7NEZ1AXigqfZheZhQcOs5lYs/Sc1A+DPojUhqmhEO0++DGpK1TAmIUxFsekC0H+po+sC8s7JB8QOvtniNwGpamXu1G/ypH722GM3sswFXqgdRUKxv+Nu3EXTehjm3wQVoRpRq9Gy/fsSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay+9PXBCAMyE3JNz/XEu4o0HEVcPTs3bbzwdLXVpVwI=;
 b=eEnhZBBsfGKONx8A1gQiJomT2Fr2gFsdcF6DIK8LvvGMbKH5FBX9Vd9caHWdM9k8NgZ5x7E0DkQqmZJNwIZFWOm3or8JKA3DWzcrZq+Ag2C2NqJbFGS/NqwkM2OEiDPOtoR8bvYXpsR+jdBkY/i5Y53O0I7OlYKPNSOB28g7OkY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2856.eurprd04.prod.outlook.com (2603:10a6:4:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 12:49:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 12:49:24 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/4] ARM: imx: imx7ulp: support HSRUN mode
Date:   Wed, 15 Apr 2020 20:40:48 +0800
Message-Id: <1586954449-17463-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
References: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR02CA0098.apcprd02.prod.outlook.com (2603:1096:4:92::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 12:49:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e53b5eb4-976b-4c65-0bdc-08d7e13b6893
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2856:|DB6PR0402MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2856C62783A9DB97F72A53C088DB0@DB6PR0402MB2856.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6486002)(66946007)(26005)(186003)(52116002)(16526019)(6506007)(956004)(5660300002)(2616005)(6512007)(4326008)(6666004)(2906002)(316002)(8936002)(69590400007)(66556008)(9686003)(36756003)(81156014)(8676002)(478600001)(86362001)(66476007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4z9hRsgZiepscgp1RaclslEing86gPcrkfcl5A+aio1mLPYphzVfBeP1D1CRSzYomdAgMyAljKgswKAYXhQPbJTFGBEKz84O3x2AxxhAg0Icm3ZK6mEcUsJnKQkKvqHejZlccki1UKo9Bw6lpcEFDFaoPm4bTnk31UcqJi2p5wlDG0ve90oA72s76I+xnLIVXySUkbd6f1AG3SqXvVssI+3p54f1h1Q9jy61z6ldRnKJ0Fjj/x9eeFodFjR7r/ahuWbVXFwtwz8ew5h1t6Kl0ZXEyqA3ZM0E8XIjaLrFFkmxImLL9x0kOIXKz3lheM2C5DDE1LUK8yRRYb1YNR+N5iw+3QOm153OILKEfnSd13/IQoJGGHroOAkURbMDu0TJUiVnsxu5WWLK9NZp94YwuGQFR654aCXQz3jIwHhEUY7uzr50We18B/PQy+wlr66enmrG6XQSYCG8WsieccQXxEzmSpy8v2vwRHGvfbavVj1l9inAy/IFHPo4GHCspz8
X-MS-Exchange-AntiSpam-MessageData: gg1GFHYUbhaJ1hSZcCfHrQiIbuimrYDgUgYLTu13p8qz4IbSTgAzurviCSyW3u29UUtgdZhnf8vqpLJgS44SJZg5SrXMJ9W0EMiKYLqZEnVQbvT9/mQQgNQGYGlFfAP+ghUCjxro+JWy8x/sQFdLYw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53b5eb4-976b-4c65-0bdc-08d7e13b6893
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 12:49:17.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNRPNf4zIwGhHEKlG4L0PE4w3FYslEyV9nXxtiBLCzWLNtOfwjkp9U3M3Biqwwy0k6uaYzZ9FvsdnrDp4LOzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Configure PMPROT to let ARM core could run into HSRUN mode.
In LDO-enabled mode, HSRUN mode is not allowed, so add a check before
configure PMPROT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/pm-imx7ulp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx7ulp.c b/arch/arm/mach-imx/pm-imx7ulp.c
index 2e756d8191fa..393faf1e8382 100644
--- a/arch/arm/mach-imx/pm-imx7ulp.c
+++ b/arch/arm/mach-imx/pm-imx7ulp.c
@@ -11,6 +11,10 @@
 
 #include "common.h"
 
+#define PMC0_CTRL		0x28
+#define BM_CTRL_LDOEN		BIT(31)
+
+#define SMC_PMPROT		0x8
 #define SMC_PMCTRL		0x10
 #define BP_PMCTRL_PSTOPO        16
 #define PSTOPO_PSTOP3		0x3
@@ -25,7 +29,10 @@
 #define BM_PMCTRL_RUNM		(3 << BP_PMCTRL_RUNM)
 #define BM_PMCTRL_STOPM		(7 << BP_PMCTRL_STOPM)
 
+#define BM_PMPROT_AHSRUN	BIT(7)
+
 static void __iomem *smc1_base;
+static void __iomem *pmc0_base;
 
 int imx7ulp_set_lpm(enum ulp_cpu_pwr_mode mode)
 {
@@ -65,5 +72,13 @@ void __init imx7ulp_pm_init(void)
 	of_node_put(np);
 	WARN_ON(!smc1_base);
 
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7ulp-pmc0");
+	pmc0_base = of_iomap(np, 0);
+	WARN_ON(!pmc0_base);
+	of_node_put(np);
+
+	if (!(readl_relaxed(pmc0_base + PMC0_CTRL) & BM_CTRL_LDOEN))
+		writel_relaxed(BM_PMPROT_AHSRUN, smc1_base + SMC_PMPROT);
+
 	imx7ulp_set_lpm(ULP_PM_RUN);
 }
-- 
2.16.4

