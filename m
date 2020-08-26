Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2669C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9462A207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598479174;
	bh=BrP5+luDzcaKbNl9TP+ZZA+bkFzfPAFW3jQvvE+kl9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lxa9mwmZ2blkO2TIu8QyR+qKtin1hSRmbPlyi0qxyFJyI+vdqvlfTmxgPyAJYqcUp
	 8fWI4B4CUYsD0FrTVSYlDsxk3YOhDY0N+cZ7saSUTda1S235xO5dh/53RmzvchyvN8
	 sJpICNpNh77q6Ag9m/imiERIf5sqhzyVAwu5d4UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHZV7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZV7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:59:30 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48AB207CD;
        Wed, 26 Aug 2020 21:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598479169;
        bh=BrP5+luDzcaKbNl9TP+ZZA+bkFzfPAFW3jQvvE+kl9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cZtq4Si/mXrq5gsupDzVsBJpK1JfTk75Q/lxyLqDBUf8fosENOFHvvRVL9e5Z/tov
         XaaPdfS2OV6qY6AwLe/mAhnlllf7jMrL1cIHAB4Ott205xJwWmmTSKn8OhwfHmZTYH
         BaWC+Ngu4Y1auOPKMx0vtQKlmnfeA10n8me7A154=
Received: by mail-ej1-f45.google.com with SMTP id d26so4968020ejr.1;
        Wed, 26 Aug 2020 14:59:28 -0700 (PDT)
X-Gm-Message-State: AOAM531pBZtkU6BYkPG1oRXNC2DetSQ4d6H1xqyzLZxDQdE7UFpRPhBf
        Cpb/WgicPKoN8G8hLZIApD27Tg+jzobFvCxZmg==
X-Google-Smtp-Source: ABdhPJy6EZRoJAW/N3n2yX5Xeg201W/2e0zB+iCU5WqtwgRqX6a7/Zh/oip57VtbnC0hJ5vx+Vs4NHXZ/39zaoaHIbw=
X-Received: by 2002:a17:906:3a41:: with SMTP id a1mr17670334ejf.260.1598479167274;
 Wed, 26 Aug 2020 14:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com>
 <1597289564-17030-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
 <1597636953.3394.7.camel@mtkswgap22> <CAAOTY__7gmvp+U+xD12KJkxuya=CkD8xV67S3pfC60gyfajQiA@mail.gmail.com>
 <1597718679.5704.3.camel@mtkswgap22> <1597731644.12680.2.camel@mtkswgap22> <1598435993.17926.5.camel@mtkswgap22>
In-Reply-To: <1598435993.17926.5.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 27 Aug 2020 05:59:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9BJES3sqz4aO-eKJ1zDWTzsuyOkA0xLxy8wf2ZOyJCfQ@mail.gmail.com>
Message-ID: <CAAOTY_9BJES3sqz4aO-eKJ1zDWTzsuyOkA0xLxy8wf2ZOyJCfQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Tue, 2020-08-18 at 14:20 +0800, Neal Liu wrote:
> > Hi Chun-Kuang,
> >
> > On Tue, 2020-08-18 at 10:44 +0800, Neal Liu wrote:
> > > Hi Chun-Kuang,
> > >
> > > On Mon, 2020-08-17 at 23:13 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:02=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > Hi Chun-Kuang,
> > > > >
> > > > > On Sat, 2020-08-15 at 11:03 +0800, Chun-Kuang Hu wrote:
> > > > > > Hi, Neal:
> > > > > >
> > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > MediaTek bus fabric provides TrustZone security support and d=
ata
> > > > > > > protection to prevent slaves from being accessed by unexpecte=
d
> > > > > > > masters.
> > > > > > > The security violation is logged and sent to the processor fo=
r
> > > > > > > further analysis or countermeasures.
> > > > > > >
> > > > > > > Any occurrence of security violation would raise an interrupt=
, and
> > > > > > > it will be handled by mtk-devapc driver. The violation
> > > > > > > information is printed in order to find the murderer.
> > > > > > >
> > > > > > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > > > > > ---
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > > +/*
> > > > > > > + * devapc_violation_irq - the devapc Interrupt Service Routi=
ne (ISR) will dump
> > > > > > > + *                        violation information including wh=
ich master violates
> > > > > > > + *                        access slave.
> > > > > > > + */
> > > > > > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > > > > > +                                       struct mtk_devapc_con=
text *ctx)
> > > > > > > +{
> > > > > > > +       /*
> > > > > > > +        * Mask slave's irq before clearing vio status.
> > > > > > > +        * Must do it to avoid nested interrupt and prevent
> > > > > > > +        * unexpected behavior.
> > > > > > > +        */
> > > > > > > +       mask_module_irq(ctx, true);
> > > > > >
> > > > > > I still don't understand why nested interrupt happen. If two CP=
U
> > > > > > process different devapc interrupt at the same time, mask inter=
rupt
> > > > > > could not prevent these two CPU to sync vio dbg at the same tim=
e. As I
> > > > > > know, in ARM CPU, only CPU0 process irq handler, and all devapc
> > > > > > interrupt has the same priority, so why nested interrupt happen=
? Could
> > > > > > you explain more detail about how nested interrupt happen?
> > > > >
> > > > > If there is another violation happened before previous violation =
is
> > > > > fully handled, nested interrupt would happen.
> > > > >
> > > > > Let's me take an example:
> > > > > vio A happen
> > > > > enter A ISR
> > > > > ...             vio B happen
> > > > > finish A ISR    enter B ISR
> > > > >                 ...
> > > > >                 finish B ISR
> > > > >
> > > > > We mask all module's irq to avoid nested interrupt.
> > > >
> > > > This is not 'nested' interrupt. After A ISR is finished, B ISR happ=
en.
> > > > So A ISR and B ISR are consecutive interrupt, not nested interrupt.
> > > > To compare mask irq and no mask irq, Let's consider this situation:
> > > >
> > > > 1. 1000 consecutive violation happen, the time period between two
> > > > violation is 0.01 ms, so the total time is 10ms. (In 10ms, 1000
> > > > violation happen)
> > > > 2. One ISR handle time is 1 ms, so in one ISR handler, 100 violatio=
n happen.
> > > >
> > > > For mask irq solution, 10 ISR handler is trigger. For no mask irq
> > > > solution, 11 ISR handler is trigger.
> > > > I think these two solution have similar result, and no mask irq
> > > > solution print more information (If these 1000 violation is trigger=
 by
> > > > 20 different driver, no mask solution may show one more driver than
> > > > mask solution)
> > > > So I think it's not necessary to mask irq in irq handler.
> > > >
> > >
> > > No, my example is B ISR is entered before A ISR finished.
> > > Why this is not nested?
> > > vio A happen
> > > enter A ISR
> > > ...             vio B happen
> > > ...         enter B ISR
> > > finish A ISR
> > >                 ...
> > >             ...
> > >                 finish B ISR
> > >
> >
> > I have some misunderstanding about how ARM CPU & GIC works. I'll confir=
m
> > it and get back to you. Please ignore previous mail thread.
> > Thanks !
>
> Yes, you are right. There is only 1 CPU (CPU0) will process irq handler
> in ARM CPU. Nested interrupt will never happen.
> The reason why I have misunderstanding is that Mediatek has some
> customization about irq handling for ARM CPUs. But it would not applied
> in upstream kernel.
>
> Let remove mask/unmask module irq during ISR. The diff would be:
>
> diff --git a/drivers/soc/mediatek/mtk-devapc.c
> b/drivers/soc/mediatek/mtk-devapc.c
> index 5189b3f4d63f..0ba61d742e0e 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -183,24 +183,10 @@ static void devapc_extract_vio_dbg(struct
> mtk_devapc_context *ctx)
>  static irqreturn_t devapc_violation_irq(int irq_number,
>                                         struct mtk_devapc_context *ctx)
>  {
> -       /*
> -        * Mask slave's irq before clearing vio status.
> -        * Must do it to avoid nested interrupt and prevent
> -        * unexpected behavior.
> -        */
> -       mask_module_irq(ctx, true);
> -
>         while (devapc_sync_vio_dbg(ctx))
>                 devapc_extract_vio_dbg(ctx);
>
> -       /*
> -        * Ensure that violation info are written
> -        * before further operations
> -        */
> -       smp_mb();
> -
>         clear_vio_status(ctx);
> -       mask_module_irq(ctx, false);
>
>         return IRQ_HANDLED;
>  }
>
> Is that okay for you?

Looks good to me.

Regards,
Chun-Kuang.

> Thanks !
>
> >
> > > > >
> > > > > >
> > > > > > > +
> > > > > > > +       while (devapc_sync_vio_dbg(ctx))
> > > > > > > +               devapc_extract_vio_dbg(ctx);
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Ensure that violation info are written
> > > > > > > +        * before further operations
> > > > > > > +        */
> > > > > > > +       smp_mb();
> > > > > > > +
> > > > > > > +       clear_vio_status(ctx);
> > > > > > > +       mask_module_irq(ctx, false);
> > > > > > > +
> > > > > > > +       return IRQ_HANDLED;
> > > > > > > +}
> > > > > > > +
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > > +
> > > > > > > +static int mtk_devapc_remove(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +       struct mtk_devapc_context *ctx =3D platform_get_drvda=
ta(pdev);
> > > > > > > +
> > > > > > > +       stop_devapc(ctx);
> > > > > > > +
> > > > > > > +       if (ctx->infra_clk)
> > > > > >
> > > > > > This always true.
> > > > >
> > > > > Does it mean that remove function would be called only if probe f=
unction
> > > > > is returned successfully?
> > > >
> > > > Yes.
> > > >
> > > > > Is there any chance this function would be called directly?
> > > >
> > > > No.
> > > >
> > > > Regards,
> > > > Chun-Kuang.
> > > >
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Chun-Kuang.
> > > > > >
> > > > > > > +               clk_disable_unprepare(ctx->infra_clk);
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static struct platform_driver mtk_devapc_driver =3D {
> > > > > > > +       .probe =3D mtk_devapc_probe,
> > > > > > > +       .remove =3D mtk_devapc_remove,
> > > > > > > +       .driver =3D {
> > > > > > > +               .name =3D KBUILD_MODNAME,
> > > > > > > +               .of_match_table =3D mtk_devapc_dt_match,
> > > > > > > +       },
> > > > > > > +};
> > > > > > > +
> > > > > > > +module_platform_driver(mtk_devapc_driver);
> > > > > > > +
> > > > > > > +MODULE_DESCRIPTION("Mediatek Device APC Driver");
> > > > > > > +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
> > > > > > > +MODULE_LICENSE("GPL");
> > > > > > > --
> > > > > > > 1.7.9.5
> > > > > > > _______________________________________________
> > > > > > > Linux-mediatek mailing list
> > > > > > > Linux-mediatek@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > > > >
> > >
> > >
> >
> >
>
