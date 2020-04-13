Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7399EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4277320735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n9AxKYHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4277320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgDMG5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgDMG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:57:33 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30074.outbound.protection.outlook.com [40.107.3.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE029C008651
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaJmxwakooLUfKRReKXajVek4WM2Kd8e0TAihUcXr2O0DoPJwM4fd+tRN4o4QQSG8wINLxLNhzs1UEU+w+wi+S66LBKOlz/KC6zwet8u0YXw1CzD4B6h9yUx/q5uX8iqSBFv2W1wjUT+HotPCL+8XFY9CNPc9/OJN1X8MHsmlCkZSf2iVlA98BkcRSobACvfZVuAtN6JLciOErLqlJp6mDEpPi8WaABzJlRUmgc0JncT32e8nnFrbbnt4CA/+5DtrqOxjL/fUmoTPTYP4l9DiQQVb7zt1MCkb2nUqQVnEI6YPL5uVkmDapjPtf76hQ6JK6wsXcODzGBck0p5liM4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80QGD5YNpszAHtt5BhayU2MGMa+5+rTJjZ5tMrlTnc8=;
 b=oLDf6RnKUm4KKT7oMuBRR579QWPcYeyMsowkF+kk8nV9XCJjjy0yB0vQ8PHiKii/0QFrya3CZQMu3QGaLLRR9YK+wkZqri6SgBvxr6/lOeupNLBMYwUxYu7Xo1lO6XwoEEQ6NJ1/Lp+Zn5TRUO9vP4N1az8s/HcdcFPWPJiivmKZ3ZW6fd/7qIZLs2vsCZEhn4z4QiUP5liWrNUJUjAFXujOwxIwvScZLhrszudHxbIV55TvmX0EMbdoA6UbQX59xy6a1z7XumByB6V0+SaLW8gRQGoAzoM7rNJMpzVoKyxusfUG7KfJe5a+Yz32WztaFuqpjrokwYRY5e3wFIC0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80QGD5YNpszAHtt5BhayU2MGMa+5+rTJjZ5tMrlTnc8=;
 b=n9AxKYHKHtZeW9siGEVpC33MLy4qWSFByH2ONHo5KZAtqNe0nISZXq4G4huoKL5gEoi+NSaOChIeyJKPWQsN/pgPsx6maQwlI3YIBwr9+bl2RvkLK2SMSfdbUkGTg8ni9eFnCD4haPfIw8aQLT4hmuKGxzc2+/43tXPvF2Qd/88=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB4564.eurprd04.prod.outlook.com (2603:10a6:208:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 06:57:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 06:57:30 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] ARM: imx: imx7ulp: support HSRUN mode
Date:   Mon, 13 Apr 2020 14:49:07 +0800
Message-Id: <1586760548-23046-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
References: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 06:57:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d78820cc-0e70-44bb-d4af-08d7df77eeec
X-MS-TrafficTypeDiagnostic: AM0PR04MB4564:|AM0PR04MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4564949ECA176AE2D5E6923C88DD0@AM0PR04MB4564.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(4326008)(86362001)(8936002)(478600001)(9686003)(316002)(16526019)(26005)(6512007)(6506007)(6666004)(52116002)(186003)(8676002)(81156014)(6486002)(69590400007)(66476007)(66556008)(2616005)(956004)(36756003)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAZ2jJer+Q/6ySIpMCsBmNoHTe8GZnOfXod70HU1W8tsfG3Uku2187TGIkbnbALgfqQyAmt/diUTLyNymF/25eZw3uPkiM6N6G6lr6nXCRotsSjR+gAttlt8KTCKJYM4cBvr1NeHuLRKOtn2vMfqwMZLLQh9GX0mRi0EunF1Tvi4C64L65JnhxvoQWRq66LVR+PANjZY5NiZP3rfDuMkXeK0kBIw2b7JEoRw6Chc9ZzV4LvuCX/pu1dhr01uhRsvzYAMgnXqXWzH+yzNDVrcxAW+gzEtbU86EVt7IuC+ucPzrs/eirbOs9zGXMzUCLW+5JgOhDo8Gr2R00cnha7XOKecuiDXg8uzcBZQDr2qZvGkSzOOVm8W/nfjyLnJVcSIB/FjXtuFqdXvL+uhogOEgO5KwOethblvrlEFucGTFTyrUL5zn3xlv9eZN3prXaLJUgKDY05Fz23tBG4raFMZeUZ7CR/rEKm0auRvuaotgeMJwpEkCttsuMMmpSsNacon
X-MS-Exchange-AntiSpam-MessageData: NQvOYsyFhttDA2g7JG0QX+/G5a9zvnqn05zwDFfTNNK0YnPVX35cyC83h8ZnWptZ5VfN5mSSYDdZI58RKuvXSkyNhmNeb1+SCYN8FrX2pWFheGFT8p9mieoV39A2B04qI7B8QpCt+MiJDpzS7tA9aA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78820cc-0e70-44bb-d4af-08d7df77eeec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:57:30.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3L/82YeEMhAX4/1kdS+mTn65hbXzNSKQsFXe9q144ZneIus0MZjY2f9Y7HmkKeBHzLIZGCC4Ba0bSLRoKHc1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4564
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

V2:
 None

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

