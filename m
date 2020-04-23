Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA575C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5C620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwrVBJsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgDWSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgDWSUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:20:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E99C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c63so7475533qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j4Gr42DIWiKl6eQeKg3rq/cPMMusL6SIoFXxct0KIAg=;
        b=UwrVBJsZzOzXwdEsTMcl+KRh/0QCgS9dn94FqtTs7Af5un97fe/TH6xbtKSthwk9RV
         /JAncl7NeMRjoBqtFhJfzf0fnm6zua2BizvrpdqAOwUzYImfQ9ltXKGZotJkfmdh1rUT
         qgS8ctAOT/lyFv1AJxHNDZIVElxDLeJU7Z2vNOqbLL5VtPP+BJO6U2wLccJjiwYQQFhd
         roT3nP7FW4McxdB+Rkob/nbB7l1HhM+L/El6WPrntM1ZUuI+STtoY6dBD7lXbLwO4whQ
         V84FIP1vXoiEv98UJP8pF/2dgfFb3sl1R5XEOpBDtpZeNNPl9Fodyc+sNqtcd5pl8zo6
         tT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j4Gr42DIWiKl6eQeKg3rq/cPMMusL6SIoFXxct0KIAg=;
        b=gGrLEeLnewunfvkG6eq1GCpIIFaZoJHWyEmx2fJQBC5yM8nBUZKb4ega0lYA1bTz4i
         S+vvDpBXptE1yTdMczpALHKz8CBUcyPqVABL8baEtOFTwU/qAuEvCcz/dIf3880m9khh
         Yq3ZVskFYdVSkqOEAVNftIelZXq+0fCJPeKrbLx4KhhrsUR9aur9m31w+dfjD0OYmDs4
         rHf3+pD6vx4xi7/q3kCsATWuZwdCGWX8Jv+LdNtssEMwr+XWgRgqqi8+9HNEbKhM3XOk
         JBSnDROqB168cSYjS2i4c49E1Vs+AELR3nyRRQBwZmOoGzvNriRHoc+Z4gRpiV4baBVO
         rtiQ==
X-Gm-Message-State: AGi0Pubq6nGoyj0WPibAb40RH5koVKJmc9aPVnEYZ7XNpvansJrdy/zj
        EmJMYyNcOkkSAM+RPRmhxsm3lh8xXnLluECNK8o=
X-Google-Smtp-Source: APiQypLydQuI84sE+VTN65AOkbQz72bsQCoCUOfojli0YF5UAG8nFoefn5Q7DW+gilT5gA9Bx/7hZNKjfOTi60djObQ=
X-Received: by 2002:a37:49c7:: with SMTP id w190mr4982758qka.402.1587666013842;
 Thu, 23 Apr 2020 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com> <1584689540-5227-4-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1584689540-5227-4-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Apr 2020 20:20:01 +0200
Message-ID: <CAFqH_53jcqEdrUmp3xpcmrbq5vZ_YHzVaQEXAoQ73-3X7=oa7w@mail.gmail.com>
Subject: Re: [PATCH v13 03/11] soc: mediatek: Add basic_clk_name to scp_power_data
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

Hi Weiyi Lu,

Thank you for your patch.

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dv., 20 de mar=C3=A7
2020 a les 8:33:
>
> Try to stop extending the clk_id or clk_names if there are
> more and more new BASIC clocks. To get its own clocks by the
> basic_clk_name of each power domain.
> And then use basic_clk_name strings for all compatibles, instead of
> mixing clk_id and clk_name.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 138 +++++++++++++-------------------=
------
>  1 file changed, 45 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk=
-scpsys.c
> index f669d37..db35a28 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -78,34 +78,6 @@
>  #define PWR_STATUS_HIF1                        BIT(26) /* MT7622 */
>  #define PWR_STATUS_WB                  BIT(27) /* MT7622 */
>
> -enum clk_id {
> -       CLK_NONE,
> -       CLK_MM,
> -       CLK_MFG,
> -       CLK_VENC,
> -       CLK_VENC_LT,
> -       CLK_ETHIF,
> -       CLK_VDEC,
> -       CLK_HIFSEL,
> -       CLK_JPGDEC,
> -       CLK_AUDIO,
> -       CLK_MAX,
> -};
> -
> -static const char * const clk_names[] =3D {
> -       NULL,
> -       "mm",
> -       "mfg",
> -       "venc",
> -       "venc_lt",
> -       "ethif",
> -       "vdec",
> -       "hif_sel",
> -       "jpgdec",
> -       "audio",
> -       NULL,
> -};
> -
>  #define MAX_CLKS       3
>
>  /**
> @@ -116,7 +88,7 @@ enum clk_id {
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @bus_prot_mask: The mask for single step bus protection.
> - * @clk_id: The basic clocks required by this power domain.
> + * @basic_clk_name: The basic clocks required by this power domain.

nit: what's the point on telling it basic_? why not just clk_names?

>   * @caps: The flag for active wake-up action.
>   */
>  struct scp_domain_data {
> @@ -126,7 +98,7 @@ struct scp_domain_data {
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         u32 bus_prot_mask;
> -       enum clk_id clk_id[MAX_CLKS];
> +       const char *basic_clk_name[MAX_CLKS];
>         u8 caps;
>  };
>
> @@ -411,12 +383,23 @@ static int scpsys_power_off(struct generic_pm_domai=
n *genpd)
>         return ret;
>  }
>
> -static void init_clks(struct platform_device *pdev, struct clk **clk)
> +static int init_basic_clks(struct platform_device *pdev, struct clk **cl=
k,
> +                       const char * const *name)
>  {
>         int i;
>
> -       for (i =3D CLK_NONE + 1; i < CLK_MAX; i++)
> -               clk[i] =3D devm_clk_get(&pdev->dev, clk_names[i]);
> +       for (i =3D 0; i < MAX_CLKS && name[i]; i++) {
> +               clk[i] =3D devm_clk_get(&pdev->dev, name[i]);
> +
> +               if (IS_ERR(clk[i])) {
> +                       dev_err(&pdev->dev,
> +                               "get basic clk %s fail %ld\n",
> +                               name[i], PTR_ERR(clk[i]));

devm_clk_get() will already print an error if fails, this print is
redundant, so you can remove it.


> +                       return PTR_ERR(clk[i]);
> +               }
> +       }
> +
> +       return 0;
>  }
>
>  static struct scp *init_scp(struct platform_device *pdev,
> @@ -426,9 +409,8 @@ static struct scp *init_scp(struct platform_device *p=
dev,
>  {
>         struct genpd_onecell_data *pd_data;
>         struct resource *res;
> -       int i, j;
> +       int i, ret;
>         struct scp *scp;
> -       struct clk *clk[CLK_MAX];
>
>         scp =3D devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
>         if (!scp)
> @@ -481,8 +463,6 @@ static struct scp *init_scp(struct platform_device *p=
dev,
>
>         pd_data->num_domains =3D num;
>
> -       init_clks(pdev, clk);
> -
>         for (i =3D 0; i < num; i++) {
>                 struct scp_domain *scpd =3D &scp->domains[i];
>                 struct generic_pm_domain *genpd =3D &scpd->genpd;
> @@ -493,17 +473,9 @@ static struct scp *init_scp(struct platform_device *=
pdev,
>
>                 scpd->data =3D data;
>
> -               for (j =3D 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -                       struct clk *c =3D clk[data->clk_id[j]];
> -
> -                       if (IS_ERR(c)) {
> -                               dev_err(&pdev->dev, "%s: clk unavailable\=
n",
> -                                       data->name);
> -                               return ERR_CAST(c);
> -                       }
> -
> -                       scpd->clk[j] =3D c;
> -               }
> +               ret =3D init_basic_clks(pdev, scpd->clk, data->basic_clk_=
name);
> +               if (ret)
> +                       return ERR_PTR(ret);
>
>                 genpd->name =3D data->name;
>                 genpd->power_off =3D scpsys_power_off;
> @@ -560,7 +532,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_CONN_PWR_CON,
>                 .bus_prot_mask =3D MT2701_TOP_AXI_PROT_EN_CONN_M |
>                                  MT2701_TOP_AXI_PROT_EN_CONN_S,
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_DISP] =3D {
> @@ -568,7 +539,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .sta_mask =3D PWR_STATUS_DISP,
>                 .ctl_offs =3D SPM_DIS_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .bus_prot_mask =3D MT2701_TOP_AXI_PROT_EN_MM_M0,
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -578,7 +549,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_MFG_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MFG},
> +               .basic_clk_name =3D {"mfg"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_VDEC] =3D {
> @@ -587,7 +558,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_VDE_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_ISP] =3D {
> @@ -596,7 +567,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_ISP_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(13, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_BDP] =3D {
> @@ -604,7 +575,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .sta_mask =3D PWR_STATUS_BDP,
>                 .ctl_offs =3D SPM_BDP_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_ETH] =3D {
> @@ -613,7 +583,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_ETH_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_ETHIF},
> +               .basic_clk_name =3D {"ethif"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_HIF] =3D {
> @@ -622,14 +592,13 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .ctl_offs =3D SPM_HIF_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_ETHIF},
> +               .basic_clk_name =3D {"ethif"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_IFR_MSC] =3D {
>                 .name =3D "ifr_msc",
>                 .sta_mask =3D PWR_STATUS_IFR_MSC,
>                 .ctl_offs =3D SPM_IFR_MSC_PWR_CON,
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>  };
> @@ -644,7 +613,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_DIS_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_VDEC] =3D {
> @@ -653,7 +622,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_VDE_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MM, CLK_VDEC},
> +               .basic_clk_name =3D {"mm", "vdec"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_VENC] =3D {
> @@ -662,7 +631,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_VEN_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_MM, CLK_VENC, CLK_JPGDEC},
> +               .basic_clk_name =3D {"mm", "venc", "jpgdec"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_ISP] =3D {
> @@ -671,7 +640,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_ISP_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(13, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_AUDIO] =3D {
> @@ -680,7 +649,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_AUDIO_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_AUDIO},
> +               .basic_clk_name =3D {"audio"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_USB] =3D {
> @@ -689,7 +658,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_USB_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(10, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(14, 12),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_USB2] =3D {
> @@ -698,7 +666,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_USB2_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(10, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(14, 12),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG] =3D {
> @@ -707,7 +674,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_MFG_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(16, 16),
> -               .clk_id =3D {CLK_MFG},
> +               .basic_clk_name =3D {"mfg"},
>                 .bus_prot_mask =3D BIT(14) | BIT(21) | BIT(23),
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -717,7 +684,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x02c0,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(16, 16),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG_SC2] =3D {
> @@ -726,7 +692,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x02c4,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(16, 16),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG_SC3] =3D {
> @@ -735,7 +700,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x01f8,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(16, 16),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>  };
> @@ -760,7 +724,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x300,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_VDEC},
> +               .basic_clk_name =3D {"vdec"},
>         },
>         [MT6797_POWER_DOMAIN_VENC] =3D {
>                 .name =3D "venc",
> @@ -768,7 +732,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x304,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_NONE},
>         },
>         [MT6797_POWER_DOMAIN_ISP] =3D {
>                 .name =3D "isp",
> @@ -776,7 +739,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x308,
>                 .sram_pdn_bits =3D GENMASK(9, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(13, 12),
> -               .clk_id =3D {CLK_NONE},
>         },
>         [MT6797_POWER_DOMAIN_MM] =3D {
>                 .name =3D "mm",
> @@ -784,7 +746,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x30C,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .bus_prot_mask =3D (BIT(1) | BIT(2)),
>         },
>         [MT6797_POWER_DOMAIN_AUDIO] =3D {
> @@ -793,7 +755,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x314,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_NONE},
>         },
>         [MT6797_POWER_DOMAIN_MFG_ASYNC] =3D {
>                 .name =3D "mfg_async",
> @@ -801,7 +762,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x334,
>                 .sram_pdn_bits =3D 0,
>                 .sram_pdn_ack_bits =3D 0,
> -               .clk_id =3D {CLK_MFG},
> +               .basic_clk_name =3D {"mfg"},
>         },
>         [MT6797_POWER_DOMAIN_MJC] =3D {
>                 .name =3D "mjc",
> @@ -809,7 +770,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D 0x310,
>                 .sram_pdn_bits =3D GENMASK(8, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_NONE},
>         },
>  };
>
> @@ -834,7 +794,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_ETHSYS_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_NONE},
>                 .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_ETHSYS,
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -844,7 +803,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_HIF0_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_HIFSEL},
> +               .basic_clk_name =3D {"hif_sel"},
>                 .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_HIF0,
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -854,7 +813,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_HIF1_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_HIFSEL},
> +               .basic_clk_name =3D {"hif_sel"},
>                 .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_HIF1,
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -864,7 +823,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_WB_PWR_CON,
>                 .sram_pdn_bits =3D 0,
>                 .sram_pdn_ack_bits =3D 0,
> -               .clk_id =3D {CLK_NONE},
>                 .bus_prot_mask =3D MT7622_TOP_AXI_PROT_EN_WB,
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
>         },
> @@ -881,7 +839,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_CONN_PWR_CON,
>                 .bus_prot_mask =3D MT2701_TOP_AXI_PROT_EN_CONN_M |
>                                  MT2701_TOP_AXI_PROT_EN_CONN_S,
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_ETH] =3D {
> @@ -890,7 +847,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_ETH_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_ETHIF},
> +               .basic_clk_name =3D {"ethif"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_HIF] =3D {
> @@ -899,14 +856,13 @@ static void mtk_register_power_domains(struct platf=
orm_device *pdev,
>                 .ctl_offs =3D SPM_HIF_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_ETHIF},
> +               .basic_clk_name =3D {"ethif"},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_IFR_MSC] =3D {
>                 .name =3D "ifr_msc",
>                 .sta_mask =3D PWR_STATUS_IFR_MSC,
>                 .ctl_offs =3D SPM_IFR_MSC_PWR_CON,
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>  };
> @@ -922,7 +878,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_VDE_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>         },
>         [MT8173_POWER_DOMAIN_VENC] =3D {
>                 .name =3D "venc",
> @@ -930,7 +886,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_VEN_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_MM, CLK_VENC},
> +               .basic_clk_name =3D {"mm", "venc"},
>         },
>         [MT8173_POWER_DOMAIN_ISP] =3D {
>                 .name =3D "isp",
> @@ -938,7 +894,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_ISP_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(13, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>         },
>         [MT8173_POWER_DOMAIN_MM] =3D {
>                 .name =3D "mm",
> @@ -946,7 +902,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_DIS_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(12, 12),
> -               .clk_id =3D {CLK_MM},
> +               .basic_clk_name =3D {"mm"},
>                 .bus_prot_mask =3D MT8173_TOP_AXI_PROT_EN_MM_M0 |
>                         MT8173_TOP_AXI_PROT_EN_MM_M1,
>         },
> @@ -956,7 +912,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_VEN2_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_MM, CLK_VENC_LT},
> +               .basic_clk_name =3D {"mm", "venc_lt"},
>         },
>         [MT8173_POWER_DOMAIN_AUDIO] =3D {
>                 .name =3D "audio",
> @@ -964,7 +920,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_AUDIO_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_NONE},
>         },
>         [MT8173_POWER_DOMAIN_USB] =3D {
>                 .name =3D "usb",
> @@ -972,7 +927,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_USB_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(15, 12),
> -               .clk_id =3D {CLK_NONE},
>                 .caps =3D MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8173_POWER_DOMAIN_MFG_ASYNC] =3D {
> @@ -981,7 +935,7 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_MFG_ASYNC_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D 0,
> -               .clk_id =3D {CLK_MFG},
> +               .basic_clk_name =3D {"mfg"},
>         },
>         [MT8173_POWER_DOMAIN_MFG_2D] =3D {
>                 .name =3D "mfg_2d",
> @@ -989,7 +943,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_MFG_2D_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(11, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(13, 12),
> -               .clk_id =3D {CLK_NONE},
>         },
>         [MT8173_POWER_DOMAIN_MFG] =3D {
>                 .name =3D "mfg",
> @@ -997,7 +950,6 @@ static void mtk_register_power_domains(struct platfor=
m_device *pdev,
>                 .ctl_offs =3D SPM_MFG_PWR_CON,
>                 .sram_pdn_bits =3D GENMASK(13, 8),
>                 .sram_pdn_ack_bits =3D GENMASK(21, 16),
> -               .clk_id =3D {CLK_NONE},
>                 .bus_prot_mask =3D MT8173_TOP_AXI_PROT_EN_MFG_S |
>                         MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>                         MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
