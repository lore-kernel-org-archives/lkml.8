Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733C2207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOxOuxMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHUHk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgHUHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:09 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C5BC061388
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:08 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j188so393456vsd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAU9iZW9yGALOB30mTlHDeoRf5CRh/Snlg+xCwRu8JU=;
        b=kOxOuxMxSQ+ksSLjKg3Ni5aIYiY5w0RxKooi0DNSCKve7b14PccYxmywLlnGxld6mc
         WqavXtK7TC9i0AqdD3XPTGzIoa5x8gqELOCV/+vAlvOIAyKSZztrQsMbO4Rg2Sd1UFPg
         SiEMKltZUmr8lz2zr42CVDG7YdRtLuErHINARiW/rqVexyezip3RnwlVXtlEpgakssZH
         NiFgJ9BjbUnADlw9BpI2N/RodkTY07zEH8wagrgldLZZX2bBReCzCGOX1V/M9Lb+z/Vk
         +T51a1HYvojPzfuH4UOvwvYnJe1ukLKul84xO8Z6/4GZPuwyMPAeamxXv+di9soZ/b3m
         KOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAU9iZW9yGALOB30mTlHDeoRf5CRh/Snlg+xCwRu8JU=;
        b=bO4NVi1HSGm+KNCjfkGGTggVDoyo09Jx5oAueZwn97tTcqqdrXKvT2Pi434CSvSK6p
         z48qlYtw7ErJXCBEK8UFHlI02KUmKGpspGh8HmN1rPjiYAzWQtTlAQN9Qy02veaIl4XQ
         6xxo89t8tus1LguJzYwa83oa3du+QS3svTkVQBx/waS5Wlsb91Yas5AA/M0UIevZRKqK
         KnTy1on55K5obcT+ZQrm89v841abJwzfUegLX91lAb5TK5PGqxBvnyXyuvnLCLaeVAF/
         tZweHCwr+Gi/ypDNkxN9sHAmqiRvJSCtqk0aI+EYX/OctoFk2Gd0I3FtKRdE9yaX9CuP
         MyiA==
X-Gm-Message-State: AOAM532mEFWDP27VacdzYIH4fnTl4r4oxkMYEByjwIwSTBOUyWX59C2R
        OppO3Q/O0JGpkF1ZnJEDY1xz/xPcncZsaSzqo5mnqQ==
X-Google-Smtp-Source: ABdhPJwcZWnwUZBTqM0sxN5IRp11B+ol/YTZpoa5qsJpj61ysTHH9tG19j4VKQcti7QxF7eU+rcXtzQeNyrlpU0p/zI=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr887206vso.165.1597995607373;
 Fri, 21 Aug 2020 00:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <1596673949-1571-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1596673949-1571-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 09:39:31 +0200
Message-ID: <CAPDyKFre3Rpfd-XW=kMzuKJAfUcr4v-vEj9KVkPyAvkbTdRuGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix timeout clock used by hardware data timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
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
> Tegra210/Tegra186/Tegra194 has incorrectly enabled
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK from the beginning of their support.
>
> Tegra210 and later SDMMC hardware default uses sdmmc_legacy_tm (TMCLK)
> all the time for hardware data timeout instead of SDCLK and this TMCLK
> need to be kept enabled by Tegra sdmmc driver.
>
> This series includes patches to fix this for Tegra210/Tegra186/Tegra194.
>
> These patches need to be manually backported for 4.9, 4.14 and 4.19.
>
> Will send patches to backport separately once these patches are ack'd.
>
> Delta between patch versions:
> [v3]:   Same as v2 with fixes tag
>
> [v2]:   Includes minor fix
>         - Patch-0006: parentheses around operand of '!'
>
> Sowjanya Komatineni (6):
>   sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
>   sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
>   arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
>   arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
>   arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
>   sdhci: tegra: Add missing TMCLK for data timeout
>
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 +++++++++------
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 15 ++++++-----
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 20 +++++++++------
>  drivers/mmc/host/sdhci-tegra.c           | 43 ++++++++++++++++++++++++++++++--
>  4 files changed, 74 insertions(+), 24 deletions(-)
>
> --
> 2.7.4
>

This looks good to me.

If it helps, I can also pick the arm64 patches for my fixes branch,
but I need an ack from Thierry/Jon to do that.

Kind regards
Uffe
