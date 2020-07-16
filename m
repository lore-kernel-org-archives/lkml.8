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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390EC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC820775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PG3h2s1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgGPLbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:31:40 -0400
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:44462
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbgGPLbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:31:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk+XxjN63P+RQLH7HBsjwPNTOf9aR836TD+SufN7w3sW67XRdB32yVrZKvTjYBceU0vofL57tHAjucjHwe+JPmgrGYn+aPd/9vb4wRMW6M7QiO/nzq1oIaJ0aiy0p9xRpav4TYzaG8ZpC14Q2AdPsEHPRIHq5K0lgDTen8z3hLu6Js2cdB1tWwZv2ejZ/lB586gYcCzUV09ok/7h1X6+n0kuyppIpHGY/od3G1bMHDOTsfQV2QfOL0ZYaLQr9ZwWzfebZe1xY7ZY+Pg9DY76xA75KB7DeZKyEDRVdfpYI0woKL8C37ahfUpqsY559jHZRp4XzEpl58AyJMKsZh8WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXSeQi4PIdzMVR3tSfPhVtK7bVwzw1jcU/FbuCO1qh4=;
 b=dhFFftFHLN45jX02YKLKL7VJLADrnGHNxd32smc7A9mA16pjIoUyMb891LawYJJx5QaJXq+atWcbrxbNfda5waZCwW05I8EpJnvM2LfH0EUysdzG2XNvgtpuqUYGCV7ol/Ocwvgs1yAq7RN3ZrU40dEy7QUwYnIM9bq7jrF9QEW7kg+tWcgt1Jz/1NWKos06Ivoci1+oy49c8PpN7cf9P+noKa3smWO0iaDivyPKd7HUjNKcHYOOfm+W+CAXXlwSjrD4QKiJWeMaFvu8R1rzqkAOvYInfH41hiUG1JivFCAMSKecPImLz0mLFH+sFfqJNx/+iia3r/XOL8Q2KLr4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXSeQi4PIdzMVR3tSfPhVtK7bVwzw1jcU/FbuCO1qh4=;
 b=PG3h2s1T/bXNIKcVU27bRuQujz/ZrjVxoPlJ5+/5+B0iqXUgW9Sdk+JwMLmHgLCHTc5sEEjXFFR4Xt0v/NwaZRyJeKf4cX9pZj06Rdn5LndSYV9sfWacWbC1i1KEA5NKyIqq+civjUcS21rztkuXuPBBZQME10+izxLGUIrDlno=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB3PR0402MB3708.eurprd04.prod.outlook.com (2603:10a6:8:d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 11:31:35 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7564:54a2:a35e:1066%9]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 11:31:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or
Subject: [PATCH 1/2] irqchip: imx-intmux: add system PM support
Date:   Fri, 17 Jul 2020 03:32:43 +0800
Message-Id: <20200716193244.31090-2-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
References: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0223.apcprd06.prod.outlook.com (2603:1096:4:68::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 11:31:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aee36b4f-7d7b-40a2-910a-08d8297bcba1
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3708AC0C530C3F47AD4C618EE67F0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8jWrN+IHbjSN/MRa65VeO7jNyASkYpBczW4U+BowgFMwcYc2hmYiLxF98PBSPudyuiU8a+2vGVb5qFD7gwjFfNlour3TJzYm/zy4vzbHOFgj+oTjIx/40IAfdNRZhmw1m57ZhydhWIkovhsYkDfnPXAhBuMoTp21hmV9DooGlY4OTR2Du3sUJxsMxr5GbFo4DOlHasM6/4W9+BbDhL8EzIUsgRbK1GIlLg/TCn15oWCnWaBSwYpmATfd3Sinnmrfls3oy8HbHUl3AdsMX1/m9IsbzTQWQquRSAmuu98qi6/lO/w2rFpeqb4NFIWota0UpZoADjacMtAv7HZWNwOz3SpGnkR6vyi6VHkTHk9bPdKBgFPdfcxLbcuKqBJdK6X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(1076003)(8936002)(8676002)(6512007)(4326008)(6666004)(66476007)(52116002)(66556008)(66946007)(956004)(2616005)(5660300002)(83380400001)(6506007)(478600001)(6486002)(2906002)(36756003)(86362001)(316002)(186003)(26005)(69590400007)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0c4nU1pWCudBKWVH/FwUmXQrxqE7YPw1YUGLR75r3s8UZ4vruHDD37Ent5ikZbGL/edxGDKIcav/jSp/sNSfky+c1B9RwmTBTV4RSjFhTTytzs/epMtb1u3uU5ayXCHyTs9C6eEbwHUaomohh67sVf2rdt70bxBgDeVw2zGys3JuiFC1Q2+t/q4OSmmxD8BOBaeE/o9yGo4ZKhhdsNQ7YeLDRZ1utbCmebB9FtSlyYcSWn1Ifoe9LQ4SrUEKwnOvAvMReCBCYet02h3eliqIv46mJQTk6hfQDN/9e7YdTSwo9nXHWJZa/TSPHhlcdEDkQoiDaYblGbPp9MZJZaa/iW1BwB1H6q95I+ckVZbNUXmAdJKAkjMQ0oUTZgp7aN69Zk02wPDCyAo9IKLlXJkjAHj9kytjWcTN39oY6/+lKr3HvrXzkUzZXdIM1pXn+ur/PkmwSftrAval3vBVBOMPtsjE0iBH7o8g6syKCvnWpQs=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee36b4f-7d7b-40a2-910a-08d8297bcba1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 11:31:34.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c1TEeQ51RUPhtwo1qU6paOn6Vd+g3zNb6MNG2/+gqaqgBDCpzJlLTan0lZZQSN57mHKpG+hvZMO4p0CI0wvPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system PM support for intmux interrupt controller.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/irq-imx-intmux.c | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index c27577c81126..6095f76c4f0d 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -70,6 +70,9 @@ struct intmux_data {
 	void __iomem			*regs;
 	struct clk			*ipg_clk;
 	int				channum;
+#ifdef CONFIG_PM
+	unsigned int			*saved_reg;
+#endif
 	struct intmux_irqchip_data	irqchip_data[];
 };
 
@@ -232,6 +235,15 @@ static int imx_intmux_probe(struct platform_device *pdev)
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
 	ret = clk_prepare_enable(data->ipg_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
@@ -293,6 +305,53 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static void imx_intmux_save_regs(struct intmux_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->channum; i++)
+		data->saved_reg[i] = readl_relaxed(data->regs + CHANIER(i));
+}
+
+static void imx_intmux_restore_regs(struct intmux_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->channum; i++)
+		writel_relaxed(data->saved_reg[i], data->regs + CHANIER(i));
+}
+
+static int imx_intmux_suspend(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+
+	imx_intmux_save_regs(data);
+	clk_disable_unprepare(data->ipg_clk);
+
+	return 0;
+}
+
+static int imx_intmux_resume(struct device *dev)
+{
+	struct intmux_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+	imx_intmux_restore_regs(data);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops imx_intmux_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_intmux_suspend, imx_intmux_resume)
+};
+
 static const struct of_device_id imx_intmux_id[] = {
 	{ .compatible = "fsl,imx-intmux", },
 	{ /* sentinel */ },
-- 
2.17.1

