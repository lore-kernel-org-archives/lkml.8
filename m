Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB535C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7C0207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447435;
	bh=sBv8mpqJlknnPCCg6c7Y2sFeS2VKiUqxb+y5UoFtA5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNAnEhJiHs474KEv3KmLODUHt13v3YbPtBi4Izov8ICesFYxID5AHrZDXSMfMekl6
	 mV5d74OweSdej3cSoOvReHSU4qDV+cYgSt7surAe5SXGeCfvNoxNPh7PgxRWNa4CaG
	 t+FGdkCzzK5BpI0LZptXUyBs0+cD5+jgCQ+BGFWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgFRCae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgFRBPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52BC221F1;
        Thu, 18 Jun 2020 01:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442946;
        bh=sBv8mpqJlknnPCCg6c7Y2sFeS2VKiUqxb+y5UoFtA5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBMN59X/INkILvufa15dM0M9RLLW7LMCWfWGbYpUP6NoKUMvMSYdtownlHvwXcD4T
         0dro0vuinBcFY6RvpdgzH/7nOKmEPwihN0DKteGT9Z8H0sM7QiE1J3GmOWk76wjmzN
         dgO+fFEJxOT0v/pPLva0Ymzpf9Q9IKNmzZlfmpFY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 356/388] mailbox: imx: Add context save/restore for suspend/resume
Date:   Wed, 17 Jun 2020 21:07:33 -0400
Message-Id: <20200618010805.600873-356-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 9d6f0217077b..478308fb82cc 100644
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

