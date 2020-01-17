Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09183C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2872082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z78oRWjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAQGKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:10:17 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:51598
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727691AbgAQGKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:10:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWSWLhbRC2gL+PpiR1bNAVInib7QP8ErigSN3CU+IBaeLRqTBL8OCvz7ed1AdTBnXaTkvPMT9K84TTAsNT4GsEXMtWECKdtxtWDzFhanp0Fhu2yOCWTgD5tJTd4RB2N9B/qD4tnl0UTO6ec59Lrc2KFfjRKsYL5vnvwZukq3nKYg6BSfBPFmJo2vHiW6l9AhbDhRAZgGV2yJPn96OoHhQ30YM2Vx/93qiESPcl8wW6Ej2OL9Hyr7EMH33l7QpNfQs2BpyVm0xjL2IdbCPSzY0laxfNHbGNyqf2ztVr1w/9a3J9DJ2sgvnagq9iUbejFm3TWH4yzFqkoIkdjFMYrrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlY53Yn/Ho4ilcrQ8kBH8ZVk4goSizXwLeZVRx56HmY=;
 b=f18go0HcnXZIgtEJm4COqD9C35SSoCiFnU53CBJNOE+34mrXd5h4kpLqlEpVEeeY01hoEhksjEkkI36LpH7UOu4ZDc0YN0c0Ev6rVOhrXFUFimTwoHfzyqT1TGc/6B/Fmsy9oprZmBi9ZXNQ2fNnuO+WyF+14YxQIsDNRM+YJNYHFXtwWwfdc1O2+9GA4uIBbTDzi4OAFGm3fMUTdZbnUrFiR+ABSU4HRS5OWWERYD78MhDMHz2wXhS5704MZGOMPyDta4Z24LrH4MtGmfUC+rYEOZMW/ErTOKiH1Qyes/+55G4qDwEbFF2fzOYa789Pt4n0ZaSLlkuNH0I885C7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlY53Yn/Ho4ilcrQ8kBH8ZVk4goSizXwLeZVRx56HmY=;
 b=Z78oRWjZ2WcrkzkRa1SZ6uaPKoXG1Ce7x8KZ15zW0HOMUy85DL+1S68p0Vbv2Lhlo/OIIzuoxCl4AyhPKXq22LNyvGdENYY0rRZT33RjVB+2O6Qt5nVwGmBMyYdBnr1t/QXFvZmreutCLuoVBumccCZGyjWCTFDqlp+D5xGxWlQ=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4841.eurprd04.prod.outlook.com (20.176.232.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 06:10:10 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 06:10:10 +0000
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0102.apcprd01.prod.exchangelabs.com (2603:1096:3:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 06:10:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: [PATCH V6 2/2] drivers/irqchip: add NXP INTMUX interrupt multiplexer
 support
Thread-Topic: [PATCH V6 2/2] drivers/irqchip: add NXP INTMUX interrupt
 multiplexer support
Thread-Index: AQHVzPzFrIfh9Ea/kUOGD3qp7dRI6Q==
Date:   Fri, 17 Jan 2020 06:10:10 +0000
Message-ID: <20200117060653.27485-3-qiangqing.zhang@nxp.com>
References: <20200117060653.27485-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20200117060653.27485-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::28) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:38::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb8294ba-a0e8-465f-f723-08d79b13e822
x-ms-traffictypediagnostic: DB7PR04MB4841:|DB7PR04MB4841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB48418D66B9211C59611E91F7E6310@DB7PR04MB4841.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(189003)(1076003)(5660300002)(66446008)(6506007)(8676002)(478600001)(81156014)(81166006)(6512007)(6666004)(16526019)(186003)(2906002)(36756003)(86362001)(26005)(316002)(110136005)(54906003)(8936002)(6486002)(66946007)(71200400001)(64756008)(4326008)(7416002)(66556008)(66476007)(69590400006)(2616005)(956004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4841;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WIVi3rSepEIMWEmpu5MX9syIKLYh8z41I/k2o68WC6C6emgcc8Nu9kmtfmDHMerG6Mcjr5VojiNmyp1R9vuZSc5K/jc6mvXpgNlnEgBgO0NKQHJa3mrvTJ95iffXVK3R3/21m1mQQg6SHdFCscZJ2XUwUNA7CGSCJpH3R3RKMGPzwaykrvclsJxx2peRUxV2OiRuWo5i70kyri96TiGOuRf6bZMaFI2QcY615iBCj580UuOpZONxb9x0cvNT8NHbfc2FJm8jPTV5use33BDba81NTm3Q/axNmxMTmQL5EcE8MH+vwPVDqD84abNnGR9Ov0GtS/Aq0T8zENaz8TWCqvQhIt/B5se8ZOxqDofJtwgIwyZUzA42EV6jIbmgHn7ka8jfLNd+Kd/1gYuLv1TfD6KL3zY79CORe2DQO96gJOcHQ45LF2SzmmJs3tLFVsylPnPdXmobt+ESuM3mQ6Z79sgx+FhXw+Pl4Vo3vaGo0wIUOe7JgdgzeXdOhw8/E5qJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8294ba-a0e8-465f-f723-08d79b13e822
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 06:10:10.0682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeggG3ata/PUNYiLoaK+jSqTbrmPr1SE8UQf9LyZSs9mpbcXyw3qBkM7ETT6ffEdGCqitgRb1NuwVmlDa4wEBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Interrupt Multiplexer (INTMUX) expands the number of peripherals
that can interrupt the core:
* The INTMUX has 8 channels that are assigned to 8 NVIC interrupt slots.
* Each INTMUX channel can receive up to 32 interrupt sources and has 1
  interrupt output.
* The INTMUX routes the interrupt sources to the interrupt outputs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/Kconfig          |   6 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-intmux.c | 309 +++++++++++++++++++++++++++++++
 3 files changed, 316 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ba152954324b..7e2b1e9d0b45 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -457,6 +457,12 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
=20
+config IMX_INTMUX
+	def_bool y if ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  Support for the i.MX INTMUX interrupt multiplexer.
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..af976a79d1fb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
+obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
 obj-$(CONFIG_MADERA_IRQ)		+=3D irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=3D irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-int=
mux.c
new file mode 100644
index 000000000000..c27577c81126
--- /dev/null
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 NXP
+
+/*                     INTMUX Block Diagram
+ *
+ *                               ________________
+ * interrupt source #  0  +---->|                |
+ *                        |     |                |
+ * interrupt source #  1  +++-->|                |
+ *            ...         | |   |   channel # 0  |--------->interrupt out =
# 0
+ *            ...         | |   |                |
+ *            ...         | |   |                |
+ * interrupt source # X-1 +++-->|________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                        | | | |                |
+ *                        | +-->|                |
+ *                        | | | |   channel # 1  |--------->interrupt out =
# 1
+ *                        | | +>|                |
+ *                        | | | |                |
+ *                        | | | |________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |       ...
+ *                        | | |       ...
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                          | | |                |
+ *                          +-->|                |
+ *                            | |   channel # N  |--------->interrupt out =
# N
+ *                            +>|                |
+ *                              |                |
+ *                              |________________|
+ *
+ *
+ * N: Interrupt Channel Instance Number (N=3D7)
+ * X: Interrupt Source Number for each channel (X=3D32)
+ *
+ * The INTMUX interrupt multiplexer has 8 channels, each channel receives =
32
+ * interrupt sources and generates 1 interrupt output.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define CHANIER(n)	(0x10 + (0x40 * n))
+#define CHANIPR(n)	(0x20 + (0x40 * n))
+
+#define CHAN_MAX_NUM		0x8
+
+struct intmux_irqchip_data {
+	int			chanidx;
+	int			irq;
+	struct irq_domain	*domain;
+};
+
+struct intmux_data {
+	raw_spinlock_t			lock;
+	void __iomem			*regs;
+	struct clk			*ipg_clk;
+	int				channum;
+	struct intmux_irqchip_data	irqchip_data[];
+};
+
+static void imx_intmux_irq_mask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data =3D d->chip_data;
+	int idx =3D irqchip_data->chanidx;
+	struct intmux_data *data =3D container_of(irqchip_data, struct intmux_dat=
a,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg =3D data->regs + CHANIER(idx);
+	val =3D readl_relaxed(reg);
+	/* disable the interrupt source of this channel */
+	val &=3D ~BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void imx_intmux_irq_unmask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data =3D d->chip_data;
+	int idx =3D irqchip_data->chanidx;
+	struct intmux_data *data =3D container_of(irqchip_data, struct intmux_dat=
a,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg =3D data->regs + CHANIER(idx);
+	val =3D readl_relaxed(reg);
+	/* enable the interrupt source of this channel */
+	val |=3D BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static struct irq_chip imx_intmux_irq_chip =3D {
+	.name		=3D "intmux",
+	.irq_mask	=3D imx_intmux_irq_mask,
+	.irq_unmask	=3D imx_intmux_irq_unmask,
+};
+
+static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, h->host_data);
+	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static int imx_intmux_irq_xlate(struct irq_domain *d, struct device_node *=
node,
+				const u32 *intspec, unsigned int intsize,
+				unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct intmux_irqchip_data *irqchip_data =3D d->host_data;
+	int idx =3D irqchip_data->chanidx;
+	struct intmux_data *data =3D container_of(irqchip_data, struct intmux_dat=
a,
+						irqchip_data[idx]);
+
+	/*
+	 * two cells needed in interrupt specifier:
+	 * the 1st cell: hw interrupt number
+	 * the 2nd cell: channel index
+	 */
+	if (WARN_ON(intsize !=3D 2))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[1] >=3D data->channum))
+		return -EINVAL;
+
+	*out_hwirq =3D intspec[0];
+	*out_type =3D IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static int imx_intmux_irq_select(struct irq_domain *d, struct irq_fwspec *=
fwspec,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct intmux_irqchip_data *irqchip_data =3D d->host_data;
+
+	/* Not for us */
+	if (fwspec->fwnode !=3D d->fwnode)
+		return false;
+
+	return irqchip_data->chanidx =3D=3D fwspec->param[1];
+}
+
+static const struct irq_domain_ops imx_intmux_domain_ops =3D {
+	.map		=3D imx_intmux_irq_map,
+	.xlate		=3D imx_intmux_irq_xlate,
+	.select		=3D imx_intmux_irq_select,
+};
+
+static void imx_intmux_irq_handler(struct irq_desc *desc)
+{
+	struct intmux_irqchip_data *irqchip_data =3D irq_desc_get_handler_data(de=
sc);
+	int idx =3D irqchip_data->chanidx;
+	struct intmux_data *data =3D container_of(irqchip_data, struct intmux_dat=
a,
+						irqchip_data[idx]);
+	unsigned long irqstat;
+	int pos, virq;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	/* read the interrupt source pending status of this channel */
+	irqstat =3D readl_relaxed(data->regs + CHANIPR(idx));
+
+	for_each_set_bit(pos, &irqstat, 32) {
+		virq =3D irq_find_mapping(irqchip_data->domain, pos);
+		if (virq)
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_intmux_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct irq_domain *domain;
+	struct intmux_data *data;
+	int channum;
+	int i, ret;
+
+	channum =3D platform_irq_count(pdev);
+	if (channum =3D=3D -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (channum > CHAN_MAX_NUM) {
+		dev_err(&pdev->dev, "supports up to %d multiplex channels\n",
+			CHAN_MAX_NUM);
+		return -EINVAL;
+	}
+
+	data =3D devm_kzalloc(&pdev->dev, sizeof(*data) +
+			    channum * sizeof(data->irqchip_data[0]), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize reg\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(data->ipg_clk)) {
+		ret =3D PTR_ERR(data->ipg_clk);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	data->channum =3D channum;
+	raw_spin_lock_init(&data->lock);
+
+	ret =3D clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i =3D 0; i < channum; i++) {
+		data->irqchip_data[i].chanidx =3D i;
+
+		data->irqchip_data[i].irq =3D irq_of_parse_and_map(np, i);
+		if (data->irqchip_data[i].irq <=3D 0) {
+			ret =3D -EINVAL;
+			dev_err(&pdev->dev, "failed to get irq\n");
+			goto out;
+		}
+
+		domain =3D irq_domain_add_linear(np, 32, &imx_intmux_domain_ops,
+					       &data->irqchip_data[i]);
+		if (!domain) {
+			ret =3D -ENOMEM;
+			dev_err(&pdev->dev, "failed to create IRQ domain\n");
+			goto out;
+		}
+		data->irqchip_data[i].domain =3D domain;
+
+		/* disable all interrupt sources of this channel firstly */
+		writel_relaxed(0, data->regs + CHANIER(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 imx_intmux_irq_handler,
+						 &data->irqchip_data[i]);
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+out:
+	clk_disable_unprepare(data->ipg_clk);
+	return ret;
+}
+
+static int imx_intmux_remove(struct platform_device *pdev)
+{
+	struct intmux_data *data =3D platform_get_drvdata(pdev);
+	int i;
+
+	for (i =3D 0; i < data->channum; i++) {
+		/* disable all interrupt sources of this channel */
+		writel_relaxed(0, data->regs + CHANIER(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 NULL, NULL);
+
+		irq_domain_remove(data->irqchip_data[i].domain);
+	}
+
+	clk_disable_unprepare(data->ipg_clk);
+
+	return 0;
+}
+
+static const struct of_device_id imx_intmux_id[] =3D {
+	{ .compatible =3D "fsl,imx-intmux", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver imx_intmux_driver =3D {
+	.driver =3D {
+		.name =3D "imx-intmux",
+		.of_match_table =3D imx_intmux_id,
+	},
+	.probe =3D imx_intmux_probe,
+	.remove =3D imx_intmux_remove,
+};
+builtin_platform_driver(imx_intmux_driver);
--=20
2.17.1

