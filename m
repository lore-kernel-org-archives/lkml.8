Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCAC83003
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64FC206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1P3PyC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgD1DGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:06:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0CC03C1A9;
        Mon, 27 Apr 2020 20:06:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so16958560ljj.11;
        Mon, 27 Apr 2020 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRSh6bM9XP0azbhFTCMzRWuFhD8+MW6Kxy/FSqtXLPk=;
        b=n1P3PyC90pe6PHwGpU3m7XTda+91bMKaQ0Duk39nY72xGoewIBIuuXB0sw51HgMuKT
         cVqA9VamlTQ3X/NUwDdX+9hiXRUxdYnRdFZTxonbUY0ZF5A8oD/kQBNW0488o1UaVgVa
         ACGMnFK2cV9KOvcNP6sTVFjq36UaMWPM7TXgK5IKPW0KJxET8ZU9j8Hd8tPoC70SouDf
         72NY/9IhT++TXKVC32BWCwqTyGJXTUaakDPaVzW7rTUy14n4fQgH2Y3JIm7ktahE0Wrr
         sUq9e4Tfn9ntpfJP2A4KAz55StcyNBg3r89H7j0GLNsLbqmYiIgps3vLiU8UMDznel6p
         2+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRSh6bM9XP0azbhFTCMzRWuFhD8+MW6Kxy/FSqtXLPk=;
        b=mI5xVgNEFsNTO1Le3V7YMT3PbG3Ceav6wdKoFRM3tv68eUmghVkGDAsAi2nQ3XeW3e
         8KM/Er5bg+8snw1BxzJCiofAX/kCAbI3JHHKIyYOmlzUA+gy+oLoI0VahLOU81syqxnu
         mhVwo8brY8ea1iaHDW/wslHW9SqpHFX3RXBpoCcK8970hkuAjSqV4QyaU7bGeYPFcpva
         3lOyXvAxEq9JUHxXvIfTzU5ILlhXNMKarbFX1cQK2XZyGXg2qhcvpnkKDZV/A16vNb4H
         g9VhEnJ0iBofudSTVZwXl3dXiPbtQpKwWdhfnq8tScsWH7QTX5HA/F++gxX/3IhtCtpq
         fGxQ==
X-Gm-Message-State: AGi0PuYaGsqXzspYk1bvhswB3LMwQEf1RSPp/5x7rOpmTaSsMibuciwM
        nk1Y4/2bJvQc5VpfyDObXMZhKCU0FNQIwVaVeDmwXn+wcMc=
X-Google-Smtp-Source: APiQypL2kd2Gi0EBH+kdmVbmL2dRpZPQ0G3ZQJhyORxU/boq6BgLN+RFAu55XUj+xaRUyc1MlY+QJl5k9f/sT1ozG1c=
X-Received: by 2002:a05:651c:2011:: with SMTP id s17mr15121456ljo.242.1588043187420;
 Mon, 27 Apr 2020 20:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1587894279.git.baolin.wang7@gmail.com>
 <6f8ac1af5a43d6fd487dc21c052624277325e6f1.1587894279.git.baolin.wang7@gmail.com>
 <CABb+yY31zAr9xfS3bWC5k=94L921CyhzA7fot3eJP1WYSvNCpw@mail.gmail.com>
In-Reply-To: <CABb+yY31zAr9xfS3bWC5k=94L921CyhzA7fot3eJP1WYSvNCpw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 28 Apr 2020 11:06:16 +0800
Message-ID: <CADBw62pk7AtahXXMqrHo4Fh64TQC_2k4VWZ2U47LGxZv41o4Fg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On Tue, Apr 28, 2020 at 4:19 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Mon, Apr 27, 2020 at 2:20 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang@unisoc.com>
> >
> > The Spreadtrum mailbox controller supports 8 channels to communicate
> > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > are used to send and receive messages by IRQ mode.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> > Changes from v2:
> >  - None.
> >
> > Changes from v1:
> >  - None
> > ---
> >  drivers/mailbox/Kconfig        |   8 +
> >  drivers/mailbox/Makefile       |   2 +
> >  drivers/mailbox/sprd-mailbox.c | 350 +++++++++++++++++++++++++++++++++
> >  3 files changed, 360 insertions(+)
> >  create mode 100644 drivers/mailbox/sprd-mailbox.c
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 5a577a6734cf..e03f3fb5caed 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -236,4 +236,12 @@ config SUN6I_MSGBOX
> >           various Allwinner SoCs. This mailbox is used for communication
> >           between the application CPUs and the power management coprocessor.
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
> > index 2e4364ef5c47..9caf4ede6ce0 100644
> > --- a/drivers/mailbox/Makefile
> > +++ b/drivers/mailbox/Makefile
> > @@ -50,3 +50,5 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)   += mtk-cmdq-mailbox.o
> >  obj-$(CONFIG_ZYNQMP_IPI_MBOX)  += zynqmp-ipi-mailbox.o
> >
> >  obj-$(CONFIG_SUN6I_MSGBOX)     += sun6i-msgbox.o
> > +
> > +obj-$(CONFIG_SPRD_MBOX)                += sprd-mailbox.o
> > diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
> > new file mode 100644
> > index 000000000000..58e5388f190b
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
> If 'id' is all you need, please assign that to mbox_chan.con_priv and
> discard the sprd_mbox_chan. That will be much simpler.

Yes, will do in next version.

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
> .........
>
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
> Maybe check this before  mbox_chan_txdone(mchan->chan, 0) and avoid
> failing in send_data.

This is used to check if the target core have fetched the message from
the FIFO or not, if not, we can not send any more message, otherwise
the message will be overflowed.

Thanks for your comments.

-- 
Baolin Wang
