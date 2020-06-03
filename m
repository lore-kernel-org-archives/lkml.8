Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4EFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0820A2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFCF0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:26:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60034 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCF0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:26:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0DE8200D8A;
        Wed,  3 Jun 2020 07:26:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CABF200D42;
        Wed,  3 Jun 2020 07:26:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D2E4640299;
        Wed,  3 Jun 2020 13:26:03 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] mailbox: imx: Add runtime PM callback to handle MU clocks
Date:   Wed,  3 Jun 2020 13:15:43 +0800
Message-Id: <1591161344-12885-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591161344-12885-1-git-send-email-Anson.Huang@nxp.com>
References: <1591161344-12885-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of i.MX8M SoCs have MU clock, they need to be managed in runtime
to make sure the MU clock can be off in runtime, add runtime PM callback
to handle MU clock.

And on i.MX8MP, the MU clock is combined with power domain and runtime
PM is enabled for the clock driver, during noirq suspend/resume phase,
runtime PM is disabled by device suspend, but the MU context save/restore
needs to enable MU clock for register access, calling clock prepare/enable
will trigger runtime resume failure and lead to system suspend failed.

Actually, the MU context save/restore is ONLY necessary for SCU IPC MU,
other MUs especially on i.MX8MP platforms which have MU clock assigned,
they need to runtime request/free mailbox channel in the consumer driver,
so no need to save/restore MU context for them, hence it can avoid this
issue, so the MU context save/restore is ONLY applied to i.MX platforms
MU instance without clock present.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index da90a8e..080b608 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -536,10 +536,13 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto disable_runtime_pm;
 
+	clk_disable_unprepare(priv->clk);
+
 	return 0;
 
 disable_runtime_pm:
 	pm_runtime_disable(dev);
+	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 
@@ -547,7 +550,6 @@ static int imx_mu_remove(struct platform_device *pdev)
 {
 	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(priv->clk);
 	pm_runtime_disable(priv->dev);
 
 	return 0;
@@ -595,7 +597,8 @@ static int imx_mu_suspend_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 
-	priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
+	if (!priv->clk)
+		priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
 
 	return 0;
 }
@@ -612,15 +615,38 @@ static int imx_mu_resume_noirq(struct device *dev)
 	 * send failed, may lead to system freeze. This issue
 	 * is observed by testing freeze mode suspend.
 	 */
-	if (!imx_mu_read(priv, priv->dcfg->xCR))
+	if (!imx_mu_read(priv, priv->dcfg->xCR) && !priv->clk)
 		imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
 
 	return 0;
 }
 
+static int imx_mu_runtime_suspend(struct device *dev)
+{
+	struct imx_mu_priv *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int imx_mu_runtime_resume(struct device *dev)
+{
+	struct imx_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		dev_err(dev, "failed to enable clock\n");
+
+	return ret;
+}
+
 static const struct dev_pm_ops imx_mu_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_mu_suspend_noirq,
 				      imx_mu_resume_noirq)
+	SET_RUNTIME_PM_OPS(imx_mu_runtime_suspend,
+			   imx_mu_runtime_resume, NULL)
 };
 
 static struct platform_driver imx_mu_driver = {
-- 
2.7.4

