Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233C7221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyQaqmP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgIKKES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:04:14 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC05C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:04:13 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e2so122713vsr.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lv7DYSegmi05MQ2Or1cVULVSVjTeshwqgQaUDPulOTE=;
        b=gyQaqmP/9o85fe1LiMX2cY1a7zMENgWNJsst1hDiZSI33Fosd3Qv5rUAPGvomlSiU2
         aCLS3ARaIRotYG2VnNOxjwzt/FFcgjR9YaN9I56g1wQjxDYE5YeylRG2CapeXI8KF4Uy
         W3OiNGzsxUBWEBMZqOvabMjSoxBJnqQ42FzVzZyua4B99MamgAo0mgjfcHxdfqZQDXJt
         v7voKkopP50unQtCJonw4iiYQbfMjnj1uHTECeKNfEzowDdrMypLR/GdZPt+k9Dc4Bha
         4x7IUuFy06fTbzFttIW36kDpODVIiw0Vy8NfN1RsU0SU3zlFygTIPgl4LYhlBjsk90wO
         T3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lv7DYSegmi05MQ2Or1cVULVSVjTeshwqgQaUDPulOTE=;
        b=Z3l/7edgidcX9u1uuVVSwimXFpc3kubxkCKwX0NO/YjaWcgfsXOK3y3QgdG8Z4Vd9P
         OaSr7h0DG+MV6j5/0kxfjZvohK20oKavMGTSDxm6ne9S7JjgTXEcj9moUMDtImIG92nG
         3AEDaLPi/rEl0/eJFHRC4TCGRVM4nw2UBrejcv26jozGefKtctM0LXjWoMvdM5w8B4rf
         TPodyYEB6Py0NOaTTmAqgcvFb9LKo8MK+jk54gZSCtEHe61ohrMTh/drP2Cr06HVvera
         Mw0yjCgXyughhxapacMbSpuCg6KDv/J+A2F2/3um3NPrncM6cwyHCQUWDLTIUu3Y3Hyq
         xxWQ==
X-Gm-Message-State: AOAM533ZuZlnWVGfZHoUAFNMLy3meDoAH1xVZWMvExvFkHSmBFGZM25q
        /LSGngkx4IZrfkwVR3BHncQB+QbQ344OOkvJXL6QtQ==
X-Google-Smtp-Source: ABdhPJzQhkBpSUuU0Ob3GWHfokuWfgA4zmVG5+TujkYG/hWdckyrLWyFYgoTqFxrTETn15q2HAHHdhCozEtVDbO2gls=
X-Received: by 2002:a67:e355:: with SMTP id s21mr496154vsm.50.1599818652720;
 Fri, 11 Sep 2020 03:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <890ae5601594fca5de104695a682f4b6efbc631b.1599660554.git.viresh.kumar@linaro.org>
In-Reply-To: <890ae5601594fca5de104695a682f4b6efbc631b.1599660554.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Sep 2020 12:03:36 +0200
Message-ID: <CAPDyKFropJGPHEmczi9rjWEJvgCOz8d9bLUdMmu6K+B+1w8c-w@mail.gmail.com>
Subject: Re: [PATCH V2 resend] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 at 16:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

>
> ---
> V2:
> - Compare with -ENODEV only for failures.
> - Create new label to put clkname.
> - Based on 5.9-rc4
> ---
>  drivers/mmc/host/sdhci-msm.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5a33389037cd..f7beaec6412e 100644
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
> @@ -2285,11 +2284,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         /* OPP table is optional */
>         ret = dev_pm_opp_of_add_table(&pdev->dev);
> -       if (!ret) {
> -               msm_host->has_opp_table = true;
> -       } else if (ret != -ENODEV) {
> +       if (ret && ret != -ENODEV) {
>                 dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
> -               goto opp_cleanup;
> +               goto opp_put_clkname;
>         }
>
>         /* Vote for maximum clock rate for maximum performance */
> @@ -2453,8 +2450,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
>                                    msm_host->bulk_clks);
>  opp_cleanup:
> -       if (msm_host->has_opp_table)
> -               dev_pm_opp_of_remove_table(&pdev->dev);
> +       dev_pm_opp_of_remove_table(&pdev->dev);
> +opp_put_clkname:
>         dev_pm_opp_put_clkname(msm_host->opp_table);
>  bus_clk_disable:
>         if (!IS_ERR(msm_host->bus_clk))
> @@ -2474,8 +2471,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
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
