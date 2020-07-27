Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F1F2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEy8Cilk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgG0GQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:16:53 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:13454
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgG0GQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUunenqaWikVgGJZCdA0VxlujnuecY0L/mUJ5/yq26t6nuoIZDd4In9y07DZOEqwuZDSisZ6xKTXH4cC90nFoYYp0DK936E5lOF45lxu6EKqmgzQwCMolXvstouHMo7xZIwDmtMOjmDA+Rd1rBUSBo4ONjzEGCmfK5WKMep7M6CFAn5pQVO5I2elEvuIubPMwPrhUHd8Q6jZZZ5Wl5bHQuBoaR/0SmIl/tNNbAWeZfmdY/fgM62fjhEJ77T5Nj6v7STFFH6C9zbs+wBDaBqBHPXng6VbdjO8tJFQqXR+1tIFwuruSQVp2PhhWvQyYiQDz3tvDVwaFZ3M3KyMEF+PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TObf+wDx8VEHendrmsa+yWcB3HIIOjWW8t88yx1Ll20=;
 b=a/lcOn1mMqWkYfd2OGb/7G7AYz921RPJSxGCnNQhIgpLt9uHUAdRG1EFGXAelsViQmL1+e68rOwtMPOSYxoNAOcrTuzOGia9fdsEsDYYoV7g09Tw/R//TFuF10i3ZKqwIaUIH3U0h/G0gVyAN9L34kJKLTu8eT1f2TTzFVdGgQxx2u41hrdfxH7QKrE8ZSGzYvFOimvGsp6txAzgybR8LJyCFz1V3vFyKQgxgDWBz+0QYL2TQMej8iBzvb80SkqVBMTVXg62UZsPonH0PAme+KgaEsBFgMMcp0MhoKfteToWwNV31zGxAmju21e2IxvXKq/HZ8XnDMfZz0nDPrsbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TObf+wDx8VEHendrmsa+yWcB3HIIOjWW8t88yx1Ll20=;
 b=CEy8Cilk7SPq/CSognPAim04JRCB3Z+Sl5a94OKH4Ey8F1fijfz8pYcPMJCI+ZjWOvCUroGuSlROIeej/6wwyP6+ggNcB30POBiCLAXP1sjUvzZ1L9sEVhIyxYjXHTUMt/NqEJ/mL+UGUSihECfyAXZCwZ++gWs//ZE1hE/OzLU=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5305.eurprd04.prod.outlook.com (2603:10a6:10:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 06:16:49 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6dce:e74b:4350:1be5%9]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:16:49 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/1] irqchip: imx-intmux: implement intmux PM
Date:   Mon, 27 Jul 2020 22:17:34 +0800
Message-Id: <20200727141734.24890-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727141734.24890-1-qiangqing.zhang@nxp.com>
References: <20200727141734.24890-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0139.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 06:16:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33a373a4-77a9-4e3c-d6ce-08d831f4a550
X-MS-TrafficTypeDiagnostic: DB7PR04MB5305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB53059E9DCF675BCF1BE00D3AE6720@DB7PR04MB5305.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEDD6fPFq4VVQhzlnIhogsxsZo+c+nxvF+mODIz+T2jo16UKI06/iW6RdPcCWyBt46tFpgk6dZvEEnBo5s6MYH3aDj7GFLpltM5fKD+VwuLtJd7uvHfijpASi59dXMUlL3Xo05Bn+fPHLnDa4MigsgOO4SfWAt8oPYs1T04RFsrrjF0o4clfZXMhH3Lw38YwK7OHP+ZalxePgzs4GxY50UKKo979TeqMQ6cjxk6f0S7bf64qCPBq9OJfVeXrsXSp3oSgWoBg2/FtjOpcNpdE1H4IIYYxtn4Q+Z0cjQimQyaw7HIQnqxJ5DRjaTM2zMEOJORahwsF3PPe1bWdIelWT+ooLVEg6JJcri5CVzimADCm1orBujk6rt9Kp5Y0u+HK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(16526019)(6506007)(186003)(52116002)(956004)(1076003)(2616005)(26005)(66476007)(66556008)(8936002)(66946007)(6486002)(6512007)(5660300002)(8676002)(316002)(83380400001)(86362001)(69590400007)(4326008)(2906002)(36756003)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n3hh10UVPXXYBkge4r85cmj0V9qRC+kAK/ClRH/lRT4Ld4I6sDc/DLHE4C2n1YIBiNRuwfOcvS9sYsE5hpHkJ4xZMaf2sU0Z/BUBNUYJYVQfMykAxTGvXo8SWYXD+zUKoyYboyXrhU4WEzrCXJVNSBJ9ooiPBldQd8rJRdVAna8PAhsO0mKuOgjgjaw66nZyNFGl7+PybA0r9s2r4estYTs5lbqWnK9r3GPt2LAHLDuiXDZ4xTCQUbmQ2mPkITjtnymzGhsi7vcbq4pn0BdvhERkSYoiI2ItQlm6neRsK/v6iAuY67XamOaJeEmCT1u8wSMaV0HhSL+Dfvz2ku2jyn//GUtf6js+CIznKSTYT/D6rRwI7BK3STz0Opnqm/ULK9hqjmsc/0lIKK7iPZRG/KOAFW6B924BR1Y5lXh0/UEmfiNCyFDjuC8xeNrkJIDvsLRI72N9cOYy1V7k+FDJNZFARWBFb/rmfwSAnEGPrHc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a373a4-77a9-4e3c-d6ce-08d831f4a550
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 06:16:49.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjQ2Yx1STeqWGnTZEPLSbY4A2X2t71b2tjI+BjHWa9RmS0u86Vs1M26TsWavHYoBe1d9dz6yXqXpYXNYgzhMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system suspended, we could explicitly disable clock to save power.
And we need save registers' state since it could be lost after power
off.

Implement PM which will:
1) Without CONFIG_PM, clock is always on after probe stage.
2) With CONFIG_PM, clock is off after probe stage.
3) Disable clock and save registers' state when do system suspend and
enable clock and restore registers' state while system resume.
4) Make Power Domain framework be able to shutdown the corresponding
power domain of this device.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/irq-imx-intmux.c | 67 +++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index c27577c81126..4524c931c368 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -53,6 +53,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 #define CHANIER(n)	(0x10 + (0x40 * n))
 #define CHANIPR(n)	(0x20 + (0x40 * n))
@@ -60,6 +61,8 @@
 #define CHAN_MAX_NUM		0x8
 
 struct intmux_irqchip_data {
+	struct irq_chip		chip;
+	u32			saved_reg;
 	int			chanidx;
 	int			irq;
 	struct irq_domain	*domain;
@@ -120,8 +123,10 @@ static struct irq_chip imx_intmux_irq_chip = {
 static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_data(irq, h->host_data);
-	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
+	struct intmux_irqchip_data *data = h->host_data;
+
+	irq_set_chip_data(irq, data);
+	irq_set_chip_and_handler(irq, &data->chip, handle_level_irq);
 
 	return 0;
 }
@@ -232,6 +237,10 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = clk_prepare_enable(data->ipg_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
@@ -239,6 +248,8 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chip = imx_intmux_irq_chip;
+		data->irqchip_data[i].chip.parent_device = &pdev->dev;
 		data->irqchip_data[i].chanidx = i;
 
 		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
@@ -267,6 +278,12 @@ static int imx_intmux_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	/*
+	 * Let pm_runtime_put() disable clock.
+	 * If CONFIG_PM is not enabled, the clock will stay powered.
+	 */
+	pm_runtime_put(&pdev->dev);
+
 	return 0;
 out:
 	clk_disable_unprepare(data->ipg_clk);
@@ -288,11 +305,56 @@ static int imx_intmux_remove(struct platform_device *pdev)
 		irq_domain_remove(data->irqchip_data[i].domain);
 	}
 
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int imx_intmux_runtime_suspend(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+	struct intmux_irqchip_data irqchip_data;
+	int i;
+
+	for (i = 0; i < data->channum; i++) {
+		irqchip_data = data->irqchip_data[i];
+		irqchip_data.saved_reg = readl_relaxed(data->regs + CHANIER(i));
+	}
+
 	clk_disable_unprepare(data->ipg_clk);
 
 	return 0;
 }
 
+static int imx_intmux_runtime_resume(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+	struct intmux_irqchip_data irqchip_data;
+	int ret, i;
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < data->channum; i++) {
+		irqchip_data = data->irqchip_data[i];
+		writel_relaxed(irqchip_data.saved_reg, data->regs + CHANIER(i));
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx_intmux_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx_intmux_runtime_suspend,
+			   imx_intmux_runtime_resume, NULL)
+};
+
 static const struct of_device_id imx_intmux_id[] = {
 	{ .compatible = "fsl,imx-intmux", },
 	{ /* sentinel */ },
@@ -302,6 +364,7 @@ static struct platform_driver imx_intmux_driver = {
 	.driver = {
 		.name = "imx-intmux",
 		.of_match_table = imx_intmux_id,
+		.pm = &imx_intmux_pm_ops,
 	},
 	.probe = imx_intmux_probe,
 	.remove = imx_intmux_remove,
-- 
2.17.1

