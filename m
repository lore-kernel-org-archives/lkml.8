Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7677C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F84206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHuXkUnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgHXH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:59:03 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5776C061575
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:59:02 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j188so3965443vsd.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5fetNBGlq6IDEbKDStVMl4rk13Z2lttGI7mVbBoANg=;
        b=QHuXkUnpzno+kWLVS5giRuWiYCUzOhxOpcvPhkZp0VmzUF0E2y1n5YR13ShN+SPEFL
         JJFQCYCGhqS8sEZpb45cYKnkILyJBPw7RzXpxvpYkPEoL2od3NMw2PQrnsr1vq1tfNCB
         gWSsRvI6m2engpZqC9iA2xBjM7HH1j2f2jY8iaPNwkl0eMQgdzn49x9/Xk7f7RWWlocQ
         c4WcvhRoh8vSIdL+U+glIqO7uWLlmEUoX35MgTQxlN4FHfXe6ZaerbYGPUDcHT7ERy7A
         gfiibhBbuXTQqsVrPj4xGzj6dXRDMZVkyrIS9sUJ9jOPvSrHTHDGhkyT64WIPykCTCQZ
         BuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5fetNBGlq6IDEbKDStVMl4rk13Z2lttGI7mVbBoANg=;
        b=LBzoTSKu7Uz9xxbx77kz79P84MAUDX7EZtQEUanQJrXiuR+JRACFkJhHFDGp/IM8S1
         xGVvZzUvGsgwO3BzJYMWd4nhEsOVb/88T6cFz+aDzYAcGI4Bw5l1XdArOnwPhlluB/OI
         tLRIlu3FpLAebKLFeXWOKqMJQ3LTwWA89KLeadMjGyVH6noQmcb6oBX++FOh6K94C7KQ
         ahXxpTFdb44AYnJJq3pSKuK64hTRaGZqWKVNE7L1hw/QM22D6542gK6b19dlR3ZjaPTQ
         MfVO49oIZ4SqrDBJrK0QbfDBkPwiAkhv8jvuNuwqVSxVuOr88mWqiyVPcqUUMOjm+YVU
         cTsg==
X-Gm-Message-State: AOAM5316rDlfyvqZR/pOVd1gLVzAUEa6apj9MBkpfloH/1A7US3kBsO7
        yPdhQU2vPmyflzQfQdhqAsLUFRUT7GhdXTHFL6GxzA==
X-Google-Smtp-Source: ABdhPJyTCnrU5j4N+bDMRKTXv/VoAO85MH3Zxse2PUmGY/gwR2eoAN6g9RWT58TPGUc6iYmOooJUjV6vconZcUFv3yY=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr1800063vso.165.1598255941860;
 Mon, 24 Aug 2020 00:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <1596673949-1571-1-git-send-email-skomatineni@nvidia.com> <1596673949-1571-7-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1596673949-1571-7-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 09:58:25 +0200
Message-ID: <CAPDyKFpSwcfu3NqM_uqpKfDBeWAvE7XguZntO=ZrnJx8m+vjeg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] sdhci: tegra: Add missing TMCLK for data timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 02:32, Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
>
> commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
>
> Tegra210 and later has a separate sdmmc_legacy_tm (TMCLK) used by Tegra
> SDMMC hawdware for data timeout to achive better timeout than using
> SDCLK and using TMCLK is recommended.
>
> USE_TMCLK_FOR_DATA_TIMEOUT bit in Tegra SDMMC register
> SDHCI_TEGRA_VENDOR_SYS_SW_CTRL can be used to choose either TMCLK or
> SDCLK for data timeout.
>
> Default USE_TMCLK_FOR_DATA_TIMEOUT bit is set to 1 and TMCLK is used
> for data timeout by Tegra SDMMC hardware and having TMCLK not enabled
> is not recommended.
>
> So, this patch fixes it.

Just realized that there should be an updated DT binding accordingly,
stating that the "tmclk" is recommended but optional for some
variants. Please re-spin.

Kind regards
Uffe

>
> Fixes: b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
> Cc: stable <stable@vger.kernel.org> # 5.4
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 31ed321..c0b9405 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -140,6 +140,7 @@ struct sdhci_tegra_autocal_offsets {
>  struct sdhci_tegra {
>         const struct sdhci_tegra_soc_data *soc_data;
>         struct gpio_desc *power_gpio;
> +       struct clk *tmclk;
>         bool ddr_signaling;
>         bool pad_calib_required;
>         bool pad_control_available;
> @@ -1611,6 +1612,44 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>                 goto err_power_req;
>         }
>
> +       /*
> +        * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
> +        * timeout clock and SW can choose TMCLK or SDCLK for hardware
> +        * data timeout through the bit USE_TMCLK_FOR_DATA_TIMEOUT of
> +        * the register SDHCI_TEGRA_VENDOR_SYS_SW_CTRL.
> +        *
> +        * USE_TMCLK_FOR_DATA_TIMEOUT bit default is set to 1 and SDMMC uses
> +        * 12Mhz TMCLK which is advertised in host capability register.
> +        * With TMCLK of 12Mhz provides maximum data timeout period that can
> +        * be achieved is 11s better than using SDCLK for data timeout.
> +        *
> +        * So, TMCLK is set to 12Mhz and kept enabled all the time on SoC's
> +        * supporting SDR104 mode and when not using SDCLK for data timeout.
> +        */
> +
> +       if ((soc_data->nvquirks & NVQUIRK_ENABLE_SDR104) &&
> +           !(soc_data->pdata->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> +               clk = devm_clk_get(&pdev->dev, "tmclk");
> +               if (IS_ERR(clk)) {
> +                       rc = PTR_ERR(clk);
> +                       if (rc == -EPROBE_DEFER)
> +                               goto err_power_req;
> +
> +                       dev_warn(&pdev->dev, "failed to get tmclk: %d\n", rc);
> +                       clk = NULL;
> +               }
> +
> +               clk_set_rate(clk, 12000000);
> +               rc = clk_prepare_enable(clk);
> +               if (rc) {
> +                       dev_err(&pdev->dev,
> +                               "failed to enable tmclk: %d\n", rc);
> +                       goto err_power_req;
> +               }
> +
> +               tegra_host->tmclk = clk;
> +       }
> +
>         clk = devm_clk_get(mmc_dev(host->mmc), NULL);
>         if (IS_ERR(clk)) {
>                 rc = PTR_ERR(clk);
> @@ -1654,6 +1693,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  err_rst_get:
>         clk_disable_unprepare(pltfm_host->clk);
>  err_clk_get:
> +       clk_disable_unprepare(tegra_host->tmclk);
>  err_power_req:
>  err_parse_dt:
>         sdhci_pltfm_free(pdev);
> @@ -1671,6 +1711,7 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>         reset_control_assert(tegra_host->rst);
>         usleep_range(2000, 4000);
>         clk_disable_unprepare(pltfm_host->clk);
> +       clk_disable_unprepare(tegra_host->tmclk);
>
>         sdhci_pltfm_free(pdev);
>
> --
> 2.7.4
>
