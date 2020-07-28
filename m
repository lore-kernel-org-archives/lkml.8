Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E1320825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TVB5nnqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG1C7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:59:25 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:31207
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgG1C7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzB/GQVNXOgHEWcOmosNklGvCGG5AlAsNYoUNkqiNIbd9RNBfOmBkCX33pT/xAqS8pT5lMbxVYA9wORwSNDZ6v5Jwasj3lT1ZX7asLXNS2ouWChAWctPor2J6ER5bA0ARGgZ9TkHYHRy9Q+8F3SLo3X6yp/5+9jMJc5e6T6Q0xULOrwC9PuGFp6bO/ppUb9Rd4Y/uFayHN4IkEC8UPUjtBUu8xa32C2paU+rKdCtYvWqRKUW24dyNkPG1TRV1XsCvqiCEQVsB6oKVPRuqqxTWd4mXZUDrYCUh844hbT24h57Cz2yM12jEHOom73YXTFBP6jX+hEslHOvWqTQpyt7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHc4ZLBn6LqSEaVWD1WQj1f2pBC5R7K7NjDLiaOYHy4=;
 b=B7VwELAusrOAqEAfvkBxkCadRb32ro7YpU/q7K4q7P4SukG0DNuqCX7vR/36gHyON002AkE3Tfb7nHRh8NR1WJVr2pbTanKuQNdttC59Ack3o7CnOoIM7bHXCNiu+NSTeG4TPnPisq4GcacAe5MCHjuXVxN/cBrQTVDZbCY9J8wVQveXLdx+6vfEauvz8jsiCeyL+GnN7RFZ4jDfnVYxuzmvLgXQjwA20TE2hby2JWbM2lnwhXEzXyCNnp5SHLUxoA6o36kQJP9QUZ+2ZlxYWz6MzW/PsT7FtHXXjFxSaUc6iEmjxsvQpE8Z+957tY4TeekMhiv0pOaguwc8ZgXVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHc4ZLBn6LqSEaVWD1WQj1f2pBC5R7K7NjDLiaOYHy4=;
 b=TVB5nnqUrYIj4gxC7vn8s2PpyB84MGTQq/HMDlikZp27lNMkgAfk2On8jBv0MHPYWAgVE7CEGZr/oOQ0amIlUGF7wz1f0mgQPUC6cYcPMhFtG00UoEKqUS24xZMIXF2hvBAw4AZRY7puTXAM2ANBsfxENOshToqjbuxCSyvVY/M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 02:59:19 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 02:59:19 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] clk: imx: imx8m: avoid memory leak
Date:   Tue, 28 Jul 2020 10:54:48 +0800
Message-Id: <1595904889-30811-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 02:59:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9d39231-d738-4da0-ca1a-08d832a238db
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27602C493A26F9CD06A9BB2A88730@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbWjeuFw0iLy1a+Fr/pfCVKag/bhLv/a6Hb8bwZ8c0zgARnEtUN/ktYqlDCOSMc4+DxiuMN8MpHOiwMgepwuD5a9519aMTu1a9JQq3XvdygGuqLayXWA7JG/ojJtWXz8AxQt6lc14OWSKijCAYLk6nZNH/6MmEpM9AGe/uehhH/QD2eMczBHYcpoDThTcqMlqRacWWT6IMBVWpFPNH6RdCun3SGYaNq8uerV5T07a/GhyycXm+kkXp5eohzIlagcusG3i6ZuA5oQtjtPoukx6Kfq6fNmLOPWrlFpg7s5T58YoZy8+oF6vvV51sHHHagfL7d7Ncld+0TuggjV9Ovrs0kIoDCqBXZNtsD5op+zB9gAfakblki2tcME0eRbAWtHFp6+roD1SkCRJkW+5waizT9VPmueuYpNyA+j66XhwLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(9686003)(8936002)(6512007)(26005)(6506007)(316002)(478600001)(5660300002)(186003)(4326008)(6486002)(16526019)(8676002)(86362001)(2616005)(66556008)(52116002)(69590400007)(2906002)(66476007)(36756003)(956004)(83380400001)(6666004)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c1asqmjHaZZEUGILCx3Ng9A4Th9ljF1/9suPmz2zrLYbum1okOzBU/b8Lo14cbrDr3KytJMwiPizkYqEffbLLYVduvvYtkPCKJugzFaiglPa8YxmAMO9zThiI98b5bIS+/uaSHSga0LTEjscxftr+Tt/LZH8u4PZgZevlvQ6oO88eCopmyO72n/3y4lhkjX0jTA5Cg1ewCVUbrdk4KoRyPhV5laW+yZiEK+ksRONRQtutN3hzhyx6t5EqOVW/TWExwHUmnywEDnPouFlMt15L7SE1JvaGCBdMJnWwKJ7nGuoQJZFQAJQBBhSOwxby5Bkyh5BfvrabtLvd2iQb5T1ovN3SN2aGagqrDB3JTQdBCzeECMHFhgIwlK+rudAbHlur9Qw7AtLBRnG/n2J9EiO2VtXY19tdHUwW8mmzgVDI84c58oWb6cpR0bdu3AHAqLlNEZvpaefVtt5chZRTDfW+3NRlkPPr6sCMmsTYhXlFLaHPofdNhC2ieYEu9bypZXx
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d39231-d738-4da0-ca1a-08d832a238db
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 02:59:19.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqYbSdF2ey0uJyl7eiz9r0naL0I4KwvZ2n/Iyrx4gE9sc8vzL+fMwrT1qj11KOZgaNh82d2/E7UZu37naCVDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use devm_kzalloc to avoid memory leak when probe fail.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

