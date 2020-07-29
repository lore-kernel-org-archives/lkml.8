Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7CF2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595989345;
	bh=k5qS863fFeAFImz8qQ72STBgwqwjrT2VdEQppPTBzkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uxkq+2+vMse+rzXrysQM2J7TsmMiyE8LRAx2vul5KYRmBbq0M+P72ikWliME1Liti
	 ZtCydrpps2YdzijoH7J5hJNqbmrsmOf2ImkPMXdj4CTpQsW4jF/me+NBab4yGH5nii
	 CyKlcyVg3TkOoZaYQZ1C7oO0qZOMYn+CdoYBQwYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgG2CWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbgG2CWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:22:22 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CC52070B;
        Wed, 29 Jul 2020 02:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595989340;
        bh=k5qS863fFeAFImz8qQ72STBgwqwjrT2VdEQppPTBzkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UD2/SrXnSaE/nhR8QzLzln/M1nBs3BDKwAM2N1IFATWjIZxRnjcMdLqtNvkQlCTZS
         OpydQCu0X+xprkrVevu6lL5QpcKnCTCEdNu2rnqrOAfQBAeHnVH78g4LouybBmztXT
         wyapIPA8QyLf3cXBqKsKQZ5NzNHK93PhcTbNgDKM=
Received: by mail-ed1-f53.google.com with SMTP id m20so6774722eds.2;
        Tue, 28 Jul 2020 19:22:19 -0700 (PDT)
X-Gm-Message-State: AOAM532TgPSo80PBX8j0YyyBld2SnOR5BwjQeRWyJu8ilqXVBGyPDuEs
        Q8LnFey8/DVz2U4Y3NQeFA9FIYBL1fGM8RwO2w==
X-Google-Smtp-Source: ABdhPJydhzr6C/k9YnK7AjZNwvP8zWehqaiYPIACf3wyURav0IRtuOo10iWWbsTTEwW5OauoJYKz5teZYxl1XRqcP/k=
X-Received: by 2002:a50:e617:: with SMTP id y23mr28961939edm.47.1595989338240;
 Tue, 28 Jul 2020 19:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
 <1595303971-8793-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8T=DCntU8x5YEo+Pcs2J0Y4YvDaHUBdGiqEFRxghOd_Q@mail.gmail.com>
 <1595389756.20193.12.camel@mtkswgap22> <CAAOTY_9k7rM=Pf43DwJR_bkQvxVtpWYTjVoNSZLVE2N0Y_DBmA@mail.gmail.com>
 <1595484707.26237.12.camel@mtkswgap22> <CAAOTY__V3zwux7UP7p4SUbreGrPBbwRqi=E1WVsA58tYNmri1A@mail.gmail.com>
 <1595573719.24412.9.camel@mtkswgap22> <CAAOTY__KYH4G3E+c=zoOk==hPJHsAd5u4Q0oj4adKstaoOciMg@mail.gmail.com>
 <1595819152.7630.13.camel@mtkswgap22> <CAAOTY_8j4rxxqOD0-gf-=sJPhiLu9KE4zF467v7g2EBrTFJUeQ@mail.gmail.com>
 <1595908325.1388.8.camel@mtkswgap22> <CAAOTY_-POOCU0mG3qcV8=3UF4Qr5rq1RVAeFtnRvLgAxaof32g@mail.gmail.com>
 <1595988652.9265.8.camel@mtkswgap22>
In-Reply-To: <1595988652.9265.8.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Jul 2020 10:22:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY_82nN8U34-LW8RTqTLEH2MwTg+B5KMHjha3=sbOXPdWSw@mail.gmail.com>
Message-ID: <CAAOTY_82nN8U34-LW8RTqTLEH2MwTg+B5KMHjha3=sbOXPdWSw@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On Tue, 2020-07-28 at 23:35 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Chun-Kuang,
> > >
> > > On Mon, 2020-07-27 at 22:47 +0800, Chun-Kuang Hu wrote:
> > > > Hi, Neal:
> > > >
> > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=882=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:06=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > Hi Chun-Kuang,
> > > > >
> > > > > On Fri, 2020-07-24 at 23:55 +0800, Chun-Kuang Hu wrote:
> > > > > > Hi, Neal:
> > > > > >
> > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8824=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > Hi Chun-Kuang,
> > > > > > >
> > > > > > > On Fri, 2020-07-24 at 00:32 +0800, Chun-Kuang Hu wrote:
> > > > > > > > Hi, Neal:
> > > > > > > >
> > > > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > Hi Chun-Kuang,
> > > > > > > > >
> > > > > > > > > On Wed, 2020-07-22 at 22:25 +0800, Chun-Kuang Hu wrote:
> > > > > > > > > > Hi, Neal:
> > > > > > > > > >
> > > > > > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=
=B47=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:49=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > Hi Chun-Kuang,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 2020-07-22 at 07:21 +0800, Chun-Kuang Hu wrot=
e:
> > > > > > > > > > > > Hi, Neal:
> > > > > > > > > > > >
> > > > > > > > > > > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=
=B9=B47=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8812:00=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +/*
> > > > > > > > > > > > > + * mtk_devapc_dump_vio_dbg - get the violation i=
ndex and dump the full violation
> > > > > > > > > > > > > + *                           debug information.
> > > > > > > > > > > > > + */
> > > > > > > > > > > > > +static bool mtk_devapc_dump_vio_dbg(struct mtk_d=
evapc_context *ctx, u32 vio_idx)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       u32 shift_bit;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       if (check_vio_mask(ctx, vio_idx))
> > > > > > > > > > > > > +               return false;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       if (!check_vio_status(ctx, vio_idx))
> > > > > > > > > > > > > +               return false;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       shift_bit =3D get_shift_group(ctx, vio_id=
x);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       if (sync_vio_dbg(ctx, shift_bit))
> > > > > > > > > > > > > +               return false;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       devapc_extract_vio_dbg(ctx);
> > > > > > > > > > > >
> > > > > > > > > > > > I think get_shift_group(), sync_vio_dbg(), and
> > > > > > > > > > > > devapc_extract_vio_dbg() should be moved out of vio=
_idx for-loop (the
> > > > > > > > > > > > loop in devapc_violation_irq()) because these three=
 function is not
> > > > > > > > > > > > related to vio_idx.
> > > > > > > > > > > > Another question: when multiple vio_idx violation o=
ccur, vio_addr is
> > > > > > > > > > > > related to which one vio_idx? The latest happened o=
ne?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Actually, it's related to vio_idx. But we don't use i=
t directly on these
> > > > > > > > > > > function. I think below snip code might be better way=
 to understand it.
> > > > > > > > > > >
> > > > > > > > > > > for (...)
> > > > > > > > > > > {
> > > > > > > > > > >         check_vio_mask()
> > > > > > > > > > >         check_vio_status()
> > > > > > > > > > >
> > > > > > > > > > >         // if get vio_idx, mask it temporarily
> > > > > > > > > > >         mask_module_irq(true)
> > > > > > > > > > >         clear_vio_status()
> > > > > > > > > > >
> > > > > > > > > > >         // dump violation info
> > > > > > > > > > >         get_shift_group()
> > > > > > > > > > >         sync_vio_dbg()
> > > > > > > > > > >         devapc_extract_vio_dbg()
> > > > > > > > > > >
> > > > > > > > > > >         // unmask
> > > > > > > > > > >         mask_module_irq(false)
> > > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > This snip code does not explain any thing. I could rewr=
ite this code as:
> > > > > > > > > >
> > > > > > > > > > for (...)
> > > > > > > > > > {
> > > > > > > > > >     check_vio_mask()
> > > > > > > > > >     check_vio_status()
> > > > > > > > > >
> > > > > > > > > >     // if get vio_idx, mask it temporarily
> > > > > > > > > >     mask_module_irq(true)
> > > > > > > > > >     clear_vio_status()
> > > > > > > > > >     // unmask
> > > > > > > > > >     mask_module_irq(false)
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > // dump violation info
> > > > > > > > > > get_shift_group()
> > > > > > > > > > sync_vio_dbg()
> > > > > > > > > > devapc_extract_vio_dbg()
> > > > > > > > > >
> > > > > > > > > > And my version is identical with your version, isn't it=
?
> > > > > > > > >
> > > > > > > > > Sorry, I did not explain it clearly. Let's me try again.
> > > > > > > > > The reason why I put "dump violation info" between mask &=
 unmask context
> > > > > > > > > is because it has to stop interrupt first before dump vio=
lation info,
> > > > > > > > > and then unmask it to prepare next violation.
> > > > > > > > > These sequence guarantee that if multiple violation is tr=
iggered, we
> > > > > > > > > still have information to debug.
> > > > > > > > > If the code sequence in your version and multiple violati=
on is
> > > > > > > > > triggered, there might be no any information but keeps en=
tering ISR.
> > > > > > > > > Finally, system might be abnormal and watchdog timeout.
> > > > > > > > > In this case, we still don't have any information to debu=
g.
> > > > > > > >
> > > > > > > > I still don't understand why no information to debug. For e=
xample when
> > > > > > > > vio_idx 5, 10, 15 has violation,
> > > > > > > > You would mask vio_idx 5 to get information, but vio_idx 10=
, 15 does
> > > > > > > > not mask yet.
> > > > > > > > In your words, when vio_idx 10, 15 not mask, you would not =
get any
> > > > > > > > debug information when you process vio_idx 5.
> > > > > > > >
> > > > > > > > In my version, I would clear all status, why keeps entering=
 ISR?
> > > > > > >
> > > > > > > Think about this case, if someone tries to dump "AAA" module'=
s register.
> > > > > > > It would keep read reg base, base+0x4, base+0x8, ...
> > > > > > > All these registers are in the same slave, which would be sam=
e vio_idx.
> > > > > > > (Take vio_idx 5 as example)
> > > > > > > In this case, vio_idx 5 will keep triggering interrupt. If yo=
u did not
> > > > > > > do "dump violation info" between mask & unmask, you cannot ge=
t any
> > > > > > > violation info until the last interrupt being handled.
> > > > > > > Normally, system will crash before last interrupt coming.
> > > > > >
> > > > > > You have said that first vio_addr would be kept until it's 'han=
dled'.
> > > > > > So the first vio_addr reg_base would be kept even though other
> > > > > > violation happen. And I could handle (clear status and dump inf=
o) it
> > > > > > then vio_addr would next violation's address. I'm confused with=
 your
> > > > > > statement. If AAA is dumping register of vio_idx 5, BBB is dump=
ing
> > > > > > register of vio_idx 10, CCC is dumping register of vio_idx 15, =
I think
> > > > > > you should mask all vio_idx not only one. So the code would be
> > > > > >
> > > > > > for all vio_idx {
> > > > > >     mask_module_irq(true)
> > > > > > }
> > > > > >
> > > > > > devapc_extract_vio_dbg()
> > > > > >
> > > > > > for all vio_idx {
> > > > > >     clear_vio_status()
> > > > > >     mask_module_irq(false)
> > > > > > }
> > > > > >
> > > > >
> > > > > I'm also consider this solution and I think it's much better to
> > > > > understand hardware behavior.
> > > > >
> > > > > devapc_dump_vio_dbg()
> > > > > {
> > > > >         while(1) {
> > > > >                 // might have multiple shift_bit raised
> > > > >                 shift_bit =3D get_shift_group()
> > > > >                 if (shift_bit >=3D 0 && shift bit <=3D 31)
> > > > >                         sync_vio_dbg(shift_bit)
> > > > >                         extract_vio_dbg()
> > > >
> > > > According to your statement, when multiple violation occur, only th=
e
> > > > first one is kept, others are dropped. I think we just need to dump
> > > > debug info once.
> > > >
> > > > Because only one violation information would be kept, why not only =
one
> > > > group (equal to no group)?
> > > >
> > > > Regards,
> > > > Chun-Kuang.
> > >
> > > Let's me give you an example of devapc design.
> > > vio_idx: 0, 1, 2 -> group 0 (shift_bit: 0)
> > > vio_idx: 3, 4, 5 -> group 1 (shift_bit: 1)
> > > ...
> > >
> > > Each group violation will keep one violation (the first one). If vio_=
idx
> > > 0 is triggered first, vio_idx 1 is triggered next, then group 0 will
> > > just keep vio_idx 0 violation info.
> > > If vio_idx 2 is triggered first, vio_idx 3 is triggered next, then gr=
oup
> > > 0 will keep vio_idx 2 violation info, group 1 will keep vio_idx 3's.
> > >
> > > We have to scan all groups and dump everything we have.
> > > Thanks !
> > >
> >
> > Could we let all vio_idx be group 0 so that we could just sync one
> > group? It's bad to spend too much time in irq handler.
> > When we set pd_vio_shift_sel_reg, it seems we could set multiple group
> > together, couldn't it?
> >
> > Regards,
> > Chun-Kuang.
> >
>
> No, Which group vio_idx belongs to is determined by hardware. Software
> cannot change its group.
> There is very low possibility that multiple groups has violation at the
> same time, so it would not spend much time to handle it.
> It also cannot shift multiple groups at the same time since there is
> only one vio_info(rw, vio_addr, master_id, ...) exist at a time.
> devapc_extract_vio_dbg() function is doing this step.
>

So this flow is OK for me. Would you please add comment for this
information so that we could understand how hardware work.

Regards,
Chun-Kuang.

> Thanks !
>
> > > >
> > > > >                 else
> > > > >                         break
> > > > >         }
> > > > > }
> > > > >
> > > > > devapc_violation_irq()
> > > > > {
> > > > >         for all vio_idx {
> > > > >                 mask_module_irq(true)
> > > > >         }
> > > > >
> > > > >         devapc_dump_vio_dbg()
> > > > >
> > > > >         for all vio_idx {
> > > > >                 clear_vio_status()
> > > > >                 mask_module_irq(false)
> > > > >         }
> > > > > }
> > > > >
> > > > > Is it more clear for this control flow?
> > > > > Thanks !
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > About your question, vio_addr would be the first one.
> > > > > > > > > >
> > > > > > > > > > So other vio_addr would be dropped? Or hardware would k=
eep all
> > > > > > > > > > vio_addr and you have some way to get all vio_addr?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > In this case, hardware will drop other violation info and=
 keep the first
> > > > > > > > > one until it been handled.
> > > > > > > >
> > > > > > > > Does 'handled' mean status is cleared?
> > > > > > >
> > > > > > > "handled" means clear status and dump violation info.
> > > > > > >
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Chun-Kuang.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       return true;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +/*
> > > > > > > > > > > > > + * devapc_violation_irq - the devapc Interrupt S=
ervice Routine (ISR) will dump
> > > > > > > > > > > > > + *                        violation information =
including which master violates
> > > > > > > > > > > > > + *                        access slave.
> > > > > > > > > > > > > + */
> > > > > > > > > > > > > +static irqreturn_t devapc_violation_irq(int irq_=
number,
> > > > > > > > > > > > > +                                       struct mt=
k_devapc_context *ctx)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       u32 vio_idx;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_id=
x_num; vio_idx++) {
> > > > > > > > > > > > > +               if (!mtk_devapc_dump_vio_dbg(ctx,=
 vio_idx))
> > > > > > > > > > > > > +                       continue;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               /* Ensure that violation info are=
 written before
> > > > > > > > > > > > > +                * further operations
> > > > > > > > > > > > > +                */
> > > > > > > > > > > > > +               smp_mb();
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               /*
> > > > > > > > > > > > > +                * Mask slave's irq before cleari=
ng vio status.
> > > > > > > > > > > > > +                * Must do it to avoid nested int=
errupt and prevent
> > > > > > > > > > > > > +                * unexpected behavior.
> > > > > > > > > > > > > +                */
> > > > > > > > > > > > > +               mask_module_irq(ctx, vio_idx, tru=
e);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               clear_vio_status(ctx, vio_idx);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               mask_module_irq(ctx, vio_idx, fal=
se);
> > > > > > > > > > > > > +       }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       return IRQ_HANDLED;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +/*
> > > > > > >
> > > > >
> > >
>
