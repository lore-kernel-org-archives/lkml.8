Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE5C43468
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F389620767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+xM73FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGXHoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:44:19 -0400
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:61664
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727836AbgGXHoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV9zHcRv2QdLAWsdVbdqPx2Z5fxZWG6CtfCEOngmILAXuj/5rVPPL3peGotRtkBbYcFrnfflw/y3lFciYa4ZWFBADOc6XcLYAXWWXKyFH28sAGRf4RoojfUPnkWClY1vtPNZqdCowVh5+AiU+Bs9cXaM+Iwe0FEQd4Kr7lH87e6gJ2ShvX8puTvfpXgGyBcst2pfEJQae2D6bVA+SGM5M/tD/wIb0RWIM/xhHH/lU2F0tRcH4lU/zkSqm51GKTONjnseSEGs5Ww18WI5+iAeioRV59PKdh7nBen+ni8ADu0MA9GtnCR2vg/5uz6MmyLkLeDitPBUH2AwUcamXIxFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycrD+ONW/+IkoPUuu4wnsgt/1ruih9vo8Wr0ekuz24E=;
 b=XSIBAhhFuIzeA0QBzFOUeA+9xGfAQcavKcS0mgJ6WbPLpdtWsyX3VRc+AjFi1Ctn8KrSvr+MdKUj8LGuvNWzxrwQNYZSiJ+3MWsowU6MY2GfQOJ85PojFrNXJSM5SOG5lBfh5G2BejiMRIyp2YJ5hInrypu3YYKhFGXJ01ccganAWz7mbQ43DLu0ZtzjBwaKXuWHIBzJmyp6Cb4ra0y20gpzQnTsryu536NTYcrsClt/pmR5voPncILv4b5eNd3GjsaVz+0itP9FcPAYQ+MGxHJUI/B85m0nA43ClmTWgQKPW8YkIgNokU97FrVQfLgEdj0m6prWQCD+CBTONx3wMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycrD+ONW/+IkoPUuu4wnsgt/1ruih9vo8Wr0ekuz24E=;
 b=Z+xM73FOJVLHsoZBM548Wq377CDD4vnnOuejxoSFGmsdHl8W1KVpymtwoVH1ZdtzpheFAgP7dmDpCQnVTVZ1pTb19ahxEcr3D0Psl9ra6j39MqFSRHvtk/wr5LU4jH1P6Nknq4s2pEkdl6XQXWx3y3o1Prv/b/SS/h0mYKRcn/U=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:44:12 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:44:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 10/10] remoteproc: imx_rproc: support coproc booting before Linux
Date:   Fri, 24 Jul 2020 16:08:13 +0800
Message-Id: <20200724080813.24884-11-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:44:08 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2481b5ca-703a-413b-5505-08d82fa55b94
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858170FDE1329E53F34D77A88770@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CU9BcNYCU1wjESF7XCRpx2fQzOYD2VDLrDXGzOC1jw0bxPVfPXXoIRufQOi0yO1SuO4YgAlKAB3adbpOuxWaXwuN3XgqRKbz0oq3bZdY8HklYC9wbgqhhlu+3ZsESb5J9WxD7QctepLq3cpKRuiTcgDfIXJgSvJnsFWabtbOO/rR+DswCGorgP3ewGuu9d6Ka1EW9KDfurewYOn3nOYhXaGCtP1FP90LQXMxpqDutAZMQo0zEkBnBqtSY+wtjasTumCD1UpxztiVEYozQVORiKy5um0xf48UG7Jdh7sYP2u2kMoNzE7HnfdY9XFpn/K+GpMYjN8imjpozZ5VMmPQPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(36756003)(83380400001)(478600001)(1076003)(2906002)(6666004)(16526019)(186003)(26005)(6506007)(44832011)(956004)(2616005)(86362001)(6486002)(66946007)(316002)(8936002)(7416002)(6512007)(66476007)(66556008)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +BXej0xxfuBoqWkqbDIdKogrwn+KqM33XmQoWEPqtwv689nhKMiy9a/GQx5fh7vsH/cLP3i/3TS2kJwnWFmAlr1wdgcTimXDPZNdM3GYT7vIWOSqNNFV1r41/1uxEgmKP6u9ysIzGwOW9eyHWGHFP2powwKL7giRwZmWW/xFkv7p41ZQlSDRRqyYR5NRGe4J0bRMZdm3REJafZKIJEzHsoa9OqDpcy8bnRhcZNRtwTXmlR6MeTjetws1nbhtA8f/qYIutTaJlfrrGpCoSO8Gj6EHJCsnvywT374toN5bfS23Zrg4nuXihPRyxUZ9zjMavDIyrvh616c/Tq7A5FA1MQnc6AoAdbC5nF01cnGBnUFgHxHsnPFNazCI4aSKxA0HHl+dyAeaBH4dhN6T96BHaF7sgUR5sFBkE4LDbli3USQ4MvDPzijiGL7RsZ33CmQxMRisK6PpKQtDRT12tzP4QhrIIrca9RMTWeckIPqKuDM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2481b5ca-703a-413b-5505-08d82fa55b94
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:44:12.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQP6hoC7N6XHnB3Flgwp+ynlQ9oZb2a2pYsUfnyVV8i2WWsfBAwy+3/9JaZoyNpnUzfeD5edF6WgWFKChEutrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect Coproc booted or not and Parse resource table
Set remoteproc state to RPROC_DETACHED when M4 is booted early
Add attach hook

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index a8ce97c04e1e..0863b3162777 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -91,6 +91,7 @@ struct imx_rproc {
 	const struct imx_rproc_dcfg	*dcfg;
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
+	bool				early_boot;
 	void				*rsc_va;
 	struct mbox_client		cl;
 	struct mbox_chan		*tx_ch;
@@ -235,6 +236,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 				 dcfg->src_mask, dcfg->src_stop);
 	if (ret)
 		dev_err(dev, "Failed to stop M4!\n");
+	else
+		priv->early_boot = false;
 
 	return ret;
 }
@@ -390,6 +393,32 @@ static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static int imx_rproc_get_loaded_rsc_table(struct device *dev,
+					  struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	struct device_node *np = dev->of_node;
+	u32 da;
+	int ret;
+
+	ret = of_property_read_u32(np, "rsc-da", &da);
+	if (!ret)
+		priv->rsc_va = rproc_da_to_va(rproc, (u64)da, SZ_1K);
+	else
+		return 0;
+
+	if (!priv->rsc_va) {
+		dev_err(priv->dev, "no map for rsc-da: %x\n", da);
+		return PTR_ERR(priv->rsc_va);
+	}
+
+	rproc->table_ptr = (struct resource_table *)priv->rsc_va;
+	rproc->table_sz = SZ_1K;
+	rproc->cached_table = NULL;
+
+	return 0;
+}
+
 static int imx_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 {
 	struct device *dev = &rproc->dev;
@@ -472,9 +501,15 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 			__func__, vqid, err);
 }
 
+static int imx_rproc_attach(struct rproc *rproc)
+{
+	return 0;
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
+	.attach		= imx_rproc_attach,
 	.kick		= imx_rproc_kick,
 	.da_to_va       = imx_rproc_da_to_va,
 	.load		= imx_rproc_elf_load_segments,
@@ -609,6 +644,36 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	return ret;
 }
 
+static int imx_rproc_detect_mode(struct imx_rproc *priv)
+{
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	struct device *dev = priv->dev;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
+	if (ret) {
+		dev_err(dev, "Failed to read src\n");
+		return ret;
+	}
+
+	priv->early_boot = !(val & dcfg->src_stop);
+
+	if (priv->early_boot) {
+		priv->rproc->state = RPROC_DETACHED;
+
+		ret = imx_rproc_parse_memory_regions(priv->rproc);
+		if (ret)
+			return ret;
+
+		ret = imx_rproc_get_loaded_rsc_table(dev, priv->rproc);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int imx_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -661,6 +726,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		goto err_put_mbox;
 	}
 
+	ret = imx_rproc_detect_mode(priv);
+	if (ret)
+		goto err_put_mbox;
+
 	priv->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "Failed to get clock\n");
@@ -689,7 +758,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_clk:
-	clk_disable_unprepare(priv->clk);
+	if (!priv->early_boot)
+		clk_disable_unprepare(priv->clk);
 err_put_mbox:
 	if (!IS_ERR(priv->tx_ch))
 		mbox_free_channel(priv->tx_ch);
@@ -706,7 +776,8 @@ static int imx_rproc_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct imx_rproc *priv = rproc->priv;
 
-	clk_disable_unprepare(priv->clk);
+	if (!priv->early_boot)
+		clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
 	rproc_free(rproc);
 
-- 
2.16.4

