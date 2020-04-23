Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47CC55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3882080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFoDA/uR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDWCMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgDWCMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:12:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59971C03C1AA;
        Wed, 22 Apr 2020 19:12:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so4561389ljn.7;
        Wed, 22 Apr 2020 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UryFGfh7CmsyS5qQiC0XyxUWqqHw5YvioBnkYhGvhZQ=;
        b=HFoDA/uRFUCUhCMj4shlSQYFY5gcKB5kH1C1E7tcV2PHSpaV+NSuWC8Arxp/OvfuVb
         rn/RhpdYsfWlfvkoAkxOiycyfzdEfmcavg5y0N2Ja0qa0dTbf0XGlzsechFD0MYnqnCA
         7VEaPVoz7KnhJ5XOtwh/jnQsaQ6UkDQJIcgK8Zs4GSdWt6WQgxEAxAr2UGVG6TKyyPAh
         YL+gMZPdAGXT0s1rIxX8PTZvg1uhijheNc4qzlpF26u8iVW7Gl5amKKO6CZxpFrD1mOQ
         IyyQ+dNjYRqPzh+VrOPrNHxBQH8eIUP8PXt7RgVequavDn15Gop2NP0rx/kOGtfyVtF8
         Mu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UryFGfh7CmsyS5qQiC0XyxUWqqHw5YvioBnkYhGvhZQ=;
        b=kafO2rDXzJZHcHjk/Ai7xgiaGEuhJZo5cyuUob7D4Q84lZByxsgeqZodKQuetCntB3
         CJt23qhzWrIcDyHSK77ZJzt7XxUxJ24Dlnpw7ks2p7xIAEy4AgQsrI1ubag4WCLh/PV2
         bLcsc+5SpJuKeVa6SKMoQ6SK0lQ1oXyhAPA083ZjL5lVDqKUEitVw/pMABa7T4Jx5tcP
         5LvGj9eQDq5HFgwHDLBOFrRLrvcz1RT1YUp/WOODn71Xl50OvHehEBu4AsnswQl/Hi5l
         eI7xVK+Isl/8Q8VqtqB/2NgnJJvRKGFeP8y80hjTbkakHe+ovGrQO99/a22+Zv9aN2MB
         XX5Q==
X-Gm-Message-State: AGi0PuYeBcVDwJ0+pWT/Mv5ye/LPMCrVi4zYPXwZeyOSi5vb+P0u+t70
        Au7hltkw3umwedwP/xlfe0KVFSdxizYK77ZL0f1VMN6TTrw=
X-Google-Smtp-Source: APiQypIWgdjsYfFvd71m5B/ABJfPlrxmq+km4ux84RxxsCPWyBGkjWMSiFn7T52RNDq0zvSTNRYtlgMg74ew4u4QVyM=
X-Received: by 2002:a2e:8603:: with SMTP id a3mr951813lji.153.1587607955335;
 Wed, 22 Apr 2020 19:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <49020c8b96410f023707777750125cfd680c904d.1585720483.git.baolin.wang7@gmail.com>
 <0aa0f67a2de6f0a1f012cf6358b356537341af72.1585720483.git.baolin.wang7@gmail.com>
 <CADBw62rUvJZzTa2QxgSGz95JnDDZt5eV8bppSmpaDmrRnaRopQ@mail.gmail.com>
In-Reply-To: <CADBw62rUvJZzTa2QxgSGz95JnDDZt5eV8bppSmpaDmrRnaRopQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 23 Apr 2020 10:12:24 +0800
Message-ID: <CADBw62pmtn9prNtooDgDTisSnCvgCBfj3UtZbjge-FpTL1NfPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
To:     robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On Wed, Apr 8, 2020 at 10:20 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Jassi,
>
> On Wed, Apr 1, 2020 at 1:57 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang@unisoc.com>
> >
> > The Spreadtrum mailbox controller supports 8 channels to communicate
> > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > are used to send and receive messages by IRQ mode.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>
> Do you have any comments for this patch? Thanks.

Gentle ping, do you have any comments? Thanks.

> > ---
> > Changes from v2:
> >  - None.
> >
> > Changes from v1:
> >  - None
> > ---
> >  drivers/mailbox/Kconfig        |   8 +
> >  drivers/mailbox/Makefile       |   2 +
> >  drivers/mailbox/sprd-mailbox.c | 350 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 360 insertions(+)
> >  create mode 100644 drivers/mailbox/sprd-mailbox.c
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index ab4eb75..a33eaab 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -227,4 +227,12 @@ config ZYNQMP_IPI_MBOX
> >           message to the IPI buffer and will access the IPI control
> >           registers to kick the other processor or enquire status.
> >
> > +config SPRD_MBOX
> > +       tristate "Spreadtrum Mailbox"
> > +       depends on ARCH_SPRD || COMPILE_TEST
> > +       help
> > +         Mailbox driver implementation for the Spreadtrum platform. It is used
> > +         to send message between application processors and MCU. Say Y here if
> > +         you want to build the Spreatrum mailbox controller driver.
> > +
> >  endif
> > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> > index c22fad6..0f47b6b 100644
> > --- a/drivers/mailbox/Makefile
> > +++ b/drivers/mailbox/Makefile
> > @@ -48,3 +48,5 @@ obj-$(CONFIG_STM32_IPCC)      += stm32-ipcc.o
> >  obj-$(CONFIG_MTK_CMDQ_MBOX)    += mtk-cmdq-mailbox.o
> >
> >  obj-$(CONFIG_ZYNQMP_IPI_MBOX)  += zynqmp-ipi-mailbox.o
> > +
> > +obj-$(CONFIG_SPRD_MBOX)                += sprd-mailbox.o
> > diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> > new file mode 100644
> > index 0000000..58e5388
> > --- /dev/null
> > +++ b/drivers/mailbox/sprd-mailbox.c
> > @@ -0,0 +1,350 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Spreadtrum mailbox driver
> > + *
> > + * Copyright (c) 2020 Spreadtrum Communications Inc.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/mailbox_controller.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +
> > +#define SPRD_MBOX_ID           0x0
> > +#define SPRD_MBOX_MSG_LOW      0x4
> > +#define SPRD_MBOX_MSG_HIGH     0x8
> > +#define SPRD_MBOX_TRIGGER      0xc
> > +#define SPRD_MBOX_FIFO_RST     0x10
> > +#define SPRD_MBOX_FIFO_STS     0x14
> > +#define SPRD_MBOX_IRQ_STS      0x18
> > +#define SPRD_MBOX_IRQ_MSK      0x1c
> > +#define SPRD_MBOX_LOCK         0x20
> > +#define SPRD_MBOX_FIFO_DEPTH   0x24
> > +
> > +/* Bit and mask definiation for inbox's SPRD_MBOX_FIFO_STS register */
> > +#define SPRD_INBOX_FIFO_DELIVER_MASK           GENMASK(23, 16)
> > +#define SPRD_INBOX_FIFO_OVERLOW_MASK           GENMASK(15, 8)
> > +#define SPRD_INBOX_FIFO_DELIVER_SHIFT          16
> > +#define SPRD_INBOX_FIFO_BUSY_MASK              GENMASK(7, 0)
> > +
> > +/* Bit and mask definiation for SPRD_MBOX_IRQ_STS register */
> > +#define SPRD_MBOX_IRQ_CLR                      BIT(0)
> > +
> > +/* Bit and mask definiation for outbox's SPRD_MBOX_FIFO_STS register */
> > +#define SPRD_OUTBOX_FIFO_FULL                  BIT(0)
> > +#define SPRD_OUTBOX_FIFO_WR_SHIFT              16
> > +#define SPRD_OUTBOX_FIFO_RD_SHIFT              24
> > +#define SPRD_OUTBOX_FIFO_POS_MASK              GENMASK(7, 0)
> > +
> > +/* Bit and mask definiation for inbox's SPRD_MBOX_IRQ_MSK register */
> > +#define SPRD_INBOX_FIFO_BLOCK_IRQ              BIT(0)
> > +#define SPRD_INBOX_FIFO_OVERFLOW_IRQ           BIT(1)
> > +#define SPRD_INBOX_FIFO_DELIVER_IRQ            BIT(2)
> > +#define SPRD_INBOX_FIFO_IRQ_MASK               GENMASK(2, 0)
> > +
> > +/* Bit and mask definiation for outbox's SPRD_MBOX_IRQ_MSK register */
> > +#define SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ         BIT(0)
> > +#define SPRD_OUTBOX_FIFO_IRQ_MASK              GENMASK(4, 0)
> > +
> > +#define SPRD_MBOX_CHAN_MAX                     8
> > +
> > +struct sprd_mbox_chan {
> > +       u8                      id;
> > +       struct mbox_chan        *chan;
> > +};
> > +
> > +struct sprd_mbox_priv {
> > +       struct mbox_controller  mbox;
> > +       struct device           *dev;
> > +       void __iomem            *inbox_base;
> > +       void __iomem            *outbox_base;
> > +       struct clk              *clk;
> > +       u32                     outbox_fifo_depth;
> > +
> > +       struct sprd_mbox_chan   mchan[SPRD_MBOX_CHAN_MAX];
> > +       struct mbox_chan        chan[SPRD_MBOX_CHAN_MAX];
> > +};
> > +
> > +static struct sprd_mbox_priv *to_sprd_mbox_priv(struct mbox_controller *mbox)
> > +{
> > +       return container_of(mbox, struct sprd_mbox_priv, mbox);
> > +}
> > +
> > +static u32 sprd_mbox_get_fifo_len(struct sprd_mbox_priv *priv, u32 fifo_sts)
> > +{
> > +       u32 wr_pos = (fifo_sts >> SPRD_OUTBOX_FIFO_WR_SHIFT) &
> > +               SPRD_OUTBOX_FIFO_POS_MASK;
> > +       u32 rd_pos = (fifo_sts >> SPRD_OUTBOX_FIFO_RD_SHIFT) &
> > +               SPRD_OUTBOX_FIFO_POS_MASK;
> > +       u32 fifo_len;
> > +
> > +       /*
> > +        * If the read pointer is equal with write pointer, which means the fifo
> > +        * is full or empty.
> > +        */
> > +       if (wr_pos == rd_pos) {
> > +               if (fifo_sts & SPRD_OUTBOX_FIFO_FULL)
> > +                       fifo_len = priv->outbox_fifo_depth;
> > +               else
> > +                       fifo_len = 0;
> > +       } else if (wr_pos > rd_pos) {
> > +               fifo_len = wr_pos - rd_pos;
> > +       } else {
> > +               fifo_len = priv->outbox_fifo_depth - rd_pos + wr_pos;
> > +       }
> > +
> > +       return fifo_len;
> > +}
> > +
> > +static irqreturn_t sprd_mbox_outbox_isr(int irq, void *data)
> > +{
> > +       struct sprd_mbox_priv *priv = data;
> > +       struct sprd_mbox_chan *mchan;
> > +       u32 fifo_sts, fifo_len, msg[2];
> > +       int i, id;
> > +
> > +       fifo_sts = readl(priv->outbox_base + SPRD_MBOX_FIFO_STS);
> > +
> > +       fifo_len = sprd_mbox_get_fifo_len(priv, fifo_sts);
> > +       if (!fifo_len) {
> > +               dev_warn_ratelimited(priv->dev, "spurious outbox interrupt\n");
> > +               return IRQ_NONE;
> > +       }
> > +
> > +       for (i = 0; i < fifo_len; i++) {
> > +               msg[0] = readl(priv->outbox_base + SPRD_MBOX_MSG_LOW);
> > +               msg[1] = readl(priv->outbox_base + SPRD_MBOX_MSG_HIGH);
> > +               id = readl(priv->outbox_base + SPRD_MBOX_ID);
> > +
> > +               mchan = &priv->mchan[id];
> > +               mbox_chan_received_data(mchan->chan, (void *)msg);
> > +
> > +               /* Trigger to update outbox FIFO pointer */
> > +               writel(0x1, priv->outbox_base + SPRD_MBOX_TRIGGER);
> > +       }
> > +
> > +       /* Clear irq status after reading all message. */
> > +       writel(SPRD_MBOX_IRQ_CLR, priv->outbox_base + SPRD_MBOX_IRQ_STS);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t sprd_mbox_inbox_isr(int irq, void *data)
> > +{
> > +       struct sprd_mbox_priv *priv = data;
> > +       struct sprd_mbox_chan *mchan;
> > +       u32 fifo_sts, send_sts, id;
> > +
> > +       fifo_sts = readl(priv->inbox_base + SPRD_MBOX_FIFO_STS);
> > +
> > +       /* Get the inbox data delivery status */
> > +       send_sts = (fifo_sts & SPRD_INBOX_FIFO_DELIVER_MASK) >>
> > +               SPRD_INBOX_FIFO_DELIVER_SHIFT;
> > +       if (!send_sts) {
> > +               dev_warn_ratelimited(priv->dev, "spurious inbox interrupt\n");
> > +               return IRQ_NONE;
> > +       }
> > +
> > +       while (send_sts) {
> > +               id = __ffs(send_sts);
> > +               send_sts &= (send_sts - 1);
> > +
> > +               mchan = &priv->mchan[id];
> > +               mbox_chan_txdone(mchan->chan, 0);
> > +       }
> > +
> > +       /* Clear FIFO delivery and overflow status */
> > +       writel(fifo_sts &
> > +              (SPRD_INBOX_FIFO_DELIVER_MASK | SPRD_INBOX_FIFO_OVERLOW_MASK),
> > +              priv->inbox_base + SPRD_MBOX_FIFO_RST);
> > +
> > +       /* Clear irq status */
> > +       writel(SPRD_MBOX_IRQ_CLR, priv->inbox_base + SPRD_MBOX_IRQ_STS);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int sprd_mbox_send_data(struct mbox_chan *chan, void *msg)
> > +{
> > +       struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> > +       struct sprd_mbox_chan *mchan = chan->con_priv;
> > +       u32 *data = msg, busy;
> > +
> > +       /*
> > +        * Check if current channel is busy or not, and we can not send data
> > +        * if current channel is busy.
> > +        */
> > +       busy = readl(priv->inbox_base + SPRD_MBOX_FIFO_STS) &
> > +               SPRD_INBOX_FIFO_BUSY_MASK;
> > +       if (busy & BIT(mchan->id)) {
> > +               dev_err(priv->dev, "Channel %d is busy\n", mchan->id);
> > +               return -EBUSY;
> > +       }
> > +
> > +       /* Write data into inbox FIFO, and only support 8 bytes every time */
> > +       writel(data[0], priv->inbox_base + SPRD_MBOX_MSG_LOW);
> > +       writel(data[1], priv->inbox_base + SPRD_MBOX_MSG_HIGH);
> > +
> > +       /* Set target core id */
> > +       writel(mchan->id, priv->inbox_base + SPRD_MBOX_ID);
> > +
> > +       /* Trigger remote request */
> > +       writel(0x1, priv->inbox_base + SPRD_MBOX_TRIGGER);
> > +
> > +       return 0;
> > +}
> > +
> > +static int sprd_mbox_startup(struct mbox_chan *chan)
> > +{
> > +       struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> > +       u32 val;
> > +
> > +       /* Select outbox FIFO mode and reset the outbox FIFO status */
> > +       writel(0x0, priv->outbox_base + SPRD_MBOX_FIFO_RST);
> > +
> > +       /* Enable inbox FIFO overflow and delivery interrupt */
> > +       val = readl(priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > +       val &= ~(SPRD_INBOX_FIFO_OVERFLOW_IRQ | SPRD_INBOX_FIFO_DELIVER_IRQ);
> > +       writel(val, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > +
> > +       /* Enable outbox FIFO not empty interrupt */
> > +       val = readl(priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +       val &= ~SPRD_OUTBOX_FIFO_NOT_EMPTY_IRQ;
> > +       writel(val, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +
> > +       return 0;
> > +}
> > +
> > +static void sprd_mbox_shutdown(struct mbox_chan *chan)
> > +{
> > +       struct sprd_mbox_priv *priv = to_sprd_mbox_priv(chan->mbox);
> > +
> > +       /* Disable inbox & outbox interrupt */
> > +       writel(SPRD_INBOX_FIFO_IRQ_MASK, priv->inbox_base + SPRD_MBOX_IRQ_MSK);
> > +       writel(SPRD_OUTBOX_FIFO_IRQ_MASK, priv->outbox_base + SPRD_MBOX_IRQ_MSK);
> > +}
> > +
> > +static const struct mbox_chan_ops sprd_mbox_ops = {
> > +       .send_data    = sprd_mbox_send_data,
> > +       .startup      = sprd_mbox_startup,
> > +       .shutdown     = sprd_mbox_shutdown,
> > +};
> > +
> > +static void sprd_mbox_disable(void *data)
> > +{
> > +       struct sprd_mbox_priv *priv = data;
> > +
> > +       clk_disable_unprepare(priv->clk);
> > +}
> > +
> > +static int sprd_mbox_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct sprd_mbox_priv *priv;
> > +       int i, ret, inbox_irq, outbox_irq;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->dev = dev;
> > +
> > +       /*
> > +        * The Spreadtrum mailbox uses an inbox to send messages to the target
> > +        * core, and uses an outbox to receive messages from other cores.
> > +        *
> > +        * Thus the mailbox controller supplies 2 different register addresses
> > +        * and IRQ numbers for inbox and outbox.
> > +        */
> > +       priv->inbox_base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(priv->inbox_base))
> > +               return PTR_ERR(priv->inbox_base);
> > +
> > +       priv->outbox_base = devm_platform_ioremap_resource(pdev, 1);
> > +       if (IS_ERR(priv->outbox_base))
> > +               return PTR_ERR(priv->outbox_base);
> > +
> > +       priv->clk = devm_clk_get(dev, "enable");
> > +       if (IS_ERR(priv->clk)) {
> > +               dev_err(dev, "failed to get mailbox clock\n");
> > +               return PTR_ERR(priv->clk);
> > +       }
> > +
> > +       ret = clk_prepare_enable(priv->clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
> > +       if (ret) {
> > +               dev_err(dev, "failed to add mailbox disable action\n");
> > +               return ret;
> > +       }
> > +
> > +       inbox_irq = platform_get_irq(pdev, 0);
> > +       if (inbox_irq < 0)
> > +               return inbox_irq;
> > +
> > +       ret = devm_request_irq(dev, inbox_irq, sprd_mbox_inbox_isr,
> > +                              IRQF_NO_SUSPEND, dev_name(dev), priv);
> > +       if (ret) {
> > +               dev_err(dev, "failed to request inbox IRQ: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       outbox_irq = platform_get_irq(pdev, 1);
> > +       if (outbox_irq < 0)
> > +               return outbox_irq;
> > +
> > +       ret = devm_request_irq(dev, outbox_irq, sprd_mbox_outbox_isr,
> > +                              IRQF_NO_SUSPEND, dev_name(dev), priv);
> > +       if (ret) {
> > +               dev_err(dev, "failed to request outbox IRQ: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       /* Get the default outbox FIFO depth */
> > +       priv->outbox_fifo_depth =
> > +               readl(priv->outbox_base + SPRD_MBOX_FIFO_DEPTH) + 1;
> > +       priv->mbox.dev = dev;
> > +       priv->mbox.chans = &priv->chan[0];
> > +       priv->mbox.num_chans = SPRD_MBOX_CHAN_MAX;
> > +       priv->mbox.ops = &sprd_mbox_ops;
> > +       priv->mbox.txdone_irq = true;
> > +
> > +       for (i = 0; i < SPRD_MBOX_CHAN_MAX; i++) {
> > +               priv->chan[i].con_priv = &priv->mchan[i];
> > +
> > +               priv->mchan[i].chan = &priv->chan[i];
> > +               priv->mchan[i].id = i;
> > +       }
> > +
> > +       ret = devm_mbox_controller_register(dev, &priv->mbox);
> > +       if (ret) {
> > +               dev_err(dev, "failed to register mailbox: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id sprd_mbox_of_match[] = {
> > +       { .compatible = "sprd,sc9860-mailbox", },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, sprd_mbox_of_match);
> > +
> > +static struct platform_driver sprd_mbox_driver = {
> > +       .driver = {
> > +               .name = "sprd-mailbox",
> > +               .of_match_table = sprd_mbox_of_match,
> > +       },
> > +       .probe  = sprd_mbox_probe,
> > +};
> > +module_platform_driver(sprd_mbox_driver);
> > +
> > +MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
> > +MODULE_DESCRIPTION("Spreadtrum mailbox driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 1.9.1
> >
>
>
> --
> Baolin Wang



-- 
Baolin Wang
