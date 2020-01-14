Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C6C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4BC2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANVs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:48:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54864 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:48:24 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EF77201224;
        Tue, 14 Jan 2020 22:48:22 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F4B02004FB;
        Tue, 14 Jan 2020 22:48:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E635D402AE;
        Wed, 15 Jan 2020 05:48:08 +0800 (SGT)
From:   Han Xu <han.xu@nxp.com>
To:     vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        esben@geanix.com, boris.brezillon@collabora.com
Cc:     festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dmaengine: mxs: add the remove function
Date:   Wed, 15 Jan 2020 05:43:59 +0800
Message-Id: <1579038243-28550-3-git-send-email-han.xu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the remove function for mxs-dma

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/dma/mxs-dma.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 9deaaf4fc58f..b458f06f9067 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -863,6 +863,22 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int mxs_dma_remove(struct platform_device *pdev)
+{
+	struct mxs_dma_engine *mxs_dma = platform_get_drvdata(pdev);
+	int i;
+
+	dma_async_device_unregister(&mxs_dma->dma_device);
+
+	for (i = 0; i < MXS_DMA_CHANNELS; i++) {
+		struct mxs_dma_chan *mxs_chan = &mxs_dma->mxs_chans[i];
+
+		tasklet_kill(&mxs_chan->tasklet);
+	}
+
+	return 0;
+}
+
 static struct platform_driver mxs_dma_driver = {
 	.driver		= {
 		.name	= "mxs-dma",
@@ -870,6 +886,7 @@ static struct platform_driver mxs_dma_driver = {
 	},
 	.id_table	= mxs_dma_ids,
 	.probe		= mxs_dma_probe,
+	.remove		= mxs_dma_remove,
 };
 
 module_platform_driver(mxs_dma_driver);
-- 
2.17.1

