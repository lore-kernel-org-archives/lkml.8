Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6056EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298A62083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595861254;
	bh=ra7ySkxUG6tdQ2Sev5kAIRiDu6mF6ko2V3p5aNPDPJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RSkSbV/diHuTKzCYkaDDSTPUc7S8iFTQzf386mczKOhLmSAS6nT1Ifb7rppmHIwJj
	 OcaI9xGUe4ccsw+X3QBI7Yb0VxIk+suMAY+c2PvX2JqJose7P3a+lZGDEPO/OQyfvz
	 yoKWZxW1BWXlAWaR4KTBZDPorUGamYQa5jqBp2fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgG0Ora (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgG0Ora (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:47:30 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47780208E4;
        Mon, 27 Jul 2020 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595861249;
        bh=ra7ySkxUG6tdQ2Sev5kAIRiDu6mF6ko2V3p5aNPDPJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TF2dtyfsIDQRwALZEtKEIJBBZLhz7MjWD1h9rT0N1cjMb4xqxeeRIRk7ENzGtUqcl
         249z6ZfJuZ2do83K5kHDAzU8UMHstx7getoA4EnGDxRWPFCLO+5uQpSynbRfzuQ/s/
         5I+u+Q36tKog5J3IeOWAlhiBjQ790O6cCwaf8dEY=
Received: by mail-ej1-f47.google.com with SMTP id g11so5580647ejr.0;
        Mon, 27 Jul 2020 07:47:29 -0700 (PDT)
X-Gm-Message-State: AOAM530wqU6PjiEBRo320eQpo9ddmzw+p2QQQozUB88Eq/LMU7chl7zm
        yovObqXqlRrD4DXicUSgUeIsbZKCCJkiua28Zw==
X-Google-Smtp-Source: ABdhPJx8L+G/aF7IMetyVPuFX7TWQTopBRl2QWzS8clJFtiKlB8YVgmkr1f0mMdVne9ueI/35nYOM9rLDue3RzkM5BI=
X-Received: by 2002:a17:906:7857:: with SMTP id p23mr20143758ejm.260.1595861247757;
 Mon, 27 Jul 2020 07:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
 <1595303971-8793-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
 <1595389756.20193.12.camel@mtkswgap22> <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
 <1595484707.26237.12.camel@mtkswgap22> <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
 <1595573719.24412.9.camel@mtkswgap22> <CAAOTY__KYH4G3E+c=zoOk==hPJHsAd5u4Q0oj4adKstaoOciMg@mail.gmail.com>
 <1595819152.7630.13.camel@mtkswgap22>
In-Reply-To: <1595819152.7630.13.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 27 Jul 2020 22:47:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8j4rxxqOD0-gf-=sJPhiLu9KE4zF467v7g2EBrTFJUeQ@mail.gmail.com>
Message-ID: <CAAOTY_8j4rxxqOD0-gf-=sJPhiLu9KE4zF467v7g2EBrTFJUeQ@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:06=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Fri, 2020-07-24 at 23:55 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:55=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > On Fri, 2020-07-24 at 00:32 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=882=
3=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > Hi Chun-Kuang,
> > > > >
> > > > > On Wed, 2020-07-22 at 22:25 +0800, Chun-Kuang Hu wrote:
> > > > > > Hi, Neal:
> > > > > >
> > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:49=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > Hi Chun-Kuang,
> > > > > > >
> > > > > > > On Wed, 2020-07-22 at 07:21 +0800, Chun-Kuang Hu wrote:
> > > > > > > > Hi, Neal:
> > > > > > > >
> > > > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * mtk_devapc_dump_vio_dbg - get the violation index and=
 dump the full violation
> > > > > > > > > + *                           debug information.
> > > > > > > > > + */
> > > > > > > > > +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_co=
ntext *ctx, u32 vio_idx)
> > > > > > > > > +{
> > > > > > > > > +       u32 shift_bit;
> > > > > > > > > +
> > > > > > > > > +       if (check_vio_mask(ctx, vio_idx))
> > > > > > > > > +               return false;
> > > > > > > > > +
> > > > > > > > > +       if (!check_vio_status(ctx, vio_idx))
> > > > > > > > > +               return false;
> > > > > > > > > +
> > > > > > > > > +       shift_bit =3D get_shift_group(ctx, vio_idx);
> > > > > > > > > +
> > > > > > > > > +       if (sync_vio_dbg(ctx, shift_bit))
> > > > > > > > > +               return false;
> > > > > > > > > +
> > > > > > > > > +       devapc_extract_vio_dbg(ctx);
> > > > > > > >
> > > > > > > > I think get_shift_group(), sync_vio_dbg(), and
> > > > > > > > devapc_extract_vio_dbg() should be moved out of vio_idx for=
-loop (the
> > > > > > > > loop in devapc_violation_irq()) because these three functio=
n is not
> > > > > > > > related to vio_idx.
> > > > > > > > Another question: when multiple vio_idx violation occur, vi=
o_addr is
> > > > > > > > related to which one vio_idx? The latest happened one?
> > > > > > > >
> > > > > > >
> > > > > > > Actually, it's related to vio_idx. But we don't use it direct=
ly on these
> > > > > > > function. I think below snip code might be better way to unde=
rstand it.
> > > > > > >
> > > > > > > for (...)
> > > > > > > {
> > > > > > >         check_vio_mask()
> > > > > > >         check_vio_status()
> > > > > > >
> > > > > > >         // if get vio_idx, mask it temporarily
> > > > > > >         mask_module_irq(true)
> > > > > > >         clear_vio_status()
> > > > > > >
> > > > > > >         // dump violation info
> > > > > > >         get_shift_group()
> > > > > > >         sync_vio_dbg()
> > > > > > >         devapc_extract_vio_dbg()
> > > > > > >
> > > > > > >         // unmask
> > > > > > >         mask_module_irq(false)
> > > > > > > }
> > > > > >
> > > > > > This snip code does not explain any thing. I could rewrite this=
 code as:
> > > > > >
> > > > > > for (...)
> > > > > > {
> > > > > >     check_vio_mask()
> > > > > >     check_vio_status()
> > > > > >
> > > > > >     // if get vio_idx, mask it temporarily
> > > > > >     mask_module_irq(true)
> > > > > >     clear_vio_status()
> > > > > >     // unmask
> > > > > >     mask_module_irq(false)
> > > > > > }
> > > > > >
> > > > > > // dump violation info
> > > > > > get_shift_group()
> > > > > > sync_vio_dbg()
> > > > > > devapc_extract_vio_dbg()
> > > > > >
> > > > > > And my version is identical with your version, isn't it?
> > > > >
> > > > > Sorry, I did not explain it clearly. Let's me try again.
> > > > > The reason why I put "dump violation info" between mask & unmask =
context
> > > > > is because it has to stop interrupt first before dump violation i=
nfo,
> > > > > and then unmask it to prepare next violation.
> > > > > These sequence guarantee that if multiple violation is triggered,=
 we
> > > > > still have information to debug.
> > > > > If the code sequence in your version and multiple violation is
> > > > > triggered, there might be no any information but keeps entering I=
SR.
> > > > > Finally, system might be abnormal and watchdog timeout.
> > > > > In this case, we still don't have any information to debug.
> > > >
> > > > I still don't understand why no information to debug. For example w=
hen
> > > > vio_idx 5, 10, 15 has violation,
> > > > You would mask vio_idx 5 to get information, but vio_idx 10, 15 doe=
s
> > > > not mask yet.
> > > > In your words, when vio_idx 10, 15 not mask, you would not get any
> > > > debug information when you process vio_idx 5.
> > > >
> > > > In my version, I would clear all status, why keeps entering ISR?
> > >
> > > Think about this case, if someone tries to dump "AAA" module's regist=
er.
> > > It would keep read reg base, base+0x4, base+0x8, ...
> > > All these registers are in the same slave, which would be same vio_id=
x.
> > > (Take vio_idx 5 as example)
> > > In this case, vio_idx 5 will keep triggering interrupt. If you did no=
t
> > > do "dump violation info" between mask & unmask, you cannot get any
> > > violation info until the last interrupt being handled.
> > > Normally, system will crash before last interrupt coming.
> >
> > You have said that first vio_addr would be kept until it's 'handled'.
> > So the first vio_addr reg_base would be kept even though other
> > violation happen. And I could handle (clear status and dump info) it
> > then vio_addr would next violation's address. I'm confused with your
> > statement. If AAA is dumping register of vio_idx 5, BBB is dumping
> > register of vio_idx 10, CCC is dumping register of vio_idx 15, I think
> > you should mask all vio_idx not only one. So the code would be
> >
> > for all vio_idx {
> >     mask_module_irq(true)
> > }
> >
> > devapc_extract_vio_dbg()
> >
> > for all vio_idx {
> >     clear_vio_status()
> >     mask_module_irq(false)
> > }
> >
>
> I'm also consider this solution and I think it's much better to
> understand hardware behavior.
>
> devapc_dump_vio_dbg()
> {
>         while(1) {
>                 // might have multiple shift_bit raised
>                 shift_bit =3D get_shift_group()
>                 if (shift_bit >=3D 0 && shift bit <=3D 31)
>                         sync_vio_dbg(shift_bit)
>                         extract_vio_dbg()

According to your statement, when multiple violation occur, only the
first one is kept, others are dropped. I think we just need to dump
debug info once.

Because only one violation information would be kept, why not only one
group (equal to no group)?

Regards,
Chun-Kuang.

>                 else
>                         break
>         }
> }
>
> devapc_violation_irq()
> {
>         for all vio_idx {
>                 mask_module_irq(true)
>         }
>
>         devapc_dump_vio_dbg()
>
>         for all vio_idx {
>                 clear_vio_status()
>                 mask_module_irq(false)
>         }
> }
>
> Is it more clear for this control flow?
> Thanks !
>
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > About your question, vio_addr would be the first one.
> > > > > >
> > > > > > So other vio_addr would be dropped? Or hardware would keep all
> > > > > > vio_addr and you have some way to get all vio_addr?
> > > > > >
> > > > >
> > > > > In this case, hardware will drop other violation info and keep th=
e first
> > > > > one until it been handled.
> > > >
> > > > Does 'handled' mean status is cleared?
> > >
> > > "handled" means clear status and dump violation info.
> > >
> > > >
> > > > Regards,
> > > > Chun-Kuang.
> > > >
> > > > >
> > > > > > >
> > > > > > > > > +
> > > > > > > > > +       return true;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * devapc_violation_irq - the devapc Interrupt Service R=
outine (ISR) will dump
> > > > > > > > > + *                        violation information includin=
g which master violates
> > > > > > > > > + *                        access slave.
> > > > > > > > > + */
> > > > > > > > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > > > > > > > +                                       struct mtk_devapc=
_context *ctx)
> > > > > > > > > +{
> > > > > > > > > +       u32 vio_idx;
> > > > > > > > > +
> > > > > > > > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; v=
io_idx++) {
> > > > > > > > > +               if (!mtk_devapc_dump_vio_dbg(ctx, vio_idx=
))
> > > > > > > > > +                       continue;
> > > > > > > > > +
> > > > > > > > > +               /* Ensure that violation info are written=
 before
> > > > > > > > > +                * further operations
> > > > > > > > > +                */
> > > > > > > > > +               smp_mb();
> > > > > > > > > +
> > > > > > > > > +               /*
> > > > > > > > > +                * Mask slave's irq before clearing vio s=
tatus.
> > > > > > > > > +                * Must do it to avoid nested interrupt a=
nd prevent
> > > > > > > > > +                * unexpected behavior.
> > > > > > > > > +                */
> > > > > > > > > +               mask_module_irq(ctx, vio_idx, true);
> > > > > > > > > +
> > > > > > > > > +               clear_vio_status(ctx, vio_idx);
> > > > > > > > > +
> > > > > > > > > +               mask_module_irq(ctx, vio_idx, false);
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       return IRQ_HANDLED;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +/*
> > >
>
