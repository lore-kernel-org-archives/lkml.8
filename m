Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1786A207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="PLaQehW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgHTMgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgHTMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:36:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A4C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:36:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so1435481wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Moer/SJ9KLlu3c/uwDMNvHyn5qjYDQOmB7XI8YOHHus=;
        b=PLaQehW0vLNh+/cJ81yCL0Ml7HL17BTyC4aVxhL/dvOXOv9C7AX2jnPYMhxmMaGOs3
         46lAnhGgNaGPhAoCnzRbhqFs0sujzr02do1qasB12aONgUbOgLR4XJmVxu0u7ByevRqZ
         kIPUfzkx5QM11j5V8QvFuKB9TAWVuYQGkmQFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Moer/SJ9KLlu3c/uwDMNvHyn5qjYDQOmB7XI8YOHHus=;
        b=NNyaa/Mxxoz4OeFDCFbPZ/8Cfu5W4K2UT8zNnVJOTPzB1iSF8JUJXWLXECuYv1CS6p
         LfQ91/TgO6mjAb82ysQcXJDJa/j4HYXpeCeAIY2xd0tAm7iNJn+DtEyp1CEl5Ys0TP7R
         hNm7Fvs9oN24rD1Xhai41AU9Zs+U/2K+Gd2anpy16vCNxuIXxlDcco2qrFbDkyClJ5sn
         LJpHkLYs/+EvbUumUuq58la9LOdSxFwCrBeLluYfc+yUEvOjte/uu+3dlwsy+s4tDHJS
         0+fgwVNabjEj/Kq9dKBQ0P+fKStMG4Cnq660UzlMMsmtEYRbqiw89Nycy3ZsaCgKHaEg
         PD4w==
X-Gm-Message-State: AOAM533I9/OWHMH8c7RaRQ4HpDR7PbucAvLzrh1wLqj3uXQHlamVmHJz
        T9HjFo5ENMKUWU/bxR1VNiRz8kvgLidx3Usa4JTJsw==
X-Google-Smtp-Source: ABdhPJzieD2BdIwd5/DSBke56nqPwJlmPQzUB3bcJJb0oKNuOfviI7H6eOIVa6cKDK/kzUs1LFUdrdxPzKW/gK24iQ0=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr3467143wmh.4.1597926993474;
 Thu, 20 Aug 2020 05:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200819034231.20726-1-mark-pk.tsai@mediatek.com> <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20200819153757.28993-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 20 Aug 2020 21:36:22 +0900
Message-ID: <CAFr9PXnzdHs2F3pyF-493xuhn9wFU1G9eLXRtiW-rYNB5bLX7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip: irq-mst: Add MStar interrupt controller support
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>, alix.wu@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK, Marc

I'm not sure this will be the final version but I'm going to try to
integrate this with my current MStar/SigmaStar tree over the weekend
and then I guess I can give this a tested-by?

Assuming this version or the next is acceptable can I just follow up
with a small patch to add the instances I need in my dtsi or should I
wait until it's merged before doing that?

Thanks,

Daniel

On Thu, 20 Aug 2020 at 00:38, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> Add MStar interrupt controller support using hierarchy irq
> domain.
>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/irqchip/Kconfig        |   8 ++
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/irq-mst-intc.c | 199 +++++++++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mst-intc.c
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bb70b7177f94..0b5ae5fa0d3c 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -571,4 +571,12 @@ config LOONGSON_PCH_MSI
>         help
>           Support for the Loongson PCH MSI Controller.
>
> +config MST_IRQ
> +       bool "MStar Interrupt Controller"
> +       default ARCH_MEDIATEK
> +       select IRQ_DOMAIN
> +       select IRQ_DOMAIN_HIERARCHY
> +       help
> +         Support MStar Interrupt Controller.
> +
>  endmenu
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 133f9c45744a..e2688a62403e 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)                += irq-loongson-htpic.o
>  obj-$(CONFIG_LOONGSON_HTVEC)           += irq-loongson-htvec.o
>  obj-$(CONFIG_LOONGSON_PCH_PIC)         += irq-loongson-pch-pic.o
>  obj-$(CONFIG_LOONGSON_PCH_MSI)         += irq-loongson-pch-msi.o
> +obj-$(CONFIG_MST_IRQ)                  += irq-mst-intc.o
> diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
> new file mode 100644
> index 000000000000..4be077591898
> --- /dev/null
> +++ b/drivers/irqchip/irq-mst-intc.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> + */
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define INTC_MASK      0x0
> +#define INTC_EOI       0x20
> +
> +struct mst_intc_chip_data {
> +       raw_spinlock_t  lock;
> +       unsigned int    irq_start, nr_irqs;
> +       void __iomem    *base;
> +       bool            no_eoi;
> +};
> +
> +static void mst_set_irq(struct irq_data *d, u32 offset)
> +{
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +       u16 val, mask;
> +       unsigned long flags;
> +
> +       mask = 1 << (hwirq % 16);
> +       offset += (hwirq / 16) * 4;
> +
> +       raw_spin_lock_irqsave(&cd->lock, flags);
> +       val = readw_relaxed(cd->base + offset) | mask;
> +       writew_relaxed(val, cd->base + offset);
> +       raw_spin_unlock_irqrestore(&cd->lock, flags);
> +}
> +
> +static void mst_clear_irq(struct irq_data *d, u32 offset)
> +{
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +       u16 val, mask;
> +       unsigned long flags;
> +
> +       mask = 1 << (hwirq % 16);
> +       offset += (hwirq / 16) * 4;
> +
> +       raw_spin_lock_irqsave(&cd->lock, flags);
> +       val = readw_relaxed(cd->base + offset) & ~mask;
> +       writew_relaxed(val, cd->base + offset);
> +       raw_spin_unlock_irqrestore(&cd->lock, flags);
> +}
> +
> +static void mst_intc_mask_irq(struct irq_data *d)
> +{
> +       mst_set_irq(d, INTC_MASK);
> +       irq_chip_mask_parent(d);
> +}
> +
> +static void mst_intc_unmask_irq(struct irq_data *d)
> +{
> +       mst_clear_irq(d, INTC_MASK);
> +       irq_chip_unmask_parent(d);
> +}
> +
> +static void mst_intc_eoi_irq(struct irq_data *d)
> +{
> +       struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
> +
> +       if (!cd->no_eoi)
> +               mst_set_irq(d, INTC_EOI);
> +
> +       irq_chip_eoi_parent(d);
> +}
> +
> +static struct irq_chip mst_intc_chip = {
> +       .name                   = "mst-intc",
> +       .irq_mask               = mst_intc_mask_irq,
> +       .irq_unmask             = mst_intc_unmask_irq,
> +       .irq_eoi                = mst_intc_eoi_irq,
> +       .irq_get_irqchip_state  = irq_chip_get_parent_state,
> +       .irq_set_irqchip_state  = irq_chip_set_parent_state,
> +       .irq_set_affinity       = irq_chip_set_affinity_parent,
> +       .irq_set_vcpu_affinity  = irq_chip_set_vcpu_affinity_parent,
> +       .irq_set_type           = irq_chip_set_type_parent,
> +       .irq_retrigger          = irq_chip_retrigger_hierarchy,
> +       .flags                  = IRQCHIP_SET_TYPE_MASKED |
> +                                 IRQCHIP_SKIP_SET_WAKE |
> +                                 IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int mst_intc_domain_translate(struct irq_domain *d,
> +                                    struct irq_fwspec *fwspec,
> +                                    unsigned long *hwirq,
> +                                    unsigned int *type)
> +{
> +       struct mst_intc_chip_data *cd = d->host_data;
> +
> +       if (is_of_node(fwspec->fwnode)) {
> +               if (fwspec->param_count != 3)
> +                       return -EINVAL;
> +
> +               /* No PPI should point to this domain */
> +               if (fwspec->param[0] != 0)
> +                       return -EINVAL;
> +
> +               if (fwspec->param[1] >= cd->nr_irqs)
> +                       return -EINVAL;
> +
> +               *hwirq = fwspec->param[1];
> +               *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +                                unsigned int nr_irqs, void *data)
> +{
> +       int i;
> +       irq_hw_number_t hwirq;
> +       struct irq_fwspec parent_fwspec, *fwspec = data;
> +       struct mst_intc_chip_data *cd = domain->host_data;
> +
> +       /* Not GIC compliant */
> +       if (fwspec->param_count != 3)
> +               return -EINVAL;
> +
> +       /* No PPI should point to this domain */
> +       if (fwspec->param[0])
> +               return -EINVAL;
> +
> +       hwirq = fwspec->param[1];
> +       for (i = 0; i < nr_irqs; i++)
> +               irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +                                             &mst_intc_chip,
> +                                             domain->host_data);
> +
> +       parent_fwspec = *fwspec;
> +       parent_fwspec.fwnode = domain->parent->fwnode;
> +       parent_fwspec.param[1] = cd->irq_start + hwirq;
> +       return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_fwspec);
> +}
> +
> +static const struct irq_domain_ops mst_intc_domain_ops = {
> +       .translate      = mst_intc_domain_translate,
> +       .alloc          = mst_intc_domain_alloc,
> +       .free           = irq_domain_free_irqs_common,
> +};
> +
> +int __init
> +mst_intc_of_init(struct device_node *dn, struct device_node *parent)
> +{
> +       struct irq_domain *domain, *domain_parent;
> +       struct mst_intc_chip_data *cd;
> +       u32 irq_start, irq_end;
> +
> +       domain_parent = irq_find_host(parent);
> +       if (!domain_parent) {
> +               pr_err("mst-intc: interrupt-parent not found\n");
> +               return -EINVAL;
> +       }
> +
> +       if (of_property_read_u32_index(dn, "mstar,irqs-map-range", 0, &irq_start) ||
> +           of_property_read_u32_index(dn, "mstar,irqs-map-range", 1, &irq_end))
> +               return -EINVAL;
> +
> +       cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +       if (!cd)
> +               return -ENOMEM;
> +
> +       cd->base = of_iomap(dn, 0);
> +       if (!cd->base) {
> +               kfree(cd);
> +               return -ENOMEM;
> +       }
> +
> +       cd->no_eoi = of_property_read_bool(dn, "mstar,intc-no-eoi");
> +       raw_spin_lock_init(&cd->lock);
> +       cd->irq_start = irq_start;
> +       cd->nr_irqs = irq_end - irq_start + 1;
> +       domain = irq_domain_add_hierarchy(domain_parent, 0, cd->nr_irqs, dn,
> +                                         &mst_intc_domain_ops, cd);
> +       if (!domain) {
> +               iounmap(cd->base);
> +               kfree(cd);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);
> --
> 2.18.0
