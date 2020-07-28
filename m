Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B802074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595950569;
	bh=JKF4hn8HMV/Sa4e2zd/1K+b0t04gImZKExTpgzf9rI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b9g5KfRG/id9piuXxVWH8fvAN/oblAQD6zko9/LZVm4YzA5S97isI5UTp8IMuu1j2
	 JXNYMaHWYApIYkfipmEkGHSsA5NYbTBodHF+GyZ16LVc+huYp6vUhXdwJdHn9s/eAR
	 SerxKOSvDHBkwkrS1xM9/NYYsMk6aC1n4KsmqftA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgG1PgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbgG1PgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:36:06 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC60207F5;
        Tue, 28 Jul 2020 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595950564;
        bh=JKF4hn8HMV/Sa4e2zd/1K+b0t04gImZKExTpgzf9rI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MmjnbMl60IJUuuhxAXOECSYRYqmmXNIcd2m8fgaSEcGojPTKg301f4AqKP3dccqc1
         +RZDneK7BJXQQ1nb85PZyDcQgxSA1U40G6I2SLK82f4YXCp69DUt7KhVOx3hDpVf+2
         IpALnX96XkewNlTtwwoYuEeNYen31RiccN15UXzQ=
Received: by mail-ej1-f48.google.com with SMTP id f24so593938ejx.6;
        Tue, 28 Jul 2020 08:36:04 -0700 (PDT)
X-Gm-Message-State: AOAM533D0rNu1NG754kLRdXJRPg0qDAYplILLWaerGI6js5f0dt9Z5xh
        /MGNih9xcNCVglEsqkFnjBMSeKJWBJMfp5VOsg==
X-Google-Smtp-Source: ABdhPJzcajRS0zlozFB4pcWjOkhFxSzCzTlpBxf9e6KiujD3CpUP/VncTiRoBNgH1jeCiuXslsn/mMwXFKWRx1Iia+g=
X-Received: by 2002:a17:906:6959:: with SMTP id c25mr25528381ejs.375.1595950562806;
 Tue, 28 Jul 2020 08:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
 <1595303971-8793-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
 <1595389756.20193.12.camel@mtkswgap22> <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
 <1595484707.26237.12.camel@mtkswgap22> <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
 <1595573719.24412.9.camel@mtkswgap22> <CAAOTY__KYH4G3E+c=zoOk==hPJHsAd5u4Q0oj4adKstaoOciMg@mail.gmail.com>
 <1595819152.7630.13.camel@mtkswgap22> <CAAOTY_8j4rxxqOD0-gf-=sJPhiLu9KE4zF467v7g2EBrTFJUeQ@mail.gmail.com>
 <1595908325.1388.8.camel@mtkswgap22>
In-Reply-To: <1595908325.1388.8.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 28 Jul 2020 23:35:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-POOCU0mG3qcV8=3UF4Qr5rq1RVAeFtnRvLgAxaof32g@mail.gmail.com>
Message-ID: <CAAOTY_-POOCU0mG3qcV8=3UF4Qr5rq1RVAeFtnRvLgAxaof32g@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Mon, 2020-07-27 at 22:47 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:06=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > On Fri, 2020-07-24 at 23:55 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=882=
4=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:55=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > Hi Chun-Kuang,
> > > > >
> > > > > On Fri, 2020-07-24 at 00:32 +0800, Chun-Kuang Hu wrote:
> > > > > > Hi, Neal:
> > > > > >
> > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > Hi Chun-Kuang,
> > > > > > >
> > > > > > > On Wed, 2020-07-22 at 22:25 +0800, Chun-Kuang Hu wrote:
> > > > > > > > Hi, Neal:
> > > > > > > >
> > > > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=
=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:49=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > Hi Chun-Kuang,
> > > > > > > > >
> > > > > > > > > On Wed, 2020-07-22 at 07:21 +0800, Chun-Kuang Hu wrote:
> > > > > > > > > > Hi, Neal:
> > > > > > > > > >
> > > > > > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=
=B47=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:00=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * mtk_devapc_dump_vio_dbg - get the violation index=
 and dump the full violation
> > > > > > > > > > > + *                           debug information.
> > > > > > > > > > > + */
> > > > > > > > > > > +static bool mtk_devapc_dump_vio_dbg(struct mtk_devap=
c_context *ctx, u32 vio_idx)
> > > > > > > > > > > +{
> > > > > > > > > > > +       u32 shift_bit;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (check_vio_mask(ctx, vio_idx))
> > > > > > > > > > > +               return false;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (!check_vio_status(ctx, vio_idx))
> > > > > > > > > > > +               return false;
> > > > > > > > > > > +
> > > > > > > > > > > +       shift_bit =3D get_shift_group(ctx, vio_idx);
> > > > > > > > > > > +
> > > > > > > > > > > +       if (sync_vio_dbg(ctx, shift_bit))
> > > > > > > > > > > +               return false;
> > > > > > > > > > > +
> > > > > > > > > > > +       devapc_extract_vio_dbg(ctx);
> > > > > > > > > >
> > > > > > > > > > I think get_shift_group(), sync_vio_dbg(), and
> > > > > > > > > > devapc_extract_vio_dbg() should be moved out of vio_idx=
 for-loop (the
> > > > > > > > > > loop in devapc_violation_irq()) because these three fun=
ction is not
> > > > > > > > > > related to vio_idx.
> > > > > > > > > > Another question: when multiple vio_idx violation occur=
, vio_addr is
> > > > > > > > > > related to which one vio_idx? The latest happened one?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Actually, it's related to vio_idx. But we don't use it di=
rectly on these
> > > > > > > > > function. I think below snip code might be better way to =
understand it.
> > > > > > > > >
> > > > > > > > > for (...)
> > > > > > > > > {
> > > > > > > > >         check_vio_mask()
> > > > > > > > >         check_vio_status()
> > > > > > > > >
> > > > > > > > >         // if get vio_idx, mask it temporarily
> > > > > > > > >         mask_module_irq(true)
> > > > > > > > >         clear_vio_status()
> > > > > > > > >
> > > > > > > > >         // dump violation info
> > > > > > > > >         get_shift_group()
> > > > > > > > >         sync_vio_dbg()
> > > > > > > > >         devapc_extract_vio_dbg()
> > > > > > > > >
> > > > > > > > >         // unmask
> > > > > > > > >         mask_module_irq(false)
> > > > > > > > > }
> > > > > > > >
> > > > > > > > This snip code does not explain any thing. I could rewrite =
this code as:
> > > > > > > >
> > > > > > > > for (...)
> > > > > > > > {
> > > > > > > >     check_vio_mask()
> > > > > > > >     check_vio_status()
> > > > > > > >
> > > > > > > >     // if get vio_idx, mask it temporarily
> > > > > > > >     mask_module_irq(true)
> > > > > > > >     clear_vio_status()
> > > > > > > >     // unmask
> > > > > > > >     mask_module_irq(false)
> > > > > > > > }
> > > > > > > >
> > > > > > > > // dump violation info
> > > > > > > > get_shift_group()
> > > > > > > > sync_vio_dbg()
> > > > > > > > devapc_extract_vio_dbg()
> > > > > > > >
> > > > > > > > And my version is identical with your version, isn't it?
> > > > > > >
> > > > > > > Sorry, I did not explain it clearly. Let's me try again.
> > > > > > > The reason why I put "dump violation info" between mask & unm=
ask context
> > > > > > > is because it has to stop interrupt first before dump violati=
on info,
> > > > > > > and then unmask it to prepare next violation.
> > > > > > > These sequence guarantee that if multiple violation is trigge=
red, we
> > > > > > > still have information to debug.
> > > > > > > If the code sequence in your version and multiple violation i=
s
> > > > > > > triggered, there might be no any information but keeps enteri=
ng ISR.
> > > > > > > Finally, system might be abnormal and watchdog timeout.
> > > > > > > In this case, we still don't have any information to debug.
> > > > > >
> > > > > > I still don't understand why no information to debug. For examp=
le when
> > > > > > vio_idx 5, 10, 15 has violation,
> > > > > > You would mask vio_idx 5 to get information, but vio_idx 10, 15=
 does
> > > > > > not mask yet.
> > > > > > In your words, when vio_idx 10, 15 not mask, you would not get =
any
> > > > > > debug information when you process vio_idx 5.
> > > > > >
> > > > > > In my version, I would clear all status, why keeps entering ISR=
?
> > > > >
> > > > > Think about this case, if someone tries to dump "AAA" module's re=
gister.
> > > > > It would keep read reg base, base+0x4, base+0x8, ...
> > > > > All these registers are in the same slave, which would be same vi=
o_idx.
> > > > > (Take vio_idx 5 as example)
> > > > > In this case, vio_idx 5 will keep triggering interrupt. If you di=
d not
> > > > > do "dump violation info" between mask & unmask, you cannot get an=
y
> > > > > violation info until the last interrupt being handled.
> > > > > Normally, system will crash before last interrupt coming.
> > > >
> > > > You have said that first vio_addr would be kept until it's 'handled=
'.
> > > > So the first vio_addr reg_base would be kept even though other
> > > > violation happen. And I could handle (clear status and dump info) i=
t
> > > > then vio_addr would next violation's address. I'm confused with you=
r
> > > > statement. If AAA is dumping register of vio_idx 5, BBB is dumping
> > > > register of vio_idx 10, CCC is dumping register of vio_idx 15, I th=
ink
> > > > you should mask all vio_idx not only one. So the code would be
> > > >
> > > > for all vio_idx {
> > > >     mask_module_irq(true)
> > > > }
> > > >
> > > > devapc_extract_vio_dbg()
> > > >
> > > > for all vio_idx {
> > > >     clear_vio_status()
> > > >     mask_module_irq(false)
> > > > }
> > > >
> > >
> > > I'm also consider this solution and I think it's much better to
> > > understand hardware behavior.
> > >
> > > devapc_dump_vio_dbg()
> > > {
> > >         while(1) {
> > >                 // might have multiple shift_bit raised
> > >                 shift_bit =3D get_shift_group()
> > >                 if (shift_bit >=3D 0 && shift bit <=3D 31)
> > >                         sync_vio_dbg(shift_bit)
> > >                         extract_vio_dbg()
> >
> > According to your statement, when multiple violation occur, only the
> > first one is kept, others are dropped. I think we just need to dump
> > debug info once.
> >
> > Because only one violation information would be kept, why not only one
> > group (equal to no group)?
> >
> > Regards,
> > Chun-Kuang.
>
> Let's me give you an example of devapc design.
> vio_idx: 0, 1, 2 -> group 0 (shift_bit: 0)
> vio_idx: 3, 4, 5 -> group 1 (shift_bit: 1)
> ...
>
> Each group violation will keep one violation (the first one). If vio_idx
> 0 is triggered first, vio_idx 1 is triggered next, then group 0 will
> just keep vio_idx 0 violation info.
> If vio_idx 2 is triggered first, vio_idx 3 is triggered next, then group
> 0 will keep vio_idx 2 violation info, group 1 will keep vio_idx 3's.
>
> We have to scan all groups and dump everything we have.
> Thanks !
>

Could we let all vio_idx be group 0 so that we could just sync one
group? It's bad to spend too much time in irq handler.
When we set pd_vio_shift_sel_reg, it seems we could set multiple group
together, couldn't it?

Regards,
Chun-Kuang.

> >
> > >                 else
> > >                         break
> > >         }
> > > }
> > >
> > > devapc_violation_irq()
> > > {
> > >         for all vio_idx {
> > >                 mask_module_irq(true)
> > >         }
> > >
> > >         devapc_dump_vio_dbg()
> > >
> > >         for all vio_idx {
> > >                 clear_vio_status()
> > >                 mask_module_irq(false)
> > >         }
> > > }
> > >
> > > Is it more clear for this control flow?
> > > Thanks !
> > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > About your question, vio_addr would be the first one.
> > > > > > > >
> > > > > > > > So other vio_addr would be dropped? Or hardware would keep =
all
> > > > > > > > vio_addr and you have some way to get all vio_addr?
> > > > > > > >
> > > > > > >
> > > > > > > In this case, hardware will drop other violation info and kee=
p the first
> > > > > > > one until it been handled.
> > > > > >
> > > > > > Does 'handled' mean status is cleared?
> > > > >
> > > > > "handled" means clear status and dump violation info.
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Chun-Kuang.
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +       return true;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * devapc_violation_irq - the devapc Interrupt Servi=
ce Routine (ISR) will dump
> > > > > > > > > > > + *                        violation information incl=
uding which master violates
> > > > > > > > > > > + *                        access slave.
> > > > > > > > > > > + */
> > > > > > > > > > > +static irqreturn_t devapc_violation_irq(int irq_numb=
er,
> > > > > > > > > > > +                                       struct mtk_de=
vapc_context *ctx)
> > > > > > > > > > > +{
> > > > > > > > > > > +       u32 vio_idx;
> > > > > > > > > > > +
> > > > > > > > > > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_nu=
m; vio_idx++) {
> > > > > > > > > > > +               if (!mtk_devapc_dump_vio_dbg(ctx, vio=
_idx))
> > > > > > > > > > > +                       continue;
> > > > > > > > > > > +
> > > > > > > > > > > +               /* Ensure that violation info are wri=
tten before
> > > > > > > > > > > +                * further operations
> > > > > > > > > > > +                */
> > > > > > > > > > > +               smp_mb();
> > > > > > > > > > > +
> > > > > > > > > > > +               /*
> > > > > > > > > > > +                * Mask slave's irq before clearing v=
io status.
> > > > > > > > > > > +                * Must do it to avoid nested interru=
pt and prevent
> > > > > > > > > > > +                * unexpected behavior.
> > > > > > > > > > > +                */
> > > > > > > > > > > +               mask_module_irq(ctx, vio_idx, true);
> > > > > > > > > > > +
> > > > > > > > > > > +               clear_vio_status(ctx, vio_idx);
> > > > > > > > > > > +
> > > > > > > > > > > +               mask_module_irq(ctx, vio_idx, false);
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       return IRQ_HANDLED;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > >
> > >
>
