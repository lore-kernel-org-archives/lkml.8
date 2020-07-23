Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36369C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C39206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595521937;
	bh=UsE0AfyyH9ASPhZTnv7rHkKV2A1QkqMr7Pj3l5isRpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Oi1QUgFjbbEEdLEj71VO7khuJkgBkf/Tzi6tXiNdt+RxNvRbHkom347tLocXagGAs
	 8SxDdGSK9KGUf0IS+n3rfntiHoAq5rkDVGE+/38O3VfkRHjsamLy1O3/Vgu0KxT3q3
	 1yWOCyOl1RubeRzaPz7p/kjviGrwG3NdbA1UIwW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgGWQcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:32:15 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0ACC206F4;
        Thu, 23 Jul 2020 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595521934;
        bh=UsE0AfyyH9ASPhZTnv7rHkKV2A1QkqMr7Pj3l5isRpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bO22246CLB+6Y85wT9sR8OfksIMvslPN0d6PY6Z1fDrwncHCz7S7WQGLe4vDVJHRF
         xHNUH0d8FJaQhBWKzmQf+3JWJdo0M0jl3QCXzSyAnkfHV0Cj6YH7haYvdpblpiWsoO
         wlLNFtk5bP/EiZlb5mKEGbxK9+kzU1HMLchHxM8M=
Received: by mail-ed1-f42.google.com with SMTP id d18so4973452edv.6;
        Thu, 23 Jul 2020 09:32:14 -0700 (PDT)
X-Gm-Message-State: AOAM532QQlAIqN8HVPlzreYM+OHg4eTrw7YHxmbr/+BaGkW2d5mlrmhm
        8Pe0iG1k7zUJ+L0L6PmIA/UCSM0Ofc+iTpekFQ==
X-Google-Smtp-Source: ABdhPJyRm/l9dPj0W+dfDKiakdRmDJRlB3h26Hb6zg+r04P5orwxjTD/vSWsiavEJACFhMP/gwvhQEf/i1OLYSZOpWs=
X-Received: by 2002:a50:e617:: with SMTP id y23mr4915055edm.47.1595521933191;
 Thu, 23 Jul 2020 09:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
 <1595303971-8793-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
 <1595389756.20193.12.camel@mtkswgap22> <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
 <1595484707.26237.12.camel@mtkswgap22>
In-Reply-To: <1595484707.26237.12.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 24 Jul 2020 00:32:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
Message-ID: <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Wed, 2020-07-22 at 22:25 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > On Wed, 2020-07-22 at 07:21 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=882=
1=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > >
> > > > > +
> > > > > +/*
> > > > > + * mtk_devapc_dump_vio_dbg - get the violation index and dump th=
e full violation
> > > > > + *                           debug information.
> > > > > + */
> > > > > +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *c=
tx, u32 vio_idx)
> > > > > +{
> > > > > +       u32 shift_bit;
> > > > > +
> > > > > +       if (check_vio_mask(ctx, vio_idx))
> > > > > +               return false;
> > > > > +
> > > > > +       if (!check_vio_status(ctx, vio_idx))
> > > > > +               return false;
> > > > > +
> > > > > +       shift_bit =3D get_shift_group(ctx, vio_idx);
> > > > > +
> > > > > +       if (sync_vio_dbg(ctx, shift_bit))
> > > > > +               return false;
> > > > > +
> > > > > +       devapc_extract_vio_dbg(ctx);
> > > >
> > > > I think get_shift_group(), sync_vio_dbg(), and
> > > > devapc_extract_vio_dbg() should be moved out of vio_idx for-loop (t=
he
> > > > loop in devapc_violation_irq()) because these three function is not
> > > > related to vio_idx.
> > > > Another question: when multiple vio_idx violation occur, vio_addr i=
s
> > > > related to which one vio_idx? The latest happened one?
> > > >
> > >
> > > Actually, it's related to vio_idx. But we don't use it directly on th=
ese
> > > function. I think below snip code might be better way to understand i=
t.
> > >
> > > for (...)
> > > {
> > >         check_vio_mask()
> > >         check_vio_status()
> > >
> > >         // if get vio_idx, mask it temporarily
> > >         mask_module_irq(true)
> > >         clear_vio_status()
> > >
> > >         // dump violation info
> > >         get_shift_group()
> > >         sync_vio_dbg()
> > >         devapc_extract_vio_dbg()
> > >
> > >         // unmask
> > >         mask_module_irq(false)
> > > }
> >
> > This snip code does not explain any thing. I could rewrite this code as=
:
> >
> > for (...)
> > {
> >     check_vio_mask()
> >     check_vio_status()
> >
> >     // if get vio_idx, mask it temporarily
> >     mask_module_irq(true)
> >     clear_vio_status()
> >     // unmask
> >     mask_module_irq(false)
> > }
> >
> > // dump violation info
> > get_shift_group()
> > sync_vio_dbg()
> > devapc_extract_vio_dbg()
> >
> > And my version is identical with your version, isn't it?
>
> Sorry, I did not explain it clearly. Let's me try again.
> The reason why I put "dump violation info" between mask & unmask context
> is because it has to stop interrupt first before dump violation info,
> and then unmask it to prepare next violation.
> These sequence guarantee that if multiple violation is triggered, we
> still have information to debug.
> If the code sequence in your version and multiple violation is
> triggered, there might be no any information but keeps entering ISR.
> Finally, system might be abnormal and watchdog timeout.
> In this case, we still don't have any information to debug.

I still don't understand why no information to debug. For example when
vio_idx 5, 10, 15 has violation,
You would mask vio_idx 5 to get information, but vio_idx 10, 15 does
not mask yet.
In your words, when vio_idx 10, 15 not mask, you would not get any
debug information when you process vio_idx 5.

In my version, I would clear all status, why keeps entering ISR?

>
> >
> > >
> > > About your question, vio_addr would be the first one.
> >
> > So other vio_addr would be dropped? Or hardware would keep all
> > vio_addr and you have some way to get all vio_addr?
> >
>
> In this case, hardware will drop other violation info and keep the first
> one until it been handled.

Does 'handled' mean status is cleared?

Regards,
Chun-Kuang.

>
> > >
> > > > > +
> > > > > +       return true;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * devapc_violation_irq - the devapc Interrupt Service Routine (=
ISR) will dump
> > > > > + *                        violation information including which =
master violates
> > > > > + *                        access slave.
> > > > > + */
> > > > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > > > +                                       struct mtk_devapc_context=
 *ctx)
> > > > > +{
> > > > > +       u32 vio_idx;
> > > > > +
> > > > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++=
) {
> > > > > +               if (!mtk_devapc_dump_vio_dbg(ctx, vio_idx))
> > > > > +                       continue;
> > > > > +
> > > > > +               /* Ensure that violation info are written before
> > > > > +                * further operations
> > > > > +                */
> > > > > +               smp_mb();
> > > > > +
> > > > > +               /*
> > > > > +                * Mask slave's irq before clearing vio status.
> > > > > +                * Must do it to avoid nested interrupt and preve=
nt
> > > > > +                * unexpected behavior.
> > > > > +                */
> > > > > +               mask_module_irq(ctx, vio_idx, true);
> > > > > +
> > > > > +               clear_vio_status(ctx, vio_idx);
> > > > > +
> > > > > +               mask_module_irq(ctx, vio_idx, false);
> > > > > +       }
> > > > > +
> > > > > +       return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +/*
