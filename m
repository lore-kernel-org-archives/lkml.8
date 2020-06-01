Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D898C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034EA20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFAD5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:57:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34702 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgFAD5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:57:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BEDF320043F;
        Mon,  1 Jun 2020 05:57:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4FEA32001B8;
        Mon,  1 Jun 2020 05:57:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9EC89402A7;
        Mon,  1 Jun 2020 11:57:39 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] mailbox: imx: Add context save/restore for suspend/resume
Date:   Mon,  1 Jun 2020 11:47:28 +0800
Message-Id: <1590983248-7203-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

For "mem" mode suspend on i.MX8 SoCs, MU settings could be
lost because its power is off, so save/restore is needed
for MU settings during suspend/resume. However, the restore
can ONLY be done when MU settings are actually lost, for the
scenario of settings NOT lost in "freeze" mode suspend, since
there could be still IPC going on multiple CPUs, restoring the
MU settings could overwrite the TIE by mistake and cause system
freeze, so need to make sure ONLY restore the MU settings when
it is powered off, Anson fixes this by checking whether restore
is actually needed when resume.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- change the author and add more fix note in commit log.
---
 drivers/mailbox/imx-mailbox.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 97bf0ac..b53cf63 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -67,6 +67,8 @@ struct imx_mu_priv {
 	struct clk		*clk;
 	int			irq;
 
+	u32 xcr;
+
 	bool			side_b;
 };
 
@@ -583,12 +585,45 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
 
+static int imx_mu_suspend_noirq(struct device *dev)
+{
+	struct imx_mu_priv *priv = dev_get_drvdata(dev);
+
+	priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
+
+	return 0;
+}
+
+static int imx_mu_resume_noirq(struct device *dev)
+{
+	struct imx_mu_priv *priv = dev_get_drvdata(dev);
+
+	/*
+	 * ONLY restore MU when context lost, the TIE could
+	 * be set during noirq resume as there is MU data
+	 * communication going on, and restore the saved
+	 * value will overwrite the TIE and cause MU data
+	 * send failed, may lead to system freeze. This issue
+	 * is observed by testing freeze mode suspend.
+	 */
+	if (!imx_mu_read(priv, priv->dcfg->xCR))
+		imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_mu_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_mu_suspend_noirq,
+				      imx_mu_resume_noirq)
+};
+
 static struct platform_driver imx_mu_driver = {
 	.probe		= imx_mu_probe,
 	.remove		= imx_mu_remove,
 	.driver = {
 		.name	= "imx_mu",
 		.of_match_table = imx_mu_dt_ids,
+		.pm = &imx_mu_pm_ops,
 	},
 };
 module_platform_driver(imx_mu_driver);
-- 
2.7.4

