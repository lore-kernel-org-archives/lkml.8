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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C90720759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="peeWj8Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgG1JHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:07:45 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:51511
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728051AbgG1JHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsCGC6uOFH2+kJmJKy5E7MVC9QhgaPhHmhwZwXIBhTMN53KA7VgnjMyDeD4GA1h11D6ZlqAhR1YeecxQtg0J4ZOu9pSfWYWwzSEFMmXF90XVGEljcRObBRWgt98LoV0Lx4QdReic6AFXxC3/rxqPAKoS7MjPw8fA7nhTcS5gZmrS1o6BvpTPIvmGvWKq5aWc/Zgon5ZzBlsMAcvCkYViF1f/W97vXF2PVpA7ATktKZ7ralml6OD8mFaTFo0lAwuFTUCfr/1VE9FcEPxTvXNZ0XILMnj1knfIpjI9ZI3g3N7qGydXh/0UnfwGP+/9sERdMtO8KqKg5+auLsMsBQFZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXhqZnnpVSFLJo6rcmxZJV22XmGvRN08duHIrJwYT+o=;
 b=DL6WvfE2YAdVJLLeAWw8g3eshpS5w3Yz4usm6uZTdx2UhFIJnqRtB6rG1oNMdeWFB8yRwiBpcWOLpiT/KFSd6aQZWzzBY8di9uWeCy+EH9n6R3B4Vry6WnI6I6XBfiw1+ZnhYjSfzS0k0wIjY/amc0b5fXOGYZFeeXiRTy3Qxo5AvgHnnzr63HsQki799bTOzr8DFCJBgsY+ckF/nqtg8oIlVHp61McuWo1nshDCsbgIWx/Ri5FLawXI2bleH8HL4YW4mtvqbJEaxuUoHeZAF/gy+PfgWj3mA78bB+sS0cGcGEY3ntdJWZcfTt6jzDQU9NQqMUeLRZAV9PBbXzdvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXhqZnnpVSFLJo6rcmxZJV22XmGvRN08duHIrJwYT+o=;
 b=peeWj8Lrdpsu57ea/ChRs9FAncEo5DLGmhr2ZJNL0fLbS4RPQNoOvrSXJ5o0auyN8kGZzlyya4GyzWZVDjg9eiNLcbZV+XRz9NmYVt1QFGXakfIQre5SujtTlgf2w056sShJm0m/cL7mSmD5aCOwEdnaeEuW/4biO88ZQL+PkO4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5466.eurprd04.prod.outlook.com (2603:10a6:10:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 09:07:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:07:39 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 1/2] clk: imx: imx8m: avoid memory leak
Date:   Tue, 28 Jul 2020 17:03:18 +0800
Message-Id: <1595926999-14934-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0174.apcprd06.prod.outlook.com
 (2603:1096:1:1e::28) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0174.apcprd06.prod.outlook.com (2603:1096:1:1e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 09:07:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29c925b3-ebb2-4423-243e-08d832d5ad99
X-MS-TrafficTypeDiagnostic: DB7PR04MB5466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB546612A25FF5614AA52BB65788730@DB7PR04MB5466.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayKgpjYNsu9ahjgAvf8WcR1a0b+29LZBDyBR4BSzPaKNW8g7nZopGhyV5Dj80bSN6Ws6nXCuk8OFui3m3HmoZLeYpW++9Fe3Ebkti0sEwWWbvRMgxU/kpYtCXupFF21FMmfWdNTo6pSgtXZljPcMcfJ8wwcLBKg/0X0uYluqp2WkBZNL6lnp2qFuJMHOmONVHoi75ZVLirwKodwIBr+n+2CSiL95EXeVq8+7MEdji0d9NfyvJOeyQGPnW0UuWPBspjDx0kRZumcDagr4yMAE3uNlzQg2xcwiFtt21ZC6zZq7bmthqjOyOCKDS1+kaw1mLOrMKg5fP5zsnH3bGB8+7pSaZw/mTsNd5+xO6joCbb4LG61f8qb1gyWkfxdhTca8Chxcbj8PwVBHEjyvkNoFcafWtR2mOn2FJ31MJNZ2234=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(8936002)(6666004)(478600001)(316002)(2906002)(6486002)(8676002)(52116002)(36756003)(4326008)(26005)(9686003)(69590400007)(86362001)(83380400001)(6506007)(5660300002)(6512007)(66556008)(66476007)(66946007)(16526019)(186003)(2616005)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4Vn4OkK+WV7Xm3Xf/T/pOQocl3Ndm6/F2MGSk6wKecuwDHDSm/g+yt4J7SEtBE/eMXjcENfVn6fTE01PLQdllYVbOXvKQE0mejTPULFf9QSO8ThbHsjC2+xqyY4mhWEKlk5Ap/iCPwhjQxKs0qwOoB0/W0NDUBq3P0naC+aOTim65JUhH5JWVfS1KqVZvLawAznJL9iU3tmDX3BWNxYb+tXYmD76PJv+upcNfbqtR+a1zD+LAxC40SVdvwDNDdZDzJRG68RY07vfUKNT5W+WHpIKIC5TmdAFOoZIVpMKuFHoAoNju3c4EhGsj+0IOSHPhem8xzlow2C5z7XOTEBwCCC80EACegZMvj2ZdMSsDhChNP0WFhuOZzgatpi7yJv3fmjyr2EL5hln/WQ3UyDQ/Eo4hwrcYFHgBURT7J6BSVLtvcH+VbSAtinW6VLLqrIv21y8NFOAAOzLum4mQNg+9/9pNY0o9O1exZrIInEnot3/NKIrhjyHA51FLqkXyBtb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c925b3-ebb2-4423-243e-08d832d5ad99
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:07:39.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LylAU2Woy60P57DTQTrvX2FY3wppM17L6JUUoKV9V1LNbRq8WV2G0qzYswrYV5UspUCKZ8GLErA9icjQVfcltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use devm_kzalloc() to avoid memory leak when probe fail.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add () to functions in commit log

 drivers/clk/imx/clk-imx8mm.c |  3 +--
 drivers/clk/imx/clk-imx8mn.c | 15 +++++----------
 drivers/clk/imx/clk-imx8mp.c |  2 +-
 drivers/clk/imx/clk-imx8mq.c |  3 +--
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b793264c21c6..b43dbe305e7a 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -306,8 +306,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret, i;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
-					  IMX8MM_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MM_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
 
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 213cc37b3173..4189f7f6980e 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -299,8 +299,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret, i;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
-					  IMX8MN_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MN_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
 
@@ -318,10 +317,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
 	base = of_iomap(np, 0);
 	of_node_put(np);
-	if (WARN_ON(!base)) {
-		ret = -ENOMEM;
-		goto unregister_hws;
-	}
+	if (WARN_ON(!base))
+		return -ENOMEM;
 
 	hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -407,10 +404,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base))) {
-		ret = PTR_ERR(base);
-		goto unregister_hws;
-	}
+	if (WARN_ON(IS_ERR(base)))
+		return PTR_ERR(base);
 
 	/* CORE */
 	hws[IMX8MN_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mn_a53_sels, base + 0x8000);
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index ca747712400f..f6ec7b2b8038 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -447,7 +447,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 		return PTR_ERR(ccm_base);
 	}
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data)) {
 		iounmap(anatop_base);
 		return -ENOMEM;
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index a64aace213c2..0106a33c24a4 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -288,8 +288,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int err, i;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
-					  IMX8MQ_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MQ_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
 
-- 
2.16.4

