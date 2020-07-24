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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE60C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCE220767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvfjDZ/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGXHoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:44:13 -0400
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:28161
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727836AbgGXHoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1ovKxIb/lYevOxiZ/OotmUVKlz6OtOOm017HAQfqmH5iDgO8+ykWhYCboTVjlgmDO5Kmy++kopi1BlUIHRDpVs6xxCZxEzxzaXzsU3dA6PQBws39SXr+Qp/rw22mnJoLQ84IN6KFzS3K6J4edGjszpXWadmy0lcc8Lm4Kw2H4B8MKlE3uPg3/Fw3m2S1S7a+LGwAQPZ5UNmNkB6Oi0ydv/21Ud8PSr5uAb8U9O11+PDBXwstr6Vm+9SV9GjCIwM3jY+87yLFCGhcSwROJ6VR4k6qJ9ADekB1OH2nf11kD2qfrtwz8Q1CLPm+vbZJQ9Ns1We6k94Qvaz7JFFQpNojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S5xzslLg13cyVfNnQlytWG9SZw7GUarAuSy+KDde0M=;
 b=QnJQ+nK4irrZTi8Tx9m+2Ay+2DuMW7xYhwjsr0fiPCF9J408lX6ZKKFWG6xNXDg484u7zp0ALuZB0JnYaS1CTVg+3zxdMP79cDUsjYLGd764XaB9zQ2t963dQAMZqeGoieWnTArtPpjcmYIY3MAb4LFheWFObMPokFgElGfgd8qvzFWdlQmgofQMTWBpD6Iws7RaWm6ivkyScCg5AJbtxDSaih4QSZrmSEqgBVhXz97xMqzgEtmDJ+BmsFIOUvUF7irxWt1Eaj66PWVKEh7ETwFb4dLk23XGpPFnLCShMvPwaajkMOSCF39KDHd2em8OL5tyQZt1GlqHdHMUOzP3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S5xzslLg13cyVfNnQlytWG9SZw7GUarAuSy+KDde0M=;
 b=cvfjDZ/hWzW4fbDyVUKCffKpDpDOR3CvvmMxqHrpQtNCAPGrqPNcqzCtFewci5lLRQLPMp9shS7784qbF2r7xtqW33PnGsBE9pGHxQBkSPyb6aCIwApAkMh5SmQljoRtqrawgNNKi46b9Z9moYVJm0Q2g8NnxfWyIiqcDNaI2vA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:44:08 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:44:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 09/10] remoteproc: imx_proc: enable virtio/mailbox
Date:   Fri, 24 Jul 2020 16:08:12 +0800
Message-Id: <20200724080813.24884-10-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:44:04 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ceff2ed-4731-4da3-157c-08d82fa558ca
X-MS-TrafficTypeDiagnostic: DB8PR04MB6858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6858BF10F17FDA5AB472BAAF88770@DB8PR04MB6858.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzwWHjCFNDxRKwjcZ1Am4qfoAfYQKtHJT56NJ4I8vvsbU3biNcJxw4fOELHdlfSh29TXvGPYtmrV2iZm9ilX1oBWGaoFFMrYTo6f6xhtel34v/EiD7tLsXlKwkQCiMhHMMD2A8gknrPeg8cLsp6F0GgKVIbhVQgmKJMPZE1InJk7z2oMVDe8hgJI96L+Hh7oVl47yg5qwKqzruNet3qT3kSWFygzywYYPrQaE+Bqn+U7kw7mqTYZjU0cdW8w2tUpR0mFu9RIO1f78hZ9E7LmC4w01P9UnGfJcoOb+2TP7AdJZWaiyBA2mQ7MQXrnl12VpFCG7bAXjxaF3SVgH3GATQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(52116002)(36756003)(83380400001)(478600001)(1076003)(2906002)(6666004)(16526019)(186003)(26005)(6506007)(15650500001)(44832011)(956004)(2616005)(86362001)(6486002)(66946007)(316002)(8936002)(7416002)(6512007)(66476007)(66556008)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CChrRR4/ftpbxpupoLpzgHVkiFq+SRpNDX8Dm1p2Yqm4WCM1gKLzdbVlfDr2jkC/ZLqDTfHS35d34cvczSV1mDMwZ6Mlfg4VACo7TD07OJq8NsU/xThmJPrCQ9rtv0nl563kcL4pmoZxsgd/IHdA26uFvJAORVs6kEy8g8MgIAbUkj5oY3KKnU0AJ0gY0XViARPmaeBwNkrKeYlVT0oiDzg2gTD9EQm0DE4TNQ12XGizyCtTIT32Co8ptbkEUo1SW+wUk394xVRFo7M3QDgwNCQ+xkXGL9kJhOpRl3qWtw0b+jNNwPkIgY3AS5lT3Pry9lIKYjmPzR7P0Klta8IZD78f7FY5k2y0q3qhzlKr5EYnVzYFNCQUFtr8m7A4S7LPxmpdiYqRdTwa4keKor+9g8MwissP/DYfJ2z+qBI0jArLYG7nrhxe4Tzqy6rIkS0oTXtBnlvyE8BtzSf119fSL8cM+RgN3NgOhFwHK1BTtEI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceff2ed-4731-4da3-157c-08d82fa558ca
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:44:08.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC0yi20tO9/nMiO3qC5KCZvfjzWLugk6HqTdzmmOesD0uaXFvN72OsU3LINKIfbuJhET9U7JK0bLDznxE9oLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use virtio/mailbox to build connection between Remote Proccessors
and Linux. Add delayed work to handle incoming messages.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 102 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 03382290d6a5..a8ce97c04e1e 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -91,6 +92,10 @@ struct imx_rproc {
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
 	void				*rsc_va;
+	struct mbox_client		cl;
+	struct mbox_chan		*tx_ch;
+	struct mbox_chan		*rx_ch;
+	struct delayed_work		rproc_work;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
@@ -452,9 +457,25 @@ static int imx_rproc_elf_load_segments(struct rproc *rproc, const struct firmwar
 	return ret;
 }
 
+static void imx_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct imx_rproc *priv = rproc->priv;
+	int err;
+	__u32 mmsg;
+
+	mmsg = vqid << 16;
+
+	priv->cl.tx_tout = 20;
+	err = mbox_send_message(priv->tx_ch, (void *)&mmsg);
+	if (err < 0)
+		dev_err(priv->dev, "%s: failed (%d, err:%d)\n",
+			__func__, vqid, err);
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
+	.kick		= imx_rproc_kick,
 	.da_to_va       = imx_rproc_da_to_va,
 	.load		= imx_rproc_elf_load_segments,
 	.parse_fw	= imx_rproc_parse_fw,
@@ -527,6 +548,67 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 	return 0;
 }
 
+static void imx_rproc_vq_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct imx_rproc *priv = container_of(dwork, struct imx_rproc,
+					      rproc_work);
+
+	rproc_vq_interrupt(priv->rproc, 0);
+	rproc_vq_interrupt(priv->rproc, 1);
+}
+
+static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
+{
+	struct rproc *rproc = dev_get_drvdata(cl->dev);
+	struct imx_rproc *priv = rproc->priv;
+
+	schedule_delayed_work(&(priv->rproc_work), 0);
+}
+
+static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	struct device *dev = priv->dev;
+	struct mbox_client *cl;
+	int ret = 0;
+
+	cl = &priv->cl;
+	cl->dev = dev;
+	cl->tx_block = true;
+	cl->tx_tout = 20;
+	cl->knows_txdone = false;
+	cl->rx_callback = imx_rproc_rx_callback;
+
+	priv->tx_ch = mbox_request_channel_byname(cl, "tx");
+	if (IS_ERR(priv->tx_ch)) {
+		if (PTR_ERR(priv->tx_ch) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		ret = PTR_ERR(priv->tx_ch);
+		dev_dbg(cl->dev, "failed to request mbox tx chan, ret %d\n",
+			ret);
+		goto err_out;
+	}
+
+	priv->rx_ch = mbox_request_channel_byname(cl, "rx");
+	if (IS_ERR(priv->rx_ch)) {
+		ret = PTR_ERR(priv->rx_ch);
+		dev_dbg(cl->dev, "failed to request mbox rx chan, ret %d\n",
+			ret);
+		goto err_out;
+	}
+
+	return ret;
+
+err_out:
+	if (!IS_ERR(priv->tx_ch))
+		mbox_free_channel(priv->tx_ch);
+	if (!IS_ERR(priv->rx_ch))
+		mbox_free_channel(priv->rx_ch);
+
+	return ret;
+}
+
 static int imx_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -566,17 +648,24 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, rproc);
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			goto err_put_rproc;
+		/* mbox is optional, so not fail here */
+	}
+
 	ret = imx_rproc_addr_init(priv, pdev);
 	if (ret) {
 		dev_err(dev, "failed on imx_rproc_addr_init\n");
-		goto err_put_rproc;
+		goto err_put_mbox;
 	}
 
 	priv->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "Failed to get clock\n");
 		ret = PTR_ERR(priv->clk);
-		goto err_put_rproc;
+		goto err_put_mbox;
 	}
 
 	/*
@@ -586,9 +675,11 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
 		dev_err(&rproc->dev, "Failed to enable clock\n");
-		goto err_put_rproc;
+		goto err_put_mbox;
 	}
 
+	INIT_DELAYED_WORK(&(priv->rproc_work), imx_rproc_vq_work);
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
@@ -599,6 +690,11 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
+err_put_mbox:
+	if (!IS_ERR(priv->tx_ch))
+		mbox_free_channel(priv->tx_ch);
+	if (!IS_ERR(priv->rx_ch))
+		mbox_free_channel(priv->rx_ch);
 err_put_rproc:
 	rproc_free(rproc);
 
-- 
2.16.4

