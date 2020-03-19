Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA17C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD58920658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCSICd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:02:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52570 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSICd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:02:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A80D220150E;
        Thu, 19 Mar 2020 09:02:31 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 752E920151B;
        Thu, 19 Mar 2020 09:02:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 80B4340246;
        Thu, 19 Mar 2020 16:02:22 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] nvmem: imx-ocotp: Improve logic to save many code lines
Date:   Thu, 19 Mar 2020 15:55:40 +0800
Message-Id: <1584604540-10097-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several logic improvements to save many code lines:

 - no need to use goto;
 - no need to assign return value;
 - combine different conditions of return value into one line.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 50bea2a..7a1ebd6 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -196,7 +196,6 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 		if (*(buf - 1) == IMX_OCOTP_READ_LOCKED_VAL)
 			imx_ocotp_clr_err_if_set(priv);
 	}
-	ret = 0;
 
 read_end:
 	clk_disable_unprepare(priv->clk);
@@ -435,17 +434,13 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	       priv->base + IMX_OCOTP_ADDR_CTRL_SET);
 	ret = imx_ocotp_wait_for_busy(priv,
 				      priv->params->ctrl.bm_rel_shadows);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(priv->dev, "timeout during shadow register reload\n");
-		goto write_end;
-	}
 
 write_end:
 	clk_disable_unprepare(priv->clk);
 	mutex_unlock(&ocotp_mutex);
-	if (ret < 0)
-		return ret;
-	return bytes;
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config imx_ocotp_nvmem_config = {
-- 
2.7.4

