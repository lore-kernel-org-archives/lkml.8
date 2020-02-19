Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAEDC3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D701024656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B66giBbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgBSHeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:00 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:54262
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSHd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSbWm5V7ueIVe6oi1Wtjj64J9t6wCMkSRL4eXXjfvtKsFSr5PYw+PMY95SqJQMnHm4nj/ZsoMOsCNYxeiAz572hKKQzU5MQ2RNhViGI/XW5CVKRbCBonK1I28BlufgieAraiO8XeEV+zLugH38/djbJWhOD9TNyrKh0f/rBe/OUYRzE+U8YdhWBwyHqzPzxsJEhtNNuXEEEYUSGyCAM+y/H5SesNFXXmQaGcmZRR7kItep/AMPnv4wBaktk2+l9DoOxXsCYZ3oZ4lKGyNy2krnAKzdGeENTq/gHvam0MlAFtQbwtUn8SaHvALRzjhO0dDVb1UxCspbiQOwMDu7tO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mg3lyAdZT3dDrqLGc/wWfuzj9BY+McWIN4feT5+PRs=;
 b=NId0WqHe1Y/MvZ1dkwdj2mTa3MDd53q0F+NyEuh8Py/enqPR1LG+LFUy2ULRFeScTvi8dJl6S8ATtUbu252jSJ7mE6Nth9zI+IBkJCm1VEjnTXjxPD/xuaAvayROtpuhJrhRoMnqkN2gIxy43vLejUIu+cQ65+B/cnp/70/QH9L/0q6b8ByFP1b7kw5xptJXydTVHIHbO3jdZr8d+5Da2L7ZP5+IA+MpU70psKKtT0yBNwc1k3S+R8EAU07PH6tmtHAMb59ucXjU7WGZbNr2JJVDvsGAKLbrbDVs5+pSGwR3qPypojBQdRMMeC3HmJSfDqd63n81i5bPqUP02DDEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mg3lyAdZT3dDrqLGc/wWfuzj9BY+McWIN4feT5+PRs=;
 b=B66giBbpYolGhOu5K1iQbAQOmYhUyBJrk/roxZFCX6rHF5S3402E+hFZVagTArIJxKUfbOS/3VXRnCeoSKieOvPhZRcPI7pjnInWXdyi/IVygk1WGjVtOOEPmaaVv2IggrFhPzjq9dYMA4j2zR/hebyWL/IopO0uectnwDona10=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3969.eurprd04.prod.outlook.com (52.134.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:33:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:33:54 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/9] remoteproc: imx_rproc: surport early booted remote processor
Date:   Wed, 19 Feb 2020 15:27:40 +0800
Message-Id: <1582097265-20170-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:33:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b41eb06e-d249-4076-7c60-08d7b50e12d8
X-MS-TrafficTypeDiagnostic: AM0PR04MB3969:|AM0PR04MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB39694ED52737FD5066CF85D088100@AM0PR04MB3969.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(66556008)(66476007)(8676002)(478600001)(186003)(52116002)(956004)(81166006)(81156014)(7416002)(5660300002)(4326008)(2616005)(66946007)(8936002)(16526019)(316002)(69590400006)(9686003)(6666004)(36756003)(2906002)(86362001)(6506007)(6512007)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3969;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDI6bReplngS3yC+XMf8XvdkEnaScbQqxSebSMPF8HI9dR6qnAdWPiEjxChIgvUlvZ2DRFjDOX97wJThqjz6B8h5vBJJ64LVfJRFB6qdL5KpyoETZm/n7NfV1v9Vvz+GVJ9oIAWq+93/+75y2eprPH3bb/hCsYOifhmtsEfqrcf1z4OegQpyKOdl+dJqeg3SysCptXh2mjZsyLKJdI3pZORb0pfmHdP2PBU3ukJ8AqQV5BWsaKGeZjt39eghW+tvBTypFbgE4wN7wTcyX0gkgDUuuPXYkDJMTby6b+a6e19CindRSBK+Py4fcFduSsdzsUdCmRHyPFn31cP7S1n5A9uVBHAZT/novtAHrfF3YHQlWS7qccl7BSh6Vm8fggx6zBUErolLSPAMwfGKs8MM5kxc3vKeOFIKXfS86MqB9VfqyY5bgprGrYYf9O6k5N7PrIIIHE9cEgN4N3NDbIRY88mNbVrIGc8X1B4iBt6sE0G+e2OuHd/lq3+ngkfUm1JJBN5S3/1xnce5EgTI3IF7JDZIrz1E1caYmZs9sJDhQUs=
X-MS-Exchange-AntiSpam-MessageData: kKuZoOzXRqxasYxpRAiZBHlbgyCZts53UKGdo7ZdVA6niRno4vnsXDuupfQyNS3kd2Un/rVQopgOR3soInZ7XP/Z8yQO6nWB1lOPeOtJcDjBItNg3Eo7S/BDfvqnYt2uIpOx5fyyowrlxTo5NibZcg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41eb06e-d249-4076-7c60-08d7b50e12d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:33:54.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bWEmLXBFIuUyqmGdP+aAm4wMao8qv04J6ceUoAYhgoe2fUziXuvEhBWRX6tbF6mZCUZd9XdGC/RM/SojAMFpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When remote processor is booted by bootloader, Linux need to
ignore firmware loading, and ignore remote processor start/stop
related hardware operations. what should do is to need to handle
memory-regions and resource table.

Add a src_started entry to check whether Cortex-M4 is started for i.MX7D
and i.MX6SX.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 240 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 220 insertions(+), 20 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 3e72b6f38d4b..b9fabe269fd2 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -74,6 +74,7 @@ struct imx_rproc_dcfg {
 	u32				src_mask;
 	u32				src_start;
 	u32				src_stop;
+	u32				src_started;
 	const struct imx_rproc_att	*att;
 	size_t				att_size;
 };
@@ -85,6 +86,7 @@ struct imx_rproc {
 	const struct imx_rproc_dcfg	*dcfg;
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
+	bool				early_boot;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
@@ -142,6 +144,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d = {
 	.src_mask	= IMX7D_M4_RST_MASK,
 	.src_start	= IMX7D_M4_START,
 	.src_stop	= IMX7D_M4_STOP,
+	.src_started	= IMX7D_ENABLE_M4,
 	.att		= imx_rproc_att_imx7d,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx7d),
 };
@@ -151,6 +154,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx6sx = {
 	.src_mask	= IMX6SX_M4_RST_MASK,
 	.src_start	= IMX6SX_M4_START,
 	.src_stop	= IMX6SX_M4_STOP,
+	.src_started	= IMX6SX_ENABLE_M4,
 	.att		= imx_rproc_att_imx6sx,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx6sx),
 };
@@ -162,6 +166,9 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	int ret;
 
+	if (priv->early_boot)
+		return 0;
+
 	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
 				 dcfg->src_mask, dcfg->src_start);
 	if (ret)
@@ -177,6 +184,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	int ret;
 
+	if (priv->early_boot)
+		return 0;
+
 	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
 				 dcfg->src_mask, dcfg->src_stop);
 	if (ret)
@@ -240,10 +250,167 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	return va;
 }
 
+static int imx_rproc_elf_load_segments(struct rproc *rproc,
+				       const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+
+	if (!priv->early_boot)
+		return rproc_elf_load_segments(rproc, fw);
+
+	return 0;
+}
+
+static int imx_rproc_mem_alloc(struct rproc *rproc,
+			       struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(dev, "map memory: %p+%x\n", &mem->dma, mem->len);
+	va = ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %p+%x\n",
+			&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+
+static int imx_rproc_mem_release(struct rproc *rproc,
+				 struct rproc_mem_entry *mem)
+{
+	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
+	iounmap(mem->va);
+
+	return 0;
+}
+
+static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+	struct resource_table *resource_table;
+	struct device_node *np = priv->dev->of_node;
+	struct of_phandle_iterator it;
+	struct rproc_mem_entry *mem;
+	struct reserved_mem *rmem;
+	int index = 0;
+	int elems;
+	int ret;
+	u64 da;
+
+	if (!priv->early_boot)
+		return rproc_elf_load_rsc_table(rproc, fw);
+
+	/* Register associated reserved memory regions */
+	of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
+	while (of_phandle_iterator_next(&it) == 0) {
+		rmem = of_reserved_mem_lookup(it.node);
+		if (!rmem) {
+			dev_err(priv->dev, "unable to acquire memory-region\n");
+			return -EINVAL;
+		}
+
+		/* No need to translate pa to da */
+		da = rmem->base;
+
+		if (strcmp(it.node->name, "vdev0buffer")) {
+			/* Register memory region */
+			mem = rproc_mem_entry_init(priv->dev, NULL,
+						   (dma_addr_t)rmem->base,
+						   rmem->size, da,
+						   imx_rproc_mem_alloc,
+						   imx_rproc_mem_release,
+						   it.node->name);
+
+			if (mem)
+				rproc_coredump_add_segment(rproc, da,
+							   rmem->size);
+		} else {
+			/* Register reserved memory for vdev buffer alloc */
+			mem = rproc_of_resm_mem_entry_init(priv->dev, index,
+							   rmem->size,
+							   rmem->base,
+							   it.node->name);
+		}
+
+		if (!mem)
+			return -ENOMEM;
+
+		rproc_add_carveout(rproc, mem);
+		index++;
+	}
+
+	/*Parse device tree to get resource table */
+	elems = of_property_count_u32_elems(np, "rsrc-table");
+	if (elems < 0) {
+		dev_err(&rproc->dev, "no rsrc-table\n");
+		return elems;
+	}
+
+	resource_table = kzalloc(elems * sizeof(u32), GFP_KERNEL);
+	if (!resource_table)
+		return PTR_ERR(resource_table);
+
+	ret = of_property_read_u32_array(np, "rsrc-table",
+					 (u32 *)resource_table, elems);
+	if (ret)
+		return ret;
+
+	rproc->cached_table = resource_table;
+	rproc->table_ptr = resource_table;
+	rproc->table_sz = elems * sizeof(u32);
+
+	return 0;
+}
+
+static struct resource_table *
+imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
+				    const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+
+	if (!priv->early_boot)
+		return rproc_elf_find_loaded_rsc_table(rproc, fw);
+
+	return NULL;
+}
+
+static int imx_rproc_elf_sanity_check(struct rproc *rproc,
+				      const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+
+	if (!priv->early_boot)
+		return rproc_elf_sanity_check(rproc, fw);
+
+	return 0;
+}
+
+static u32 imx_rproc_elf_get_boot_addr(struct rproc *rproc,
+				       const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+
+	if (!priv->early_boot)
+		return rproc_elf_get_boot_addr(rproc, fw);
+
+	return 0;
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.da_to_va       = imx_rproc_da_to_va,
+	.load		= imx_rproc_elf_load_segments,
+	.parse_fw	= imx_rproc_parse_fw,
+	.find_loaded_rsc_table = imx_rproc_elf_find_loaded_rsc_table,
+	.sanity_check	= imx_rproc_elf_sanity_check,
+	.get_boot_addr	= imx_rproc_elf_get_boot_addr,
 };
 
 static int imx_rproc_addr_init(struct imx_rproc *priv,
@@ -309,6 +476,31 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 	return 0;
 }
 
+static int imx_rproc_configure_mode(struct imx_rproc *priv)
+{
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	struct device *dev = priv->dev;
+	int ret;
+	u32 val;
+
+	if (of_get_property(dev->of_node, "early-booted", NULL)) {
+		priv->early_boot = true;
+	} else {
+		ret = regmap_read(priv->regmap, dcfg->src_reg, &val);
+		if (ret) {
+			dev_err(dev, "Failed to read src\n");
+			return ret;
+		}
+
+		priv->early_boot = !!(val & dcfg->src_started);
+	}
+
+	if (priv->early_boot)
+		priv->rproc->skip_fw_load = true;
+
+	return 0;
+}
+
 static int imx_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -347,27 +539,33 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, rproc);
 
-	ret = imx_rproc_addr_init(priv, pdev);
-	if (ret) {
-		dev_err(dev, "failed on imx_rproc_addr_init\n");
+	ret = imx_rproc_configure_mode(priv);
+	if (ret)
 		goto err_put_rproc;
-	}
 
-	priv->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "Failed to get clock\n");
-		ret = PTR_ERR(priv->clk);
-		goto err_put_rproc;
-	}
+	if (!priv->early_boot) {
+		ret = imx_rproc_addr_init(priv, pdev);
+		if (ret) {
+			dev_err(dev, "failed on imx_rproc_addr_init\n");
+			goto err_put_rproc;
+		}
 
-	/*
-	 * clk for M4 block including memory. Should be
-	 * enabled before .start for FW transfer.
-	 */
-	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(&rproc->dev, "Failed to enable clock\n");
-		goto err_put_rproc;
+		priv->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(priv->clk)) {
+			dev_err(dev, "Failed to get clock\n");
+			ret = PTR_ERR(priv->clk);
+			goto err_put_rproc;
+		}
+
+		/*
+		 * clk for M4 block including memory. Should be
+		 * enabled before .start for FW transfer.
+		 */
+		ret = clk_prepare_enable(priv->clk);
+		if (ret) {
+			dev_err(&rproc->dev, "Failed to enable clock\n");
+			goto err_put_rproc;
+		}
 	}
 
 	ret = rproc_add(rproc);
@@ -379,7 +577,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_clk:
-	clk_disable_unprepare(priv->clk);
+	if (!priv->early_boot)
+		clk_disable_unprepare(priv->clk);
 err_put_rproc:
 	rproc_free(rproc);
 
@@ -391,7 +590,8 @@ static int imx_rproc_remove(struct platform_device *pdev)
 	struct rproc *rproc = platform_get_drvdata(pdev);
 	struct imx_rproc *priv = rproc->priv;
 
-	clk_disable_unprepare(priv->clk);
+	if (!priv->early_boot)
+		clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
 	rproc_free(rproc);
 
-- 
2.16.4

