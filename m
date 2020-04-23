Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B55C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6802071C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgGJK79T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgDWST4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgDWST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:19:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B848CC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:19:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v26so84137qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0xwMgS5hnqkfTVij6WET/wLkgPqmJ55RCf68aR2rUhE=;
        b=lgGJK79TGuuUFMJYa506teektxNwr1qjM+9whr2cjCWbT7IWNet4nGp/xgGOzdZA2P
         bQw9gz0nUrdrACE+6xx9pwYLpp33a1b0myh02Z9CcSkdCLl/1hzuqwwRiacs69q1KkBg
         50L3r4U/ZmDqj8I5reR0QSnkGelCa4MYJ/DyeIRA1L4WTQ8DNuVWlvx/wAgcv4g13lmu
         z8YfjautkCSjxyuqoJxLG8icqgyBanQdck3PownZgHs4RYX20KQaaCLKU76pZGi6h/9C
         JY5Zwp8BJ0y52OayYGfcZWppnCjZ+SbLCxVcME4zmWWgHVTGAwxsYHjgya6jf4eHB3Xw
         SnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0xwMgS5hnqkfTVij6WET/wLkgPqmJ55RCf68aR2rUhE=;
        b=Gv0zyHK5mfiHN7hbHPyciJRKpnnNLhk/d/tspPyNnmCA8osmppT3UIgShE7+aINOvV
         hXaWpBC42hx/qy7DasYUJKIZ2mrjBNXeETAVs0lGXb/V5slyYE0AhANw8w2NUUWr98RR
         JFEBksX3thtIgtbqch6AzKmaT8WUlq6GcMaiwso+Gl3q8ZpNW0jM4oCK5nc7vBcayLX+
         Xrq+5K0URvgY2/NPFFl21wW/Y5VuJ2Yi8E0LNTciEPcI1Nj69TmQa9Cirsv0jPIYMKw2
         NbChjatmWAW61/fpYcVk3dXpgaxIm30puMO9ppZcNRPq2L0ipqCrquoEDp0vIXl9bmFz
         G+Ug==
X-Gm-Message-State: AGi0PuYBcehRXg/plepS1zxQYQ3tnEvh6NjOolVeUcBnEmV937kxFzbV
        Y2gjDHiSdF5oRJnbyy1Vh+NjhjwNWG3dkSPHpYFufM91
X-Google-Smtp-Source: APiQypIGWeJwrFimQzMgUQG+qTPqYl20upz8Dot3jjNmeXFU7YbX5dBUQnwsRfCDphRmUJJMAqf5lI9P8qYDF8Aiqt0=
X-Received: by 2002:ac8:7681:: with SMTP id g1mr5257448qtr.311.1587665993646;
 Thu, 23 Apr 2020 11:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com> <1584689540-5227-7-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1584689540-5227-7-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Apr 2020 20:19:41 +0200
Message-ID: <CAFqH_50KjArK4hCeO88jGoaHgybOOkwTXx2vemO6LdxFqHAeXw@mail.gmail.com>
Subject: Re: [PATCH v13 06/11] soc: mediatek: Add subsys clock control for bus protection
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

Thank you for the patch.

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dv., 20 de mar=C3=A7
2020 a les 8:33:
>
> For the bus protection operations, some subsys clocks need to be enabled
> before releasing the protection, and vise versa.

typo s/vise/vice/

> But those subsys clocks could only be controlled once its corresponding
> power domain is turned on first.
> In this patch, we add the subsys clock control into its relavent steps.

typo s/relavent/relevant/

>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 71 +++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk=
-scpsys.c
> index a4fb0b23..2a9478f 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -80,6 +80,7 @@
>  #define PWR_STATUS_WB                  BIT(27) /* MT7622 */
>
>  #define MAX_CLKS       3
> +#define MAX_SUBSYS_CLKS 10
>
>  /**
>   * struct scp_domain_data - scp domain data for power on/off flow
> @@ -89,6 +90,8 @@
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @basic_clk_name: The basic clocks required by this power domain.
> + * @subsys_clk_prefix: The prefix name of the clocks need to be enabled
> + *                     before releasing bus protection.
>   * @caps: The flag for active wake-up action.
>   * @bp_table: The mask table for multiple step bus protection.
>   */
> @@ -99,6 +102,7 @@ struct scp_domain_data {
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         const char *basic_clk_name[MAX_CLKS];
> +       const char *subsys_clk_prefix;
>         u8 caps;
>         struct bus_prot bp_table[MAX_STEPS];
>  };
> @@ -109,6 +113,7 @@ struct scp_domain {
>         struct generic_pm_domain genpd;
>         struct scp *scp;
>         struct clk *clk[MAX_CLKS];
> +       struct clk *subsys_clk[MAX_SUBSYS_CLKS];
>         const struct scp_domain_data *data;
>         struct regulator *supply;
>  };
> @@ -384,16 +389,22 @@ static int scpsys_power_on(struct generic_pm_domain=
 *genpd)
>         val |=3D PWR_RST_B_BIT;
>         writel(val, ctl_addr);
>
> -       ret =3D scpsys_sram_enable(scpd, ctl_addr);
> +       ret =3D scpsys_clk_enable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>         if (ret < 0)
>                 goto err_pwr_ack;
>
> +       ret =3D scpsys_sram_enable(scpd, ctl_addr);
> +       if (ret < 0)
> +               goto err_sram;
> +
>         ret =3D scpsys_bus_protect_disable(scpd);
>         if (ret < 0)
> -               goto err_pwr_ack;
> +               goto err_sram;
>
>         return 0;
>
> +err_sram:
> +       scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>  err_pwr_ack:
>         scpsys_clk_disable(scpd->clk, MAX_CLKS);
>  err_clk:
> @@ -420,6 +431,8 @@ static int scpsys_power_off(struct generic_pm_domain =
*genpd)
>         if (ret < 0)
>                 goto out;
>
> +       scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> +
>         /* subsys power off */
>         val =3D readl(ctl_addr);
>         val |=3D PWR_ISO_BIT;
> @@ -457,6 +470,48 @@ static int scpsys_power_off(struct generic_pm_domain=
 *genpd)
>         return ret;
>  }
>
> +static int init_subsys_clks(struct platform_device *pdev,
> +               const char *prefix, struct clk **clk)
> +{
> +       struct device_node *node =3D pdev->dev.of_node;
> +       u32 prefix_len, sub_clk_cnt =3D 0;
> +       struct property *prop;
> +       const char *clk_name;
> +
> +       if (!node) {

Is this possible? I suspect you can remove this check.

> +               dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
> +                       PTR_ERR(node));
> +               return PTR_ERR(node);
> +       }
> +
> +       prefix_len =3D strlen(prefix);
> +
> +       of_property_for_each_string(node, "clock-names", prop, clk_name) =
{
> +               if (!strncmp(clk_name, prefix, prefix_len) &&
> +                               (clk_name[prefix_len] =3D=3D '-')) {
> +                       if (sub_clk_cnt >=3D MAX_SUBSYS_CLKS) {
> +                               dev_err(&pdev->dev,
> +                                       "subsys clk out of range %d\n",
> +                                       sub_clk_cnt);
> +                               return -EINVAL;
> +                       }
> +
> +                       clk[sub_clk_cnt] =3D devm_clk_get(&pdev->dev,
> +                                               clk_name);
> +
> +                       if (IS_ERR(clk[sub_clk_cnt])) {
> +                               dev_err(&pdev->dev,
> +                                       "Subsys clk get fail %ld\n",
> +                                       PTR_ERR(clk[sub_clk_cnt]));

This dev_err is redundant, devm_clk_get already prints it if the clock
is not found.

> +                               return PTR_ERR(clk[sub_clk_cnt]);
> +                       }
> +                       sub_clk_cnt++;
> +               }
> +       }
> +
> +       return sub_clk_cnt;
> +}
> +
>  static int init_basic_clks(struct platform_device *pdev, struct clk **cl=
k,
>                         const char * const *name)
>  {
> @@ -559,6 +614,18 @@ static struct scp *init_scp(struct platform_device *=
pdev,
>                 if (ret)
>                         return ERR_PTR(ret);
>
> +               if (data->subsys_clk_prefix) {
> +                       ret =3D init_subsys_clks(pdev,
> +                                       data->subsys_clk_prefix,
> +                                       scpd->subsys_clk);
> +                       if (ret < 0) {
> +                               dev_err(&pdev->dev,
> +                                       "%s: subsys clk unavailable\n",
> +                                       data->name);

And this print is also redundant.


> +                               return ERR_PTR(ret);
> +                       }
> +               }
> +
>                 genpd->name =3D data->name;
>                 genpd->power_off =3D scpsys_power_off;
>                 genpd->power_on =3D scpsys_power_on;
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
