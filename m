Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE318C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC1F20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943332;
	bh=sW+jBCCO6NkN4e1rV06N+PlKnzFK+hB+HqsuJF1txJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MPGxHjRoMCmypAJ3gR4AMDxqB5Q8bdbtHTpLLkLM6UTiNBu3/0aiLC8H2PMatJI2y
	 tgECif7axJTUCdOOv0YqUnc7oHV7ooE/uYMugSI7pQ7+3xJp93IIM9CfOE/EPZG7dH
	 2TKVzPbPiyj9BBdL+jQDCHFmJdVjx9zH+MtVkpKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbgFWUPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389317AbgFWUPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:15:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFDC2064B;
        Tue, 23 Jun 2020 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943324;
        bh=sW+jBCCO6NkN4e1rV06N+PlKnzFK+hB+HqsuJF1txJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiLm7xW349HuUekY4s/me7tzeAYjn59WJJfmbJa5h61Lf5uAqTUm47/UD7OIT8mpO
         U5QyU9cCN5sX6sWJLftM9YKSKLLGR0fSyZEspLkeGIUNj5kPTIEeo2yD9v3Wh0A47M
         No/oo/2tu04pGH8869j13hPuu4USrXNI/38A5wfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 348/477] mailbox: imx: Add context save/restore for suspend/resume
Date:   Tue, 23 Jun 2020 21:55:45 +0200
Message-Id: <20200623195423.988055449@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

[ Upstream commit ba5f9fa0ca85a6137fa35efd3a1256d8bb6bc5ff ]

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
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/imx-mailbox.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9d6f0217077b2..478308fb82cc6 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -66,6 +66,8 @@ struct imx_mu_priv {
 	struct clk		*clk;
 	int			irq;
 
+	u32 xcr;
+
 	bool			side_b;
 };
 
@@ -558,12 +560,45 @@ static const struct of_device_id imx_mu_dt_ids[] = {
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
2.25.1



