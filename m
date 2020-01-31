Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA93C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C534320707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qqKKowbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgAaOTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:19:41 -0500
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:6170
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728840AbgAaOTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in/1MyW7s5tKIcDCS4Ma4xylLzj5gnajXH/eLF76v+E+3drmxTc6C3PeH8PLZHnCq6GKjuPY3h3LIY/L5fpARmJabJEp1ss5uimbf+xNgEW2XAcJKLzgXSHb6AZRsxcBPBlzzuy9rQ4kZuytxy/8H50hCraMQU1/vq8bZLgC9Qf1iaYSWsIIRwMmQOK/9hEr7eFaPRnFpU3wJpBKlbEpDUBvhOPYBVfiZ4EsINaxiFqdmFiNksf18iF3/npfwyrrfstCDL0RMBqiADVC+gqlYZHOOi2kga5Asbkq/YMk2XyAFIckELAF01sVr+dtIpZumA7qcCKQAO0TPfVLqH71Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaJzoEpzNgsib8JcsYItL11owxVA8Cti9/oyNr1ZBsg=;
 b=cbEqPvjZFissms6983lSZfo3HVc36CqGO+Kaad2qhrkFJSBHLuk8sKp5ffc4d4ynNpWQKp/89FGcUrhQ9QprWkrYbsjMN8U3YOmvuhzuGDwWc8+hJoqQvFUdvf4msARXjscbnqifj+p3cx1uhjpBj4PjRE+nGH4kTdcL7+/9CkGNYO0HxWmLdoNFBtbmYOL5YXq1tTqnm1rcjthpOCCakwl7EWo2vXpfafICOmp7LkhsQ543dYojyosO9a+CJwnSvoiKZQt8ui3kyuj11/SbhVMFX1rqo7sABmKiaPyVrX8O+X2lzaAj24YqmyC9Kwm6LsTY3J+0MYQF3XIAaENYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaJzoEpzNgsib8JcsYItL11owxVA8Cti9/oyNr1ZBsg=;
 b=qqKKowbS7bgLnuQXmYKZOEYdSRbURklbugIS87joKAo2Y+ilcRKZjJy6LtL7MPWEXjM3rYyaNtNyJP4vhdHnfRMUOS+hWJF0NYL5vKGCCDnUT8L6OjfhY8m1vbdm2maJcGBG+GXhMOxw2yRfIYZk5LyZi4vlnYHHUQFhVZcFXzk=
Received: from SN4PR0201CA0066.namprd02.prod.outlook.com
 (2603:10b6:803:20::28) by BYAPR02MB4104.namprd02.prod.outlook.com
 (2603:10b6:a02:f1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 14:19:32 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN4PR0201CA0066.outlook.office365.com
 (2603:10b6:803:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend
 Transport; Fri, 31 Jan 2020 14:19:32 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Fri, 31 Jan 2020 14:19:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1ixX8s-0004Un-Dk; Fri, 31 Jan 2020 06:19:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1ixX8n-0006dJ-1N; Fri, 31 Jan 2020 06:19:25 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00VEJHrT030121;
        Fri, 31 Jan 2020 06:19:17 -0800
Received: from [10.140.6.23] (helo=xhdmubinusm40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1ixX8e-0006bw-Cy; Fri, 31 Jan 2020 06:19:16 -0800
From:   Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, siva.durga.paladugu@xilinx.com,
        anirudha.sarangi@xilinx.com,
        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
Subject: [PATCH] irqchip: xilinx: Add support for multiple instances
Date:   Fri, 31 Jan 2020 19:48:58 +0530
Message-Id: <1580480338-3361-1-git-send-email-mubin.usman.sayyed@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(426003)(2906002)(63350400001)(2616005)(9786002)(26005)(336012)(6666004)(356004)(4326008)(186003)(8676002)(8936002)(81166006)(70586007)(81156014)(316002)(5660300002)(36756003)(7696005)(70206006)(107886003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4104;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:ErrorRetry;MX:1;A:3;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c526dc-8a32-413c-8fa0-08d7a65896c1
X-MS-TrafficTypeDiagnostic: BYAPR02MB4104:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4104ED82B3F336B35DB368AAA1070@BYAPR02MB4104.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /u4+0SO91q4NCOYaqGwWqDQYqRzkEpVOBo2zopqQgLMe8aEGWMwmBjtn68jOVEQGTNljiJXFo6u2BAowPH3vBjRMb+KTd0eCP9LaNTSs0fKQvPq3EIMqhRPyGql+0N9yOxN20QivUErpeT5AFWhKCLGXHv2dI16EOvLc4lOejn7hsJhTr++0AIiPd+ZB7iLb9n94VFY+lEbilD4tlrSX0ljuZTbR7hhJGhB+ujqDOjD1cOLW/LU6cfP8cvkByNtWpUwOw6vy6f8Suie1TtjVnhx3vm4nlVbB4Zn9/X5jKfeCibCKSt88VuFFCuILUdF1eAZMjHd0l8FMEHJmthULNBY8x6Jjtaiq9Kw+MayvlK/TIewoUHAjCrYnJ0To8yQr+TNWi0cXNb57gdg2gTdd9mSsI3onnM9kCN6T/eRa08OVshBS78tdD749ZykwpvJL
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 14:19:30.9922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c526dc-8a32-413c-8fa0-08d7a65896c1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4104
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
 drivers/irqchip/irq-xilinx-intc.c | 143 +++++++++++++++++++++++-----------=
----
 1 file changed, 87 insertions(+), 56 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx=
-intc.c
index e3043de..43d6e4e 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -15,10 +15,11 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
-#include <linux/jump_label.h>
 #include <linux/bug.h>
 #include <linux/of_irq.h>

+static struct xintc_irq_chip *primary_intc;
+
 /* No one else should require these constants, so define them locally here=
. */
 #define ISR 0x00                       /* Interrupt Status Register */
 #define IPR 0x04                       /* Interrupt Pending Register */
@@ -32,35 +33,40 @@
 #define MER_ME (1<<0)
 #define MER_HIE (1<<1)

-static DEFINE_STATIC_KEY_FALSE(xintc_is_be);
-
 struct xintc_irq_chip {
        void            __iomem *base;
        struct          irq_domain *root_domain;
        u32             intr_mask;
+       struct                  irq_chip *intc_dev;
+       u32                             nr_irq;
+       unsigned int    (*read_fn)(void __iomem *addr);
+       void                    (*write_fn)(void __iomem *addr, u32);
 };

-static struct xintc_irq_chip *xintc_irqc;
+static void xintc_write(void __iomem *addr, u32 data)
+{
+               iowrite32(data, addr);
+}
+
+static unsigned int xintc_read(void __iomem *addr)
+{
+               return ioread32(addr);
+}

-static void xintc_write(int reg, u32 data)
+static void xintc_write_be(void __iomem *addr, u32 data)
 {
-       if (static_branch_unlikely(&xintc_is_be))
-               iowrite32be(data, xintc_irqc->base + reg);
-       else
-               iowrite32(data, xintc_irqc->base + reg);
+               iowrite32be(data, addr);
 }

-static unsigned int xintc_read(int reg)
+static unsigned int xintc_read_be(void __iomem *addr)
 {
-       if (static_branch_unlikely(&xintc_is_be))
-               return ioread32be(xintc_irqc->base + reg);
-       else
-               return ioread32(xintc_irqc->base + reg);
+               return ioread32be(addr);
 }

 static void intc_enable_or_unmask(struct irq_data *d)
 {
        unsigned long mask =3D 1 << d->hwirq;
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;

        pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);

@@ -69,47 +75,57 @@ static void intc_enable_or_unmask(struct irq_data *d)
         * acks the irq before calling the interrupt handler
         */
        if (irqd_is_level_type(d))
-               xintc_write(IAR, mask);
+               local_intc->write_fn(local_intc->base + IAR, mask);

-       xintc_write(SIE, mask);
+       local_intc->write_fn(local_intc->base + SIE, mask);
 }

 static void intc_disable_or_mask(struct irq_data *d)
 {
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;
+
        pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
-       xintc_write(CIE, 1 << d->hwirq);
+       local_intc->write_fn(local_intc->base + CIE, 1 << d->hwirq);
 }

 static void intc_ack(struct irq_data *d)
 {
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;
+
        pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
-       xintc_write(IAR, 1 << d->hwirq);
+       local_intc->write_fn(local_intc->base + IAR, 1 << d->hwirq);
 }

 static void intc_mask_ack(struct irq_data *d)
 {
        unsigned long mask =3D 1 << d->hwirq;
+       struct xintc_irq_chip *local_intc =3D irq_data_get_irq_chip_data(d)=
;

        pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
-       xintc_write(CIE, mask);
-       xintc_write(IAR, mask);
+       local_intc->write_fn(local_intc->base + CIE, mask);
+       local_intc->write_fn(local_intc->base + IAR, mask);
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
+       hwirq =3D local_intc->read_fn(local_intc->base + IVR);
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
+       hwirq =3D primary_intc->read_fn(primary_intc->base + IVR);
        if (hwirq !=3D -1U)
-               irq =3D irq_find_mapping(xintc_irqc->root_domain, hwirq);
+               irq =3D irq_find_mapping(primary_intc->root_domain, hwirq);

        pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);

@@ -118,15 +134,18 @@ unsigned int xintc_get_irq(void)

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

@@ -138,11 +157,13 @@ static const struct irq_domain_ops xintc_irq_domain_o=
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
@@ -153,28 +174,20 @@ static void xil_intc_irq_handler(struct irq_desc *des=
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
@@ -183,30 +196,45 @@ static int __init xilinx_intc_of_init(struct device_n=
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

+       irqc->write_fn =3D xintc_write;
+       irqc->read_fn =3D xintc_read;
        /*
         * Disable all external interrupts until they are
         * explicity requested.
         */
-       xintc_write(IER, 0);
+       irqc->write_fn(irqc->base + IER, 0);

        /* Acknowledge any pending interrupts just in case. */
-       xintc_write(IAR, 0xffffffff);
+       irqc->write_fn(irqc->base + IAR, 0xffffffff);

        /* Turn on the Master Enable. */
-       xintc_write(MER, MER_HIE | MER_ME);
-       if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
-               static_branch_enable(&xintc_is_be);
-               xintc_write(MER, MER_HIE | MER_ME);
+       irqc->write_fn(irqc->base + MER, MER_HIE | MER_ME);
+       if (!(irqc->read_fn(irqc->base + MER) & (MER_HIE | MER_ME))) {
+               irqc->write_fn =3D xintc_write_be;
+               irqc->read_fn =3D xintc_read_be;
+               irqc->write_fn(irqc->base + MER, MER_HIE | MER_ME);
        }

-       irqc->root_domain =3D irq_domain_add_linear(intc, nr_irq,
+       irqc->root_domain =3D irq_domain_add_linear(intc, irqc->nr_irq,
                                                  &xintc_irq_domain_ops, ir=
qc);
        if (!irqc->root_domain) {
                pr_err("irq-xilinx: Unable to create IRQ domain\n");
@@ -225,13 +253,16 @@ static int __init xilinx_intc_of_init(struct device_n=
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
