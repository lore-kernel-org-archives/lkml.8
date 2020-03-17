Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495F120736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeTAYQGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQL65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:58:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35711 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:58:57 -0400
Received: by mail-vs1-f65.google.com with SMTP id m9so13648861vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziPifkez7j6pzaQwPMltTvzIm222hM3Rxhjp+43wCTo=;
        b=JeTAYQGvVohR3UZoFDEid5nTnkdVgqbMZ3gR+mYsFruKibVZsLWeD3PSCT/mCT/ODZ
         UnHoDQiwyinuqKqMNaegRVQP91D//Xno8ZIOag9+nSl77c6tbnYLxYeslu9goUbqX084
         ZiuENTDy6ZRBtViHUZuKVl6Lf6eQGwAo3U6BameOs79TjSje9xkkoQZOKb6u4PxMFjxx
         n3CBH1UTImUB6C+GFO+ZZ920vNPnmTmQjX434gK8cVGuqyF5YY5+UnuVKSJs1JoY1Eqf
         idnhkQ1AEZz+ixGPtkZ8eeetMX4CkDfZVloCdMnOSSMfa9G6oSiVtmyM1f9f6vNAbJoc
         dAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziPifkez7j6pzaQwPMltTvzIm222hM3Rxhjp+43wCTo=;
        b=qlR/B/7S8t14PDaais3A2IBB3b39Id86TQco6X2G2r9C2XxGUOuFbFPYdRMaRO9nuu
         SUDl1Spc3pnK5ic2gjvzV3wvIugtBPG8WEpfE4HzlJdqUzZPovZxVAEoblQD03pVTB9F
         f51RW9+KD1loE5Vl1RoViMnTDwK427KEzD+BQqpSsiCbAR1tJxP4AqztE5lUrBGc3nNM
         xr/LA3gON8Kzws447TVR/SPNdk7SjP105aJZHSBOjwb/Rj2TInfVD/YexbHshutGEr0W
         puzFyxhNP6tnBAgu+ODR6LYVp0jt3KUzetOQeTEILwKQcjWAcepIbpFbpyYtrPIBB2kM
         oaOg==
X-Gm-Message-State: ANhLgQ0dCVmb6ysrjL2pvTcPZEauDBqwVOFwLHMcNU/PXebtvyLIX/bf
        yzBrTihSAiXhcgizlRkT+EP2n0/qL9jTaPxbTmH93Q==
X-Google-Smtp-Source: ADFU+vve1HSypH8KF/9GC/lwsm/l2exw2VbYjGTYn89O5y1Xp54XpyVLwKorrJBEAxLLPBXZhkuft/fBBhXyii4UANY=
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr3320079vsr.165.1584446335124;
 Tue, 17 Mar 2020 04:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200312104257.21017-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200312104257.21017-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Mar 2020 12:58:18 +0100
Message-ID: <CAPDyKFqcJP3X74B2T-g9RZ0q1KaObuF_g+REcyjV27T6SmKxLQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
 for UniPhier
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 at 11:43, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The SDHCI_PRESET_FOR_* registers are not set for the UniPhier platform
> integration. (They are all read as zeros).
>
> Set the SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk flag. Otherwise, the
> High Speed DDR mode on the eMMC controller (MMC_TIMING_MMC_DDR52)
> would not work.
>
> I split the platform data to give no impact to other platforms,
> although the UniPhier platform is currently only the upstream user
> of this IP.
>
> The SDHCI_QUIRK2_PRESET_VALUE_BROKEN flag is set if the compatible
> string matches to "socionext,uniphier-sd4hc".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 5827d3751b81..e573495f8726 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -11,6 +11,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -235,6 +236,11 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>         .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> +       .ops = &sdhci_cdns_ops,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
>         .ops = &sdhci_cdns_ops,
>  };
> @@ -334,6 +340,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> +       const struct sdhci_pltfm_data *data;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_cdns_priv *priv;
>         struct clk *clk;
> @@ -350,8 +357,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       data = of_device_get_match_data(dev);
> +       if (!data)
> +               data = &sdhci_cdns_pltfm_data;
> +
>         nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -       host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
> +       host = sdhci_pltfm_init(pdev, data,
>                                 struct_size(priv, phy_params, nr_phy_params));
>         if (IS_ERR(host)) {
>                 ret = PTR_ERR(host);
> @@ -431,7 +442,10 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
>  };
>
>  static const struct of_device_id sdhci_cdns_match[] = {
> -       { .compatible = "socionext,uniphier-sd4hc" },
> +       {
> +               .compatible = "socionext,uniphier-sd4hc",
> +               .data = &sdhci_cdns_uniphier_pltfm_data,
> +       },
>         { .compatible = "cdns,sd4hc" },
>         { /* sentinel */ }
>  };
> --
> 2.17.1
>
