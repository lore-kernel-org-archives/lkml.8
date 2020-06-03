Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C73F206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFCF0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:26:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60144 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCF0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:26:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AFF5E200D21;
        Wed,  3 Jun 2020 07:26:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C1A7200D53;
        Wed,  3 Jun 2020 07:26:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B2687402B1;
        Wed,  3 Jun 2020 13:26:04 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] mailbox: imx: ONLY IPC MU needs IRQF_NO_SUSPEND flag
Date:   Wed,  3 Jun 2020 13:15:44 +0800
Message-Id: <1591161344-12885-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591161344-12885-1-git-send-email-Anson.Huang@nxp.com>
References: <1591161344-12885-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPC MU has no power domain assigned and there could be IPC during
noirq suspend phase, so IRQF_NO_SUSPEND flag is needed for IPC MU.
However, for other MUs, they have power domain assigned and their
power will be turned off during noirq suspend phase, but with
IRQF_NO_SUSPEND set, their interrupts are NOT disabled even after
their power turned off, it will cause system crash when mailbox
driver trys to handle pending interrupts but the MU power is already
turned off.

So, IRQF_NO_SUSPEND flag should ONLY be added to IPC MU which has
power domain managed by SCU, then all other MUs' pending interrupts
after noirq suspend phase will be handled after system resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 080b608..7205b82 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -292,6 +292,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
+	unsigned long irq_flag = IRQF_SHARED;
 	int ret;
 
 	pm_runtime_get_sync(priv->dev);
@@ -302,8 +303,12 @@ static int imx_mu_startup(struct mbox_chan *chan)
 		return 0;
 	}
 
-	ret = request_irq(priv->irq, imx_mu_isr, IRQF_SHARED |
-			  IRQF_NO_SUSPEND, cp->irq_desc, chan);
+	/* IPC MU should be with IRQF_NO_SUSPEND set */
+	if (!priv->dev->pm_domain)
+		irq_flag |= IRQF_NO_SUSPEND;
+
+	ret = request_irq(priv->irq, imx_mu_isr, irq_flag,
+			  cp->irq_desc, chan);
 	if (ret) {
 		dev_err(priv->dev,
 			"Unable to acquire IRQ %d\n", priv->irq);
-- 
2.7.4

