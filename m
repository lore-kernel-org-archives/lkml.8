Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6BBC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA9821741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Rze0uzfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBFHGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:06:34 -0500
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:6104
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbgBFHGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:06:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGxBmuPTuUgbUqrNEOuSzwYA4FLAWh3i2BDV2giWS8fnnslgjcm3yEKTaGZNRRLHOpq3ahbddSuiNqY01RQu2Oqz3MYJ23/iKWwEJvra4lXFBM/+/XVC0m7mym1SwvGlHMukZIDX4jRCg+TO55nScPtnZq7M6eDP9kwlm/Ldrz2K+MNgOanLS2Z2QVSYGaWL5cihA4i/SXbCH9ihyldwbjerQGOasI41EOH+jj24xueOhSOe/SrBt5yEVT9XiCVd5y7KwpcNqCQ6MkK0EvSwHOLZT3yWi9QHX0Z0Stztrwlwk0VMyu65lCl9mHqnYzPH88ofq+T7WVed8M5w27Uj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uil0drSpHn+/H1FxPHuXC0k1DOISDNN0XSFIbTUc+k=;
 b=lOEoXE00zu7jsoghJD8Nuz3shhCcxRbLbgGZKj44iQApadPoe6YIZwUuKOuWwYkBNF+LjezqspWPAIEGPasJr9flgHvdey5gzpoXMsNnSD2MlC+dqcVr7ddeHmbGpCjgH3lojimG0b87GeUn6v8uUq4a7GU9hW4IlBl00FLSY3aizUgr+27yTfTO93J//bjbP6wBA1zq1j4najVIP+UjTrSVhS0/bED0fT0mggjBNJMvkzist6E0JBsEg6Vt7vwjU0TUzlUj8e/1He2vMV8zfKF4IeUteICuZ9ZotMMEztzOecKlY/49hUu/oW9omEC+Y7GTqf+LMy/cyamrAezJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uil0drSpHn+/H1FxPHuXC0k1DOISDNN0XSFIbTUc+k=;
 b=Rze0uzfJUpmyayBqmrQKedEU1eqD4iS/P7RakKMzYJq0iMXRCa+r2WrNxNqzsVskYmo/bw1fJxOMeFKParipyzrhhy14GU2sLHFdqAVxaXSg+7bHaj6WtnfpFrRE85H347bqtp2XvashlT0tPtAsSejpjm+cBIx7nxa9tJyuCpI=
Received: from MN2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:208:fc::35)
 by MWHPR0201MB3580.namprd02.prod.outlook.com (2603:10b6:301:78::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30; Thu, 6 Feb
 2020 07:06:29 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MN2PR02CA0022.outlook.office365.com
 (2603:10b6:208:fc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 07:06:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Thu, 6 Feb 2020 07:06:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izbF6-0002rn-JC; Wed, 05 Feb 2020 23:06:28 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izbF1-00044m-FY; Wed, 05 Feb 2020 23:06:23 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01676GN3006301;
        Wed, 5 Feb 2020 23:06:16 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1izbEt-000442-QQ; Wed, 05 Feb 2020 23:06:16 -0800
Subject: Re: [PATCH v2] irqchip: xilinx: Add support for multiple instances
To:     Marc Zyngier <maz@kernel.org>,
        Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        siva.durga.paladugu@xilinx.com, anirudha.sarangi@xilinx.com
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <b8e7b9120bc6cd306bda3347cde117ff@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3d6077c1-2b13-acc6-e8f4-3d1ab23dc159@xilinx.com>
Date:   Thu, 6 Feb 2020 08:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b8e7b9120bc6cd306bda3347cde117ff@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(44832011)(31696002)(316002)(110136005)(81166006)(8936002)(8676002)(81156014)(31686004)(9786002)(36756003)(26005)(53546011)(2616005)(6636002)(336012)(426003)(186003)(2906002)(70206006)(356004)(6666004)(4326008)(70586007)(107886003)(5660300002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3580;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71389a3-a6d2-4a81-7dd6-08d7aad316e5
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3580:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3580AE6F10C1CDA51A9B326DC61D0@MWHPR0201MB3580.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHtdbiCdIAq8dWSQbU8f2Pi2YUbaHbjjgNqNPnq+Tx5GwzR8IexUsMuBFNkyxujyiQ7rPs5/YA9dPRxsqaiT5n2wCM9L9G/Wdz6zfYhw1QTTvRciv6k9p07/doXBxLCcmq8sCK7F88+OLZsB9oH+ptWKcFxixhGeMDtcnMT6rOYi4FOfGvzu6gSqdXm4MrWU4QjvOlFqzR/j5azGnCfKwOKKFRvKuU3FzA7A+xz9pVDKrMeNglmL7/0HdWbzOP83ta4JhtERoAUhtWmx9NQTBl1imvI/YjuUE1f4qKrUdlZIc+RiBqPeW7MQOkOX98drm+/UIHBW5Z14TNkKHcRBMJnsH7cqcRf5sZGDomVwrQlP3hxNuXetZ8nHm6WvzqxlTOrR448MqBTYZAzUoWkiqthtaY4Ubznl1EbEP+2vGakuzvwlpkGN0wXv7P/xsSIQ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 07:06:29.2032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71389a3-a6d2-4a81-7dd6-08d7aad316e5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 02. 20 17:53, Marc Zyngier wrote:
> On 2020-02-05 14:05, Mubin Usman Sayyed wrote:
>> From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
>>
>> This patch adds support for multiple instances of
>> xilinx interrupt controller. Below configurations are
>> supported by driver,
>>
>> - peripheral->xilinx-intc->xilinx-intc->gic
>> - peripheral->xilinx-intc->xilinx-intc
>>
>> Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
>> Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
>> ---
>> Changes for v2:
>>         - Removed write_fn/read_fn hooks, used xintc_write/
>>           xintc_read directly
>>         - Moved primary_intc declaration after xintc_irq_chip
>> ---
>>  drivers/irqchip/irq-xilinx-intc.c | 121
>> +++++++++++++++++++++++---------------
>>  1 file changed, 73 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-xilinx-intc.c
>> b/drivers/irqchip/irq-xilinx-intc.c
>> index e3043de..14cb630 100644
>> --- a/drivers/irqchip/irq-xilinx-intc.c
>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>> @@ -38,29 +38,32 @@ struct xintc_irq_chip {
>>         void            __iomem *base;
>>         struct          irq_domain *root_domain;
>>         u32             intr_mask;
>> +       struct                  irq_chip *intc_dev;
>> +       u32                             nr_irq;
>>  };
>>
>> -static struct xintc_irq_chip *xintc_irqc;
>> +static struct xintc_irq_chip *primary_intc;
>>
>> -static void xintc_write(int reg, u32 data)
>> +static void xintc_write(void __iomem *addr, u32 data)
>>  {
>>         if (static_branch_unlikely(&xintc_is_be))
>> -               iowrite32be(data, xintc_irqc->base + reg);
>> +               iowrite32be(data, addr);
>>         else
>> -               iowrite32(data, xintc_irqc->base + reg);
>> +               iowrite32(data, addr);
>>  }
>>
>> -static unsigned int xintc_read(int reg)
>> +static unsigned int xintc_read(void __iomem *addr)
> 
> Since you are changing this, please change the return value to reflect
> the size of what you're returning (u32 instead of unsigned int).
> 
>>  {
>>         if (static_branch_unlikely(&xintc_is_be))
>> -               return ioread32be(xintc_irqc->base + reg);
>> +               return ioread32be(addr);
>>         else
>> -               return ioread32(xintc_irqc->base + reg);
>> +               return ioread32(addr);
>>  }
>>
>>  static void intc_enable_or_unmask(struct irq_data *d)
>>  {
>>         unsigned long mask = 1 << d->hwirq;
>> +       struct xintc_irq_chip *local_intc =
>> irq_data_get_irq_chip_data(d);
>>
>>         pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);
>>
>> @@ -69,47 +72,57 @@ static void intc_enable_or_unmask(struct irq_data *d)
>>          * acks the irq before calling the interrupt handler
>>          */
>>         if (irqd_is_level_type(d))
>> -               xintc_write(IAR, mask);
>> +               xintc_write(local_intc->base + IAR, mask);
>>
>> -       xintc_write(SIE, mask);
>> +       xintc_write(local_intc->base + SIE, mask);
>>  }
>>
>>  static void intc_disable_or_mask(struct irq_data *d)
>>  {
>> +       struct xintc_irq_chip *local_intc =
>> irq_data_get_irq_chip_data(d);
>> +
>>         pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
>> -       xintc_write(CIE, 1 << d->hwirq);
>> +       xintc_write(local_intc->base + CIE, 1 << d->hwirq);
>>  }
>>
>>  static void intc_ack(struct irq_data *d)
>>  {
>> +       struct xintc_irq_chip *local_intc =
>> irq_data_get_irq_chip_data(d);
>> +
>>         pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
>> -       xintc_write(IAR, 1 << d->hwirq);
>> +       xintc_write(local_intc->base + IAR, 1 << d->hwirq);
>>  }
>>
>>  static void intc_mask_ack(struct irq_data *d)
>>  {
>>         unsigned long mask = 1 << d->hwirq;
>> +       struct xintc_irq_chip *local_intc =
>> irq_data_get_irq_chip_data(d);
>>
>>         pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
>> -       xintc_write(CIE, mask);
>> -       xintc_write(IAR, mask);
>> +       xintc_write(local_intc->base + CIE, mask);
>> +       xintc_write(local_intc->base + IAR, mask);
>>  }
>>
>> -static struct irq_chip intc_dev = {
>> -       .name = "Xilinx INTC",
>> -       .irq_unmask = intc_enable_or_unmask,
>> -       .irq_mask = intc_disable_or_mask,
>> -       .irq_ack = intc_ack,
>> -       .irq_mask_ack = intc_mask_ack,
>> -};
>> +static unsigned int xintc_get_irq_local(struct xintc_irq_chip
>> *local_intc)
>> +{
>> +       int hwirq, irq = -1;
> 
> Type consistency for hwirq.
> 
>> +
>> +       hwirq = xintc_read(local_intc->base + IVR);
>> +       if (hwirq != -1U)
>> +               irq = irq_find_mapping(local_intc->root_domain, hwirq);
>> +
>> +       pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
>> +
>> +       return irq;
> 
> That now gives you both -1 and 0 for error values. Please stick with 0.
> 
>> +}
>>
>>  unsigned int xintc_get_irq(void)
>>  {
>> -       unsigned int hwirq, irq = -1;
>> +       int hwirq, irq = -1;
>>
>> -       hwirq = xintc_read(IVR);
>> +       hwirq = xintc_read(primary_intc->base + IVR);
>>         if (hwirq != -1U)
>> -               irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
>> +               irq = irq_find_mapping(primary_intc->root_domain, hwirq);
>>
>>         pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
> 
> I have the ugly feeling I'm reading the same code twice... Surely you can
> make these two functions common code.

I have some questions regarding this.
I have updated one patchset which is adding support for Microblaze SMP.
And when I was looking at current wiring of this driver I have decided
to change it.

I have enabled  GENERIC_IRQ_MULTI_HANDLER and HANDLE_DOMAIN_IRQ.
This driver calls set_handle_irq(xil_intc_handle_irq)
and MB do_IRQ() call handle_arch_irq()
and IRQ routine here is using handle_domain_irq().

I would expect that this chained IRQ handler can also use
handle_domain_irq().

Is that correct understanding?



>>
>> @@ -118,15 +131,18 @@ unsigned int xintc_get_irq(void)
>>
>>  static int xintc_map(struct irq_domain *d, unsigned int irq,
>> irq_hw_number_t hw)
>>  {
>> -       if (xintc_irqc->intr_mask & (1 << hw)) {
>> -               irq_set_chip_and_handler_name(irq, &intc_dev,
>> +       struct xintc_irq_chip *local_intc = d->host_data;
>> +
>> +       if (local_intc->intr_mask & (1 << hw)) {
> 
> BIT(hw)
> 
>> +               irq_set_chip_and_handler_name(irq, local_intc->intc_dev,
>>                                                 handle_edge_irq, "edge");
>>                 irq_clear_status_flags(irq, IRQ_LEVEL);
>>         } else {
>> -               irq_set_chip_and_handler_name(irq, &intc_dev,
>> +               irq_set_chip_and_handler_name(irq, local_intc->intc_dev,
>>                                                 handle_level_irq,
>> "level");
>>                 irq_set_status_flags(irq, IRQ_LEVEL);
>>         }
>> +       irq_set_chip_data(irq, local_intc);
>>         return 0;
>>  }
>>
>> @@ -138,11 +154,13 @@ static const struct irq_domain_ops
>> xintc_irq_domain_ops = {
>>  static void xil_intc_irq_handler(struct irq_desc *desc)
>>  {
>>         struct irq_chip *chip = irq_desc_get_chip(desc);
>> +       struct xintc_irq_chip *local_intc =
>> +               irq_data_get_irq_handler_data(&desc->irq_data);
>>         u32 pending;
>>
>>         chained_irq_enter(chip, desc);
>>         do {
>> -               pending = xintc_get_irq();
>> +               pending = xintc_get_irq_local(local_intc);
>>                 if (pending == -1U)
>>                         break;
>>                 generic_handle_irq(pending);
>> @@ -153,28 +171,20 @@ static void xil_intc_irq_handler(struct irq_desc
>> *desc)
>>  static int __init xilinx_intc_of_init(struct device_node *intc,
>>                                              struct device_node *parent)
>>  {
>> -       u32 nr_irq;
>>         int ret, irq;
>>         struct xintc_irq_chip *irqc;
>> -
>> -       if (xintc_irqc) {
>> -               pr_err("irq-xilinx: Multiple instances aren't
>> supported\n");
>> -               return -EINVAL;
>> -       }
>> +       struct irq_chip *intc_dev;
>>
>>         irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
>>         if (!irqc)
>>                 return -ENOMEM;
>> -
>> -       xintc_irqc = irqc;
>> -
>>         irqc->base = of_iomap(intc, 0);
>>         BUG_ON(!irqc->base);
>>
>> -       ret = of_property_read_u32(intc, "xlnx,num-intr-inputs",
>> &nr_irq);
>> +       ret = of_property_read_u32(intc, "xlnx,num-intr-inputs",
>> &irqc->nr_irq);
>>         if (ret < 0) {
>>                 pr_err("irq-xilinx: unable to read
>> xlnx,num-intr-inputs\n");
>> -               goto err_alloc;
>> +               goto error;
>>         }
>>
>>         ret = of_property_read_u32(intc, "xlnx,kind-of-intr",
>> &irqc->intr_mask);
>> @@ -183,30 +193,42 @@ static int __init xilinx_intc_of_init(struct
>> device_node *intc,
>>                 irqc->intr_mask = 0;
>>         }
>>
>> -       if (irqc->intr_mask >> nr_irq)
>> +       if (irqc->intr_mask >> irqc->nr_irq)
>>                 pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
>>
>>         pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",
>> -               intc, nr_irq, irqc->intr_mask);
>> +               intc, irqc->nr_irq, irqc->intr_mask);
>> +
>> +       intc_dev = kzalloc(sizeof(*intc_dev), GFP_KERNEL);
>> +       if (!intc_dev) {
>> +               ret = -ENOMEM;
>> +               goto error;
>> +       }
>>
>> +       intc_dev->name = intc->full_name;
> 
> No. The world doesn't need to see the OF path of your interrupt
> controller in /proc/cpuinfo.
> The name that was there before was perfectly descriptive, please stick
> to it.

It should be showing name like interrupt-controller@41800000.
Do you think that we really should stick with just fixed name?
There could be multiple instances in the system and you will have no
idea how they are connected.

Thanks,
Michal
