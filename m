Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B191C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDE62177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IH6pihLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGTClq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:41:46 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:30187
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTClp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:41:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7z2bkjI+bU14XSWoVJCh7kkRbB4JmBNtPO+vHYZHG96FHvFZv2ysCgurMgNurBIw12jmL2PLyI9yC8kEKmS/7eKFDS6f/blMYyTZMywV3tDARvQFqqLsueZYfnl2hOdxeN7pW1WWDUhJ/6Xg2F0aVRzNlaKjUIqvGrMGT8Pkl82labS2p7H+SSmc2MHTiUS9f679P3WJ/JNshJGExIkkIN2Jq0r4nTddggmY1z7AL3969NHQ8drLR1/BTsbHxDjG3xqEoYsU0FcQI9dJfD9FCVggiVg0LBMDHE2ZEgA5cWd7VADu0EyE2121zqr+y8zF9yrb9BdyPWzbjtUxa9z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4yooamWj2QsXfQBJpUYK0xCr51KHJzScI1VQ/i9JE4=;
 b=PuwwQWPes4b4EV/fxv4Hc9Fxm00WjaLPtgOBcK8nJNOFTmyZ9FoymiBbxFKVKsuf52rYVKKSsgKzBMx5zoree25EG4zADh+bG9VmymUvtaUuq/el5bBJV6tXk7rAH0V9BfLHPYyE4ZynHu/yK4tyd/XEGEcKUpshkoWiFz1b+xVO97EWLiOPPMCPj3y17GJg5C0i4VoKebVwIZh+Z/nFnDJuB84H+pnXwcuPHIkzSxFGZJdCPG9hSgaSeYZ9ibVBPO+fEETPZaXrpDjg1Q96Qribp+1eL1mWy9qr/wHq75NZ0fol75Rl7OwL8W8jlWfoiLCFkXbKK/SHP4vlT/pFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4yooamWj2QsXfQBJpUYK0xCr51KHJzScI1VQ/i9JE4=;
 b=IH6pihLH5scje2A1CySD0bagcTXVyM3tHwAtqarM+07DUbela0xIkGT1QqAlxn+/rIQs5DuCM1/RuQ1h1ouWr3J6oTpr6ITfaF9YeUCa/4Q26wc1I1MgWZhS23nb2C/ecBA7+bAYN7OSPNpyPV3SvDmOJYZO4z8wwPq+9x2KzGE=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5884.eurprd04.prod.outlook.com (2603:10a6:10:b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 02:41:41 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 02:41:41 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/1] irqchip: imx-intmux: implement intmux PM
Date:   Mon, 20 Jul 2020 18:42:37 +0800
Message-Id: <20200720104237.13119-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720104237.13119-1-qiangqing.zhang@nxp.com>
References: <20200720104237.13119-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:3:1::11) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0001.apcprd04.prod.outlook.com (2603:1096:3:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 02:41:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c7dea65-9b83-47bb-b408-08d82c566e83
X-MS-TrafficTypeDiagnostic: DB8PR04MB5884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5884FE9A5057C874CE5C3CC2E67B0@DB8PR04MB5884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWqqo2MZ03UrudV8OldzCrOvlyx3/lxh5TT0dfmfUPeKJepzXPqaLcBygIfHHsw9ATA8wiuLJRCOgwmGKnFualzUsplmmK1xCw4d4zjicZUV/MnOaA52ZqRjQe9fDwEmuU1KZQDVtN9vvNJI9ltaYXczrp3AUWiDytAejL8voUHoBbSB+fQeVqwuTpLRHCfeV9+4I+4fwsWNHeA3tiK4qaLu2786WzNaMoRRLKR2wbw/M3I/Ac+FuqmoL4KQjE63icQfkFXO9rzbhiQhRRiRbuNGndqe8EtbBkpPH643Ufh7mlSpbMkCRYfV0W7B8Mm5u8EGpaXDvcUyUPQi7xFR1FXHFyrioFb5fgJbbam/ANDYQ/WrMYuQIngHlGhpEsIj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(36756003)(86362001)(2906002)(5660300002)(316002)(6486002)(66556008)(26005)(478600001)(186003)(66476007)(8676002)(16526019)(6506007)(8936002)(1076003)(52116002)(66946007)(2616005)(956004)(83380400001)(69590400007)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +a9VkSD+hlaCe8h0eg5Oz8aTBOo4Hk8lAKKg8g+3oCySqCQd9wP4IDasGOuIXwrQcNavztU92oAovLbee6lCemqGsTSlmf6bo8RRIF46J/3eP7vCyo2Kc1wFyOtvamK7mBiqLANHW4RbLwYl927EzY8WbMmHXSc4jSZS40IhPnsM009lniN5fhF1kY/GGJ9AfI6P6x1x0D6UPZN+DPulO9iCPpwyv/Lwo/1Sl89yBvEBcRGRXu/6VxYByp+WtsuMeXLTg/AnJ4y4QcEkPQWfwc+FSQuzPzn/Daa9Zj6NJg5OOpzkjxIbcoF/KMg9TP44fPyx2+xhSRcHGNbUyWVehxs5TWjoIiRcBmjuwsxQgrWYQDroLaxhKN+9xxaFynaUNh5pqJJMv1oyLF4XA4GaNjEdJ+zPhqWuPB38oas7guVndqwGz5T5naZXjqeK6OdI05iSPPeKSd8/xnw7eXgA3rwPE7psRbCtsayw/V8Kutg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7dea65-9b83-47bb-b408-08d82c566e83
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 02:41:40.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLEKjaT3suerkxi2SI7TnpcPn6IJG8eN6auflisgfNTh8JOgN3TBpxHRgwPH/iFaJOWUPrknTGd0tcrBZadctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5884
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
 drivers/irqchip/irq-imx-intmux.c | 70 +++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index c27577c81126..5971603cc607 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -53,6 +53,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 #define CHANIER(n)	(0x10 + (0x40 * n))
 #define CHANIPR(n)	(0x20 + (0x40 * n))
@@ -60,6 +61,7 @@
 #define CHAN_MAX_NUM		0x8
 
 struct intmux_irqchip_data {
+	struct irq_chip		chip;
 	int			chanidx;
 	int			irq;
 	struct irq_domain	*domain;
@@ -70,6 +72,7 @@ struct intmux_data {
 	void __iomem			*regs;
 	struct clk			*ipg_clk;
 	int				channum;
+	u32				*saved_reg;
 	struct intmux_irqchip_data	irqchip_data[];
 };
 
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
@@ -232,6 +237,19 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
 
+	if (IS_ENABLED(CONFIG_PM)) {
+		/* save CHANIER register */
+		data->saved_reg = devm_kzalloc(&pdev->dev,
+					       sizeof(unsigned int) * channum,
+					       GFP_KERNEL);
+		if (!data->saved_reg)
+			return -ENOMEM;
+	}
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = clk_prepare_enable(data->ipg_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
@@ -239,6 +257,8 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chip = imx_intmux_irq_chip;
+		data->irqchip_data[i].chip.parent_device = &pdev->dev;
 		data->irqchip_data[i].chanidx = i;
 
 		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
@@ -267,6 +287,12 @@ static int imx_intmux_probe(struct platform_device *pdev)
 
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
@@ -288,11 +314,50 @@ static int imx_intmux_remove(struct platform_device *pdev)
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
+	int i;
+
+	for (i = 0; i < data->channum; i++)
+		data->saved_reg[i] = readl_relaxed(data->regs + CHANIER(i));
+
 	clk_disable_unprepare(data->ipg_clk);
 
 	return 0;
 }
 
+static int imx_intmux_runtime_resume(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < data->channum; i++)
+		writel_relaxed(data->saved_reg[i], data->regs + CHANIER(i));
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
@@ -302,6 +367,7 @@ static struct platform_driver imx_intmux_driver = {
 	.driver = {
 		.name = "imx-intmux",
 		.of_match_table = imx_intmux_id,
+		.pm = &imx_intmux_pm_ops,
 	},
 	.probe = imx_intmux_probe,
 	.remove = imx_intmux_remove,
-- 
2.17.1

