Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B2C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3052067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SE5CYPIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCLNIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:08:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36968 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgCLNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:08:54 -0400
Received: by mail-vs1-f67.google.com with SMTP id o24so3623010vsp.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCpLsjhLXqr8ggz/g7xy6/f16tUDkY6B6Kn6YoYqpUE=;
        b=SE5CYPIzIyid17hSGz1XcILHYzJtY8UUO98gqgEp4CJnYHME3htfnaICAfLF5FgNqM
         qOw4RnCvaSmVbCnCuBp1xms7EHt5OUHz5MGB+yQFX86jBpJ2tJ3TErluuvyefoQLcRT3
         2NQmpjTa3CrDs1eTaEuQoNZCn5RNOFtblECM6Cpqaaot1jZd0LG3AJ6fE7cX/LTAOCrH
         dw4svMTbd2gqpgR1scyiOSn1uc9ivxqPdVjQLXUq7xeqipU5JRU++MFycq4H/YG4zi/y
         WnjaeE5r+sJgpgw+8bOpjbrfBYSbu6k63Vv6duO2LuP3QZSTiBe1JO3QiUBBmZyXHhTg
         sUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCpLsjhLXqr8ggz/g7xy6/f16tUDkY6B6Kn6YoYqpUE=;
        b=FX3AoUmMBZDEN2FgBk0U1fX4vSE1Bias7GTGPmnZ8hWzMb0m/EjL/rNTsI8AAdZiL6
         p34OjAqFDH+PrQ0O4EAfJ1EEX4QFIG6ZE6/YDondXayM2761u1BVSzjxuh7nxxsKSpdr
         mo00OmYwTnwGclpurhKO2kaMKuC8Qxtgh8tM4CCU/qCGGmZs22y8rv9ujZMXio4RTZzs
         WO2KzMqistLwk2uNVOH3nEpASYctfCVaUxuBzUbkiNsShyAgiaYiA+rjEyWOkxIwmcS/
         nORLJl4xxV4juoj5Ej6D5LJMsL9F9k5KbIgILuxxfT0g7jQL2+2Bmzw4w++lX/CJeFAs
         utSg==
X-Gm-Message-State: ANhLgQ0UHgA/2cx3l2c4PV1zcseOxb6wwBxiR80gzWIgYkfCL1NvIL4F
        mI0M2OLwUqSMYvAWNHKjaT6uIjK2YHGljccy0gCoUg==
X-Google-Smtp-Source: ADFU+vuqWI1okeIEKVWttizSEM5+86jFnLV1WXerjvGWOLaY7prRU7aBOXi7RzasPCbo3bmZNaNLqK66zhw+3WtGSdQ=
X-Received: by 2002:a67:646:: with SMTP id 67mr4966608vsg.34.1584018532247;
 Thu, 12 Mar 2020 06:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <1583916962-9467-1-git-send-email-skomatineni@nvidia.com> <1583916962-9467-2-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1583916962-9467-2-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 14:08:16 +0100
Message-ID: <CAPDyKFrF4EahPZ3VxEGYBbxCGXAEHFZHtte79CW=2-jEpvLvTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-trimmed cc list

On Thu, 12 Mar 2020 at 00:51, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Tegra sdhci host supports HW busy detection of the device busy
> signaling over data0 lane.
>
> So, this patch enables host capability MMC_CAP_wAIT_WHILE_BUSY.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index fa8f6a4..1c381f8 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1580,6 +1580,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_parse_dt;
>
> +       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +
>         if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>                 host->mmc->caps |= MMC_CAP_1_8V_DDR;
>
> --
> 2.7.4
>
