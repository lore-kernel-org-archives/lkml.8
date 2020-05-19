Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4960C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906D520709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppCH2wak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgESH3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESH3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:29:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B0C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:29:20 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a37so1501103uad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGKa+ni4azruYMg4t2OX9ZfrcsxATG1wfkYBrvmx3ac=;
        b=ppCH2waksv32s+VVjjgoMAHZCn1L6IO+CmDuUgCw0Ah8QKNmJsagxzjFwL1icKfVL6
         GMFWWLDxgqUgXutFVVzJi3VAwC3XUqmxCY6DikqwItRz2Z+sxzMOxZUIuGbPS7LMLFAo
         2CrhGUnvrHNzcOhTf6J0cWp5Wo3JPer7NcqIN4d26PORoOmIKbmdOgEqFUpk8WacxsAB
         sb+1PA2XFj/jrKGRv1/6lcfY4xY1zeXqbaeFMama6eAdHX+1zaVPRgJV0L6RpsaTdRae
         i4ngUbPx2AjAShzmkOh4EQOybvPQ8BhHHrNYB7CrCeeFd2fNUK/+ptg132X2WpNow7o3
         laUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGKa+ni4azruYMg4t2OX9ZfrcsxATG1wfkYBrvmx3ac=;
        b=pPzgOzT9JQBmMRivjKiwY2TjbsNbhSccGZy/3uegPZEWkETM6v0F9ztJ3Ar1rAB/AZ
         XFQ85dclGcZL2cDT9GwhTDJTFTJY8rzib14aZ4ARwdNkCbvfFP+Bpz9xzlnUrSTQr4Bu
         Fg6laO/QsTdLma1X6GDOsSCzC/qW/7SYuEzasxxSIWFfDs5A2JaVcI07CGZb52ixbBYX
         +QFjnoy0ybGAKb47JEAC2JQSgapDLTZhvdVRIZd2t8DS1NYY4hb4Xl+QffJBpnAOSrNO
         yrgpegPmFAXxhgBYSiMSpAzm/p8cT9VyRgF3FU3n63b4iC5UnO+i9S2YHWUHeCISbBah
         GwKQ==
X-Gm-Message-State: AOAM532tXGY7xFv/tW9tpxC3j06jIthaDxv7GuVyjvRyBJpqKY2fI2YR
        pH+xm4CTtFui9isnyKA6iK+fKwlxNHzT+E1UkL/dRg==
X-Google-Smtp-Source: ABdhPJziq/dAaaMSV1g+QUyl2hxCAINBzMD1C8r8rFdoRyfZhqRSKCVUBriAlDSydtj6W9Tb1GcQRCiaHtbeQ3upsjw=
X-Received: by 2002:ab0:5ca:: with SMTP id e68mr13796837uae.19.1589873359897;
 Tue, 19 May 2020 00:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200516154314.14769-1-digetx@gmail.com>
In-Reply-To: <20200516154314.14769-1-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 09:28:43 +0200
Message-ID: <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Several people asked me about the MMC warnings in the KMSG log and
> I had to tell to ignore them because these warning are irrelevant to
> pre-Tegra210 SoCs.

Why are the warnings irrelevant?

> It should be up to a board's device-tree writer to
> properly describe all the necessary properties. Secondly, eventually all
> device-tree bindings will be converted to YAML, which allows to validate
> board DT files, giving a warning about missing properties. Hence let's
> remove the noisy warnings to stop the confusion.

Yep, makes sense. However, perhaps we should do this conversion then,
rather than first drop the warnings?

Kind regards
Uffe

>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 3e2c5101291d..83867629013d 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -607,46 +607,26 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
>                         &autocal->pull_up_3v3_timeout);
> -       if (err) {
> -               if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> -                       (tegra_host->pinctrl_state_3v3_drv == NULL))
> -                       pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> -                               mmc_hostname(host->mmc));
> +       if (err)
>                 autocal->pull_up_3v3_timeout = 0;
> -       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
>                         &autocal->pull_down_3v3_timeout);
> -       if (err) {
> -               if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
> -                       (tegra_host->pinctrl_state_3v3_drv == NULL))
> -                       pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
> -                               mmc_hostname(host->mmc));
> +       if (err)
>                 autocal->pull_down_3v3_timeout = 0;
> -       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-1v8-timeout",
>                         &autocal->pull_up_1v8_timeout);
> -       if (err) {
> -               if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
> -                       (tegra_host->pinctrl_state_1v8_drv == NULL))
> -                       pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
> -                               mmc_hostname(host->mmc));
> +       if (err)
>                 autocal->pull_up_1v8_timeout = 0;
> -       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-1v8-timeout",
>                         &autocal->pull_down_1v8_timeout);
> -       if (err) {
> -               if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
> -                       (tegra_host->pinctrl_state_1v8_drv == NULL))
> -                       pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
> -                               mmc_hostname(host->mmc));
> +       if (err)
>                 autocal->pull_down_1v8_timeout = 0;
> -       }
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-sdr104",
> --
> 2.26.0
>
