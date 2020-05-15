Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01047C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D052220671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIGvyUUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEOHKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEOHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:10:06 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:10:05 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id p7so328600vkf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mjd+prrjNqDXqBM9/JBw7x6PcberMvd4v5JGZhudn1M=;
        b=xIGvyUUHtSqMRzFRXRnD4nfC2if8wa39ovV9GvseHD7I+pK+Gw9uLPMl82g51Trnpr
         s4GcWcpuS6KMNpb+Dn0pHR4t/X562i0PfW1GttkjayRQUz1ZMPrun3msXt5FLjOEqTc1
         bJyPfm/TErT0RZpuMAfhfxmSiVVnMhaWLgLVaVwMH3yAb/zDtGjLyrGPAc0DuZgiHZH3
         ZqyAtZuxpydnmVosRFn5gNQcyF1j2ezdm/wiDPpQ28z52Qu284jLsUpZU2RcwLCZsi5X
         fDAx2E0RqlZbQMjD5XPdklOD17tGn9YBeQWIn9+ukQ1eDivxTrTabIiV4Ja6AAKK/Qvx
         22NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mjd+prrjNqDXqBM9/JBw7x6PcberMvd4v5JGZhudn1M=;
        b=GxF8vcRFXxpH50rytf0aySagnChesSj1fi8Tp+9n+RXcs07NU4vuM7DRoo1BRAFDay
         WxvgzQmIeYS3gtWHltZ9YcCyemx+SLBa0H33rlquWO7HLSACD3qO5OI+k62hHGyMjSCG
         c7zUXCTA9vaCLtlpiTEoGFDfD7SKh1yW1WhrzK02MMpx9DJoa5FyntHzYYgI0BRcLDHj
         YrP4oOZgIiKdAI2ULCq6How0c7KF6t346YooXJMp/+C/0gRwcFLFD3BwZmCiK0GoQxnX
         zEA9w+rtm600agf1PQFuQNasXFvxyO9L3GSoXo85fzo/EtPM8K0PpWeawQcCug2SbHm+
         Qk5w==
X-Gm-Message-State: AOAM532FZ2rKQ7pwpyXHsD8OX4JHBpzroG1rzIR6Diud5zPOlXYYl2zW
        pBsyX3AcCyTy06t64cFeUFB0L9KstWhf+fgxPQgCDA==
X-Google-Smtp-Source: ABdhPJwxZbZR68HiY+mo1Hhtcs9d5uEygTDNwRq8jwAS5SfojmWEhuvdsHyCL/tLbuQOhpQ1qL4iS9ld5jUBImTv2d8=
X-Received: by 2002:ac5:cded:: with SMTP id v13mr1701498vkn.59.1589526604780;
 Fri, 15 May 2020 00:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200515141926.52e088fe@xhacker.debian>
In-Reply-To: <20200515141926.52e088fe@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:09:28 +0200
Message-ID: <CAPDyKFqD2YKbQYAFSZT=v2kwT4ssW79Zxda0NAUtbUaq4CEQwA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add suspend/resume support
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 08:19, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Add dwcmshc specific system-level suspend and resume support.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a9ed0e006e06..64ac0dbee95c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -163,6 +163,48 @@ static int dwcmshc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int dwcmshc_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = sdhci_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       clk_disable_unprepare(pltfm_host->clk);
> +       if (!IS_ERR(priv->bus_clk))
> +               clk_disable_unprepare(priv->bus_clk);
> +
> +       return ret;
> +}
> +
> +static int dwcmshc_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               return ret;
> +
> +       if (!IS_ERR(priv->bus_clk)) {
> +               ret = clk_prepare_enable(priv->bus_clk);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return sdhci_resume_host(host);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>         { .compatible = "snps,dwcmshc-sdhci" },
>         {}
> @@ -173,6 +215,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {
>                 .name   = "sdhci-dwcmshc",
>                 .of_match_table = sdhci_dwcmshc_dt_ids,
> +               .pm = &dwcmshc_pmops,
>         },
>         .probe  = dwcmshc_probe,
>         .remove = dwcmshc_remove,
> --
> 2.26.2
>
