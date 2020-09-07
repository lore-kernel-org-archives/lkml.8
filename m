Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0637DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D746207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpG2iBWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIGKHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgIGKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:07:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C34C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:07:44 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x203so7075230vsc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce6obAoY06qb3yfC15lC/wYcbO24HR4Ggz8VlArYV5I=;
        b=gpG2iBWSdQ5eahHqJWkR0z9Znx1jhPqheJ1ciSe4hCMHTL9NyEPjrAb+nC0AtfZVMF
         iX3JbaU10TsRqgFHKITh5NU86iQcIlIfRTQOR62AQqb/8MeRJ8kNYSui+PYqCXoxnzLG
         PFKWzjBzT81bfnVq2yFpbmA7gp7VxxmwoyofYsl2Sq6J7Bt2gxyptwnky2biQZpY2ae1
         TJkWumpJPbtatrVQuZxIihT0UjmJrMCtsYw0twy/yXroZrrHCgfFjJ7X84TCw+MjjaeZ
         t5B2fRvYmP5FYuDqaUa+q7Vthib56jvWeECcJi2vVjl40w8peFKT06ty53K4n6XRfvM1
         Yy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce6obAoY06qb3yfC15lC/wYcbO24HR4Ggz8VlArYV5I=;
        b=i7QCyUGNU9EwqC9KpvKR60BLGmhJvIiMVgB1LKuLIn2b4auDroL/7gIoZ+LI+Zh1by
         n7U3JFToWhQkbH4z8w0e6ByZZ1ClRJvjNqqfmYx74Zi6rOiTaFHNcdvT/MEbapDhCyvi
         ImMwq3jCQN2VI3jys+bFoTBxLznBgNPiwLJ4bX8sIUWURETkhLkaivxOitHgOUZ1nV84
         x9xNWSoSoVtK5l16njp9R+0g98+7TvlaTRMmohssfnRsrUKBB+NBhKnnkWuta0/2D2cX
         aNb5NReH9wpZobkAwKmc/rbCmBP3hHswSgDOeGgYums53B7JeoYlbNPcL7AAHNQczU00
         Qi+Q==
X-Gm-Message-State: AOAM5319bwuZil/eYzv1qK3NfxGnHS5o68btGSM/qbHHGSKjtCq+1E9a
        OXfjGz0MZV4EkeT9CbJmsYGSR2bIe1dUlYh7b2uRKA==
X-Google-Smtp-Source: ABdhPJwDJaI3759+fZr6m+VSJRYg+e8v1KCPXZUCXbChfkQ7zkupTb2pUy+KivsGmeJZ4vk4HulUd5jk+xtdLdPpiPw=
X-Received: by 2002:a67:e197:: with SMTP id e23mr11355927vsl.7.1599473263611;
 Mon, 07 Sep 2020 03:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200903084825.85616-1-vulab@iscas.ac.cn>
In-Reply-To: <20200903084825.85616-1-vulab@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Sep 2020 12:07:06 +0200
Message-ID: <CAPDyKFrADVAs2zK2FY5sOh0R=8Kgsm9GwAKkbV9pfdczt07QOg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: omap-hsmmc: remove redundant null check
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 at 10:48, Xu Wang <vulab@iscas.ac.cn> wrote:
>
> Because clk_disable_unprepare already checked NULL clock
> parameter, so the additional checks are unnecessary, just remove them.
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 37b8740513f5..d02983e23ed1 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1114,8 +1114,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
>         int ret;
>
>         /* Disable the clocks */
> -       if (host->dbclk)
> -               clk_disable_unprepare(host->dbclk);
> +       clk_disable_unprepare(host->dbclk);
>
>         /* Turn the power off */
>         ret = omap_hsmmc_set_power(host, 0);
> @@ -1123,8 +1122,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
>         /* Turn the power ON with given VDD 1.8 or 3.0v */
>         if (!ret)
>                 ret = omap_hsmmc_set_power(host, 1);
> -       if (host->dbclk)
> -               clk_prepare_enable(host->dbclk);
> +       clk_prepare_enable(host->dbclk);
>
>         if (ret != 0)
>                 goto err;
> @@ -2014,8 +2012,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         pm_runtime_dont_use_autosuspend(host->dev);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
> -       if (host->dbclk)
> -               clk_disable_unprepare(host->dbclk);
> +       clk_disable_unprepare(host->dbclk);
>  err1:
>         mmc_free_host(mmc);
>  err:
> @@ -2037,8 +2034,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
>         device_init_wakeup(&pdev->dev, false);
> -       if (host->dbclk)
> -               clk_disable_unprepare(host->dbclk);
> +       clk_disable_unprepare(host->dbclk);
>
>         mmc_free_host(host->mmc);
>
> @@ -2063,8 +2059,7 @@ static int omap_hsmmc_suspend(struct device *dev)
>                                 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
>         }
>
> -       if (host->dbclk)
> -               clk_disable_unprepare(host->dbclk);
> +       clk_disable_unprepare(host->dbclk);
>
>         pm_runtime_put_sync(host->dev);
>         return 0;
> @@ -2080,8 +2075,7 @@ static int omap_hsmmc_resume(struct device *dev)
>
>         pm_runtime_get_sync(host->dev);
>
> -       if (host->dbclk)
> -               clk_prepare_enable(host->dbclk);
> +       clk_prepare_enable(host->dbclk);
>
>         if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
>                 omap_hsmmc_conf_bus_power(host);
> --
> 2.17.1
>
