Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A1FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBFC21734
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJsoSEak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbgAXL0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:16 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33186 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbgAXL0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:26:12 -0500
Received: by mail-vk1-f195.google.com with SMTP id i78so520309vke.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4zxNmALyQaeSNVgycZmI7UdCPyGJp4Jq4VQMZS6LoA=;
        b=AJsoSEakroKigcs2LGpzFMwCgIQRExPi/mj4WfXkL5sxCiUUKPgLWLeoUD/zI6wuJD
         nDnv5X/UovIDv0oVVPK/bOV/r9T3ChUKkgYIYC9t4UWuxU5RAzCwaz4yls51fzKxjmS4
         baFvn3RZy1U2BYpwOJBFp0lGTKupCoduCSPuHuVqFe6Zvmvs5v8TAxcMIrCENfbv0gPO
         T3jUlKF1FWyXmL/HeSFUU3+vCbS1MQg8KiHGmR+XrrP1oi7SRNC4e6IrzGzEjUY/bSrA
         L8VNNE6vFC1uwo1MYUx997nvmvUQ9J0bM4UZHWPs6E80bkD0AYOSbSd0L/O9g8UGfZY6
         bpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4zxNmALyQaeSNVgycZmI7UdCPyGJp4Jq4VQMZS6LoA=;
        b=Ji/UFxEAhiiNZzqvdvZHZZDLX02/pCKoGVJ8toyOxcV8vX5ikZJ0cWDohJwLrzwSPi
         A/LQq2xFjuZouSW1do3LM5NWGfzx1qNawWUlxGRAjmv8dldfU5lfxsnkdcm3/sP+d0Z8
         p6WRmptEigWByu35+X4EUIrHT2mVi593hLhQU2bHQhWsrybOsQiAF8r84NuC7WYEU8Mf
         cBxAn9BPNFJPDJd8CPk8U02clcqjac6osfRNRbGLV5iA8hWqXgwupm9ehmVauQWWpjc5
         syLckMiNmxsNbfYfwF8I9aiBUBZh54Qbvb17+OVZ1sWW4rTAvd69DE8LzrHcOxgzJmDy
         GM1A==
X-Gm-Message-State: APjAAAUyHftdS20udQhaDspqh0W2QgWGXseDmxb8QrLCw8i9b0u5R58d
        xd1Wti1pfw+DN8qMk5u3gDNV5NzQ6NTtOvzLXqgKmg==
X-Google-Smtp-Source: APXvYqxfMDotHNYK2A3nSMosS8PRPs0S744rAnj3lTNvJsxAJkHtSPIC5Tx4zdR5V1TGJtFLt8LfVJgC5UtN0wPcvlg=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr1592935vkd.101.1579865170740;
 Fri, 24 Jan 2020 03:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20200121105858.13325-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200121105858.13325-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 12:25:34 +0100
Message-ID: <CAPDyKFosM5+ffP-qC+Z6k-mMzu9oVDVxNskNb5hFepgAyg8vVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: remove unneeded 'inline' marker
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 11:59, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 'static inline' in .c files does not make much sense because
> functions may or may not be inlined irrespective of the 'inline'
> marker. It is just a hint.
>
> This function is quite small, so very likely to be inlined by the
> compiler's optimization (-O2 or -Os), but it is up to the compiler
> after all.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index ae0ec27dd7cc..5827d3751b81 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -158,7 +158,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>         return 0;
>  }
>
> -static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> +static void *sdhci_cdns_priv(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
> --
> 2.17.1
>
