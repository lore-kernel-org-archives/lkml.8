Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC80C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF702074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1b9fqGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFCDqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:46:53 -0400
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:32598
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgFCDqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:46:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks+wZpr9/3G76HAcslMzjrvusgwgRFG4JTCOp2tqMVg5KaySJrzFweKfmX0Nl0TWXp+k+sHycM1AzqjcGaxeoiLzgm1AJ6wq2IUr05FfC1I8DNqQhRM4zthMImnLnIHMPmJS16FWIgyjZnrzmdmCqNT9FGvjZP8ym1kleXuJjSTON/uP6J/6Zk1pos8H9IoPswD981/JDLZ7mhtVx/DFrfeqkL2FgWhAHmpeY3WQyjAb+AtDLC3TMjkwwLQKhL5C1DivQ/SAJDUTOwabNcA1PZ/smZZx4vWmd1+HN9LG5U4YwEO3w9PcmyLCfyjgsdGT3PpYGol9ic+g5pnoC6jgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ruvIzOSMZF3SHzfC80qeNDBWE4NIJ+y4nAukjDkwis=;
 b=C2JaauzkPhfya6SPV+Neqd2CO7YElFqXbN1NH51JN7rx8uSbvGz1ss2kMPObbPURxT0n3qod7Ejtv6tKX3seuTEb0/4jOvgQjJ/D7pAScbHy15ao62dZCZvPe0ETNgTEdvsUkDJbAI04nQNJXdB5THj4bxlQ/oP5i2f9Wijfo4CRL+nKMoje0dOAC7KHsQSXbfhRswyrUt0FF2K3VfYI1dVL7YBt3O/cbfkbmOB0QPoAIntI88GCkP7jkkmGG6sLsxzqrrgiEGtIoHp7lxhaXYlxBbqoHx2AwLUkFFzsAL8lpeLI74JCo4AdYZ+3DF2W8P/AD18SCMbEisSPQZxE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ruvIzOSMZF3SHzfC80qeNDBWE4NIJ+y4nAukjDkwis=;
 b=F1b9fqGsodhq1mOgpOSdmnZVvS8sue6cguYDxisKxVCa2PzL/k2AczpiLrq23RU+ogUpVUnFEDGsC6X+v7+NTBWgBOPSpd3695K6Jcgh72ehRAzYkluqTbppacGWVrmehG1IjyebCUhrlpIdkOtA3lp4zW49m471GDsnUMMhZag=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2870.eurprd04.prod.outlook.com (2603:10a6:4:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Wed, 3 Jun
 2020 03:46:46 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 03:46:46 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] clk: imx8mp: add mu root clk
Date:   Wed,  3 Jun 2020 11:36:00 +0800
Message-Id: <1591155360-26173-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591155360-26173-1-git-send-email-peng.fan@nxp.com>
References: <1591155360-26173-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0113.apcprd01.prod.exchangelabs.com (2603:1096:4:40::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 03:46:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4608e8c7-2d6c-4716-69bd-08d80770bcdf
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2870B81A255284BA8A58C9FE88880@DB6PR0402MB2870.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G/hNQKbosNlOzJNp1P0v9iXHSQC1gMIGo6vIoCgw7x2WxfbEGPqc9Blv1tdExGSLf0mJNzW1W4ljndYrUSaYDCq6N8v7Fzeh9JWVtlz5FKmkbveStL2V0RozS/ZUFllt3A+jUXzDX0HRMkBmiuUvwVEyVri3piBjvG9rwkVG5GbtoJALSxXsQKDEljQnPl1X31Xj7dFREuHMzNeZDLMnRT0dyE2JDtlU8soroOtHQHA8aiTqWZAvowZg1pcK1PGpnes6v5h+bWwBbVkSX6vU/f/Ur5+GkKnjCYQqusZcgirEeui23nLnBURZMxTa3V4v26oyhQg1fnz12qKoq9Nkuko+ExEBl5MAMcNzyzBQRa9I9AEdrgkCVAOpEvysxIfkgYBhSKyokAjnR0vbEl9+hKzsDNKtADNAUgUvsqQINg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(6486002)(478600001)(2616005)(6506007)(4326008)(26005)(956004)(6666004)(9686003)(7416002)(6512007)(86362001)(16526019)(186003)(66946007)(36756003)(8676002)(5660300002)(8936002)(2906002)(83380400001)(316002)(69590400007)(66556008)(52116002)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S4hEHOW5k+cvZt8bRIilDQcYvpsYwKiIhVDC15Uia32VAjaY1fWwtdIh2zgfG9fM21XDpAbBZ7cxmPoUGF7FO7USCESfwa5bC9nT9hgDnvqzJS9NWEbFeQSkrP6OtRqeY55KtlwaHYfktAlp/L51uTcBiC1/c4lzGd9Q7mCY6Vr4cvhrGmSs6mmSM+gaVMSX+zq0Km+0XNp3GAzkdtJ/NvKi2B4fRgfMU1be6A2yVI6KG7Els9oOJ+o/GvP9qnJf7WM4OrLdg8UafonlanZK1lGdvnEsZSCGQyI+3dQRwW8tdX0lYI8rK1D5o1ltUmQwjo0wPUlHuRapOCeWQ3Yz1Fq6tM9Buz7CxQgcfB2PC9caI2ymitt4SguyDr00KnTYBm0AsgM0urWQxNDDBdVma2laoc57W/6ugxybGVEktGwaA7H/U6BQ2JjYUYIyjgfOi4M88vGIkY1/KQKNUtPGTj/U5Xq6L7/4ww0BEcQcsROzilrq7JWLawhWTykw5xTA
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4608e8c7-2d6c-4716-69bd-08d80770bcdf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 03:46:46.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9s/9Dva7zABX09cz+fBvTZ51UQYnuIfCDDNgqniNUz6SY7wvUoLbSkCMchsvg1pmBKKRbaOiG4HnZYgjpcaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mu root clk for mu mailbox usage.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index b4d9db9d5bf1..ca747712400f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -680,6 +680,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", ccm_base + 0x4180, 0);
 	hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", ccm_base + 0x4190, 0);
 	hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", ccm_base + 0x41a0, 0);
+	hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", ccm_base + 0x4210, 0);
 	hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", ccm_base + 0x4220, 0);
 	hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", ccm_base + 0x4250, 0);
 	hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", ccm_base + 0x4280, 0);
-- 
2.16.4

