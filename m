Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A5C4345E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E460B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkHfo/Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGXHoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:44:05 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:26464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbgGXHoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:44:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/SV76Gjq4sasbhY+NDQXcRlRm9keyg+5wUqFPSLn+MkyTNSpAlFTGl+obIgBZun2Zes4maAZhgkkQRT9V/DEn8BsflX9lSDzakdAGiLGWLBNgudEZt3tG0rYMGVnjm7O7ZxKe/3WCBeKLTaZLPVpFMow54InFUGHKQ5/VASRfAh9kLXsxQa7JzRxJ9hnvh8UQK12S417XyJoUiF6PGcaoUdBZO/5bt0Q1fnwBB3gpz93FCpkJAzdw0R1+QnFHKK2pamPA6WzFUSLm33pq1ZJSLeLF1ymXAVJnX/cXOwN3FrKz8fBh/hR/KbkKpusJu68gZkOWj1/ZGMabxAV1DRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNKBHTMrmY8wF7CYQVz+bZy3kgVPVLfKbD5Xvr6bNBU=;
 b=YNFfVeHUMgY+OknLbOSM9wiJtISbQ0KpxPkqXyr2xNz0AZYWy1NmE4jBA7cy+eHRAPyadwI35p5rje+GC6DlcMWM8m2mQHoHLnQUfau6LyVeTj8rxuozpd5oTxb0nXJQ1iSNmvzygSUfn6PPz2yiCc97CAhkYnwmOT2xTjHEMuleuFGXvarlhe9PItg9oCyE7gyOXHaGhuQty8J6iBoMjTH7ABiKBY0Wh8xt1FR3holY7oYHTsMwLG+XfJjL27YJvuVJ7f9bej50m5mH3CG9mGijKlwdjtvhCPkTJ3VrAeyEuSp3p8do8T8KT9GXZMJzuVtlXpltAEDGg0cXC22Y3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNKBHTMrmY8wF7CYQVz+bZy3kgVPVLfKbD5Xvr6bNBU=;
 b=HkHfo/Ts1kD8h4YZh7RuBKYWclzwFdeZHAdHWsRjY1Rn5y51ajq8BUm56byhnMJkt7Dso/NRs0mjruvKu/BbeOFxjuDq0Ek/fKN/hTD1BIGON/Jyw/pQN6j4qAfdJFfPIyxFNnTSfmTG2TxFYfIqasRomaXC0K2BP10jLUKJxmk=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:43:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 07/10] remoteproc: imx_rproc: add i.MX specific parse fw hook
Date:   Fri, 24 Jul 2020 16:08:10 +0800
Message-Id: <20200724080813.24884-8-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:55 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be5bf5c4-b3d2-402f-ad0f-08d82fa5538c
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858FA9F6D82DFE9019BDFF288770@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wuKCks85IhmC2+OYiUrsGTU3FBHO5id70PmdIGFSN+BYsWU+vjdT9TJXWUVfd3FiQ68KnPKiavTxntw2SOkuRoab+0RWnwLKszCNk4u9g3iJNUU5e06Z3SWOdrbgTM/5TYl2iCMgiXJ6RhfnV6LBV36UCOsK4DPXT3M6QsY3d2+ii8lVeYwiHG/pJq8Jf66mbguEuo5ruAd/FsdQ2umnNqjmCsqZFpWFO+oJcJ/G3CnlP94Upare3ypdVBoMhrBzkGq4QTk+5dRroOGh6epaMB52jIFp9x4nSjlCQkYlNXoNFmhGvZ3okUSNWrKalTJYrwl+GVQsZ9MjLJ7xBUd2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(36756003)(83380400001)(478600001)(1076003)(2906002)(6666004)(16526019)(186003)(26005)(6506007)(44832011)(956004)(2616005)(86362001)(6486002)(66946007)(316002)(8936002)(7416002)(6512007)(66476007)(66556008)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4rB80+kq6rOSHgz75BGeKeh0K3llEyUJsXaW5hN40qfvFav6rwHscRZ0QJbM5nffQ8uvYiTOrpF8Y7BZFZRiaxSzmLTxfZHS+UbaDK1AptaoRqtoZRJKfN9UiLIWvAZZ8CN+eP8YyNAkFSToGagVPgqrAakDveBA4gxLE6DHrnjUZJaL4cL/oMIuIjTOwpm/iwkT+saqk5tHUGDxrpZsk0sr/MgscIOtlWn1nkcSGWkc/GM6oGIRVpYZY/xzG5mZoZT4MZn8bFXyYQik2wtsun96kTM7oWWM628rZ7NiCDh1XoYUkJ1DHGOp9kHnVC3SktjePdoAypQFUdJXLhMEpf4t1f28IcTEO3POXQfJJ7EaC+rBF7s0Nh1WGhrteirnFFa75bO2lCGba+y0PgnH+wkfHrpgNB36rdV2dzgw0tTpDYYGbeLxeCzKO+Tnn+5RT9C1v+FuPbatA0W/8TDiJgt/ubhucBuLXKm9OMCkfJ0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5bf5c4-b3d2-402f-ad0f-08d82fa5538c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:59.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ6B9KWUD4ZM7R/Fsst9Q4fob8QLeeijXxa6jILD3XdjWwz1Dz24GWYNuI9XcXT2BHCFPxmhjyV4pxpxxfFMpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hook is used to parse memory-regions and load resource table
from the address the remote processor published.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 99 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index c23726091228..43000a992455 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -89,6 +90,7 @@ struct imx_rproc {
 	const struct imx_rproc_dcfg	*dcfg;
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
+	void				*rsc_va;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
@@ -251,6 +253,101 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 	return va;
 }
 
+static int imx_rproc_mem_alloc(struct rproc *rproc,
+			       struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(dev, "map memory: %p+%zx\n", &mem->dma, mem->len);
+	va = ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %p+%zx\n",
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
+static int imx_rproc_parse_memory_regions(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	struct device_node *np = priv->dev->of_node;
+	struct of_phandle_iterator it;
+	struct rproc_mem_entry *mem;
+	struct reserved_mem *rmem;
+	int index = 0;
+	u32 da;
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
+		/* No need to translate pa to da, i.MX use same map */
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
+	return  0;
+}
+
+static int imx_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	int ret = imx_rproc_parse_memory_regions(rproc);
+
+	if (ret)
+		return ret;
+
+	ret = rproc_elf_load_rsc_table(rproc, fw);
+	if (ret)
+		dev_info(&rproc->dev, "No resource table in elf\n");
+
+	return 0;
+}
+
 static int imx_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 {
 	struct device *dev = &rproc->dev;
@@ -323,7 +420,7 @@ static const struct rproc_ops imx_rproc_ops = {
 	.stop		= imx_rproc_stop,
 	.da_to_va       = imx_rproc_da_to_va,
 	.load		= imx_rproc_elf_load_segments,
-	.parse_fw	= rproc_elf_load_rsc_table,
+	.parse_fw	= imx_rproc_parse_fw,
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
-- 
2.16.4

