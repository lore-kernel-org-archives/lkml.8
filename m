Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755BEC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5D21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I6IQw5US"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgBEOLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:11:21 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:5536
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgBEOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:11:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqTit+m7BxHmkwTAJjg7wjDxE9MgoGvRP92CCwT63fvs5fISTJpk3gl7giO6+XBsW3SKLuslm8iJBiRhvUQme7CEdEY5+Lw4KnIX/S507ndf29Yi7fHZaKUBRaMJgzfpAeEVHkYBr5UPRxmAGSA6M5CSm/TV9UPcKGiIwPS+49hfr+rMpITFlIxeBf55+4qvtAoIdLv6PYT+YkZrfQtiYU9v1QXWJ5dgYxNpycbm0YLSTKx/fwAKcnmDwSldStaGgsDHC5GbpFYpb5EDzhvqBsqMCUbmte/DW/dTlCBV4B8wCB7QvhKKcikaJd8S12nOPuIKvNLxZD6jvMFq5dc5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrIzBNCSY7ScFrDdEzAiu2xTBadRkGUxhpjo3jg5Op4=;
 b=epEzlAnBKbO4tTiTQsPdYv7tmcRVt00hFxqWPvXSdoCyaoSFSFDQNhw2Ruwarwiqd6p8f5Ycn1DXB+4W/GckeG6Yxp/wOZV6StzP8e/gvZZCRflPRGj3HNDbT6MxgfMMOP11PssIrTW31yU2tAp8XmLOMSUl1uK6aWBxYh6xz1DfHm2E1ARSa+zcQUcEsOoUYz6V4f0nRxksANqdSHX94V+WpVG7owkyFaHH7ZmBtgtAhjvqAM06JQDBIVto59GKk1smWMwEBzFNK+BKYOiyft6S8xlbyiJisRD7i32wGuaElZAa9Nnlz9lQTw3xEc5rqKIl1+ZO9y2aewN8RdwDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linutronix.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrIzBNCSY7ScFrDdEzAiu2xTBadRkGUxhpjo3jg5Op4=;
 b=I6IQw5US/swdvGztRPVKDhwhZQGXn9/erBS2V7bzOw5CD2DoCzjJ8sp6EjeTqB/hd3yXukVOToMRhmmTQxleR/OdDw9yGaVq97k02ooDqS1a4vhnaM7iWV0yorNlLRuAf9LC1+ru6b0v/PyZwts/Thlyf2OzIrignKfh3J5n+CQ=
Received: from BN7PR02CA0024.namprd02.prod.outlook.com (2603:10b6:408:20::37)
 by DM6PR02MB6074.namprd02.prod.outlook.com (2603:10b6:5:1fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32; Wed, 5 Feb
 2020 14:07:42 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN7PR02CA0024.outlook.office365.com
 (2603:10b6:408:20::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 5 Feb 2020 14:07:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Wed, 5 Feb 2020 14:07:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1izLLA-0002Ic-HR; Wed, 05 Feb 2020 06:07:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1izLL5-0002Hk-Bt; Wed, 05 Feb 2020 06:07:35 -0800
Received: from [10.140.6.23] (helo=xhdmubinusm40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1izLL1-0002Gr-Cx; Wed, 05 Feb 2020 06:07:31 -0800
From:   Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, siva.durga.paladugu@xilinx.com,
        anirudha.sarangi@xilinx.com,
        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
Subject: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Date:   Wed,  5 Feb 2020 19:35:35 +0530
Message-Id: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(316002)(5660300002)(2616005)(4326008)(9786002)(81166006)(2906002)(81156014)(36756003)(8936002)(7696005)(8676002)(107886003)(356004)(186003)(426003)(336012)(478600001)(70206006)(26005)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6074;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b89cba6-7d44-41a0-fc21-08d7aa44c3dd
X-MS-TrafficTypeDiagnostic: DM6PR02MB6074:
X-Microsoft-Antispam-PRVS: <DM6PR02MB607458B2D95726817FE63F94A1020@DM6PR02MB6074.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0304E36CA3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KZgA/YIhZOXKw7FiKOrDEugJ+xZMIESqo9UvFe7Bm2zGg3GojrElhxVzB2zDWYq0V8CwpRif7hN5H9YY1uUtQ79NWlmV9Wo39NnjY2FwauSTZuX2LzBq0131i2kELQ5I/F6Zm2q/MMPpiv7HEpOfuvc9+87gBUZRqjFY6jpKFoencij7SDK86CShbjtritrHqOtYGTd5nbqVL/0HaagA/o9GLmkl/+F9fj/CdDvjlbhE6fFYUAZ74o2v9H1TZ8GZb3OPPHllp5lciHhX60lEu6V5zwVa8KxOAhk53+0Kaq8Epr3R1ovimBSr/6mDVesL2rnF2js3qEfg+clKtGs1BgeSVI1aFQ69Dcoj7Yc/xG09q1zihPBLtezwiWD2a6z6DPIlbcxFD6JGp1l2DnmmLVsq7xjTsEkkcfdlnbNOYYe0SMrWgPtf68DV+oBPmhp
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:07:41.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b89cba6-7d44-41a0-fc21-08d7aa44c3dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>

This patch adds support for multiple instances of
xilinx interrupt controller. Below configurations are
supported by driver,

- peripheral->xilinx-intc->xilinx-intc->gic
- peripheral->xilinx-intc->xilinx-intc

Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
---
Changes for v2:
        - Removed write_fn/read_fn hooks, used xintc_write/
          xintc_read directly
        - Moved primary_intc declaration after xintc_irq_chip
---
 drivers/irqchip/irq-xilinx-intc.c | 121 +++++++++++++++++++++++-----------=
----
 1 file changed, 73 insertions(+), 48 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx=
-intc.c
index e3043de..14cb630 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -38,29 +38,32 @@ struct xintc_irq_chip {
        void            __iomem *base;
        struct          irq_domain *root_domain;
        u32             intr_mask;
+       struct                  irq_chip *intc_dev;
+       u32                             nr_irq;
 };

-static struct xintc_irq_chip *xintc_irqc;
+static struct xintc_irq_chip *primary_intc;

-static void xintc_write(int reg, u32 data)
+static void xintc_write(void __iomem *addr, u32 data)
 {
        if (static_branch_unlikely(&xintc_is_be))
-               iowrite32be(data, xintc_irqc->base + reg);
+               iowrite32be(data, addr);
        else
-               iowrite32(data, xintc_irqc->base + reg);
+               iowrite32(data, addr);
 }

-static unsigned int xintc_read(int reg)
+static unsigned int xintc_read(void __iomem *addr)
 {
        if (static_branch_unlikely(&xintc_is_be))
-               return ioread32be(xintc_irqc->base + reg);
+               return ioread32be(addr);
        else
-               return ioread32(xintc_irqc->base + reg);
+               return ioread32(addr);
 }

 static void intc_enable_or_unmask(struct irq_data *d)
 {
        unsigned long mask =3D 1 << d->hwirq;
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;

        pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);

@@ -69,47 +72,57 @@ static void intc_enable_or_unmask(struct irq_data *d)
         * acks the irq before calling the interrupt handler
         */
        if (irqd_is_level_type(d))
-               xintc_write(IAR, mask);
+               xintc_write(local_intc->base + IAR, mask);

-       xintc_write(SIE, mask);
+       xintc_write(local_intc->base + SIE, mask);
 }

 static void intc_disable_or_mask(struct irq_data *d)
 {
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;
+
        pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
-       xintc_write(CIE, 1 << d->hwirq);
+       xintc_write(local_intc->base + CIE, 1 << d->hwirq);
 }

 static void intc_ack(struct irq_data *d)
 {
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;
+
        pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
-       xintc_write(IAR, 1 << d->hwirq);
+       xintc_write(local_intc->base + IAR, 1 << d->hwirq);
 }

 static void intc_mask_ack(struct irq_data *d)
 {
        unsigned long mask =3D 1 << d->hwirq;
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;

        pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
-       xintc_write(CIE, mask);
-       xintc_write(IAR, mask);
+       xintc_write(local_intc->base + CIE, mask);
+       xintc_write(local_intc->base + IAR, mask);
 }

-static struct irq_chip intc_dev =3D {
-       .name =3D "Xilinx INTC",
-       .irq_unmask =3D intc_enable_or_unmask,
-       .irq_mask =3D intc_disable_or_mask,
-       .irq_ack =3D intc_ack,
-       .irq_mask_ack =3D intc_mask_ack,
-};
+static unsigned int xintc_get_irq_local(struct xintc_irq_chip *local_intc)
+{
+       int hwirq, irq =3D -1;
+
+       hwirq =3D xintc_read(local_intc->base + IVR);
+       if (hwirq !=3D -1U)
+               irq =3D irq_find_mapping(local_intc->root_domain, hwirq);
+
+       pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);
+
+       return irq;
+}

 unsigned int xintc_get_irq(void)
 {
-       unsigned int hwirq, irq =3D -1;
+       int hwirq, irq =3D -1;

-       hwirq =3D xintc_read(IVR);
+       hwirq =3D xintc_read(primary_intc->base + IVR);
        if (hwirq !=3D -1U)
-               irq =3D irq_find_mapping(xintc_irqc->root_domain, hwirq);
+               irq =3D irq_find_mapping(primary_intc->root_domain, hwirq);

        pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);

@@ -118,15 +131,18 @@ unsigned int xintc_get_irq(void)

 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number=
_t hw)
 {
-       if (xintc_irqc->intr_mask & (1 << hw)) {
-               irq_set_chip_and_handler_name(irq, &intc_dev,
+       struct xintc_irq_chip *local_intc =3D d->host_data;
+
+       if (local_intc->intr_mask & (1 << hw)) {
+               irq_set_chip_and_handler_name(irq, local_intc->intc_dev,
                                                handle_edge_irq, "edge");
                irq_clear_status_flags(irq, IRQ_LEVEL);
        } else {
-               irq_set_chip_and_handler_name(irq, &intc_dev,
+               irq_set_chip_and_handler_name(irq, local_intc->intc_dev,
                                                handle_level_irq, "level");
                irq_set_status_flags(irq, IRQ_LEVEL);
        }
+       irq_set_chip_data(irq, local_intc);
        return 0;
 }

@@ -138,11 +154,13 @@ static const struct irq_domain_ops xintc_irq_domain_o=
ps =3D {
 static void xil_intc_irq_handler(struct irq_desc *desc)
 {
        struct irq_chip *chip =3D irq_desc_get_chip(desc);
+       struct xintc_irq_chip *local_intc =3D
+               irq_data_get_irq_handler_data(&desc->irq_data);
        u32 pending;

        chained_irq_enter(chip, desc);
        do {
-               pending =3D xintc_get_irq();
+               pending =3D xintc_get_irq_local(local_intc);
                if (pending =3D=3D -1U)
                        break;
                generic_handle_irq(pending);
@@ -153,28 +171,20 @@ static void xil_intc_irq_handler(struct irq_desc *des=
c)
 static int __init xilinx_intc_of_init(struct device_node *intc,
                                             struct device_node *parent)
 {
-       u32 nr_irq;
        int ret, irq;
        struct xintc_irq_chip *irqc;
-
-       if (xintc_irqc) {
-               pr_err("irq-xilinx: Multiple instances aren't supported\n")=
;
-               return -EINVAL;
-       }
+       struct irq_chip *intc_dev;

        irqc =3D kzalloc(sizeof(*irqc), GFP_KERNEL);
        if (!irqc)
                return -ENOMEM;
-
-       xintc_irqc =3D irqc;
-
        irqc->base =3D of_iomap(intc, 0);
        BUG_ON(!irqc->base);

-       ret =3D of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq)=
;
+       ret =3D of_property_read_u32(intc, "xlnx,num-intr-inputs", &irqc->n=
r_irq);
        if (ret < 0) {
                pr_err("irq-xilinx: unable to read xlnx,num-intr-inputs\n")=
;
-               goto err_alloc;
+               goto error;
        }

        ret =3D of_property_read_u32(intc, "xlnx,kind-of-intr", &irqc->intr=
_mask);
@@ -183,30 +193,42 @@ static int __init xilinx_intc_of_init(struct device_n=
ode *intc,
                irqc->intr_mask =3D 0;
        }

-       if (irqc->intr_mask >> nr_irq)
+       if (irqc->intr_mask >> irqc->nr_irq)
                pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");

        pr_info("irq-xilinx: %pOF: num_irq=3D%d, edge=3D0x%x\n",
-               intc, nr_irq, irqc->intr_mask);
+               intc, irqc->nr_irq, irqc->intr_mask);
+
+       intc_dev =3D kzalloc(sizeof(*intc_dev), GFP_KERNEL);
+       if (!intc_dev) {
+               ret =3D -ENOMEM;
+               goto error;
+       }

+       intc_dev->name =3D intc->full_name;
+       intc_dev->irq_unmask =3D intc_enable_or_unmask,
+       intc_dev->irq_mask =3D intc_disable_or_mask,
+       intc_dev->irq_ack =3D intc_ack,
+       intc_dev->irq_mask_ack =3D intc_mask_ack,
+       irqc->intc_dev =3D intc_dev;

        /*
         * Disable all external interrupts until they are
         * explicity requested.
         */
-       xintc_write(IER, 0);
+       xintc_write(irqc->base + IER, 0);

        /* Acknowledge any pending interrupts just in case. */
-       xintc_write(IAR, 0xffffffff);
+       xintc_write(irqc->base + IAR, 0xffffffff);

        /* Turn on the Master Enable. */
-       xintc_write(MER, MER_HIE | MER_ME);
-       if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
+       xintc_write(irqc->base + MER, MER_HIE | MER_ME);
+       if (!(xintc_read(irqc->base + MER) & (MER_HIE | MER_ME))) {
                static_branch_enable(&xintc_is_be);
-               xintc_write(MER, MER_HIE | MER_ME);
+               xintc_write(irqc->base + MER, MER_HIE | MER_ME);
        }

-       irqc->root_domain =3D irq_domain_add_linear(intc, nr_irq,
+       irqc->root_domain =3D irq_domain_add_linear(intc, irqc->nr_irq,
                                                  &xintc_irq_domain_ops, ir=
qc);
        if (!irqc->root_domain) {
                pr_err("irq-xilinx: Unable to create IRQ domain\n");
@@ -225,13 +247,16 @@ static int __init xilinx_intc_of_init(struct device_n=
ode *intc,
                        goto err_alloc;
                }
        } else {
-               irq_set_default_host(irqc->root_domain);
+               primary_intc =3D irqc;
+               irq_set_default_host(primary_intc->root_domain);
        }

        return 0;

 err_alloc:
-       xintc_irqc =3D NULL;
+       kfree(intc_dev);
+error:
+       iounmap(irqc->base);
        kfree(irqc);
        return ret;

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
