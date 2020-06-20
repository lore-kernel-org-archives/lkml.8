Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 23:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A78002474C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592696234;
	bh=CawSVpHd2GDDHBo6fZNEBEmKvXOVFkRFxpMFtCubX9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TmmtHQrJq1Nsi2dy251iug5LGQOD04PwBo01BG0LR045fhKBPDdH7K4xMt8HHmEHo
	 wir3I8TDrdk6XimZCWmaz8rbibIPHzHwlAc7whPTw4sFZug+KzjcdRoqIMl8EL9Eyu
	 j+T4OpiaD9KZU6FSFEjyfp66zXyk/VosXYBWUNEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgFTXhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 19:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgFTXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 19:37:03 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1DD2474C;
        Sat, 20 Jun 2020 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592696222;
        bh=CawSVpHd2GDDHBo6fZNEBEmKvXOVFkRFxpMFtCubX9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kv25pqSEEfD0FgzqYZtxEoh3ej91+/gY4IldaQwyv3JThsK5+rn7c5nPOoIeT9OSd
         sS+G9QET9eEqhZjnS4Q7vun3bVjw/uWL8DyH7DrKgKHvqsyIPWu4uk8PTGBRCKsxEl
         RICRuvG28weCfu92RWxGFG5ShqYve8rLEYXNfAsM=
Received: by mail-ej1-f43.google.com with SMTP id w6so2952728ejq.6;
        Sat, 20 Jun 2020 16:37:02 -0700 (PDT)
X-Gm-Message-State: AOAM533919irFnPT8OTNetLlBH21nLoDniSKkHnj+FFSdFGlueyNnS0v
        ewZs5yODeqUu3QuYXF9bHnFnxTXjgubs0pDd0g==
X-Google-Smtp-Source: ABdhPJztuHi2fjsSnmBaCSN95EJlMUxP3vDj4t8FVoFTF3CYTOdZnHHjg36lEWbohNJpDCh9W1cChQLxF0ZOsvN84UM=
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr9854937ejd.7.1592696220739;
 Sat, 20 Jun 2020 16:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com>
 <1592559720-8482-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8JRnhGKOB+faOaHR6p2nknHiMjAnbfo=390c5jNHtp=A@mail.gmail.com>
 <1592623132.15277.7.camel@mtkswgap22>
In-Reply-To: <1592623132.15277.7.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 21 Jun 2020 07:36:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-ZGcsv+LEYs+3qfEE=pv8ToWSPFu+7Oum=s-nUuSsDJw@mail.gmail.com>
Message-ID: <CAAOTY_-ZGcsv+LEYs+3qfEE=pv8ToWSPFu+7Oum=s-nUuSsDJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> Thanks for your quick feedback.
>
> On Sat, 2020-06-20 at 00:25 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:01=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > MT6873 bus frabric provides TrustZone security support and data
> > > protection to prevent slaves from being accessed by unexpected
> > > masters.
> > > The security violations are logged and sent to the processor for
> > > further analysis or countermeasures.
> > >
> > > Any occurrence of security violation would raise an interrupt, and
> > > it will be handled by devapc-mt6873 driver. The violation
> > > information is printed in order to find the murderer.
> > >
> > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > ---
> >
> > [snip]
> >
> > > +
> > > +/*
> > > + * mtk_devapc_pd_get - get devapc pd_types of register address.
> > > + *
> > > + * Returns the value of reg addr
> > > + */
> > > +static void __iomem *mtk_devapc_pd_get(struct mtk_devapc_context *de=
vapc_ctx,
> > > +                                      int slave_type,
> > > +                                      enum DEVAPC_PD_REG_TYPE pd_reg=
_type,
> > > +                                      u32 index)
> > > +{
> > > +       struct mtk_devapc_vio_info *vio_info =3D devapc_ctx->soc->vio=
_info;
> > > +       u32 slave_type_num =3D devapc_ctx->soc->slave_type_num;
> > > +       const u32 *devapc_pds =3D devapc_ctx->soc->devapc_pds;
> >
> > devapc_pds =3D mt6873_devapc_pds;
>
> Are you saying all platform related variables & functions should assign
> & call it directly in this common flow?
> I don't think it's a good idea to go backwards since we already extract
> the common out of it.

I think we should "do one thing in one patch". When you mix two things
into one patch, how does reviewer know each modification belong to
first thing or second thing? For supporting multiple SoC, the patches
sequence look like this:

Patch 1: Add support SoC 1.
Patch 2: Abstract function and variable for SoC 2.
Patch 3: Add support SoC 2.
Patch 4: Abstract function and variable for SoC 3.
Patch 5: Add support SoC 3.
Patch 6: Abstract function and variable for SoC 4.
Patch 7: Add support SoC 4.

In patch 1, you should not do any thing about abstraction, but you
want to merge patch 2, 4, 6 into this patch, so this patch's title
should be "Add support SoC 1 and abstract function and varible for SoC
2, SoC 3, and SoC 4"

>
> >
> >
> > > +       void __iomem *reg;
> > > +
> > > +       if (!devapc_pds)
> >
> > Never happen.
> >
> > > +               return NULL;
> > > +
> > > +       if ((slave_type < slave_type_num &&
> > > +            index < vio_info->vio_mask_sta_num[slave_type]) &&
> > > +           pd_reg_type < PD_REG_TYPE_NUM) {
> >
> > Always true.
> >
> > > +               reg =3D devapc_ctx->devapc_pd_base[slave_type] +
> > > +                       devapc_pds[pd_reg_type];
> > > +
> > > +               if (pd_reg_type =3D=3D VIO_MASK || pd_reg_type =3D=3D=
 VIO_STA)
> > > +                       reg +=3D 0x4 * index;
> > > +
> > > +       } else {
> > > +               pr_err(PFX "Out Of Boundary, slave_type:0x%x/pd_reg_t=
ype:0x%x/index:0x%x\n",
> > > +                      slave_type, pd_reg_type, index);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       return reg;
> > > +}
> > > +
> >
> > [snip]
> >
> > > +
> > > +/*
> > > + * start_devapc - initialize devapc status and start receiving inter=
rupt
> > > + *               while devapc violation is triggered.
> > > + */
> > > +static void start_devapc(struct mtk_devapc_context *devapc_ctx)
> > > +{
> > > +       u32 slave_type_num =3D devapc_ctx->soc->slave_type_num;
> > > +       const struct mtk_device_info **device_info;
> > > +       const struct mtk_device_num *ndevices;
> > > +       void __iomem *pd_vio_shift_sta_reg;
> > > +       void __iomem *pd_apc_con_reg;
> > > +       int slave_type, i, vio_idx, index;
> > > +       u32 vio_shift_sta;
> > > +
> > > +       ndevices =3D devapc_ctx->soc->ndevices;
> >
> > ndevices =3D mtk6873_devices_num;
> >
> >
> > > +
> > > +       device_info =3D devapc_ctx->soc->device_info;
> > > +
> > > +       for (slave_type =3D 0; slave_type < slave_type_num; slave_typ=
e++) {
> > > +               pd_apc_con_reg =3D mtk_devapc_pd_get(devapc_ctx, slav=
e_type,
> > > +                                                  APC_CON, 0);
> > > +               pd_vio_shift_sta_reg =3D mtk_devapc_pd_get(devapc_ctx=
, slave_type,
> > > +                                                        VIO_SHIFT_ST=
A, 0);
> > > +
> > > +               if (!pd_apc_con_reg || !pd_vio_shift_sta_reg || !devi=
ce_info)
> > > +                       return;
> > > +
> > > +               /* Clear DEVAPC violation status */
> > > +               writel(BIT(31), pd_apc_con_reg);
> > > +
> > > +               /* Clear violation shift status */
> > > +               vio_shift_sta =3D readl(pd_vio_shift_sta_reg);
> > > +               if (vio_shift_sta)
> > > +                       writel(vio_shift_sta, pd_vio_shift_sta_reg);
> > > +
> > > +               /* Clear type 2 violation status */
> > > +               check_type2_vio_status(devapc_ctx, slave_type, &vio_i=
dx, &i);
> > > +
> > > +               /* Clear violation status */
> > > +               for (i =3D 0; i < ndevices[slave_type].vio_slave_num;=
 i++) {
> > > +                       vio_idx =3D device_info[slave_type][i].vio_in=
dex;
> > > +                       if ((check_vio_status(devapc_ctx, slave_type,=
 vio_idx)
> > > +                                             =3D=3D VIOLATION_TRIGGE=
RED) &&
> > > +                            clear_vio_status(devapc_ctx, slave_type,
> > > +                                             vio_idx)) {
> > > +                               pr_warn(PFX "Clear vio status failed,=
 slave_type:0x%x, vio_index:0x%x\n",
> > > +                                       slave_type, vio_idx);
> > > +
> > > +                               index =3D i;
> > > +                               mtk_devapc_dump_vio_dbg(devapc_ctx, s=
lave_type,
> > > +                                                       &vio_idx, &in=
dex);
> > > +                               i =3D index - 1;
> > > +                       }
> > > +
> > > +                       mask_module_irq(devapc_ctx, slave_type, vio_i=
dx, false);
> > > +               }
> > > +       }
> > > +}
> > > +
> > > +static DEFINE_SPINLOCK(devapc_lock);
> >
> > Useless, so remove it.
>
> We use devapc_lock in below isr, what do you mean useless?

We use spinlock because a thread context and irq context would access
the same resource, but where is the thread context? If the thread
context exist in another patch, move this spinlock to that patch.

Regards,
Chun-Kuang.

>
> >
> > > +
> > > +/*
> > > + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR)=
 will dump
> > > + *                       violation information including which maste=
r violates
> > > + *                       access slave.
> > > + */
> > > +static irqreturn_t devapc_violation_irq(int irq_number,
> > > +                                       struct mtk_devapc_context *de=
vapc_ctx)
> > > +{
> > > +       u32 slave_type_num =3D devapc_ctx->soc->slave_type_num;
> > > +       const struct mtk_device_info **device_info;
> > > +       struct mtk_devapc_vio_info *vio_info;
> > > +       int slave_type, vio_idx, index;
> > > +       const char *vio_master;
> > > +       unsigned long flags;
> > > +       u8 perm;
> > > +
> > > +       spin_lock_irqsave(&devapc_lock, flags);
> > > +
> > > +       device_info =3D devapc_ctx->soc->device_info;
> > > +       vio_info =3D devapc_ctx->soc->vio_info;
> > > +       vio_idx =3D -1;
> > > +       index =3D -1;
> > > +
> > > +       /* There are multiple DEVAPC_PD */
> > > +       for (slave_type =3D 0; slave_type < slave_type_num; slave_typ=
e++) {
> > > +               if (!check_type2_vio_status(devapc_ctx, slave_type, &=
vio_idx,
> > > +                                           &index))
> > > +                       if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slav=
e_type,
> > > +                                                    &vio_idx, &index=
))
> > > +                               continue;
> > > +
> > > +               /* Ensure that violation info are written before
> > > +                * further operations
> > > +                */
> > > +               smp_mb();
> > > +
> > > +               mask_module_irq(devapc_ctx, slave_type, vio_idx, true=
);
> > > +
> > > +               clear_vio_status(devapc_ctx, slave_type, vio_idx);
> > > +
> > > +               perm =3D get_permission(devapc_ctx, slave_type, index=
,
> > > +                                     vio_info->domain_id);
> > > +
> > > +               vio_master =3D devapc_ctx->soc->master_get
> > > +                       (vio_info->master_id,
> > > +                        vio_info->vio_addr,
> > > +                        slave_type,
> > > +                        vio_info->shift_sta_bit,
> > > +                        vio_info->domain_id);
> >
> > Call mt6873_bus_id_to_master() directly.
> >
> > > +
> > > +               if (!vio_master)
> > > +                       vio_master =3D "UNKNOWN_MASTER";
> > > +
> > > +               pr_info(PFX "Violation - slave_type:0x%x, sys_index:0=
x%x, ctrl_index:0x%x, vio_index:0x%x\n",
> > > +                       slave_type,
> > > +                       device_info[slave_type][index].sys_index,
> > > +                       device_info[slave_type][index].ctrl_index,
> > > +                       device_info[slave_type][index].vio_index);
> > > +
> > > +               pr_info(PFX "Violation Master: %s\n", vio_master);
> > > +
> > > +               devapc_vio_reason(perm);
> > > +
> > > +               mask_module_irq(devapc_ctx, slave_type, vio_idx, fals=
e);
> > > +       }
> > > +
> > > +       spin_unlock_irqrestore(&devapc_lock, flags);
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
>
> [snip]
>
