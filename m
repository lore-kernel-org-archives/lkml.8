Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540DAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23753217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583982;
	bh=78Kv0bButl8hiJiTg88qkjpdJFgrMdmTuvdr++dJwhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0BQd/VrONsHg/if09FJ0/skKAxcLDgLZ84cAH4Cg4zBlv3KUvrOW1VJ82KYSput9I
	 bBC+LKaXb/6BKY3eHI0RNYovEqNmqTI6NGN3nXtDaNqVntpmtRDcnIEeHD46SSpxom
	 Efn1TVM4//XhJzPtIj2WcNq1irgWf0fIIe+rf7n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394865AbgFSQ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389518AbgFSQ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:26:10 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D2E217BA;
        Fri, 19 Jun 2020 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592583968;
        bh=78Kv0bButl8hiJiTg88qkjpdJFgrMdmTuvdr++dJwhM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P5GZ1WzldX067+LJvMu1BQMUm5F0JkgEw0Egqt3qbmsCRsU86+z0xixgDXdESwXzR
         Y6A1dbxgTcLy3FdUfrCszcCY7Vg76N2lC6POuQHSzbn+6/O4+Eb1VlwoMu4j02klpx
         x2crMNA6vlo4IbyXTnWdAQ2OQXXRzhupZmUdQqeM=
Received: by mail-ej1-f44.google.com with SMTP id gl26so10798489ejb.11;
        Fri, 19 Jun 2020 09:26:08 -0700 (PDT)
X-Gm-Message-State: AOAM533AYmqiOOM4vXJMKlEm8bhkj4fZvgk7tcGF0TP9DqICqfapmvKC
        eevLBt+X9YIBFZbK581saiaZPEcNFs3TAzAFrg==
X-Google-Smtp-Source: ABdhPJyKTOXjxdzTySonR/YjAmPvTl/qJK203QbKCJ4CRUzoxbAJNoQkV879w9AEzXL4LeBMXdQN3Iq5EK2gqoi5DeI=
X-Received: by 2002:a17:906:468e:: with SMTP id a14mr4390709ejr.124.1592583966878;
 Fri, 19 Jun 2020 09:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com> <1592559720-8482-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1592559720-8482-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 20 Jun 2020 00:25:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8JRnhGKOB+faOaHR6p2nknHiMjAnbfo=390c5jNHtp=A@mail.gmail.com>
Message-ID: <CAAOTY_8JRnhGKOB+faOaHR6p2nknHiMjAnbfo=390c5jNHtp=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MT6873 bus frabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violations are logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by devapc-mt6873 driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +
> +/*
> + * mtk_devapc_pd_get - get devapc pd_types of register address.
> + *
> + * Returns the value of reg addr
> + */
> +static void __iomem *mtk_devapc_pd_get(struct mtk_devapc_context *devapc=
_ctx,
> +                                      int slave_type,
> +                                      enum DEVAPC_PD_REG_TYPE pd_reg_typ=
e,
> +                                      u32 index)
> +{
> +       struct mtk_devapc_vio_info *vio_info =3D devapc_ctx->soc->vio_inf=
o;
> +       u32 slave_type_num =3D devapc_ctx->soc->slave_type_num;
> +       const u32 *devapc_pds =3D devapc_ctx->soc->devapc_pds;

devapc_pds =3D mt6873_devapc_pds;


> +       void __iomem *reg;
> +
> +       if (!devapc_pds)

Never happen.

> +               return NULL;
> +
> +       if ((slave_type < slave_type_num &&
> +            index < vio_info->vio_mask_sta_num[slave_type]) &&
> +           pd_reg_type < PD_REG_TYPE_NUM) {

Always true.

> +               reg =3D devapc_ctx->devapc_pd_base[slave_type] +
> +                       devapc_pds[pd_reg_type];
> +
> +               if (pd_reg_type =3D=3D VIO_MASK || pd_reg_type =3D=3D VIO=
_STA)
> +                       reg +=3D 0x4 * index;
> +
> +       } else {
> +               pr_err(PFX "Out Of Boundary, slave_type:0x%x/pd_reg_type:=
0x%x/index:0x%x\n",
> +                      slave_type, pd_reg_type, index);
> +               return NULL;
> +       }
> +
> +       return reg;
> +}
> +

[snip]

> +
> +/*
> + * start_devapc - initialize devapc status and start receiving interrupt
> + *               while devapc violation is triggered.
> + */
> +static void start_devapc(struct mtk_devapc_context *devapc_ctx)
> +{
> +       u32 slave_type_num =3D devapc_ctx->soc->slave_type_num;
> +       const struct mtk_device_info **device_info;
> +       const struct mtk_device_num *ndevices;
> +       void __iomem *pd_vio_shift_sta_reg;
> +       void __iomem *pd_apc_con_reg;
> +       int slave_type, i, vio_idx, index;
> +       u32 vio_shift_sta;
> +
> +       ndevices =3D devapc_ctx->soc->ndevices;

ndevices =3D mtk6873_devices_num;


> +
> +       device_info =3D devapc_ctx->soc->device_info;
> +
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {
> +               pd_apc_con_reg =3D mtk_devapc_pd_get(devapc_ctx, slave_ty=
pe,
> +                                                  APC_CON, 0);
> +               pd_vio_shift_sta_reg =3D mtk_devapc_pd_get(devapc_ctx, sl=
ave_type,
> +                                                        VIO_SHIFT_STA, 0=
);
> +
> +               if (!pd_apc_con_reg || !pd_vio_shift_sta_reg || !device_i=
nfo)
> +                       return;
> +
> +               /* Clear DEVAPC violation status */
> +               writel(BIT(31), pd_apc_con_reg);
> +
> +               /* Clear violation shift status */
> +               vio_shift_sta =3D readl(pd_vio_shift_sta_reg);
> +               if (vio_shift_sta)
> +                       writel(vio_shift_sta, pd_vio_shift_sta_reg);
> +
> +               /* Clear type 2 violation status */
> +               check_type2_vio_status(devapc_ctx, slave_type, &vio_idx, =
&i);
> +
> +               /* Clear violation status */
> +               for (i =3D 0; i < ndevices[slave_type].vio_slave_num; i++=
) {
> +                       vio_idx =3D device_info[slave_type][i].vio_index;
> +                       if ((check_vio_status(devapc_ctx, slave_type, vio=
_idx)
> +                                             =3D=3D VIOLATION_TRIGGERED)=
 &&
> +                            clear_vio_status(devapc_ctx, slave_type,
> +                                             vio_idx)) {
> +                               pr_warn(PFX "Clear vio status failed, sla=
ve_type:0x%x, vio_index:0x%x\n",
> +                                       slave_type, vio_idx);
> +
> +                               index =3D i;
> +                               mtk_devapc_dump_vio_dbg(devapc_ctx, slave=
_type,
> +                                                       &vio_idx, &index)=
;
> +                               i =3D index - 1;
> +                       }
> +
> +                       mask_module_irq(devapc_ctx, slave_type, vio_idx, =
false);
> +               }
> +       }
> +}
> +
> +static DEFINE_SPINLOCK(devapc_lock);

Useless, so remove it.

> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) wil=
l dump
> + *                       violation information including which master vi=
olates
> + *                       access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number,
> +                                       struct mtk_devapc_context *devapc=
_ctx)
> +{
> +       u32 slave_type_num =3D devapc_ctx->soc->slave_type_num;
> +       const struct mtk_device_info **device_info;
> +       struct mtk_devapc_vio_info *vio_info;
> +       int slave_type, vio_idx, index;
> +       const char *vio_master;
> +       unsigned long flags;
> +       u8 perm;
> +
> +       spin_lock_irqsave(&devapc_lock, flags);
> +
> +       device_info =3D devapc_ctx->soc->device_info;
> +       vio_info =3D devapc_ctx->soc->vio_info;
> +       vio_idx =3D -1;
> +       index =3D -1;
> +
> +       /* There are multiple DEVAPC_PD */
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {
> +               if (!check_type2_vio_status(devapc_ctx, slave_type, &vio_=
idx,
> +                                           &index))
> +                       if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slave_ty=
pe,
> +                                                    &vio_idx, &index))
> +                               continue;
> +
> +               /* Ensure that violation info are written before
> +                * further operations
> +                */
> +               smp_mb();
> +
> +               mask_module_irq(devapc_ctx, slave_type, vio_idx, true);
> +
> +               clear_vio_status(devapc_ctx, slave_type, vio_idx);
> +
> +               perm =3D get_permission(devapc_ctx, slave_type, index,
> +                                     vio_info->domain_id);
> +
> +               vio_master =3D devapc_ctx->soc->master_get
> +                       (vio_info->master_id,
> +                        vio_info->vio_addr,
> +                        slave_type,
> +                        vio_info->shift_sta_bit,
> +                        vio_info->domain_id);

Call mt6873_bus_id_to_master() directly.

> +
> +               if (!vio_master)
> +                       vio_master =3D "UNKNOWN_MASTER";
> +
> +               pr_info(PFX "Violation - slave_type:0x%x, sys_index:0x%x,=
 ctrl_index:0x%x, vio_index:0x%x\n",
> +                       slave_type,
> +                       device_info[slave_type][index].sys_index,
> +                       device_info[slave_type][index].ctrl_index,
> +                       device_info[slave_type][index].vio_index);
> +
> +               pr_info(PFX "Violation Master: %s\n", vio_master);
> +
> +               devapc_vio_reason(perm);
> +
> +               mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
> +       }
> +
> +       spin_unlock_irqrestore(&devapc_lock, flags);
> +       return IRQ_HANDLED;
> +}
> +

[snip]

> +
> +/***********************************************************************=
*******
> + * VARIABLE DEFINATION
> + ***********************************************************************=
*******/
> +#define MOD_NO_IN_1_DEVAPC     16
> +#define VIOLATION_TRIGGERED    1
> +#define VIOLATION_MASKED       1
> +#define DEAD                   0xdeadbeaf
> +#define PFX                    "[DEVAPC]: "
> +#define SLAVE_TYPE_NUM_MAX     5

SLAVE_TYPE_NUM is 4, why SLAVE_TYPE_NUM_MAX is 5?

> +
> +#define devapc_log(p, s, fmt, args...) \
> +       do { \
> +               typeof(p) (_p) =3D (p); \
> +               ((_p) +=3D scnprintf(_p, sizeof(s) - strlen(s), fmt, ##ar=
gs)); \
> +       } while (0)

Useless, so remove it.

> +
> +#define UNUSED(x)              (void)(x)

Useless, so remove it.

> +
> +/***********************************************************************=
*******
> + * DATA STRUCTURE & FUNCTION DEFINATION
> + ***********************************************************************=
*******/
> +enum DEVAPC_PD_REG_TYPE {
> +       VIO_MASK =3D 0,
> +       VIO_STA,
> +       VIO_DBG0,
> +       VIO_DBG1,
> +       VIO_DBG2,
> +       APC_CON,
> +       VIO_SHIFT_STA,
> +       VIO_SHIFT_SEL,
> +       VIO_SHIFT_CON,
> +       PD_REG_TYPE_NUM,
> +};
> +
> +enum DEVAPC_UT_CMD {
> +       DEVAPC_UT_DAPC_VIO =3D 1,
> +       DEVAPC_UT_SRAM_VIO,
> +};

Useless, so remove it.

> +
> +enum DEVAPC_DOM_ID {
> +       DOMAIN_0 =3D 0,
> +       DOMAIN_1,
> +       DOMAIN_2,
> +       DOMAIN_3,
> +       DOMAIN_4,
> +       DOMAIN_5,
> +       DOMAIN_6,
> +       DOMAIN_7,
> +       DOMAIN_8,
> +       DOMAIN_9,
> +       DOMAIN_10,
> +       DOMAIN_11,
> +       DOMAIN_12,
> +       DOMAIN_13,
> +       DOMAIN_14,
> +       DOMAIN_15,
> +       DOMAIN_OTHERS,
> +};

Useless, so remove it.

> +
> +enum SRAMROM_VIO {
> +       ROM_VIOLATION =3D 0,
> +       SRAM_VIOLATION,
> +};
> +
> +enum DEVAPC_PERM_TYPE {
> +       NO_PROTECTION =3D 0,
> +       SEC_RW_ONLY,
> +       SEC_RW_NS_R,
> +       FORBIDDEN,
> +       PERM_TYPE_NUM,
> +};
> +
> +struct mtk_devapc_dbg_status {
> +       bool enable_ut;
> +       bool enable_dapc; /* dump APC */
> +};

Useless, so remove it.

Regards,
Chun-Kuang.
