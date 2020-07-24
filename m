Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B85C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE320748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KKzU9I0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgGXHnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:43:52 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:59307
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728266AbgGXHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2tiadCDcgVysWcTaDmrb90WH6OU5fjAfkOfUsSzIlUvnNuM4qOdKqYa/y0Q7jOkewOkvBgg24HC2gkHMOxFNxSXrZL/cw0LeGARlTBDK1zmhJ+E63AMkdafb3zAXrzUYFd9/xz4Moo5G0bUM4R/ul82oWjj3EpZSshJAL9LCxKCe92JgwWSejvqZR6V+vRBEjKEiPl6IqSEZ3eAE+mDM4MhjWE+hHG2BKmaOArJey3BPLz+G7UOTJEnMCnYKRm0HcfRAKpkAK3s4ItyimsEpUgn3vrU61yL/2gTF6QMwfPyvlXrGzDinahwKS4GTMn46Q7Szkx6fadf/N19ZcqJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA/x/bUv5KXcx+/ykfUIpTYgVe0nzp2lijRi348Hiqo=;
 b=ZYcTLQ5gdZhoO8BO8edDlv6qy4fyMldAINkXVHnENny0q8lldQTetq5Abn7N6Su3d012BUxoYCSP8eUbVNJX8822Ge0j9oGM45wV70WJ/Uh9P8S/d2SnLCELUwWHmW+H4qV7e0BA96ylvRnbbG5HbotIq24+Mw/+i4J+lDGBgBxrbZAfh0GTCykwXwcr04aPCZ9lpcVciJNiYt92+ev8rNP68pkTQ4DsCVtgjqGPjF+eZDBuaWWMbUOUcpUBc3GwkxqIuE/ku/A4DOa6qlUOIvwaMrRIiGmOro6dcNSSBJSu6tIBKJd08a40KHQC8rN2gO/ls80jt26xJinkzAWsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA/x/bUv5KXcx+/ykfUIpTYgVe0nzp2lijRi348Hiqo=;
 b=KKzU9I0eQ3gwdHqdutFyOrCJX/x9YX/B3oQmbJEIXuPEsWvWPvTts9TeQO8xrZe7PMqJLjckSVVmcHVbKNmIH8MbqmPB+70ls0vGEtKsjUEf1JcmT47gbddS9frCpmPjOmVnPFtfnRBMKBfDGHoAp2fq+lht6CbQoNIHvPdyDIc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:43:46 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Date:   Fri, 24 Jul 2020 16:08:07 +0800
Message-Id: <20200724080813.24884-5-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:41 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 423b0dc2-b7e3-4c02-c362-08d82fa54b90
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6857BB219C68133325AACF2788770@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9/7aDh06IcTShIovbPtF5fy73v1zrc2f5WcjoMSUkjnp1OViCrJ+qZJnjZhLhqGULmld/qkYpxv/TsIbqKTv32UcHzFGCINVjqf9OZCxuJXhAUlnl8AYsjUoxq+5vwGjjD8w7FI+1qzRDvID60KxQJfrla6tvhx5hQ7oC65v3ZHhnjelZhawaaaO02aqomdDkDza/mjPQMLsBWJMkCJkJ9QtgB6iu9CcjchC2MY87gkwoCvxXxn9AX4Oh9ti5iNMvViWcjiUuNWZDjhINqXRvninMuOGr/TQtfUsTi5fbkJU4JaIXq6rWsmNc6ROzbJi6Z9hJPPijKPePSjtVsoOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6512007)(478600001)(8676002)(2616005)(7416002)(316002)(44832011)(956004)(66946007)(66476007)(66556008)(1076003)(5660300002)(6506007)(186003)(26005)(8936002)(6666004)(2906002)(6486002)(16526019)(86362001)(4326008)(36756003)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WxKaPsudXHKHSa8zFDz5ur7KTZdeDmaFT8sXnjSRhr1YY2lLC+kaZCUy/J09sRbeRjZ+Ihi6BJ6ZbE7+v9fa1jeVPD/Ac07qGAe9DFMnbYIVj5SGLfjLsxx9c2sJmEoc3UY1wHhCjaxURfJf9/Rzjq33HIBTNs/mtN0+Pi2aJuZTYkQt9NMqWftaRNqcM5CY8y0PDSnFrBKbFWHKI1BaUZPgqt1358rAvA/HER75IWOZ9V2t61bLzC80pW9Oi/fSG8/11646DpV2QRszmKSMsUz9nA0lZPwzQwNkW/iN3TxhXm+fQub4PzkYemUPYB1aapude/l67W1ODf7Ao5AawB4ii/k0ie/dst+M5X8LlWhVYAXdTBm6WBi+eGgxBbaz3fTCTCjG7zIELkzZsvqcUP9DVE3YIa+uu91ga4YF7rEQCKQNHE6cqG2raJtPrWGrUn8QSuuZsFW2IX5XEQbcYH0lGK4iksWYc+LSftlRrU+DTeJhNqM1t89JXDaaraPW
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423b0dc2-b7e3-4c02-c362-08d82fa54b90
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:45.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g0sKkM3czf98YlOxvhBKz9ZYeC7JW2eV3B6MnDavos8EMqzPV3A/cEbKmAAdmLfCoQTnyVJJBXt7yvXAcetFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make syscon optional, since i.MX8QM/QXP/7ULP not have SRC to control M4.
But currently i.MX8QM/QXP/7ULP not added, so still check regmap
when start/stop to avoid unhappy things.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 82594a800a1b..4fad5c0b1c05 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -162,6 +162,9 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	int ret;
 
+	if (!priv->regmap)
+		return -EOPNOTSUPP;
+
 	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
 				 dcfg->src_mask, dcfg->src_start);
 	if (ret)
@@ -177,6 +180,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	int ret;
 
+	if (!priv->regmap)
+		return -EOPNOTSUPP;
+
 	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
 				 dcfg->src_mask, dcfg->src_stop);
 	if (ret)
@@ -325,9 +331,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "failed to find syscon\n");
-		return PTR_ERR(regmap);
+		regmap = NULL;
+	} else {
+		regmap_attach_dev(dev, regmap, &config);
 	}
-	regmap_attach_dev(dev, regmap, &config);
 
 	/* set some other name then imx */
 	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
-- 
2.16.4

