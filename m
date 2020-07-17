Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7E42070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVSu3R8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGQJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:36:02 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F801C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:36:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so6815571ilh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L84Tbx7w0d/FjjhoBml/6zKrkq6kkL1C9n9lSr0rc/U=;
        b=TVSu3R8vblnAn5ZK5sAEJ+9hv/lK9MiA0wmU1CwnleVCQmsnYALB/Vc/ze+H2gGMvq
         tsqiOZUVPTVdKnoIGUTLjOpeOfhUfL7TLCdBz/X5kEGhK/x8kLRjmUbhB8MwQAvgrD9v
         KsePMnmSw478OY/u1qtLCvsl1PaPI22ULkpOoE+B1SLvHJkYlQi8PGXJqPCKkFI/C86z
         BtGzQOWO+uPQ36Ne6FgLsJqymyZy5b7dUNDyJcXke3GZRjMgQ9Zlq4ywjPgQhG7WB3rv
         wMq5vlwFeACP1DTiCwbTFEEq5z8gOZPUWRVe5UAO6SWXV4MNWIhSJDd8ymhnno9M9Cpb
         rrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L84Tbx7w0d/FjjhoBml/6zKrkq6kkL1C9n9lSr0rc/U=;
        b=IJIPjBJMomAlKBPqpZUDbU1RUD2GGB+13nHYbd31mWUJP7+DkG9e1tdjtGBRicvdsX
         rPgG6a8M88VaJRknBWdZ8kaFRPGuxsNUphNEVBvTROOCa7B2/QoHNo4icXgBs//TcaFe
         +bNK+lWfZGSJqNTLSRmie8SKw9b7nxBYjiH42JqkWl6WSwzxaVGbEnRby+IXkUXs0D17
         22oQQNuTBz1BGOAOaq+KQtFlQJgCfE5VJU8MpRQchlqhWBRlM8yELym0lZcevxV9OGzp
         RdPbhms6nT/V10SSSwF261cUtb9eksljk7zqbw1Ldjbk7BOTz45gXefQeet7RwQW6rOk
         O9fg==
X-Gm-Message-State: AOAM532SMriE7dYCZKyAYJerDqm5ULuxoRjg2JAbgnjWOzdPUXngj9a7
        nLGPaip8WDLPZoDRHtei79/lRf9/SwSyau0mnXIpSVU9
X-Google-Smtp-Source: ABdhPJzdRLQEWD5KEnJXho9QuzH8yzwMLhvMYZTnoeaBUtabb83DQnHYclQRjD/suTWVT1hLulwAtNpjcxQndykcoQQ=
X-Received: by 2002:a92:9f96:: with SMTP id z22mr9183788ilk.266.1594978561818;
 Fri, 17 Jul 2020 02:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-3-git-send-email-gene.chen.richtek@gmail.com> <8fa489a0-7672-cbbd-ec04-32803ca69084@gmail.com>
In-Reply-To: <8fa489a0-7672-cbbd-ec04-32803ca69084@gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 17 Jul 2020 17:35:50 +0800
Message-ID: <CAE+NS36ubtAVLwYxw_3ZEAHzOr_TFVNZKo+r0WCPARoukbJHzQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mfd: mt6360: Remove handle_post_irq callback function
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:22=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 07/07/2020 12:30, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Remove handle_post_irq which is used to retrigger irq.
> > Set irq level low trigger to keep irq always be handled.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >   drivers/mfd/mt6360-core.c  | 25 ++++++++-----------------
> >   include/linux/mfd/mt6360.h |  6 +++---
> >   2 files changed, 11 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index 5dfc13e..2dd5918 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -208,24 +208,16 @@ static const struct regmap_irq mt6360_irqs[] =3D =
 {
> >       REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
> >   };
> >
> > -static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
> > -{
> > -     struct mt6360_data *data =3D irq_drv_data;
> > -
> > -     return regmap_update_bits(data->regmap,
> > -             MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG)=
;
> > -}
> > -
> > -static struct regmap_irq_chip mt6360_irq_chip =3D {
> > +static const struct regmap_irq_chip mt6360_irq_chip =3D {
> > +     .name =3D "mt6360_irqs",
> >       .irqs =3D mt6360_irqs,
> >       .num_irqs =3D ARRAY_SIZE(mt6360_irqs),
> > -     .num_regs =3D MT6360_PMU_IRQ_REGNUM,
> > -     .mask_base =3D MT6360_PMU_CHG_MASK1,
> > -     .status_base =3D MT6360_PMU_CHG_IRQ1,
> > -     .ack_base =3D MT6360_PMU_CHG_IRQ1,
> > +     .num_regs =3D MT6360_IRQ_REGNUM,
> > +     .mask_base =3D MT6360_REG_PMU_CHGMASK1,
> > +     .status_base =3D MT6360_REG_PMU_CHGIRQ1,
> > +     .ack_base =3D MT6360_REG_PMU_CHGIRQ1,
>
> Non relevant patches for the commit. Please drop this.
>

ACK

> >       .init_ack_masked =3D true,
> >       .use_ack =3D true,
> > -     .handle_post_irq =3D mt6360_pmu_handle_post_irq,
> >   };
> >
> >   static const struct regmap_config mt6360_pmu_regmap_config =3D {
> > @@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
> >               return -ENODEV;
> >       }
> >
> > -     mt6360_irq_chip.irq_drv_data =3D data;
> >       ret =3D devm_regmap_add_irq_chip(&client->dev, data->regmap, clie=
nt->irq,
> > -                                    IRQF_TRIGGER_FALLING, 0,
> > -                                    &mt6360_irq_chip, &data->irq_data)=
;
> > +                                    IRQF_ONESHOT, 0, &mt6360_irq_chip,
>
>  From what I see IRQF_ONESHOT is set implicitly in regmap_add_irq_chip_fw=
node.
> Actually I think what you want to add is IRQF_TRIGGER_LOW.
>

ACK.
I will modify argument "irqflags" to 0, because irq trigger type is
set by of_irq_get function

> > +                                    &data->irq_data);
> >       if (ret) {
> >               dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
> >               return ret;
> > diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> > index 76077e4..9fc6718 100644
> > --- a/include/linux/mfd/mt6360.h
> > +++ b/include/linux/mfd/mt6360.h
> > @@ -179,7 +179,7 @@ struct mt6360_data {
> >   #define MT6360_PMU_SPARE2                   (0xA0)
> >   #define MT6360_PMU_SPARE3                   (0xB0)
> >   #define MT6360_PMU_SPARE4                   (0xC0)
> > -#define MT6360_PMU_CHG_IRQ1                  (0xD0)
> > +#define MT6360_REG_PMU_CHGIRQ1                       (0xD0)
> >   #define MT6360_PMU_CHG_IRQ2                 (0xD1)
> >   #define MT6360_PMU_CHG_IRQ3                 (0xD2)
> >   #define MT6360_PMU_CHG_IRQ4                 (0xD3)
> > @@ -211,7 +211,7 @@ struct mt6360_data {
> >   #define MT6360_PMU_BUCK2_STAT                       (0xED)
> >   #define MT6360_PMU_LDO_STAT1                        (0xEE)
> >   #define MT6360_PMU_LDO_STAT2                        (0xEF)
> > -#define MT6360_PMU_CHG_MASK1                 (0xF0)
> > +#define MT6360_REG_PMU_CHGMASK1                      (0xF0)
> >   #define MT6360_PMU_CHG_MASK2                        (0xF1)
> >   #define MT6360_PMU_CHG_MASK3                        (0xF2)
> >   #define MT6360_PMU_CHG_MASK4                        (0xF3)
> > @@ -230,7 +230,7 @@ struct mt6360_data {
> >   #define MT6360_PMU_MAXREG                   (MT6360_PMU_LDO_MASK2)
> >
> >   /* MT6360_PMU_IRQ_SET */
> > -#define MT6360_PMU_IRQ_REGNUM        (MT6360_PMU_LDO_IRQ2 - MT6360_PMU=
_CHG_IRQ1 + 1)
>
> Not relevant for the commit. But why did you use this strange computation=
 in the
> first place?
>

I wanted to emphasize irq range with start and end address.

> > +#define MT6360_IRQ_REGNUM    16
> >   #define MT6360_IRQ_RETRIG   BIT(2)
> >
> >   #define CHIP_VEN_MASK                               (0xF0)
> >
