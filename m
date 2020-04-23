Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EDC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AD020781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q25kiY4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgDWSUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgDWSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:20:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20228C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x8so5658249qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9GSc+XJA60ifVVRdwUR6EJUxO4rYwjfZ3dYenTrxt+E=;
        b=q25kiY4liUw6GYd7VF7kqLrM96lKL7cn/iayUurPy6QPoKL+utm9D+Wst6m5SsCSK8
         lTg99yrX4LsbOOWRxGlZU4A5XFCyzCJ9dnUDvCThbUykawNVvwvtBvjE2J1AdQ/3Pnok
         BSNCyEoTozEAsLMq7ggmD1wdW6st4NygRRWFheE7/cut0rHcel/CKLxTTgLJWKQkc9Rc
         rVa7ijpj07uImHHMQWkEi/fIlLpxJRKX+H4z7atNcl90IO1YLcNpz83ldQqMkWsGOfQP
         bDcbJdDPHyVO2OSPA9KAf3wrMxCAqMg6xxY/Y7fsEaCF8rYwE/Bxsn4/Rpmod12TK5a7
         104Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9GSc+XJA60ifVVRdwUR6EJUxO4rYwjfZ3dYenTrxt+E=;
        b=uT+9tvMn9X8FvQEqNOLdHJHzquWjZOQ9lMdL+9RJOJJggnzuz6MUHm+Z6GDodgUjtR
         6URsiTlvfdR3dPbjr98OwtojWqcSPmWRLmhwIywYeB1ZzFdXxwTgW2g8jKDJtXiDNbcm
         P7ZDziIqwRa4pOSaAdZCISfgVig1fUR8d4PD8pB0Acc4xuQ1EGKwdWwxM9XS8seOyeCk
         DHux+jm/4P3jP6zQTvvmwPEixxp7WLNQDt25EI5hS66UyW317tp6e3SsUB2PzoBbdwu2
         iArE/mHIlPo09y5gYDis76jrKQNsZQ+jccl+z4E1O2RXxlhbDVbFOJNcqS9hmxWHc+X+
         KqyA==
X-Gm-Message-State: AGi0Pua3KvFlrcP+Jnggaq7KqfH592pm6CACoZzOIVPLS2Rxme048xvP
        5C39U/Oe72pLsdl3/bjvSRnHJUyp6YjAEFCeAM4=
X-Google-Smtp-Source: APiQypI8enSeot7dUs5JCNXuCdvmdb9Y2zZzgFolF6y9Dj1KJM/f1YoppoEmEnMxYn3GMi4ATgniyPaidaCGa4VQDtU=
X-Received: by 2002:aed:24ee:: with SMTP id u43mr5363655qtc.178.1587666001054;
 Thu, 23 Apr 2020 11:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com> <1584689540-5227-6-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1584689540-5227-6-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Apr 2020 20:19:48 +0200
Message-ID: <CAFqH_52iazfJswB9pyGd9KmJWi2i-KMFDUnGmwcAYRjAYykYzw@mail.gmail.com>
Subject: Re: [PATCH v13 05/11] soc: mediatek: Add multiple step bus protection control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wiyi Lu,

Thank you for your patch.

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dv., 20 de mar=C3=A7
2020 a les 8:33:
>
> Both MT8183 & MT6765 have more control steps of bus protection
> than previous project. And there add more bus protection registers
> reside at infracfg & smi-common.
> Extend function to support multiple step bus protection control
> with more customized arguments.
> And then use bp_table for bus protection of all compatibles,
> instead of mixing bus_prot_mask and bus_prot_reg_update.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 206 ++++++++++++++++++++++++++------=
------
>  drivers/soc/mediatek/scpsys.h     |  42 +++++++-
>  2 files changed, 182 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk=
-scpsys.c
> index e50a568..a4fb0b23 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -88,9 +88,9 @@
>   * @ctl_offs: The offset for main power control register.
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> - * @bus_prot_mask: The mask for single step bus protection.
>   * @basic_clk_name: The basic clocks required by this power domain.
>   * @caps: The flag for active wake-up action.
> + * @bp_table: The mask table for multiple step bus protection.
>   */
>  struct scp_domain_data {
>         const char *name;
> @@ -98,9 +98,9 @@ struct scp_domain_data {
>         int ctl_offs;
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
> -       u32 bus_prot_mask;
>         const char *basic_clk_name[MAX_CLKS];
>         u8 caps;
> +       struct bus_prot bp_table[MAX_STEPS];
>  };
>
>  struct scp;
> @@ -124,8 +124,8 @@ struct scp {
>         struct device *dev;
>         void __iomem *base;
>         struct regmap *infracfg;
> +       struct regmap *smi_common;
>         struct scp_ctrl_reg ctrl_reg;
> -       bool bus_prot_reg_update;
>  };
>
>  struct scp_subdomain {
> @@ -139,7 +139,6 @@ struct scp_soc_data {
>         const struct scp_subdomain *subdomains;
>         int num_subdomains;
>         const struct scp_ctrl_reg regs;
> -       bool bus_prot_reg_update;
>  };
>
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
> @@ -249,53 +248,102 @@ static int scpsys_sram_disable(struct scp_domain *=
scpd, void __iomem *ctl_addr)
>                         MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>  }
>
> +static int set_bus_protection(struct regmap *map, struct bus_prot *bp)
> +{
> +       u32 val;
> +       u32 set_ofs =3D bp->set_ofs;
> +       u32 en_ofs =3D bp->en_ofs;
> +       u32 sta_ofs =3D bp->sta_ofs;
> +       u32 mask =3D bp->mask;

Remove unnecessary local variables (set_ofs, en_ofs, sta_ofs and
mask), and use their bp-> form directly.

> +
> +       if (set_ofs)
> +               regmap_write(map, set_ofs, mask);
> +       else
> +               regmap_update_bits(map, en_ofs, mask, mask);
> +
> +       return regmap_read_poll_timeout(map, sta_ofs,
> +                       val, (val & mask) =3D=3D mask,
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int clear_bus_protection(struct regmap *map, struct bus_prot *bp)
> +{
> +       u32 val;
> +       u32 clr_ofs =3D bp->clr_ofs;
> +       u32 en_ofs =3D bp->en_ofs;
> +       u32 sta_ofs =3D bp->sta_ofs;
> +       u32 mask =3D bp->mask;
> +       bool ignore_ack =3D bp->ignore_clr_ack;

Remove unnecessary local variables (clr_ofs, en_ofs, sta_ofs, mask and
ignore_ack), and use their bp-> form directly.

> +
> +       if (clr_ofs)
> +               regmap_write(map, clr_ofs, mask);
> +       else
> +               regmap_update_bits(map, en_ofs, mask, 0);
> +
> +       if (ignore_ack)
> +               return 0;
> +
> +       return regmap_read_poll_timeout(map, sta_ofs,
> +                       val, !(val & mask),
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
>  static int scpsys_bus_protect_enable(struct scp_domain *scpd)
>  {
>         struct scp *scp =3D scpd->scp;
> +       const struct bus_prot *bp_table =3D scpd->data->bp_table;
>         struct regmap *infracfg =3D scp->infracfg;
> -       u32 mask =3D scpd->data->bus_prot_mask;
> -       bool reg_update =3D scp->bus_prot_reg_update;
> -       u32 val;
> -       int ret;

No need to remove ret if you're going to add anyway later.

> +       struct regmap *smi_common =3D scp->smi_common;
> +       int i;
>
> -       if (!mask)
> -               return 0;
> +       for (i =3D 0; i < MAX_STEPS; i++) {
> +               struct regmap *map =3D NULL;

Declare this on top of the function and no need to initialize to NUlL

> +               int ret;
> +               struct bus_prot bp =3D bp_table[i];

Unneeded local variable ...

>
> -       if (reg_update)
> -               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask=
,
> -                               mask);
> -       else
> -               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> +               if (bp.type =3D=3D IFR_TYPE)

bp_table[i].type?

> +                       map =3D infracfg;
> +               else if (bp.type =3D=3D SMI_TYPE)

ditto

> +                       map =3D smi_common;
> +               else
> +                       break;

So if the type is invalid you break the loop, this is different to
what you are doing below with the scpsys_bus_protect_protect_disable()
function where you are "ignoring" instead of beaking the loop. I am
wondering why? Looks to me that, or you break and print an error
because something was really wrong? or you ignore in both cases?

>
> -       ret =3D regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTST=
A1,
> -                                      val, (val & mask) =3D=3D mask,
> -                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOU=
T);
> +               ret =3D set_bus_protection(map, &bp);
>
> -       return ret;
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static int scpsys_bus_protect_disable(struct scp_domain *scpd)
>  {
>         struct scp *scp =3D scpd->scp;
> +       const struct bus_prot *bp_table =3D scpd->data->bp_table;
>         struct regmap *infracfg =3D scp->infracfg;
> -       u32 mask =3D scpd->data->bus_prot_mask;
> -       bool reg_update =3D scp->bus_prot_reg_update;
> -       u32 val;
> -       int ret;
> +       struct regmap *smi_common =3D scp->smi_common;
> +       int i;
>
> -       if (!mask)
> -               return 0;
> +       for (i =3D MAX_STEPS - 1; i >=3D 0; i--) {
> +               struct regmap *map =3D NULL;
> +               int ret;
> +               struct bus_prot bp =3D bp_table[i];

The same comments done for scpsys_bus_protect_disable apply here.

>
> -       if (reg_update)
> -               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask=
, 0);
> -       else
> -               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> +               if (bp.type =3D=3D IFR_TYPE)
> +                       map =3D infracfg;
> +               else if (bp.type =3D=3D SMI_TYPE)
> +                       map =3D smi_common;
> +               else
> +                       continue;
>
> -       ret =3D regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTST=
A1,
> -                                      val, !(val & mask),
> -                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOU=
T);
> +               ret =3D clear_bus_protection(map, &bp);
>
> -       return ret;
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
>  }
>
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
> @@ -430,8 +478,7 @@ static int init_basic_clks(struct platform_device *pd=
ev, struct clk **clk,
>
>  static struct scp *init_scp(struct platform_device *pdev,
>                         const struct scp_domain_data *scp_domain_data, in=
t num,
> -                       const struct scp_ctrl_reg *scp_ctrl_reg,
> -                       bool bus_prot_reg_update)
> +                       const struct scp_ctrl_reg *scp_ctrl_reg)
>  {
>         struct genpd_onecell_data *pd_data;
>         struct resource *res;
> @@ -445,8 +492,6 @@ static struct scp *init_scp(struct platform_device *p=
dev,
>         scp->ctrl_reg.pwr_sta_offs =3D scp_ctrl_reg->pwr_sta_offs;
>         scp->ctrl_reg.pwr_sta2nd_offs =3D scp_ctrl_reg->pwr_sta2nd_offs;
>
> -       scp->bus_prot_reg_update =3D bus_prot_reg_update;
> -
>         scp->dev =3D &pdev->dev;
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -474,6 +519,17 @@ static struct scp *init_scp(struct platform_device *=
pdev,
>                 return ERR_CAST(scp->infracfg);
>         }
>
> +       scp->smi_common =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_=
node,
> +                       "smi_comm");

Hmm, is this property documented? I couldn't find it.

> +
> +       if (scp->smi_common =3D=3D ERR_PTR(-ENODEV)) {
> +               scp->smi_common =3D NULL;
> +       } else if (IS_ERR(scp->smi_common)) {
> +               dev_err(&pdev->dev, "Cannot find smi_common controller: %=
ld\n",
> +                               PTR_ERR(scp->smi_common));
> +               return ERR_CAST(scp->smi_common);
> +       }
> +
>         for (i =3D 0; i < num; i++) {
>                 struct scp_domain *scpd =3D &scp->domains[i];
>                 const struct scp_domain_data *data =3D &scp_domain_data[i=
];
> @@ -556,8 +612,11 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .name =3D "conn",
>                 .sta_mask =3D PWR_STATUS_CONN,
>                 .ctl_offs =3D SPM_CONN_PWR_CON,
> -               .bus_prot_mask =3D MT2701_TOP_AXI_PROT_EN_CONN_M |
> -                                MT2701_TOP_AXI_PROT_EN_CONN_S,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT2701_TOP_AXI_PROT_EN_CONN_M |
> +                               MT2701_TOP_AXI_PROT_EN_CONN_S),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_DISP] =3D {
> @@ -566,7 +625,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .ctl_offs =3D SPM_DIS_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .basic_clk_name =3D {"mm"},
> -               .bus_prot_mask =3D MT2701_TOP_AXI_PROT_EN_MM_M0,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT2701_TOP_AXI_PROT_EN_MM_M0),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_MFG] =3D {
> @@ -701,7 +763,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(16, 16),
>                 .basic_clk_name =3D {"mfg"},
> -               .bus_prot_mask =3D BIT(14) | BIT(21) | BIT(23),
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0x260, 0x264, 0x220, 0x228,
> +                               BIT(14) | BIT(21) | BIT(23)),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG_SC1] =3D {
> @@ -773,7 +838,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
>                 .basic_clk_name =3D {"mm"},
> -               .bus_prot_mask =3D (BIT(1) | BIT(2)),
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               BIT(1) | BIT(2)),
> +               },
>         },
>         [MT6797_POWER_DOMAIN_AUDIO] =3D {
>                 .name =3D "audio",
> @@ -820,7 +888,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .ctl_offs =3D SPM_ETHSYS_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_ETHSYS,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT7622_TOP_AXI_PROT_EN_ETHSYS),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7622_POWER_DOMAIN_HIF0] =3D {
> @@ -830,7 +901,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
>                 .basic_clk_name =3D {"hif_sel"},
> -               .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_HIF0,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT7622_TOP_AXI_PROT_EN_HIF0),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7622_POWER_DOMAIN_HIF1] =3D {
> @@ -840,7 +914,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
>                 .basic_clk_name =3D {"hif_sel"},
> -               .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_HIF1,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT7622_TOP_AXI_PROT_EN_HIF1),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7622_POWER_DOMAIN_WB] =3D {
> @@ -849,7 +926,10 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .ctl_offs =3D SPM_WB_PWR_CON,
>                 .sram_pdn_bits =3D 0,
>                 .sram_pdn_ack_bits =3D 0,
> -               .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_WB,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT7622_TOP_AXI_PROT_EN_WB),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
>         },
>  };
> @@ -863,8 +943,11 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .name =3D "conn",
>                 .sta_mask =3D PWR_STATUS_CONN,
>                 .ctl_offs =3D SPM_CONN_PWR_CON,
> -               .bus_prot_mask =3D MT2701_TOP_AXI_PROT_EN_CONN_M |
> -                                MT2701_TOP_AXI_PROT_EN_CONN_S,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT2701_TOP_AXI_PROT_EN_CONN_M |
> +                               MT2701_TOP_AXI_PROT_EN_CONN_S),
> +               },
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_ETH] =3D {
> @@ -929,8 +1012,11 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
>                 .basic_clk_name =3D {"mm"},
> -               .bus_prot_mask =3D MT8173_TOP_AXI_PROT_EN_MM_M0 |
> -                       MT8173_TOP_AXI_PROT_EN_MM_M1,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT8173_TOP_AXI_PROT_EN_MM_M0 |
> +                               MT8173_TOP_AXI_PROT_EN_MM_M1),
> +               },
>         },
>         [MT8173_POWER_DOMAIN_VENC_LT] =3D {
>                 .name =3D "venc_lt",
> @@ -976,10 +1062,13 @@ static void mtk_register_power_domains(struct plat=
form_device *pdev,
>                 .ctl_offs =3D SPM_MFG_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(13, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(21, 16),
> -               .bus_prot_mask =3D MT8173_TOP_AXI_PROT_EN_MFG_S |
> -                       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> -                       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> -                       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
> +               .bp_table =3D {
> +                       BUS_PROT(IFR_TYPE, 0, 0, 0x220, 0x228,
> +                               MT8173_TOP_AXI_PROT_EN_MFG_S |
> +                               MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> +                               MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> +                               MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT),
> +               },
>         },
>  };
>
> @@ -995,7 +1084,6 @@ static void mtk_register_power_domains(struct platfo=
rm_device *pdev,
>                 .pwr_sta_offs =3D SPM_PWR_STATUS,
>                 .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND
>         },
> -       .bus_prot_reg_update =3D true,
>  };
>
>  static const struct scp_soc_data mt2712_data =3D {
> @@ -1007,7 +1095,6 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .pwr_sta_offs =3D SPM_PWR_STATUS,
>                 .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND
>         },
> -       .bus_prot_reg_update =3D false,
>  };
>
>  static const struct scp_soc_data mt6797_data =3D {
> @@ -1019,7 +1106,6 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .pwr_sta_offs =3D SPM_PWR_STATUS_MT6797,
>                 .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND_MT6797
>         },
> -       .bus_prot_reg_update =3D true,
>  };
>
>  static const struct scp_soc_data mt7622_data =3D {
> @@ -1029,7 +1115,6 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .pwr_sta_offs =3D SPM_PWR_STATUS,
>                 .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND
>         },
> -       .bus_prot_reg_update =3D true,
>  };
>
>  static const struct scp_soc_data mt7623a_data =3D {
> @@ -1039,7 +1124,6 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .pwr_sta_offs =3D SPM_PWR_STATUS,
>                 .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND
>         },
> -       .bus_prot_reg_update =3D true,
>  };
>
>  static const struct scp_soc_data mt8173_data =3D {
> @@ -1051,7 +1135,6 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .pwr_sta_offs =3D SPM_PWR_STATUS,
>                 .pwr_sta2nd_offs =3D SPM_PWR_STATUS_2ND
>         },
> -       .bus_prot_reg_update =3D true,
>  };
>
>  /*
> @@ -1092,8 +1175,7 @@ static int scpsys_probe(struct platform_device *pde=
v)
>
>         soc =3D of_device_get_match_data(&pdev->dev);
>
> -       scp =3D init_scp(pdev, soc->domains, soc->num_domains, &soc->regs=
,
> -                       soc->bus_prot_reg_update);
> +       scp =3D init_scp(pdev, soc->domains, soc->num_domains, &soc->regs=
);
>         if (IS_ERR(scp))
>                 return PTR_ERR(scp);
>
> diff --git a/drivers/soc/mediatek/scpsys.h b/drivers/soc/mediatek/scpsys.=
h
> index ad2559b..45bc644 100644
> --- a/drivers/soc/mediatek/scpsys.h
> +++ b/drivers/soc/mediatek/scpsys.h
> @@ -2,10 +2,28 @@
>  #ifndef __SOC_MEDIATEK_SCPSYS_H
>  #define __SOC_MEDIATEK_SCPSYS_H
>
> -#define INFRA_TOPAXI_PROTECTEN         0x0220
> -#define INFRA_TOPAXI_PROTECTSTA1       0x0228
> -#define INFRA_TOPAXI_PROTECTEN_SET     0x0260
> -#define INFRA_TOPAXI_PROTECTEN_CLR     0x0264
> +#define MAX_STEPS      4
> +
> +#define _BUS_PROT(_type, _set_ofs, _clr_ofs,                   \
> +               _en_ofs, _sta_ofs, _mask, _ignore_clr_ack) {    \
> +               .type =3D _type,                                  \
> +               .set_ofs =3D _set_ofs,                            \
> +               .clr_ofs =3D _clr_ofs,                            \
> +               .en_ofs =3D _en_ofs,                              \
> +               .sta_ofs =3D _sta_ofs,                            \
> +               .mask =3D _mask,                                  \
> +               .ignore_clr_ack =3D _ignore_clr_ack,              \
> +       }
> +
> +#define BUS_PROT(_type, _set_ofs, _clr_ofs,            \
> +               _en_ofs, _sta_ofs, _mask)               \
> +               _BUS_PROT(_type, _set_ofs, _clr_ofs,    \
> +               _en_ofs, _sta_ofs, _mask, false)
> +
> +#define BUS_PROT_IGN(_type, _set_ofs, _clr_ofs,        \
> +               _en_ofs, _sta_ofs, _mask)               \
> +               _BUS_PROT(_type, _set_ofs, _clr_ofs,    \
> +               _en_ofs, _sta_ofs, _mask, true)
>
>  #define MT2701_TOP_AXI_PROT_EN_MM_M0           BIT(1)
>  #define MT2701_TOP_AXI_PROT_EN_CONN_M          BIT(2)
> @@ -25,4 +43,20 @@
>  #define MT8173_TOP_AXI_PROT_EN_MFG_M1          BIT(22)
>  #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT   BIT(23)
>
> +enum regmap_type {
> +       INVALID_TYPE =3D 0,

I didn't see any use of that type, is this an option?


> +       IFR_TYPE,
> +       SMI_TYPE,
> +};
> +
> +struct bus_prot {
> +       enum regmap_type type;
> +       u32 set_ofs;
> +       u32 clr_ofs;
> +       u32 en_ofs;
> +       u32 sta_ofs;
> +       u32 mask;
> +       bool ignore_clr_ack;
> +};
> +
>  #endif /* __SOC_MEDIATEK_SCPSYS_H */
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
