Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0703FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D237E20825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZFjmHTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgG1C73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:59:29 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:6693
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgG1C72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCdB7n6OAPm43A66zFtm4z1ODJOxZznwKsNi0LsFOFGOpleMPxUHDHijqzZrpHx92V+cm2We4cnXBnHWG3ODzfb8rA5jy5iqVDWumkUPIjRcj49TA/3hK28h5xWM3FeWccv3mqhKLdEjVACgbFmNtE72wiLE15z42yEudo7Ci77gB1N68X/Awk9aA/0ED/NEC4HQYm9C3Et5xBiy7aBH/jkwNQr19n0vgY3njMWhaReoFPlysLSwVO7g3PqEwcixmRgI94GQTSRUGAVFDx9jm6it+nyC4zZs8E/33Nq4dTOBzEB6eNboCek9EcXnY+c7EO2SJd4RPmJu8Tv+94s82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw5NaZL8ezaM9xwdKgN4vmt8Q2Ob9WFSzz9/S+F2xu8=;
 b=PrwNC3aC8r5Tlp6ccbqh/GqjEloOs4Di47/j80eMtluNvrSzQqK/1tv0u6qszk50d6K6NEQKnFCf9j4kq20kYzigdTeXa5Ku8mvLFRXUiLhG6GoHyk1JZqME57Ib5Y5MDtFscxPFFUSo7AEAtl2huzbtXBPryFRMrpvI5zaVrf3XRFMAnoFQMWAuqtXDAPyn5EW4ylxKE7n3cx0Z/Fz/0OYy2WRT9hqD88g5bl3eoFMRDt+O/slYPAe88DANTWwgBq6yf72HKBXKzH2X6vWu25LGM1RiVMjBaUFPyFfo6JKK694FiHFZTunK3KaV7GJRsn1l8ErwNJfOjaWFYcxx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw5NaZL8ezaM9xwdKgN4vmt8Q2Ob9WFSzz9/S+F2xu8=;
 b=EZFjmHTBr9rUtohCZE+B7R2cYXQY+d9DpgkNkWPjWHzsHg1quFF8SJ4gCrNt0MM+XYPcUl38uNK5+M80jg2bQJXZSGkJONsc4M9RfEHyin8sxudmLWWWmFiSaxjEUge86JiH2K6NmU792CI2xLWwvYQ2W7CE8tAoGZH4HSAfzSw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 02:59:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 02:59:23 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clk: imx: imx8m: use devm_of_clk_add_hw_provider
Date:   Tue, 28 Jul 2020 10:54:49 +0800
Message-Id: <1595904889-30811-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595904889-30811-1-git-send-email-peng.fan@nxp.com>
References: <1595904889-30811-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 02:59:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae687f35-fb8c-4d1b-b42d-08d832a23b4f
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27602390CBDEBEF56BBB5EB088730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGmil6TieSFwwXMCaqOBeDMi5r6VD/C9r5tPVfg0JrZOnQaCu7Omw4KrKSGaHa2jR8yt2FcEAWWLgin8M48h4vLuOLI5foB8Uxyor6pWP9slck7oHUeHhLb16kyH9ZQSjgwISaAKSFaa0BsudnaDIgGdJ4zAhpukZv92snY9i9lxRyQX2G6fRPT2PGrMhV/6rKMfLogJJe8R5yfnIYvS78dff8ITqkiOJ4vyeuLpoOzjj93ihMrT8D2+EyLR17dS2a9anWFMDo1eRVLgPjqeEfrPDHC2emdmg2VQEfyrxYtEVLs6C2f0WZnqrZjbaG4G5zo22sx6V9DpR0GOQhzoWbrLV+EXN17UUaff9gP0W0RO1Or1A0sOkFmAbREg41zeKjN0vMFFYJngXGgA4qmRnLmyXxIMMYcM9SgB/QWb2RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(9686003)(8936002)(6512007)(26005)(6506007)(316002)(478600001)(5660300002)(186003)(4326008)(6486002)(16526019)(8676002)(86362001)(2616005)(66556008)(52116002)(69590400007)(2906002)(66476007)(36756003)(956004)(83380400001)(6666004)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R1AH38z55Lj8L7KYZvJ6KrS4Fckk+9po+3nMgTpJUFjlKpJKl1SjtdNCaZrblNtCe5Av72nNk4WXlc0EvJpUCAF9HRwKP30aKiq6HMjBnoLyp019lPiBAMtC0GVVMKTgwbE22Lba26WSG2TzbIln5GxYULfN/744X2uNx1q6kq9laqgAVaSy4eekLh2457xcjv+rpgxeYmO7pJNXCaO1cZiClZoTQwULwB6St2bkS01FAQql9Smq/NTptuWfObb75L+fnL/KbG3/g+Fp+QibpcPXVNsALr9Dp+eR/m2VL4NoDnATxamGmrhrlyaZ3FclX8CrfnLanVyg+eWHzdp3oC0IaGTnbHR+H8E/krclkVG0sEuTlJPsgLLf7+REKAvZ0JYW3FQ+dYe/1zCzlj6CMU4/p2dfS/+h9batoQ15MBCUAXM6rZ2l9ZXrF+i2wiOKLTXEQEIWzy6702SGj/hRhEJiVZcf9qGKciQ9MqmNjeE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae687f35-fb8c-4d1b-b42d-08d832a23b4f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 02:59:23.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj59FMkvAom4QR23DStZ3KAhiP9cIfDsQdJDOsFEcOpZKuIrzTEcrgb1WDfZvbgvVbfiZRzmPW2ypjWpJmU+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use devm_of_clk_add_hw_provider to simplify code.
To i.MX8MP, also add err handling.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

