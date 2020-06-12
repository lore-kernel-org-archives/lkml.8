Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8229C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B317020801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975688;
	bh=3yHkAwubmunjmiesfM1rpsD37zARlutAh9UqD8QN8/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YQbsrPV54oeTepO9ES7WVsQP4yImCCQNyp3OKhMEAcdZ+3DChJ2bjN+l7805DIu8t
	 z8sY6CI19ljZORJFhDV+W/zAWg8/ulk99cJG5YXPFylqdmEGyfT4rdZWO/mzfSmcnR
	 fLKi4nyzOejJv7Z4IUB9p6OuuYQqkh1MOK5RVSvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFLP2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLP2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:28:04 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16FA20835;
        Fri, 12 Jun 2020 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591975683;
        bh=3yHkAwubmunjmiesfM1rpsD37zARlutAh9UqD8QN8/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O3tSNdHzuZcgNHn9HdaY2O6n8HPcJ5t7i/x7C1z0ogjs7cl+G8eflb5siB18LUeNr
         lTpbIuOtoakfc0L92Ip5SCoTTNhItXU/ubp/8M0qMFxMjiJ7mTT7knjGgYxPtkv0Um
         VVF90NfntS3ECg8XrwPmZIOK6V5rVL/I2u+a54FM=
Received: by mail-ed1-f49.google.com with SMTP id m21so6696193eds.13;
        Fri, 12 Jun 2020 08:28:02 -0700 (PDT)
X-Gm-Message-State: AOAM533Bwk48EUZtFOLCFu248VDFdI3RWieJ4OvypqFNxil1WciG+k2D
        IrZGnV2lifTAedrMLZDD3f71FnF1Q5o0r4vGRA==
X-Google-Smtp-Source: ABdhPJx4hf1qYx8OMecO3zKZjUrgZ6Cu0RNr2WqkSXT6FEmCa+mY/AG8YYudQbNDLiDsLdfpgLvN1G09M+5JXUzk7WA=
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr12645730edr.271.1591975681395;
 Fri, 12 Jun 2020 08:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
 <1591698261-22639-3-git-send-email-neal.liu@mediatek.com> <CAAOTY__g3Fnwsoqx=x_tgdMii5K_L9TmF_9048XbAOSJwb-Cxg@mail.gmail.com>
 <1591867563.27949.9.camel@mtkswgap22> <CAAOTY_8gOjr9nBUVA6oNu0v+D0Rc0AbhJ41wBCvDpMme+kuHmA@mail.gmail.com>
 <1591931042.32738.26.camel@mtkswgap22>
In-Reply-To: <1591931042.32738.26.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 12 Jun 2020 23:27:49 +0800
X-Gmail-Original-Message-ID: <CAAOTY__zXZvv1gcKgxnbpv2RjDLyuQ1NEz8Nr+dtn4GKE1cvMA@mail.gmail.com>
Message-ID: <CAAOTY__zXZvv1gcKgxnbpv2RjDLyuQ1NEz8Nr+dtn4GKE1cvMA@mail.gmail.com>
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8812=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
> [snip]
> > > > > +/*
> > > > > + * devapc_violation_irq - the devapc Interrupt Service Routine (=
ISR) will dump
> > > > > + *                       violation information including which m=
aster violates
> > > > > + *                       access slave.
> > > > > + */
> > > > > +static irqreturn_t devapc_violation_irq(int irq_number, void *de=
v_id)
> > > > > +{
> > > > > +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_nu=
m;
> > > > > +       const struct mtk_device_info **device_info;
> > > > > +       struct mtk_devapc_vio_info *vio_info;
> > > > > +       int slave_type, vio_idx, index;
> > > > > +       const char *vio_master;
> > > > > +       unsigned long flags;
> > > > > +       bool normal;
> > > > > +       u8 perm;
> > > > > +
> > > > > +       spin_lock_irqsave(&devapc_lock, flags);
> > > > > +
> > > > > +       device_info =3D mtk_devapc_ctx->soc->device_info;
> > > > > +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> > > > > +       normal =3D false;
> > > > > +       vio_idx =3D -1;
> > > > > +       index =3D -1;
> > > > > +
> > > > > +       /* There are multiple DEVAPC_PD */
> > > > > +       for (slave_type =3D 0; slave_type < slave_type_num; slave=
_type++) {
> > > > > +               if (!check_type2_vio_status(slave_type, &vio_idx,=
 &index))
> > > > > +                       if (!mtk_devapc_dump_vio_dbg(slave_type, =
&vio_idx,
> > > > > +                                                    &index))
> > > > > +                               continue;
> > > > > +
> > > > > +               /* Ensure that violation info are written before
> > > > > +                * further operations
> > > > > +                */
> > > > > +               smp_mb();
> > > > > +               normal =3D true;
> > > > > +
> > > > > +               mask_module_irq(slave_type, vio_idx, true);
> > > > > +
> > > > > +               if (clear_vio_status(slave_type, vio_idx))
> > > > > +                       pr_warn(PFX "%s, %s:0x%x, %s:0x%x\n",
> > > > > +                               "clear vio status failed",
> > > > > +                               "slave_type", slave_type,
> > > > > +                               "vio_index", vio_idx);
> > > > > +
> > > > > +               perm =3D get_permission(slave_type, index, vio_in=
fo->domain_id);
> > > > > +
> > > > > +               vio_master =3D mtk_devapc_ctx->soc->master_get
> > > > > +                       (vio_info->master_id,
> > > > > +                        vio_info->vio_addr,
> > > > > +                        slave_type,
> > > > > +                        vio_info->shift_sta_bit,
> > > > > +                        vio_info->domain_id);
> > > >
> > > > Call mt6873_bus_id_to_master() directly. For first patch, make thin=
gs
> > > > as simple as possible.
> > >
> > > In devapc_violation_irq() function, we use common flow to handle each
> > > devapc violation on different platforms. The master_get() has differe=
nt
> > > implementation on different platforms, that why it called indirectly.
> > >
> > > Once we have new platform, we only have to update devapc-mtxxxx.c
> > > instead of common handler flow.
> >
> > You just upstream one SoC now, so I have no information of 2nd SoC.
> > Without the 2nd SoC, how do we know what is common and what is SoC spec=
ial?
> > So the first patch should not consider the things which does not exist =
yet.
> >
> > Regards,
> > Chun-Kuang.
> >
>
> It has lots of refactoring work need to do if you really want make it
> "simple". Could I explain more details and let you judge it is simple
> enough?

Making driver "simple" is very important, so it worth to spend effort
to make things simple. Everybody could modify this driver, so make
this driver simple and everybody would join this easily.

> For most MediaTek DEVAPC hw, the violation interrupt handling sequence
> is shown below.
>
> 1. Domain processor receives a interrupt issued by DEVAPC.
> 2. Software read the violation status and identify it.
> 3. Software read the debug information which are stored in hw register.
>         a. debug information includes master ID, domain ID, violation
> address, ...
> 4. Transfer debug information to human readable strings.
> 5. Extra handler to dispatch owner directly.

I don't know why need extra handler? What does this extra handler could do?
If indeed need it, separate extra handler part to an independent patch.

>
> What we really care is which master violates the rules, and which slave
> had been accessed unexpectedly.
>
> Here are platform specific information:
> 1. Slaves layout (platform devices)
> 2. hw register layout which are stored violation information
> 3. Master ID mapping table
> 4. Domain ID mapping table
>
> Hope these steps could help you understand what is common and what is
> SoC specific. If you want to see the 2nd SoC's driver, I can also send
> it for you to take a look.

Please upstream 2nd SoC's driver, so I could review common part and
SoC specific part.

Regards,
Chun-Kuang.

>
> Thanks,
> Neal
>
> > >
> > > >
> > > > > +
> > > > > +               if (!vio_master) {
> > > > > +                       pr_warn(PFX "master_get failed\n");
> > > > > +                       vio_master =3D "UNKNOWN_MASTER";
> > > > > +               }
> > > > > +
> > > > > +               pr_info(PFX "%s - %s:0x%x, %s:0x%x, %s:0x%x, %s:0=
x%x\n",
> > > > > +                       "Violation", "slave_type", slave_type,
> > > > > +                       "sys_index",
> > > > > +                       device_info[slave_type][index].sys_index,
> > > > > +                       "ctrl_index",
> > > > > +                       device_info[slave_type][index].ctrl_index=
,
> > > > > +                       "vio_index",
> > > > > +                       device_info[slave_type][index].vio_index)=
;
> > > > > +
> > > > > +               pr_info(PFX "%s %s %s %s\n",
> > > > > +                       "Violation - master:", vio_master,
> > > > > +                       "access violation slave:",
> > > > > +                       device_info[slave_type][index].device);
> > > > > +
> > > > > +               devapc_vio_reason(perm);
> > > > > +
> > > > > +               devapc_extra_handler(slave_type, vio_master, vio_=
idx,
> > > > > +                                    vio_info->vio_addr);
> > > > > +
> > > > > +               mask_module_irq(slave_type, vio_idx, false);
> > > > > +       }
> > > > > +
> > > > > +       if (normal) {
> > > > > +               spin_unlock_irqrestore(&devapc_lock, flags);
> > > > > +               return IRQ_HANDLED;
> > > > > +       }
> > > > > +
> > > > > +       spin_unlock_irqrestore(&devapc_lock, flags);
> > > > > +       return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > >
> > > [snip]
> > >
> > >
>
