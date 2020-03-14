Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A5C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974BC2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCOCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:04:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60384 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgCOCEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:04:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6951520155F;
        Sat, 14 Mar 2020 08:17:49 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 12B13201561;
        Sat, 14 Mar 2020 08:17:45 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8931D402A5;
        Sat, 14 Mar 2020 15:17:39 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] nvmem: mxs-ocotp: Use devm_add_action_or_reset() for cleanup
Date:   Sat, 14 Mar 2020 15:11:11 +0800
Message-Id: <1584169871-418-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset() for cleanup to call clk_unprepare(),
which can simplify the error handling in .probe, and .remove callback
can be dropped.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/mxs-ocotp.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 8e4898d..588ab56 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -130,6 +130,11 @@ static const struct of_device_id mxs_ocotp_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_ocotp_match);
 
+static void mxs_ocotp_action(void *data)
+{
+	clk_unprepare(data);
+}
+
 static int mxs_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -160,39 +165,26 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, mxs_ocotp_action, otp->clk);
+	if (ret)
+		return ret;
+
 	data = match->data;
 
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
 	otp->nvmem = devm_nvmem_register(dev, &ocotp_config);
-	if (IS_ERR(otp->nvmem)) {
-		ret = PTR_ERR(otp->nvmem);
-		goto err_clk;
-	}
+	if (IS_ERR(otp->nvmem))
+		return PTR_ERR(otp->nvmem);
 
 	platform_set_drvdata(pdev, otp);
 
 	return 0;
-
-err_clk:
-	clk_unprepare(otp->clk);
-
-	return ret;
-}
-
-static int mxs_ocotp_remove(struct platform_device *pdev)
-{
-	struct mxs_ocotp *otp = platform_get_drvdata(pdev);
-
-	clk_unprepare(otp->clk);
-
-	return 0;
 }
 
 static struct platform_driver mxs_ocotp_driver = {
 	.probe = mxs_ocotp_probe,
-	.remove = mxs_ocotp_remove,
 	.driver = {
 		.name = "mxs-ocotp",
 		.of_match_table = mxs_ocotp_match,
-- 
2.7.4

