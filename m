Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B992063A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591873323;
	bh=gu1h/IUOYhI/7TOM9U7hb+/LUXvwcm40pAKhwgfcYJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F6YWmANeOQPALWoOp7d7Q7bjztIZONjsI3j5EciBDcfgPRVsti6fF+bY0HLCwTyHs
	 ZSq4xSRzgKxCPeZpRWAB3yOiz3RK2d3vmqVK/ZeoG6qBNupwfFB1FIQzU2lAsSVSaG
	 vLd7OeRbXxkzh3FH767S4QW8g5pV9+JdTufYzo+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFKLCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgFKLBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:01:54 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067ED2081A;
        Thu, 11 Jun 2020 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591873313;
        bh=gu1h/IUOYhI/7TOM9U7hb+/LUXvwcm40pAKhwgfcYJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cqIboAqW4hHg8bgqsiAn5Q1joqHSy2u96T8WmDCoKNmUki3qY/n2Gi/NBM/JZe9ud
         6suEbxCYhZvyHE+wTVEtc3xrPld+ha04U7LDPUafJVU0+drjHfXo7CCbpo5IljafZq
         x65ETJPafXg64M4NzyodZhY36M1okkxf8OolFlkQ=
Received: by mail-ej1-f50.google.com with SMTP id gl26so5974104ejb.11;
        Thu, 11 Jun 2020 04:01:52 -0700 (PDT)
X-Gm-Message-State: AOAM530niEKC7kHppQF1g3Yje0Od3+8G/rPD8/UD9kQGWWHMsnXN63rH
        u03kfm18TlhLap6/Tl56yWNyMteeaBEwVDjUFA==
X-Google-Smtp-Source: ABdhPJw+wR6kRsb831SwdiEVc8DVKidgK603StbRz0iL76ismZz8YnpXgHH7FyP/vdg5X3AletAez5O8TnpELbZ50VE=
X-Received: by 2002:a17:907:369:: with SMTP id rs9mr7631774ejb.187.1591873311470;
 Thu, 11 Jun 2020 04:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
 <1591698261-22639-3-git-send-email-neal.liu@mediatek.com> <CAAOTY__g3Fnwsoqx=x_tgdMii5K_L9TmF_9048XbAOSJwb-Cxg@mail.gmail.com>
 <1591867563.27949.9.camel@mtkswgap22>
In-Reply-To: <1591867563.27949.9.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 11 Jun 2020 19:01:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8gOjr9nBUVA6oNu0v+D0Rc0AbhJ41wBCvDpMme+kuHmA@mail.gmail.com>
Message-ID: <CAAOTY_8gOjr9nBUVA6oNu0v+D0Rc0AbhJ41wBCvDpMme+kuHmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8811=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 2020-06-10 at 00:01 +0800, Chun-Kuang Hu wrote:
> Hi Chun-Kuang,
>
> [snip]
>
> > > +
> > > +/*
> > > + * mtk_devapc_pd_get - get devapc pd_types of register address.
> > > + *
> > > + * Returns the value of reg addr
> > > + */
> > > +static void __iomem *mtk_devapc_pd_get(int slave_type,
> > > +                                      enum DEVAPC_PD_REG_TYPE pd_reg=
_type,
> > > +                                      u32 index)
> > > +{
> > > +       struct mtk_devapc_vio_info *vio_info =3D mtk_devapc_ctx->soc-=
>vio_info;
> > > +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> > > +       const u32 *devapc_pds =3D mtk_devapc_ctx->soc->devapc_pds;
> > > +       void __iomem *reg;
> > > +
> > > +       if (!devapc_pds)
> > > +               return NULL;
> > > +
> > > +       if ((slave_type < slave_type_num &&
> > > +            index < vio_info->vio_mask_sta_num[slave_type]) &&
> > > +           pd_reg_type < PD_REG_TYPE_NUM) {
> > > +               reg =3D mtk_devapc_ctx->devapc_pd_base[slave_type] +
> > > +                       devapc_pds[pd_reg_type];
> > > +
> > > +               if (pd_reg_type =3D=3D VIO_MASK || pd_reg_type =3D=3D=
 VIO_STA)
> > > +                       reg +=3D 0x4 * index;
> > > +
> > > +       } else {
> > > +               pr_err(PFX "%s:0x%x or %s:0x%x or %s:0x%x is out of b=
oundary\n",
> > > +                      "slave_type", slave_type,
> >
> > Move "slave_type" into format string.
>
> Why is this necessary? Is there any benefit for moving this?

Smaller code size, simple, intuition.

> Since the line length is almost over 80 chars.

Single string could be over 80 chars.

>
> >
> > > +                      "pd_reg_type", pd_reg_type,
> > > +                      "index", index);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       return reg;
> > > +}
> > > +
> >
>
> [snip]
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
> > > +static irqreturn_t devapc_violation_irq(int irq_number, void *dev_id=
)
> > > +{
> > > +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> > > +       const struct mtk_device_info **device_info;
> > > +       struct mtk_devapc_vio_info *vio_info;
> > > +       int slave_type, vio_idx, index;
> > > +       const char *vio_master;
> > > +       unsigned long flags;
> > > +       bool normal;
> > > +       u8 perm;
> > > +
> > > +       spin_lock_irqsave(&devapc_lock, flags);
> > > +
> > > +       device_info =3D mtk_devapc_ctx->soc->device_info;
> > > +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> > > +       normal =3D false;
> > > +       vio_idx =3D -1;
> > > +       index =3D -1;
> > > +
> > > +       /* There are multiple DEVAPC_PD */
> > > +       for (slave_type =3D 0; slave_type < slave_type_num; slave_typ=
e++) {
> > > +               if (!check_type2_vio_status(slave_type, &vio_idx, &in=
dex))
> > > +                       if (!mtk_devapc_dump_vio_dbg(slave_type, &vio=
_idx,
> > > +                                                    &index))
> > > +                               continue;
> > > +
> > > +               /* Ensure that violation info are written before
> > > +                * further operations
> > > +                */
> > > +               smp_mb();
> > > +               normal =3D true;
> > > +
> > > +               mask_module_irq(slave_type, vio_idx, true);
> > > +
> > > +               if (clear_vio_status(slave_type, vio_idx))
> > > +                       pr_warn(PFX "%s, %s:0x%x, %s:0x%x\n",
> > > +                               "clear vio status failed",
> > > +                               "slave_type", slave_type,
> > > +                               "vio_index", vio_idx);
> > > +
> > > +               perm =3D get_permission(slave_type, index, vio_info->=
domain_id);
> > > +
> > > +               vio_master =3D mtk_devapc_ctx->soc->master_get
> > > +                       (vio_info->master_id,
> > > +                        vio_info->vio_addr,
> > > +                        slave_type,
> > > +                        vio_info->shift_sta_bit,
> > > +                        vio_info->domain_id);
> >
> > Call mt6873_bus_id_to_master() directly. For first patch, make things
> > as simple as possible.
>
> In devapc_violation_irq() function, we use common flow to handle each
> devapc violation on different platforms. The master_get() has different
> implementation on different platforms, that why it called indirectly.
>
> Once we have new platform, we only have to update devapc-mtxxxx.c
> instead of common handler flow.

You just upstream one SoC now, so I have no information of 2nd SoC.
Without the 2nd SoC, how do we know what is common and what is SoC special?
So the first patch should not consider the things which does not exist yet.

Regards,
Chun-Kuang.

>
> >
> > > +
> > > +               if (!vio_master) {
> > > +                       pr_warn(PFX "master_get failed\n");
> > > +                       vio_master =3D "UNKNOWN_MASTER";
> > > +               }
> > > +
> > > +               pr_info(PFX "%s - %s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\=
n",
> > > +                       "Violation", "slave_type", slave_type,
> > > +                       "sys_index",
> > > +                       device_info[slave_type][index].sys_index,
> > > +                       "ctrl_index",
> > > +                       device_info[slave_type][index].ctrl_index,
> > > +                       "vio_index",
> > > +                       device_info[slave_type][index].vio_index);
> > > +
> > > +               pr_info(PFX "%s %s %s %s\n",
> > > +                       "Violation - master:", vio_master,
> > > +                       "access violation slave:",
> > > +                       device_info[slave_type][index].device);
> > > +
> > > +               devapc_vio_reason(perm);
> > > +
> > > +               devapc_extra_handler(slave_type, vio_master, vio_idx,
> > > +                                    vio_info->vio_addr);
> > > +
> > > +               mask_module_irq(slave_type, vio_idx, false);
> > > +       }
> > > +
> > > +       if (normal) {
> > > +               spin_unlock_irqrestore(&devapc_lock, flags);
> > > +               return IRQ_HANDLED;
> > > +       }
> > > +
> > > +       spin_unlock_irqrestore(&devapc_lock, flags);
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
>
> [snip]
>
>
