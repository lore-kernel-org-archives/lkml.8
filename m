Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB713C3404F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B972465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LJgbdR2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBSHeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:07 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:42040
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbgBSHeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsJkl4Z2f9wywLy1W9rxfKuEY0f4aALnZV7LSUTu0bM30zPnfYuSzFhkUJO8GTnd9TIFk7JcMezm15BSmE2nTvyB4Dy9U5/V84RVgGm8XAoWNGvhIHSrsnn+BFJaGHbYqJLMP2k+cUerWTJgvTVr66fl+qEQQZkVBYtvsJqGZ+irk6bhRPQs9GJZczVb+2Zffy3ZOsvKm7cpZ2LVOOt06ZOWrBE+9Q1Dylu3+eQsUgYQ/XJ5vs38tLM1I8xxa0AlBATLvmVIyZFJda92i/wO4tg3G/MDDOuURU1TnD8cRBP52UwyT2PHQYoh4pTqgaBMq01DgTRJiZjjJnSxGqs3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hLsZGc0Jz3fvBUSAmJFwrydvGi0DthVlRqJf1pLuRc=;
 b=NmQpLswZ+H/LdDBaJp1WQL1BmN3kO99Aeo+0o4oBHKdekdmj5PprR3F1vYvpcvtTCZRU0T9uyfHNX5T9OnE8pceS3tNe50uziVZQVxAfZdiaM+Iq0d6YVUKzKh5hrAYYtLoExopft644/r+Y1yMRul1y/MjLQEWaP/9ptgcrWobOHef3v2YFi2Vb1xeLnMXIwl1oLVOfYwggF8ME0eu+VCZOA+wBQ4YydVtc215QDoa4kKz554SQWxGWq1yOXK/EEGhHoGWcXdAGyJaB0v6P+rfkENtzo4fR3CRd62vM/etWSvcC3iEscHlJVKXprUe4K/PW42r2gQQykgykSEJOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hLsZGc0Jz3fvBUSAmJFwrydvGi0DthVlRqJf1pLuRc=;
 b=LJgbdR2uwnmxr2OqEQug1poU3/QTEtZeMkhvDgG6/w4yTNBDOLacZsNUreFFl5gJcF+N0PuDqg7HRA4WMtEQwSRwhAqH1SAr74Pe1Df6sDu00vDm3nnXyrr1jjnmtyaTe2GYRT9YsP1AXFMs531WF9GDgjQ9H6HvKacYajArJiU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3969.eurprd04.prod.outlook.com (52.134.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:34:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:34:02 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/9] remoteproc: imx_proc: enable virtio/mailbox
Date:   Wed, 19 Feb 2020 15:27:42 +0800
Message-Id: <1582097265-20170-7-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:33:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be00a042-42f9-46d0-b244-08d7b50e178d
X-MS-TrafficTypeDiagnostic: AM0PR04MB3969:|AM0PR04MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB3969C87AA939E40C4689ECE488100@AM0PR04MB3969.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(66556008)(66476007)(8676002)(478600001)(186003)(52116002)(956004)(81166006)(81156014)(7416002)(5660300002)(4326008)(2616005)(66946007)(8936002)(16526019)(316002)(69590400006)(9686003)(6666004)(36756003)(2906002)(86362001)(6506007)(6512007)(26005)(15650500001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3969;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /55s+MllzGW+3en6ZYB3ZdcElytS7M/AJz6gFpbxzfe4kFRbkH2wKoSc7Xwj1CICrD1sCWzgGN9gDImX8dw8dbyoLoGLmHEnEvvIUpMCIEvvrbNPGlFRA4kVxaIzrHFQlg4olXIRqAtTejONr3SiDh/M70X6+0rAxSOpRsuZrvRFQqq1ll5p+23UKYE/BEsBogxH3B+JjMhx01LZJhn4LDatOhZj3AIf+T/8exn5WXqJCFjUt1KZ0vZ0w608oi+r5d5wZ5jS2wyxB0uTm6yvWvhQY9bG2lWLqUAF68gc0bMf2ekkFK4/9+s/56oWa4J1sRBRaZwF4L2TpZL1g4ejo+OqgqrgRKel5tM68ZLLbgikel7fbIcGLTk6qF+IbK3z57tQBsRYNUQtvE0D9J2WGNgrUh5vY3KFLqxYqtNLCmLDu2Ifc1SRWF6w75AF3/83ZX4X0juGPcLLe3bbJE7vvfbuLBJrx4pi7HWpR3l/TL3AmmxyGTkd0M9WZUu2fxh7pWugNsh7iSX+PFYksID0Ny+1l/x5xVQP066tQrHfcqs=
X-MS-Exchange-AntiSpam-MessageData: ljBgqsrmu2AcDFZQgrmZZxsPVtqtD4owed6+YXs0uw5duEnYF+/K+1BH9ZWeSql1LiJlKC1N13snvZ5xct3c6Pa45zRes27ewHCshTdHGUtve5JiWmwvF2mb6Kg/oVRBC3Ta26XvAlJHLKTtwGIVsg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be00a042-42f9-46d0-b244-08d7b50e178d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:34:02.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+lcboYwagk/DkbdXqWmyJ2IdERq3MZVZMCoNNx7O+oPwWrQP9XzR5ou62JxiOS5OAnUaNiOjuc9TmJy4c8GMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use virtio/mailbox to build connection between Remote Proccessors
and Linux. Add delayed work to handle incoming messages.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 106 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index e31ea1090cf3..36dec1ce4f50 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -7,14 +7,18 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 
+#include "remoteproc_internal.h"
+
 #define IMX7D_SRC_SCR			0x0C
 #define IMX7D_ENABLE_M4			BIT(3)
 #define IMX7D_SW_M4P_RST		BIT(2)
@@ -87,6 +91,10 @@ struct imx_rproc {
 	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
 	struct clk			*clk;
 	bool				early_boot;
+	struct mbox_client		cl;
+	struct mbox_chan		*tx_ch;
+	struct mbox_chan		*rx_ch;
+	struct delayed_work		rproc_work;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx7d[] = {
@@ -402,9 +410,25 @@ static u32 imx_rproc_elf_get_boot_addr(struct rproc *rproc,
 	return 0;
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
@@ -503,6 +527,67 @@ static int imx_rproc_configure_mode(struct imx_rproc *priv)
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
@@ -543,22 +628,28 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, rproc);
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			goto err_put_rproc;
+	}
+
 	ret = imx_rproc_configure_mode(priv);
 	if (ret)
-		goto err_put_rproc;
+		goto err_put_mbox;
 
 	if (!priv->early_boot) {
 		ret = imx_rproc_addr_init(priv, pdev);
 		if (ret) {
 			dev_err(dev, "failed on imx_rproc_addr_init\n");
-			goto err_put_rproc;
+			goto err_put_mbox;
 		}
 
 		priv->clk = devm_clk_get(dev, NULL);
 		if (IS_ERR(priv->clk)) {
 			dev_err(dev, "Failed to get clock\n");
 			ret = PTR_ERR(priv->clk);
-			goto err_put_rproc;
+			goto err_put_mbox;
 		}
 
 		/*
@@ -568,10 +659,12 @@ static int imx_rproc_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(priv->clk);
 		if (ret) {
 			dev_err(&rproc->dev, "Failed to enable clock\n");
-			goto err_put_rproc;
+			goto err_put_mbox;
 		}
 	}
 
+	INIT_DELAYED_WORK(&(priv->rproc_work), imx_rproc_vq_work);
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed\n");
@@ -583,6 +676,11 @@ static int imx_rproc_probe(struct platform_device *pdev)
 err_put_clk:
 	if (!priv->early_boot)
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

