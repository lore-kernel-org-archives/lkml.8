Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691BC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085DF20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CF3f7mNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGPLbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:31:43 -0400
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:44462
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728164AbgGPLbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMDlLgyOtIMwV1AyUv8z0I4XK3Mp7vtAbX/drg/pwsmkWYohjaXmnJFhW8ufLMP+ur3klzSFMNUvAhBq9nEfb/FDtS6oQWTsuUn+/6NJeDbK4vyTlpd5dzBm33KSVzAnsc4ZMdx1AQLqXRh3pDXlMdOxdpyOxi8TQeWdZW/z9SbtKrVA08WP8wx/pkqmA+xedr1+r6CKjqCfKDydq3AKZt4VME2z1rqCAaoyLdUUub+3QiG2Jb6MNzMWL7T/MvsvupUyjP+P9/1/djkfwe00GCJe4BIp3B/iEvy0H5QP3LWERk520UZ6BIDWUCopxm8f0D0mzDA3UsaTLD0QlKJzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6+xCPCH7VIAfySx128hE+hLSsBGIXqoE95mqOdD7mo=;
 b=T+VH51WpsaatmM7TCaBm/FaRerjTGnIbnDbnAXyBhGy1nvnVN+1YuCzRumkcIPULoMCilp63nxaiX/KUzeAPigbKPDffHbl+zuJ5hm5M2H365KldhIjWPy5+F+iBWlT4oMCbzgfWD/AXUEtrD+enoePaqAKzXBcfmmBkNqb9DkdCc2l+s8qj0QMKUu0Z6bqY0ahy0v6ZvU4J93JqEw3PyeBE7ROsPqiIG4xbl539FCMAeb3tuJ2Ts5mGzwG74OfyubmA3gZ3OgOUk120AHhtw06xOfP73bAc3vyAZH1Kl/jTLJ7Q7PQz29sIaOKtYnqWpu2wTq8Q6LzoLBfLF3gDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6+xCPCH7VIAfySx128hE+hLSsBGIXqoE95mqOdD7mo=;
 b=CF3f7mNubbvLOWihYkQ10udaOCuEI20haURZfv8KVGzzxjPBznGeZ1ClcYrg7Ecz3emc2YLgOWoAZMkF28X61L+GWY47CsmNnUhceiW9NeRuVXRIiVYukBc04Rdy3zkZz8k/PLChdaGzCok0AsNRi6KHOgWRwlWGjjBsyObhcn0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3708.eurprd04.prod.outlook.com (2603:10a6:8:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 11:31:38 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 11:31:38 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or
Subject: [PATCH 2/2] irqchip: imx-intmux: add runtime PM support
Date:   Fri, 17 Jul 2020 03:32:44 +0800
Message-Id: <20200716193244.31090-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
References: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0223.apcprd06.prod.outlook.com (2603:1096:4:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 11:31:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16c2a1f8-3aa3-4cab-eb19-08d8297bcdb3
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3708D5A59D88235D61AD85E6E67F0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecoRF3tSCaBfNCGhOLU0E0hHkJGdrq4sWqhX/C1ZBXQPkfwn3E3TPWW9r4ATPRSFLoaDjDv/YBWIMdb8BgEy8D7+dhYR2olFZhdiGmguZvEhKUOVkiTyaDLpTav14Gx4UgzpXTWY4jBNZ5WpDGPis7zNBTqQEHvaZpZy+6pUgfNSDg6ITCozn136gFG5E2yWlVhIdTx9GzsEBW8nSMXs6xAuQSQmUWLH11pnr7xP/4/GBoR7rwTEWu1p6DYU6eryFv8O6TJ4I5VDUk9T91xfOXy42lgr/ftRbE5Cgfp0+SYVmOgg6wrMzAjKSESyxI344lF9cexffHNBrVuYkbDFtcQO8iHT7SVc2aywPPaN4IHZYZIBydV1D/eivigzOTKk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(1076003)(8936002)(8676002)(6512007)(4326008)(6666004)(66476007)(52116002)(66556008)(66946007)(956004)(2616005)(5660300002)(83380400001)(6506007)(478600001)(6486002)(2906002)(36756003)(86362001)(316002)(186003)(26005)(69590400007)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dowApshF/wuMoGRtnGBF7Qqey01BlCINRhdEdKcRv3UNY1e30uN8mY/zrhqvygeukwqaW7MdoyrpKmawkczSpWZ8N7fMa50OXWPg18w68wA6wzslAG0ogxFnbe1LDGVP1Xr2AQE2mORMStUYFu1D0bO9MS5I3m0NXD0cqTOzboyj8mflth569DCCvZbA6QaJsj9Q3jOSR4BmZAYS80lLygL45LUS+XN250Bsye4IMxLFcOF0FnhN7Rt6LB9biFEwrec9UrPM0V/kfOr25pOnri+NkYwoRnrhnKY/nwjcq+FDwnGNy1cJspTOVlS04HR/XnlRvFjyn2m2yptjRYgWVWTgLCKx0V6/MEL1jrb/6NxSLd3XR5UQRqFq+NPFX45IWrdoISv2BBImdCWWXBqMt6qoKnHo3CzB0gwuxUxFTBv4FoCXetlfzf0kiC6v2DcIjhPAi9SE6piyo1w5v5RHPRftVhnEUd4oyGgHdbE/tx0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c2a1f8-3aa3-4cab-eb19-08d8297bcdb3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 11:31:38.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlWVElG1k0MGJOUK6OxF0wv7FbyWdI5CAXPDu0cY734b+LXYsNs60mKwGd859hgucgbE4ohkPj0S67o2NFtW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support for intmux interrupt controller.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/irq-imx-intmux.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 6095f76c4f0d..a631815c7bb4 100644
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
@@ -123,8 +125,10 @@ static struct irq_chip imx_intmux_irq_chip = {
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
@@ -244,6 +248,10 @@ static int imx_intmux_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = clk_prepare_enable(data->ipg_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
@@ -251,6 +259,8 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chip = imx_intmux_irq_chip;
+		data->irqchip_data[i].chip.parent_device = &pdev->dev;
 		data->irqchip_data[i].chanidx = i;
 
 		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
@@ -279,6 +289,12 @@ static int imx_intmux_probe(struct platform_device *pdev)
 
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
@@ -300,7 +316,7 @@ static int imx_intmux_remove(struct platform_device *pdev)
 		irq_domain_remove(data->irqchip_data[i].domain);
 	}
 
-	clk_disable_unprepare(data->ipg_clk);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
@@ -322,7 +338,7 @@ static void imx_intmux_restore_regs(struct intmux_data *data)
 		writel_relaxed(data->saved_reg[i], data->regs + CHANIER(i));
 }
 
-static int imx_intmux_suspend(struct device *dev)
+static int imx_intmux_runtime_suspend(struct device *dev)
 {
 	struct intmux_data *data = dev_get_drvdata(dev);
 
@@ -332,7 +348,7 @@ static int imx_intmux_suspend(struct device *dev)
 	return 0;
 }
 
-static int imx_intmux_resume(struct device *dev)
+static int imx_intmux_runtime_resume(struct device *dev)
 {
 	struct intmux_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -349,7 +365,10 @@ static int imx_intmux_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops imx_intmux_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_intmux_suspend, imx_intmux_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx_intmux_runtime_suspend,
+			   imx_intmux_runtime_resume, NULL)
 };
 
 static const struct of_device_id imx_intmux_id[] = {
-- 
2.17.1

