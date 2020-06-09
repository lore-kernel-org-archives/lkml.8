Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC47C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9837D2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591718522;
	bh=x9XnVqO3xzQBj6iIZG51MoTCRzkI+avhlJDOv1dW4A8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=asZlbgX84ntPIiUggaYpaew0BAZmWP9SYABxoXWcapB8h8ZYPCRJBj2P/ihWK856K
	 blv8p74yq+rmZUJaHyJZLiMp2r2NfcHh7mwygXidZiMLu9S2YPRbycEgoNSuj7gGmF
	 WAg1lSMedbsX24QBROxhkawPRC0xCOnHQ8eBmBkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgFIQCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730640AbgFIQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:02:01 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4473720737;
        Tue,  9 Jun 2020 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591718519;
        bh=x9XnVqO3xzQBj6iIZG51MoTCRzkI+avhlJDOv1dW4A8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=apmbS8jhTSKRwyxpcAwAJ9YrmcalaKgkXVrW81HNwC3Q6pj0k6T60LHoFvvYIgErD
         ynU7vSPR/6La4+GXlVu4pzaqqLjObBlhbdg56wBbME1cowdRWnAyxeKNei849YF3VJ
         VsQibWle5h7TatZeMO8tUELXgC+S4FHfeYX0y3QY=
Received: by mail-ej1-f43.google.com with SMTP id k11so23003752ejr.9;
        Tue, 09 Jun 2020 09:01:59 -0700 (PDT)
X-Gm-Message-State: AOAM531T9fdKhr6GFct/Hz32nyxJ/gamTqlqF3fvcs9cke6K0MoyDeQw
        T0s2SG5PNYfGkFHg9xQXvbtJ4zAttkqQhFQIMA==
X-Google-Smtp-Source: ABdhPJxKIl5SnYjgH7ywBQFvWrLorFiA1CakhpBe+UztqF4izapVMvaOZ1tYqCzy7V5MsEVltTQulE0V8mcD91jBlRg=
X-Received: by 2002:a17:906:d105:: with SMTP id b5mr11030541ejz.375.1591718516695;
 Tue, 09 Jun 2020 09:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com> <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 10 Jun 2020 00:01:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY__g3Fnwsoqx=x_tgdMii5K_L9TmF_9048XbAOSJwb-Cxg@mail.gmail.com>
Message-ID: <CAAOTY__g3Fnwsoqx=x_tgdMii5K_L9TmF_9048XbAOSJwb-Cxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
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

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:25=E5=AF=AB=E9=81=93=EF=BC=9A
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
>  drivers/soc/mediatek/Kconfig                      |    6 +
>  drivers/soc/mediatek/Makefile                     |    1 +
>  drivers/soc/mediatek/devapc/Kconfig               |   25 +
>  drivers/soc/mediatek/devapc/Makefile              |   13 +
>  drivers/soc/mediatek/devapc/devapc-mt6873.c       | 1733 +++++++++++++++=
++++++
>  drivers/soc/mediatek/devapc/devapc-mt6873.h       |  130 ++
>  drivers/soc/mediatek/devapc/devapc-mtk-multi-ao.c | 1019 ++++++++++++
>  drivers/soc/mediatek/devapc/devapc-mtk-multi-ao.h |  183 +++
>  include/linux/soc/mediatek/devapc_public.h        |   41 +
>  9 files changed, 3151 insertions(+)
>  create mode 100644 drivers/soc/mediatek/devapc/Kconfig
>  create mode 100644 drivers/soc/mediatek/devapc/Makefile
>  create mode 100644 drivers/soc/mediatek/devapc/devapc-mt6873.c
>  create mode 100644 drivers/soc/mediatek/devapc/devapc-mt6873.h
>  create mode 100644 drivers/soc/mediatek/devapc/devapc-mtk-multi-ao.c
>  create mode 100644 drivers/soc/mediatek/devapc/devapc-mtk-multi-ao.h
>  create mode 100644 include/linux/soc/mediatek/devapc_public.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 2114b56..cc46f50 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -44,4 +44,10 @@ config MTK_SCPSYS
>           Say yes here to add support for the MediaTek SCPSYS power domai=
n
>           driver.
>
> +menu "Security"
> +
> +source "drivers/soc/mediatek/devapc/Kconfig"
> +
> +endmenu # Security
> +
>  endmenu
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefil=
e
> index b017330..7154a2a 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_MTK_CMDQ) +=3D mtk-cmdq-helper.o
>  obj-$(CONFIG_MTK_INFRACFG) +=3D mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) +=3D mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) +=3D mtk-scpsys.o
> +obj-$(CONFIG_MTK_DEVAPC) +=3D devapc/

alphabetic order.

> diff --git a/drivers/soc/mediatek/devapc/Kconfig b/drivers/soc/mediatek/d=
evapc/Kconfig
> new file mode 100644
> index 0000000..9428360
> --- /dev/null
> +++ b/drivers/soc/mediatek/devapc/Kconfig
> @@ -0,0 +1,25 @@
> +config MTK_DEVAPC
> +       tristate "Mediatek Device APC Support"
> +       help
> +         Device APC is a kernel driver controlling internal device secur=
ity.
> +         If someone tries to access a device, which is not allowed by th=
e
> +         device, it cannot access the device and will get a violation
> +         interrupt. Device APC prevents malicious access to internal dev=
ices.
> +
> +config DEVAPC_ARCH_MULTI
> +       tristate "Mediatek Device APC driver architecture multi"
> +       help
> +         Say yes here to enable support Mediatek
> +         Device APC driver which is based on Infra
> +         architecture.
> +         This architecture supports multiple Infra AO.
> +
> +config DEVAPC_MT6873
> +       tristate "Mediatek MT6873 Device APC driver"
> +       select MTK_DEVAPC
> +       select DEVAPC_ARCH_MULTI
> +       help
> +         Say yes here to enable support Mediatek MT6873
> +         Device APC driver.
> +         This driver is combined with DEVAPC_ARCH_MULTI for
> +         common handle flow.

[snip]

> +static struct mtk_devapc_context {
> + struct clk *devapc_infra_clk;
> + u32 devapc_irq;
> +
> + /* HW reg mapped addr */
> + void __iomem *devapc_pd_base[4];
> + void __iomem *infracfg_base;
> +
> + struct mtk_devapc_soc *soc;
> +} mtk_devapc_ctx[1];
> +
> +static LIST_HEAD(viocb_list);
> +static DEFINE_SPINLOCK(devapc_lock);

Move global variable into struct mtk_devapc_context .

> +
> +/*
> + * mtk_devapc_pd_get - get devapc pd_types of register address.
> + *
> + * Returns the value of reg addr
> + */
> +static void __iomem *mtk_devapc_pd_get(int slave_type,
> +                                      enum DEVAPC_PD_REG_TYPE pd_reg_typ=
e,
> +                                      u32 index)
> +{
> +       struct mtk_devapc_vio_info *vio_info =3D mtk_devapc_ctx->soc->vio=
_info;
> +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> +       const u32 *devapc_pds =3D mtk_devapc_ctx->soc->devapc_pds;
> +       void __iomem *reg;
> +
> +       if (!devapc_pds)
> +               return NULL;
> +
> +       if ((slave_type < slave_type_num &&
> +            index < vio_info->vio_mask_sta_num[slave_type]) &&
> +           pd_reg_type < PD_REG_TYPE_NUM) {
> +               reg =3D mtk_devapc_ctx->devapc_pd_base[slave_type] +
> +                       devapc_pds[pd_reg_type];
> +
> +               if (pd_reg_type =3D=3D VIO_MASK || pd_reg_type =3D=3D VIO=
_STA)
> +                       reg +=3D 0x4 * index;
> +
> +       } else {
> +               pr_err(PFX "%s:0x%x or %s:0x%x or %s:0x%x is out of bound=
ary\n",
> +                      "slave_type", slave_type,

Move "slave_type" into format string.

> +                      "pd_reg_type", pd_reg_type,
> +                      "index", index);
> +               return NULL;
> +       }
> +
> +       return reg;
> +}
> +

[snip]

> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) wil=
l dump
> + *                       violation information including which master vi=
olates
> + *                       access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number, void *dev_id)
> +{
> +       u32 slave_type_num =3D mtk_devapc_ctx->soc->slave_type_num;
> +       const struct mtk_device_info **device_info;
> +       struct mtk_devapc_vio_info *vio_info;
> +       int slave_type, vio_idx, index;
> +       const char *vio_master;
> +       unsigned long flags;
> +       bool normal;
> +       u8 perm;
> +
> +       spin_lock_irqsave(&devapc_lock, flags);
> +
> +       device_info =3D mtk_devapc_ctx->soc->device_info;
> +       vio_info =3D mtk_devapc_ctx->soc->vio_info;
> +       normal =3D false;
> +       vio_idx =3D -1;
> +       index =3D -1;
> +
> +       /* There are multiple DEVAPC_PD */
> +       for (slave_type =3D 0; slave_type < slave_type_num; slave_type++)=
 {
> +               if (!check_type2_vio_status(slave_type, &vio_idx, &index)=
)
> +                       if (!mtk_devapc_dump_vio_dbg(slave_type, &vio_idx=
,
> +                                                    &index))
> +                               continue;
> +
> +               /* Ensure that violation info are written before
> +                * further operations
> +                */
> +               smp_mb();
> +               normal =3D true;
> +
> +               mask_module_irq(slave_type, vio_idx, true);
> +
> +               if (clear_vio_status(slave_type, vio_idx))
> +                       pr_warn(PFX "%s, %s:0x%x, %s:0x%x\n",
> +                               "clear vio status failed",
> +                               "slave_type", slave_type,
> +                               "vio_index", vio_idx);
> +
> +               perm =3D get_permission(slave_type, index, vio_info->doma=
in_id);
> +
> +               vio_master =3D mtk_devapc_ctx->soc->master_get
> +                       (vio_info->master_id,
> +                        vio_info->vio_addr,
> +                        slave_type,
> +                        vio_info->shift_sta_bit,
> +                        vio_info->domain_id);

Call mt6873_bus_id_to_master() directly. For first patch, make things
as simple as possible.

> +
> +               if (!vio_master) {
> +                       pr_warn(PFX "master_get failed\n");
> +                       vio_master =3D "UNKNOWN_MASTER";
> +               }
> +
> +               pr_info(PFX "%s - %s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> +                       "Violation", "slave_type", slave_type,
> +                       "sys_index",
> +                       device_info[slave_type][index].sys_index,
> +                       "ctrl_index",
> +                       device_info[slave_type][index].ctrl_index,
> +                       "vio_index",
> +                       device_info[slave_type][index].vio_index);
> +
> +               pr_info(PFX "%s %s %s %s\n",
> +                       "Violation - master:", vio_master,
> +                       "access violation slave:",
> +                       device_info[slave_type][index].device);
> +
> +               devapc_vio_reason(perm);
> +
> +               devapc_extra_handler(slave_type, vio_master, vio_idx,
> +                                    vio_info->vio_addr);
> +
> +               mask_module_irq(slave_type, vio_idx, false);
> +       }
> +
> +       if (normal) {
> +               spin_unlock_irqrestore(&devapc_lock, flags);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_unlock_irqrestore(&devapc_lock, flags);
> +       return IRQ_HANDLED;
> +}
> +

[snip]

> +uint32_t devapc_vio_check(void);
> +void dump_dbg_info(void);
> +void register_devapc_vio_callback(struct devapc_vio_callbacks *viocb);
> +void devapc_catch_illegal_range(phys_addr_t phys_addr, size_t size);

devapc_catch_illegal_range() is useless, so remove it.

Regards,
Chun-Kuang.

> +
> +#endif  /* __DEVAPC_PUBLIC_H__ */
> +
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
