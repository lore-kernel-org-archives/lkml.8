Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D783FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC94420656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JfI/uxRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgGHHgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:36:33 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:28384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgGHHgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:36:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivMeW7U3S+Uh5wOCpf+qsZbovc+3UnXgjeS+yCIy7y3ULfp8//QjloWd/ar6/5kW7/lXGLGcJHOgv/r57iOIzcFhwSUubjL16vxLEYK3s5pI9OF5Evb4r7mkQTthlzJeFcSLHNvvctKLOdrn5ieRozE/H53ppr5vvAWy+85peSaQPk2ATy9htbsglTxPURSXIKJNQQL7uns/jKlKINTtZS/e2MmjzuP8PnTQpcbGAKWLuvmZ8BQfG51CspGbB+9aB5M1RRZpjRg84I5ByPgkZjzzG9HUsMmKT9WtRalnr7NmzS+t3NEge8KtGkZN9WDgsBtMcLJn2LILMr5pswRBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctbrXbxWHo7a8KTPqVjF8oAJXeCzS8iEqaR1fl62DtU=;
 b=NGyxGQGGYvsCmonZOxEbb+ZWOMRubUeBj2y8NpQX24kjH/j5rWU7E4a45Of0P2xkf6vTT/2Qw+y9+K8t2gdMEZlZb56hyGNdUmW2wM7pUrRIAl0kSD7h6oCl48cUPjOqqUPpeJOxWI/nrj+YHmDqKJT/lKmWD/btS/5BGR90BbEGn417PmbLd+jDKzhkDdTtoOx2+iXiPQDLG19q23BTFevnblokD5f9dosLHGVC6JEVt5LS2ljr7w9RMPD92V23P5M1Q9qyQuuEy64WACzKsmPxE9pJ9xhNCDvCqhtIx08ojG6v7B3e+9dBZKd0LXft0mVJxQrZlFMM/SwgDNLIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctbrXbxWHo7a8KTPqVjF8oAJXeCzS8iEqaR1fl62DtU=;
 b=JfI/uxRLvY1pE/lYzQb5TV4YLHPaN02DQpu5LGyELiWZySBN+Hd5O7FGrPt3jMAclibooBOpNedd8/gXXdrY2MeQqI4uv+i0Sz3+x/mYdh1YlutIz8U0xXnct6I7K1QTFQwDDhvAFE1D75nSYZQk+F619a5XmHEUt7QOzqv0Brg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB6734.eurprd04.prod.outlook.com
 (2603:10a6:803:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 07:36:28 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 07:36:28 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux@rempel-privat.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] firmware: imx: Introduce imx_dsp_setup_channels
Date:   Wed,  8 Jul 2020 10:35:54 +0300
Message-Id: <20200708073556.19188-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
References: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::20) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 07:36:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69aa9624-65fe-4919-1e7a-08d82311a051
X-MS-TrafficTypeDiagnostic: VE1PR04MB6734:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67342E593F73DB69E3B9EB3DB8670@VE1PR04MB6734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95VmzV5nXcQNipPgl0M4IHAtdUFVZex39APJdK6YTKzJXIyYcYYKP8cxG6aNkA/kCbqb/4DGCxdgc4EvXMtnfkWYNt7Tg62D5gs8cwmi8WmxV9AmPQVQN7OT0iVw5ntQe9EFR4BZIp9Y8GMNYtdDZu0PPXkIyzNkyqZ/8WjbSXcZjxdoFrL2O7hB0Eak60F5Ag6CujB+q8jslUt8S4hsYdXX0RIWz0H+IsFcdRBmbmS9pnDAuqxL2buTmEQrQcdCytrDUpDfW7NRlVX+pK5wq+hiSjaBF96O8jkMLzD+dNCyF/VhEgp5LR8NnmxnIT+lqWqWDHgHwsmgGJWZsaTphw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(83380400001)(26005)(8936002)(4326008)(186003)(6512007)(16526019)(86362001)(8676002)(66476007)(66556008)(6506007)(6486002)(52116002)(478600001)(316002)(66946007)(1076003)(6666004)(44832011)(956004)(2616005)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lA4f8WTRLIq1aB4/r+xKoJlFUxn0I2Nby2Hvsp3MhSx2kCgi2QQYyj1XaTIYhvOBqaRZu5Lv3PaHc8HJvh2Hr/ouHbzOhZmYP7Oo3/S22GgS8KXre9sDctaPGvVVLT2vYQGy5EoGzf3MzuASiYWfP2PWd+vltAECLEPG2nAyTfNixB0TrcwfjyU/fXpN8q00rQ+D+m6v3D4RwZwQAudrGvL6Gew95e109E19xuyPAE3Fn5ZuYAyaPFDUZciA+jjzhYhrsSrt3Oe515nOGwF2j15qMoJqzC5qNWyvlTH43WVXeCKOFYYBzkdzCiTleQD3Rx09nP5rCbqSKf2UDtp2px0DtmSNaISuoecZ8KZV4MIn2lPFJr4iZd98FR6v3Z0Tbmqs8P0Sp3tl1wISp9pmqfUUfaKrah7wudpnEQ4yxBll/dFUARZF1M+IgoUGdkUoTLi2faxv2PFfoJhaXJOoc6t4xIVSCE431PrnhkrdpTo=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa9624-65fe-4919-1e7a-08d82311a051
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 07:36:28.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zf1v7r1yKE9bqn4yXvYqicvOEjc6zTrePgxFFtjsE5iXJm95x5Jq/wLpppwftZlCvtbhwGKvTEotKiFKLcF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Create a separate function that sets up DSP mailbox channels
so that imx_dsp_probe function will be easier to read.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/imx-dsp.c | 41 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 4265e9dbed84..a3a018c87b52 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -60,22 +60,15 @@ static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
 	}
 }
 
-static int imx_dsp_probe(struct platform_device *pdev)
+static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 {
-	struct device *dev = &pdev->dev;
-	struct imx_dsp_ipc *dsp_ipc;
+	struct device *dev = dsp_ipc->dev;
 	struct imx_dsp_chan *dsp_chan;
 	struct mbox_client *cl;
 	char *chan_name;
 	int ret;
 	int i, j;
 
-	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
-
-	dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
-	if (!dsp_ipc)
-		return -ENOMEM;
-
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
 		if (i < 2)
 			chan_name = kasprintf(GFP_KERNEL, "txdb%d", i);
@@ -108,12 +101,6 @@ static int imx_dsp_probe(struct platform_device *pdev)
 		kfree(chan_name);
 	}
 
-	dsp_ipc->dev = dev;
-
-	dev_set_drvdata(dev, dsp_ipc);
-
-	dev_info(dev, "NXP i.MX DSP IPC initialized\n");
-
 	return 0;
 out:
 	kfree(chan_name);
@@ -125,6 +112,30 @@ static int imx_dsp_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int imx_dsp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_dsp_ipc *dsp_ipc;
+	int ret;
+
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
+	dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
+	if (!dsp_ipc)
+		return -ENOMEM;
+
+	dsp_ipc->dev = dev;
+	dev_set_drvdata(dev, dsp_ipc);
+
+	ret = imx_dsp_setup_channels(dsp_ipc);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "NXP i.MX DSP IPC initialized\n");
+
+	return 0;
+}
+
 static int imx_dsp_remove(struct platform_device *pdev)
 {
 	struct imx_dsp_chan *dsp_chan;
-- 
2.17.1

