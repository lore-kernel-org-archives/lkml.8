Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA8DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BF8206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHKGVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:21:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42448 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgHKGVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:21:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8AE72007A4;
        Tue, 11 Aug 2020 08:21:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93879201DD0;
        Tue, 11 Aug 2020 08:21:08 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 36150402A5;
        Tue, 11 Aug 2020 08:21:03 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 14:16:15 +0800
Message-Id: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	- remove redundant return value print.
---
 drivers/irqchip/irq-imx-intmux.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index e35b7b0..7709f97 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -226,12 +226,9 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(data->ipg_clk)) {
-		ret = PTR_ERR(data->ipg_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->ipg_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->ipg_clk),
+				     "failed to get ipg clk\n");
 
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
-- 
2.7.4

