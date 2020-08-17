Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E48C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7962054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677254;
	bh=hqEMfNYoKv2H/A9NzWzm3pq6Ot1n4/y/J+WGuaOxqMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YOI1TAIT6qQXH1PFwPb48lsb6hoDemdnDS0rXMP9OGjzM/gmOJaq/9/dh3d/Is9lc
	 Yz6ys60AgPBLc55KPcPRndgVOGRZbQpUwYQaqWCNP63Mr2LHRhZtsvv/jJOTlNZc8P
	 qsQV+sSRdmdRC837/go15mAICCMwqwV4j+5vcF+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgHQPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:14:11 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1274A206FA;
        Mon, 17 Aug 2020 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677250;
        bh=hqEMfNYoKv2H/A9NzWzm3pq6Ot1n4/y/J+WGuaOxqMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sj4XnJIEDsVqpYNelJN42gpLdtuvPyZFo+ro80ps5X1fNlN/EEWNnpxGm92khy4Lx
         maruxkU2rTx7p++FLm8BfGzV8SdWIqHqPg3QRh0+IMhm1z9xBygMGnywg8GxrBQgC+
         JPiQrofIkFExUoSg+dk7StvMEvdHJ0n3Dwi/NZ7o=
Received: by mail-ej1-f50.google.com with SMTP id bo3so18126248ejb.11;
        Mon, 17 Aug 2020 08:14:09 -0700 (PDT)
X-Gm-Message-State: AOAM533ZI6LdQ9NKY2jaUFUXDNSxeIBTsKW3Yg3X9XmVr+/85tyjyjE3
        s2Pl7OuRXbVSQgw7QN1zPg9kZf03zXDD1/k91g==
X-Google-Smtp-Source: ABdhPJwbE2nEYvLa7dwJUU9IVHpeywzEtAxNOSighTuc9Ly6OaPt76S0xzF2xY1xirFF+T46DK/F0HVQWCkErsPlpOg=
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr15233703eja.124.1597677248601;
 Mon, 17 Aug 2020 08:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com>
 <1597289564-17030-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
 <1597636953.3394.7.camel@mtkswgap22>
In-Reply-To: <1597636953.3394.7.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 17 Aug 2020 23:13:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY__7gmvp+U+xD12KJkxuya=CkD8xV67S3pfC60gyfajQiA@mail.gmail.com>
Message-ID: <CAAOTY__7gmvp+U+xD12KJkxuya=CkD8xV67S3pfC60gyfajQiA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8817=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Sat, 2020-08-15 at 11:03 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > MediaTek bus fabric provides TrustZone security support and data
> > > protection to prevent slaves from being accessed by unexpected
> > > masters.
> > > The security violation is logged and sent to the processor for
> > > further analysis or countermeasures.
> > >
> > > Any occurrence of security violation would raise an interrupt, and
> > > it will be handled by mtk-devapc driver. The violation
> > > information is printed in order to find the murderer.
> > >
> > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > ---
> >
> > [snip]
> >
> > > +/*
> > > + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR)=
 will dump
> > > + *                        violation information including which mast=
er violates
> > > + *                        access slave.
> > > + */
> > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > +                                       struct mtk_devapc_context *ct=
x)
> > > +{
> > > +       /*
> > > +        * Mask slave's irq before clearing vio status.
> > > +        * Must do it to avoid nested interrupt and prevent
> > > +        * unexpected behavior.
> > > +        */
> > > +       mask_module_irq(ctx, true);
> >
> > I still don't understand why nested interrupt happen. If two CPU
> > process different devapc interrupt at the same time, mask interrupt
> > could not prevent these two CPU to sync vio dbg at the same time. As I
> > know, in ARM CPU, only CPU0 process irq handler, and all devapc
> > interrupt has the same priority, so why nested interrupt happen? Could
> > you explain more detail about how nested interrupt happen?
>
> If there is another violation happened before previous violation is
> fully handled, nested interrupt would happen.
>
> Let's me take an example:
> vio A happen
> enter A ISR
> ...             vio B happen
> finish A ISR    enter B ISR
>                 ...
>                 finish B ISR
>
> We mask all module's irq to avoid nested interrupt.

This is not 'nested' interrupt. After A ISR is finished, B ISR happen.
So A ISR and B ISR are consecutive interrupt, not nested interrupt.
To compare mask irq and no mask irq, Let's consider this situation:

1. 1000 consecutive violation happen, the time period between two
violation is 0.01 ms, so the total time is 10ms. (In 10ms, 1000
violation happen)
2. One ISR handle time is 1 ms, so in one ISR handler, 100 violation happen=
.

For mask irq solution, 10 ISR handler is trigger. For no mask irq
solution, 11 ISR handler is trigger.
I think these two solution have similar result, and no mask irq
solution print more information (If these 1000 violation is trigger by
20 different driver, no mask solution may show one more driver than
mask solution)
So I think it's not necessary to mask irq in irq handler.

>
> >
> > > +
> > > +       while (devapc_sync_vio_dbg(ctx))
> > > +               devapc_extract_vio_dbg(ctx);
> > > +
> > > +       /*
> > > +        * Ensure that violation info are written
> > > +        * before further operations
> > > +        */
> > > +       smp_mb();
> > > +
> > > +       clear_vio_status(ctx);
> > > +       mask_module_irq(ctx, false);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> >
> > [snip]
> >
> > > +
> > > +static int mtk_devapc_remove(struct platform_device *pdev)
> > > +{
> > > +       struct mtk_devapc_context *ctx =3D platform_get_drvdata(pdev)=
;
> > > +
> > > +       stop_devapc(ctx);
> > > +
> > > +       if (ctx->infra_clk)
> >
> > This always true.
>
> Does it mean that remove function would be called only if probe function
> is returned successfully?

Yes.

> Is there any chance this function would be called directly?

No.

Regards,
Chun-Kuang.

>
> >
> > Regards,
> > Chun-Kuang.
> >
> > > +               clk_disable_unprepare(ctx->infra_clk);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static struct platform_driver mtk_devapc_driver =3D {
> > > +       .probe =3D mtk_devapc_probe,
> > > +       .remove =3D mtk_devapc_remove,
> > > +       .driver =3D {
> > > +               .name =3D KBUILD_MODNAME,
> > > +               .of_match_table =3D mtk_devapc_dt_match,
> > > +       },
> > > +};
> > > +
> > > +module_platform_driver(mtk_devapc_driver);
> > > +
> > > +MODULE_DESCRIPTION("Mediatek Device APC Driver");
> > > +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
> > > +MODULE_LICENSE("GPL");
> > > --
> > > 1.7.9.5
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
