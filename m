Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22636C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF07120786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="soVI1NoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgG1JHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:07:49 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:51511
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728371AbgG1JHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij8HeKCjv1XegyOHGi+5Alj7IlRUt1M3KBOMrWj7KDTDJff9AGJpbU6Gg7ToB5qKU3jMWGDGi9JtUPpKcdcROIZ0bFRMP4hM96TCBC8+1So6h5P7IUR98mToPR642lWiDja8gRn9Zm7WOEVdl0vzjD2PmElbAkymW+lLahrfB6ZxWR9xiyR2UKiTH6vA6hmRDc+uBx5MBXL5cwzVVHaK6Mr/QyVptN+C2KM2+kZeHAeU792ZFRBG33b26d4oEU9DAQ/7lL8O1dG0fcMttMrGzeqzgg/Qcsn7GmtAZPrtrs6bxIHPpmfmE3diUCUklU7mGP85QRFjZ6IDJC5fKcBJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pBQfuFfMMUxAbNqrQ4N53MfGP2GBD766xtZz7WkBD0=;
 b=ERAwdYbn9sWWXMKAHocLqgG79+D3n5IdV62wYJzHKPtVQOfDfuvR7iY1zXTGz8Lh2NH96hrvczrZ4NDJvGJ/p/QSjiuhTDjr1WmkJkSDRHpiyTFg4dJWdFkFkqQf4cDecjcoFVlD+wEF8Lg+K00KaDk2cgCxTetn7VGKOwBqA7JF8mZl4bn+C4DQ7tpgi41EQiZnKKObUDgDLWuk5WM+2gaXjk1YRVB+9V6/C7M7y9gKck2DeHJUx5QAmwXVIG3oNevY86DqKwWWoF+UHsGUq1NBR3VEBh/L1mDdBbUmSuzJgT21ZbMQu9SySdZtJUHx0223o1cZWXLJwIJQn7XANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pBQfuFfMMUxAbNqrQ4N53MfGP2GBD766xtZz7WkBD0=;
 b=soVI1NoR9A7Io4tF7pBWzz0TTrC/EARykXwPEqJiXbSK39401iaThTBKGRHvPHpEruksE1EJvXaXHyI0eAXQ34bK78pGGYX9cCfkRcJsEe82N9JfF/9/vHtJRz7LE5VIM2uqCxSOJWs3N7zEnx5XYW+LYztDDTxkSBaz1ke5Gr0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5466.eurprd04.prod.outlook.com (2603:10a6:10:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 09:07:43 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:07:43 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 2/2] clk: imx: imx8m: use devm_of_clk_add_hw_provider()
Date:   Tue, 28 Jul 2020 17:03:19 +0800
Message-Id: <1595926999-14934-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
References: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0174.apcprd06.prod.outlook.com
 (2603:1096:1:1e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 09:07:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5756b5e-5f07-4f9a-80fd-08d832d5afeb
X-MS-TrafficTypeDiagnostic: DB7PR04MB5466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5466B533FACB9EA17F82E02088730@DB7PR04MB5466.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gicjUBPbjmxir+ML+FYwqWF+ltT2AnUzsjlDJthuDq59sURRlWkSorcE6Ku+xTqSsj6OMgXYCDAf7X8sCZ8lzhBg4nd4PfAkggavBc6shDUTYr2US7JBuFExWWSSjOLgrz78CS+i5Da6ps3+kjinyHDqn8CoIbG64FBdgaPobrRbL9BSrvzo8w0znmy3+YykgPQAB0RgfFmqBpk6ZVFs6C6yn53HL6sZZxIqrEInU+GjHv3vGYDIUMkHdPhLNWxHNq3xy98rLcBqNgZ9ZQd7MNHtDO7jKgzp1K1HnzfyD04bz8qyl9eDbpsl21PoG6sV2Jr6qDZRO81BwrM/XVIQ0LYSh6MFePTQZiBqcor0kJKVU1HF8CtTLk/pzlHzKe4VZzUcEUy31qidTtWHmR2PAb6o61g/15gT/nxS6wSsQ4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(8936002)(6666004)(478600001)(316002)(2906002)(6486002)(8676002)(52116002)(36756003)(4326008)(26005)(9686003)(69590400007)(86362001)(83380400001)(6506007)(5660300002)(6512007)(66556008)(66476007)(66946007)(16526019)(186003)(2616005)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KZnTW4rrejXG4RdaANcGyoGnetzx2Nu/hlKpt4JALVmTRDHGww0U25Secm8rjtmoqaE7Uqgp+HPzwwpTyni/Aba+yMIUyxN1skKBfQYfP5zu83ehLMHIDygQKjhQF9uUcpvdv1vGvPYFd/O8e01xPcWRo29MSJsyBDDaIpySmP2ltDmGj6ihOTqFd54N0MiX2kPSpOtQu6RZxndHkRv0bRRXRVmpo0I8fV77Pyw3bffxcwSO4W7bXKjSdsIALR3Gin2BLzQWANd4wl5PgIRZLPSw77WsAJkOLJu8OVRw8xIyzYMu+KS0/59zO92T5wmKSowhofYN75HbkPO/F6j8lDo+4D6Gt2T5+pyk78jek0F1M81Sx9Beg4BtVyHk62pqNeS4xsY1g7p29PhWLL0BoX+E0lyg5AbvgxW5M+ZY4GIsL5siJWyl6C7BYoURhq+ZBLd43kJiftIdf5Z5OZEq54LvWQiVqVyaUGRbyouhVykDejjdkOE7JxY2eGq5t9YC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5756b5e-5f07-4f9a-80fd-08d832d5afeb
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:07:43.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM14TY01zaKUsOT0fnDA4/mrj5dixVmbWpmr8loObtSUuUyqJRCJzxLuFHlfm7wQxZZg7cBHLGtHiAC6M7bZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use devm_of_clk_add_hw_provider() to simplify code.
To i.MX8MP, also add err handling.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add () to functions in commit log

 drivers/clk/imx/clk-imx8mm.c | 9 ++-------
 drivers/clk/imx/clk-imx8mn.c | 9 ++-------
 drivers/clk/imx/clk-imx8mp.c | 8 ++++++--
 drivers/clk/imx/clk-imx8mq.c | 9 ++-------
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b43dbe305e7a..fc2c1a0c9ff2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -615,10 +615,10 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MM_CLK_END);
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to register clks for i.MX8MM\n");
-		goto unregister_hws;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
@@ -630,11 +630,6 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	imx_register_uart_clocks(uart_hws);
 
 	return 0;
-
-unregister_hws:
-	imx_unregister_hw_clocks(hws, IMX8MM_CLK_END);
-
-	return ret;
 }
 
 static const struct of_device_id imx8mm_clk_of_match[] = {
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 4189f7f6980e..3620a419eb83 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -562,10 +562,10 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MN_CLK_END);
 
-	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to register hws for i.MX8MN\n");
-		goto unregister_hws;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
@@ -577,11 +577,6 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	imx_register_uart_clocks(uart_hws);
 
 	return 0;
-
-unregister_hws:
-	imx_unregister_hw_clocks(hws, IMX8MN_CLK_END);
-
-	return ret;
 }
 
 static const struct of_device_id imx8mn_clk_of_match[] = {
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index f6ec7b2b8038..43117f387460 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -432,7 +432,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *anatop_base, *ccm_base;
-	int i;
+	int ret, i;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
 	anatop_base = of_iomap(np, 0);
@@ -741,7 +741,11 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret < 0) {
+		dev_err(dev, "failed to register hws for i.MX8MN\n");
+		return ret;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
 		int index = uart_clk_ids[i];
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 0106a33c24a4..7c0a84cc9501 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -600,10 +600,10 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MQ_CLK_END);
 
-	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	err = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
 	if (err < 0) {
 		dev_err(dev, "failed to register hws for i.MX8MQ\n");
-		goto unregister_hws;
+		return err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
@@ -615,11 +615,6 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	imx_register_uart_clocks(uart_hws);
 
 	return 0;
-
-unregister_hws:
-	imx_unregister_hw_clocks(hws, IMX8MQ_CLK_END);
-
-	return err;
 }
 
 static const struct of_device_id imx8mq_clk_of_match[] = {
-- 
2.16.4

