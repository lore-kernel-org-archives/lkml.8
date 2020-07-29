Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BF9207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgG2PtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:49:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgG2PtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:49:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EEFA4C45F786571383A1;
        Wed, 29 Jul 2020 23:49:06 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Jul 2020 23:49:00 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()
Date:   Wed, 29 Jul 2020 23:58:49 +0800
Message-ID: <20200729155849.33919-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc report warning as follows:

drivers/irqchip/irq-imx-intmux.c:316:29: warning:
 variable 'irqchip_data' set but not used [-Wunused-but-set-variable]
  316 |  struct intmux_irqchip_data irqchip_data;
      |                             ^~~~~~~~~~~~

irqdata regs is stored to this variable on the stack in
imx_intmux_runtime_suspend(), which means a nop. this commit
fix to save regs to the right place.

Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power management")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/irqchip/irq-imx-intmux.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 4c9e40d193d6..e35b7b09c3ab 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -313,12 +313,12 @@ static int imx_intmux_remove(struct platform_device *pdev)
 static int imx_intmux_runtime_suspend(struct device *dev)
 {
 	struct intmux_data *data = dev_get_drvdata(dev);
-	struct intmux_irqchip_data irqchip_data;
+	struct intmux_irqchip_data *irqchip_data;
 	int i;
 
 	for (i = 0; i < data->channum; i++) {
-		irqchip_data = data->irqchip_data[i];
-		irqchip_data.saved_reg = readl_relaxed(data->regs + CHANIER(i));
+		irqchip_data = &data->irqchip_data[i];
+		irqchip_data->saved_reg = readl_relaxed(data->regs + CHANIER(i));
 	}
 
 	clk_disable_unprepare(data->ipg_clk);
@@ -329,7 +329,7 @@ static int imx_intmux_runtime_suspend(struct device *dev)
 static int imx_intmux_runtime_resume(struct device *dev)
 {
 	struct intmux_data *data = dev_get_drvdata(dev);
-	struct intmux_irqchip_data irqchip_data;
+	struct intmux_irqchip_data *irqchip_data;
 	int ret, i;
 
 	ret = clk_prepare_enable(data->ipg_clk);
@@ -339,8 +339,8 @@ static int imx_intmux_runtime_resume(struct device *dev)
 	}
 
 	for (i = 0; i < data->channum; i++) {
-		irqchip_data = data->irqchip_data[i];
-		writel_relaxed(irqchip_data.saved_reg, data->regs + CHANIER(i));
+		irqchip_data = &data->irqchip_data[i];
+		writel_relaxed(irqchip_data->saved_reg, data->regs + CHANIER(i));
 	}
 
 	return 0;

