Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7728E2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596207811;
	bh=7h1OZHbAgQvVQeo/mlH8Cx5sljeX0uW5NmyH1puDdGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lk7qnSnsQtteHKNEAIxY518OX1dglAuXcPZ4j2l8sxQq36jKh7kMoksCaOagxOsXt
	 q9hkwtvUZTrbKalve53ukAo8ClbskCuOw9O0oMwDvR7awvb/ltgREuX973sx4J4RjM
	 cG/aQbmMvBh6jGE2QNXXczYfB/rUe7yDtg0dyZqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgGaPDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgGaPD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:03:29 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9CC22B40;
        Fri, 31 Jul 2020 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596207807;
        bh=7h1OZHbAgQvVQeo/mlH8Cx5sljeX0uW5NmyH1puDdGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rC6w2BdbZHer5sg8rkIhuCYTCqE4Dd8OBJIe55xAqvD3OQ3BESKCb+VADzVG46LmW
         6yO8OfoIpi0mz0FyoaFuG8NSyTozh2Ld6bRfJv599TLwSRdeI9wdcQ00z3AV95Y5F0
         u5oprR8dwg9TBKTA6xzKTwN4qm6jAhGJLNvHvC7s=
Received: by mail-ej1-f47.google.com with SMTP id kq25so18778899ejb.3;
        Fri, 31 Jul 2020 08:03:27 -0700 (PDT)
X-Gm-Message-State: AOAM533riG01ik4jcYQjoA9y2AxngkMclJo7X0uzZieme7Hx0Ljsvg+t
        tdZ9J86cSUCniXx5GTaps6CB93AOxtifDl0n3Q==
X-Google-Smtp-Source: ABdhPJwP4TSzU3Z1rmBZBBnob1tAI88DNAqSYDEhOduU/lrwrcHZ+ITzAQsm6yLNkXkN0Ec1U4rsT9BPsaaefbqnK+c=
X-Received: by 2002:a17:906:b6d0:: with SMTP id ec16mr4465558ejb.94.1596207806008;
 Fri, 31 Jul 2020 08:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
 <1596010690-13178-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8bE8Qo5-0MA9J1gcEbN4DP=Wf2O6vOUVos=VkoODeayA@mail.gmail.com>
 <1596163478.3932.17.camel@mtkswgap22>
In-Reply-To: <1596163478.3932.17.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 31 Jul 2020 23:03:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9kS+jrCOpZtOs+L8gBzvkewi+cSN7XWGNxuiMQocedFA@mail.gmail.com>
Message-ID: <CAAOTY_9kS+jrCOpZtOs+L8gBzvkewi+cSN7XWGNxuiMQocedFA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8831=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Chun-Kuang,
>
>
> On Thu, 2020-07-30 at 00:38 +0800, Chun-Kuang Hu wrote:
> > Hi, Neal:
> >
> > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:29=E5=AF=AB=E9=81=93=EF=BC=9A
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
> > > +
> > > +static int get_shift_group(struct mtk_devapc_context *ctx)
> > > +{
> > > +       u32 vio_shift_sta;
> > > +       void __iomem *reg;
> > > +
> > > +       reg =3D ctx->devapc_pd_base + ctx->offset->vio_shift_sta;
> > > +       vio_shift_sta =3D readl(reg);
> > > +
> > > +       if (vio_shift_sta)
> > > +               return __ffs(vio_shift_sta);
> > > +
> > > +       return -EIO;
> > > +}
> >
> > get_shift_group() is a small function, I would like to merge this
> > function into sync_vio_dbg() to make code more simple.
>
> This function have a specific functionality. And it would make this
> driver more readability. I would like to keep it as a function. Is that
> okay for you?

After merge, the function would be:

static bool sync_min_shift_group_vio_dbg(struct mtk_devapc_context *ctx)
{
 int min_shift_group;
 int ret;
 u32 val;

 /* find the minimum shift group which has violation */
 val =3D readl(ctx->devapc_pd_base + ctx->offset->vio_shift_sta);
 if (!val)
    return false;

 min_shift_group =3D __ffs(val);

 /* Assign the group to sync */
 writel(0x1 << min_shift_group, ctx->devapc_pd_base +
ctx->offset->vio_shift_sel);

 /* Start syncing */
 writel(0x1, ctx->devapc_pd_base + ctx->offset->vio_shift_con);

 ret =3D readl_poll_timeout(pd_vio_shift_con_reg, val, val =3D=3D 0x3, 0,
     PHY_DEVAPC_TIMEOUT);
 if (ret) {
  dev_err(ctx->dev, "%s: Shift violation info failed\n", __func__);
  return false;
 }

 /* Stop syncing */
 writel(0x0, ctx->devapc_pd_base + ctx->offset->vio_shift_con);

 /* ? */
 writel(0x1 << min_shift_group, ctx->devapc_pd_base +
ctx->offset->vio_shift_sta);

 return true;
}

The whole function is to sync min_shift_group violation info, I don't
know why separate any part to an independent function? Any function
call would cause penalty on CPU performance, so I does not like to
break this function. After good comment, I think every body could
understand the function of each register.
After the merge, the code would be so simple as:

while(sync_min_shift_group_vio_dbg(ctx))
    devapc_extract_vio_dbg(ctx);

>
> >
> > > +
> >
> > [snip]
> >
> > > +
> > > +#define PHY_DEVAPC_TIMEOUT     0x10000
> > > +
> > > +/*
> > > + * sync_vio_dbg - do "shift" mechansim" to get full violation inform=
ation.
> > > + *                shift mechanism is depends on devapc hardware desi=
gn.
> > > + *                Mediatek devapc set multiple slaves as a group. Wh=
en violation
> > > + *                is triggered, violation info is kept inside devapc=
 hardware.
> > > + *                Driver should do shift mechansim to "shift" full v=
iolation
> > > + *                info to VIO_DBGs registers.
> > > + *
> > > + */
> > > +static int sync_vio_dbg(struct mtk_devapc_context *ctx, u32 shift_bi=
t)
> > > +{
> > > +       void __iomem *pd_vio_shift_sta_reg;
> > > +       void __iomem *pd_vio_shift_sel_reg;
> > > +       void __iomem *pd_vio_shift_con_reg;
> > > +       int ret;
> > > +       u32 val;
> > > +
> > > +       pd_vio_shift_sta_reg =3D ctx->devapc_pd_base + ctx->offset->v=
io_shift_sta;
> > > +       pd_vio_shift_sel_reg =3D ctx->devapc_pd_base + ctx->offset->v=
io_shift_sel;
> > > +       pd_vio_shift_con_reg =3D ctx->devapc_pd_base + ctx->offset->v=
io_shift_con;
> > > +
> > > +       /* Enable shift mechansim */
> > > +       writel(0x1 << shift_bit, pd_vio_shift_sel_reg);
> > > +       writel(0x1, pd_vio_shift_con_reg);
> > > +
> > > +       ret =3D readl_poll_timeout(pd_vio_shift_con_reg, val, val =3D=
=3D 0x3, 0,
> > > +                                PHY_DEVAPC_TIMEOUT);
> > > +       if (ret)
> > > +               dev_err(ctx->dev, "%s: Shift violation info failed\n"=
, __func__);
> > > +
> > > +       /* Disable shift mechanism */
> > > +       writel(0x0, pd_vio_shift_con_reg);
> > > +       writel(0x0, pd_vio_shift_sel_reg);
> > > +       writel(0x1 << shift_bit, pd_vio_shift_sta_reg);
> > > +
> > > +       return ret;
> > > +}
> > > +
> >
> > [snip]
> >
> > > +
> > > +/*
> > > + * devapc_extract_vio_dbg - extract full violation information after=
 doing
> > > + *                          shift mechanism.
> > > + */
> > > +static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
> > > +{
> > > +       const struct mtk_devapc_vio_dbgs *vio_dbgs;
> > > +       struct mtk_devapc_vio_info *vio_info;
> > > +       void __iomem *vio_dbg0_reg;
> > > +       void __iomem *vio_dbg1_reg;
> > > +       u32 dbg0;
> > > +
> > > +       vio_dbg0_reg =3D ctx->devapc_pd_base + ctx->offset->vio_dbg0;
> > > +       vio_dbg1_reg =3D ctx->devapc_pd_base + ctx->offset->vio_dbg1;
> > > +
> > > +       vio_dbgs =3D ctx->vio_dbgs;
> > > +       vio_info =3D ctx->vio_info;
> > > +
> > > +       /* Starts to extract violation information */
> > > +       dbg0 =3D readl(vio_dbg0_reg);
> > > +       vio_info->vio_addr =3D readl(vio_dbg1_reg);
> > > +
> > > +       vio_info->master_id =3D (dbg0 & vio_dbgs->mstid.mask) >>
> > > +                             vio_dbgs->mstid.start;
> >
> > What is master_id? How could we use it to debug? For example, if we
> > get a master_id =3D 1, what should we do for this?
> >
> > > +       vio_info->domain_id =3D (dbg0 & vio_dbgs->dmnid.mask) >>
> > > +                             vio_dbgs->dmnid.start;
> >
> > What is domain_id? How could we use it to debug? For example, if we
> > get a domain_id =3D 2, what should we do for this?
> >
>
> master_id and domain_id belongs our bus side-band signal info. It can
> help us to find the violation master.

Does 'violation master' means the hardware could access the protected
register? (ex. CPU, GCE, ...) If so, I think it's better to add
comment to explain how to map (master_id, domain_id) to a hardware
(maybe the device in device tree) because every body does not know
what the number means. Don't try to translate the number to a string
because this would cost much time to do this. Just print a number and
we could find out the master by the comment.

>
> > > +       vio_info->write =3D ((dbg0 & vio_dbgs->vio_w.mask) >>
> > > +                           vio_dbgs->vio_w.start) =3D=3D 1;
> > > +       vio_info->read =3D ((dbg0 & vio_dbgs->vio_r.mask) >>
> > > +                         vio_dbgs->vio_r.start) =3D=3D 1;
> > > +       vio_info->vio_addr_high =3D (dbg0 & vio_dbgs->addr_h.mask) >>
> > > +                                 vio_dbgs->addr_h.start;
> >
> > What is vio_addr_high? As I know all register address are 32 bits, is
> > vio_addr_high the address above 32 bits?
>
> Yes, you are right. In MT6779, all register base are 32 bits. We can
> ignore this info for current driver. I'll update on next patch.
> Thanks !

Such a strange hardware, all register is 32 bits but it has a
vio_addr_high in its register. OK, just drop this.

>
> >
> > > +
> > > +       devapc_vio_info_print(ctx);
> > > +}
> > > +
> >
> > [snip]
> >
> > > +
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
> > > +       u32 vio_idx;
> > > +
> > > +       /*
> > > +        * Mask slave's irq before clearing vio status.
> > > +        * Must do it to avoid nested interrupt and prevent
> > > +        * unexpected behavior.
> > > +        */
> > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++)
> > > +               mask_module_irq(ctx, vio_idx, true);
> >
> > I would like to rewrite this for-loop as below to prevent too many
> > function call in irq handler.
> >
> > for (i =3D 0; i < VIO_MOD_TO_REG_IND(ctx->vio_idx_num); i++)
> >     writel(0xffffffff, ctx->devapc_pd_base + ctx->offset->vio_mask + 4 =
* i);
> >
>
> This idea is okay for me. Is there any macro to replace 0xffffffff?

GENMASK(31, 0);

>
> > reg  =3D readl(ctx->devapc_pd_base + ctx->offset->vio_mask + 4 * i);
> > reg |=3D 1 << (ctx->vio_idx_num - 32 * i + 1) - 1;
> > writel(reg, ctx->devapc_pd_base + ctx->offset->vio_mask + 4 * i);
>
> Are you trying to clear the bits which over vio_idx_num?
> If yes, I think the second line should be:
> reg &=3D 1 << (ctx->vio_idx_num - 32 * i) - 1;
>
> For example, if vio_idx_num is 40:
> after for loop:
> vio_mask0 =3D 0xffffffff;
> vio_mask1 =3D 0xffffffff;

when vio_idx_num is 40, VIO_MOD_TO_REG_IND(ctx->vio_idx_num) is 1, so
after for-loop:
vio_mask0 =3D 0xffffffff;

And the code after for-loop just to do this:
vio_mask1 =3D 0xff;

>
> reg =3D readl(vio_mask1);
> reg &=3D (1 << 8) - 1; (which is 0x000000ff)
> reg will be 0xff
> writel(reg, vio_mask1);
>
> Does it make sense?
>
> Actually, it is okay to overwrite the unused register bits.
> So it's no matter to do this step.

OK, the code would be

for (i =3D 0; i <=3D VIO_MOD_TO_REG_IND(ctx->vio_idx_num - 1); i++)
    writel(GENMASK(31, 0), ctx->devapc_pd_base + ctx->offset->vio_mask + 4 =
* i);

Regards,
Chun-Kuang.

>
> >
> > > +
> > > +       devapc_dump_vio_dbg(ctx);
> > > +
> > > +       /*
> > > +        * Ensure that violation info are written
> > > +        * before further operations
> > > +        */
> > > +       smp_mb();
> > > +
> > > +       for (vio_idx =3D 0; vio_idx < ctx->vio_idx_num; vio_idx++) {
> > > +               clear_vio_status(ctx, vio_idx);
> > > +               mask_module_irq(ctx, vio_idx, false);
> > > +       }
> >
> > Ditto for this for-loop.
>
> Ditto.
>
> >
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> >
> > [snip]
> >
> > > +
> > > +static int mtk_devapc_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device_node *node =3D pdev->dev.of_node;
> > > +       struct mtk_devapc_context *ctx;
> > > +       struct clk *devapc_infra_clk;
> > > +       u32 devapc_irq;
> > > +       int ret;
> > > +
> > > +       if (IS_ERR(node))
> > > +               return -ENODEV;
> > > +
> > > +       ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> > > +       if (!ctx)
> > > +               return -ENOMEM;
> > > +
> > > +       ctx =3D (struct mtk_devapc_context *)of_device_get_match_data=
(&pdev->dev);
> > > +       ctx->dev =3D &pdev->dev;
> > > +
> > > +       ctx->vio_info =3D devm_kzalloc(&pdev->dev,
> > > +                                    sizeof(struct mtk_devapc_vio_inf=
o),
> > > +                                    GFP_KERNEL);
> > > +       if (!ctx->vio_info)
> > > +               return -ENOMEM;
> > > +
> > > +       ctx->devapc_pd_base =3D of_iomap(node, 0);
> > > +       if (!ctx->devapc_pd_base)
> > > +               return -EINVAL;
> > > +
> > > +       devapc_irq =3D irq_of_parse_and_map(node, 0);
> > > +       if (!devapc_irq)
> > > +               return -EINVAL;
> > > +
> > > +       devapc_infra_clk =3D devm_clk_get(&pdev->dev, "devapc-infra-c=
lock");
> > > +       if (IS_ERR(devapc_infra_clk))
> > > +               return -EINVAL;
> > > +
> > > +       if (clk_prepare_enable(devapc_infra_clk))
> > > +               return -EINVAL;
> > > +
> > > +       ret =3D devm_request_irq(&pdev->dev, devapc_irq,
> > > +                              (irq_handler_t)devapc_violation_irq,
> > > +                              IRQF_TRIGGER_NONE, "devapc", ctx);
> > > +       if (ret)
> >
> > You should clk_disable_unprepare(devapc_infra_clk);
>
> Yes, I miss this part. Thanks for your remind.
> I'll update it on next patch.
>
> >
> > > +               return ret;
> > > +
> > > +       start_devapc(ctx);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_devapc_remove(struct platform_device *dev)
> > > +{
> >
> > Ditto.
>
> Ditto.
>
> >
> > Regards,
> > Chun-Kuang.
> >
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
>
