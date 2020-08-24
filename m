Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC803C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D462071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcKirNkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgHXJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHXJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:51:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CDAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:44 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b26so4091574vsa.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ln8SN+7RLvf7fE2ywm+jg35Tyq/B4Xvx0WH4mCC+yU4=;
        b=KcKirNkka0lXfE/G1WBoDbs+9xUm6m7RRxLyArxUXcL+MBqMttUxIXZhdzZWelj9Iu
         RIgZPOet2uKIWEXK3Tlxykk+fNi0PJil1M+PImvo5F0X8/RATfwREkQbFkLLiw5p2k7c
         t9iiul5OGNaFNW/S1V7pKehZycdtVOCpXmYmd8Am7Q0OfD0G+63tpvWkVv2f3ykk4yer
         4Sq03SUehpTCjbB60/O66CIcZwzYttH8wREWhi4ah5J50SPfglsPpZPfu/APbYEigphG
         cN6yB72HGAtq8Iz5ZvMYOEqV1tgKQDeARxw6lV1aiHLD2GrWPL+yIjWwWO5xROzTmYC/
         bpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ln8SN+7RLvf7fE2ywm+jg35Tyq/B4Xvx0WH4mCC+yU4=;
        b=g+Cx0HSw0wtiiGjRG+B0+ny3S2I1EYhBgXqhTdYEEjwv+jkuPEbUzIjU6/+MnupRbr
         rO1y+xEkEzwRMZLhScVYkbEuXb20G1Ekjfu0U88qPwVKi2ecyMWySq7IxhbSuSBB8oaU
         i3QTRLpraB8EFsfwCuHgpfMWb+FV+775eMG6kDAonMXcPB7t9qrCWqmTIVeP8wzCPfE4
         rFoBDKfMKPiD2wycbFR3YgX7tdeOc4eqUYols3Kkv+ZX/dc4R2ZPebD98aDuxJJJIVfF
         Xw2PJtwmfEM66EPAZdt73fTBb6nyjbQENRU28Ywn8T2OFXhGM66dZzFlr/OGgcmyKCEr
         7fqw==
X-Gm-Message-State: AOAM532UVAZmNRgsZ/8pf7Vqd4oXa2rT8Az5JTPh3/EcHd2/KPHFfqh6
        7A3fM62wqxXf+5lQSPukeLsZBf6xNuwLMi7GI1oXbg==
X-Google-Smtp-Source: ABdhPJwd+jCqwoXcVEZBQ1HvErLYStyQ+OkTEJZDJuVbqozu9T2Ah5ho52VM3ZSTTAdEQ07d2iqF066sx8wJHfqQdWE=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr2038655vsd.200.1598262703392;
 Mon, 24 Aug 2020 02:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597919647.git.viresh.kumar@linaro.org> <e88128c48349723636b7c35e95289b50b27e235a.1597919647.git.viresh.kumar@linaro.org>
In-Reply-To: <e88128c48349723636b7c35e95289b50b27e235a.1597919647.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:51:07 +0200
Message-ID: <CAPDyKFp58Sqvmq7CFmDkHXX3ohgyqt1VPELGdq0mtOSZq+uc2Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 12:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> find the OPP table with error -ENODEV (i.e. OPP table not present for
> the device). And we can call dev_pm_opp_of_remove_table()
> unconditionally here.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5a33389037cd..b7e47107a31a 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -263,7 +263,6 @@ struct sdhci_msm_host {
>         unsigned long clk_rate;
>         struct mmc_host *mmc;
>         struct opp_table *opp_table;
> -       bool has_opp_table;
>         bool use_14lpp_dll_reset;
>         bool tuning_done;
>         bool calibration_done;
> @@ -2285,9 +2284,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         /* OPP table is optional */
>         ret = dev_pm_opp_of_add_table(&pdev->dev);
> -       if (!ret) {
> -               msm_host->has_opp_table = true;
> -       } else if (ret != -ENODEV) {
> +       if (ret != -ENODEV) {
>                 dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
>                 goto opp_cleanup;
>         }
> @@ -2453,8 +2450,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>  opp_cleanup:
> -       if (msm_host->has_opp_table)
> -               dev_pm_opp_of_remove_table(&pdev->dev);
> +       dev_pm_opp_of_remove_table(&pdev->dev);
>         dev_pm_opp_put_clkname(msm_host->opp_table);
>  bus_clk_disable:
>         if (!IS_ERR(msm_host->bus_clk))
> @@ -2474,8 +2470,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, dead);
>
> -       if (msm_host->has_opp_table)
> -               dev_pm_opp_of_remove_table(&pdev->dev);
> +       dev_pm_opp_of_remove_table(&pdev->dev);
>         dev_pm_opp_put_clkname(msm_host->opp_table);
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> --
> 2.25.0.rc1.19.g042ed3e048af
>
