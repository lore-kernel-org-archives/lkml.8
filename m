Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C32DC38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CB420776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="By0UkC0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgDQJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbgDQJbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:31:31 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DDFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:31:31 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r7so772660vso.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p64gz4wBBzrCn9693S5Yg9rZbwKOwkix1v4fg68Kaak=;
        b=By0UkC0UOpKSJshUVUxtFt+AsHtAS3exQ/0f8C0eZVdh7ZlgbbEO/V4/W6S2CLvsEQ
         la185+DwqLva/ga3ddjQJsHoOckWFGSG/bOGp4zRs8MW9lL1WDRMAoIIAPXCqAOLSeEL
         F2zkDGqaH4/qUcByFpf7pU7/zVEfcs1IyMNpp8VCxDQqTMzYeTdlbiAaaG/RsazOJGmg
         s6v79X0qRbhRxMcibMTRHPqhIzkzJW25rgkNY64JpOyVu2eiuCj83apSm9arX5dkAGFI
         2kax/j+06Gb0y6o6BDMxUD2cbc/bXyuJqpu00MNatNuaDblJnHKjhPxUrsR/+cV5PDm8
         VGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p64gz4wBBzrCn9693S5Yg9rZbwKOwkix1v4fg68Kaak=;
        b=Vkjb88EAh4MODy5nms5NwNt/SjDrvkWbuGnTb+blvs+mnkhqs59ENJfjTPrH9SnZri
         YfFsdBvNnxHyMHuvsq1pv3tGOOWH6XwXHQHRTjL4xo9e/8JdqgwrTxlYKdKpgM+Z/PLZ
         3k1gn4I1KCTDm5GzD0dUQx7ip6bX9wRwKWWLoZmLCd6KhFtauHzy1Emv8vPancM9FVUc
         I0OUy8VMiR4bGUtNBSQCxIFsrrMZWBrVDTFw/sTxolNzYW3AUN0jbGQLygtwgVFaC2gi
         CPleihZvZZuoc46uZBXHSGhimqYJa64/+KA40S4QUT4Gg3x5tlbR4QxHk/JP0Oz1wZy7
         H8tg==
X-Gm-Message-State: AGi0PuY4z9yYw0EWCKqqjI3IYwMpe5DxcUlBaKrzG7ekEEqdf3dxuorb
        MO5sZcNj/GpaTArGvmwvLV/EtDPpJm243m3f7A0eaA==
X-Google-Smtp-Source: APiQypKTNkTpvRdq+a9PAoyBZV9h6xbL3cicvsKIs4XdjEhAkHKBJJUZuuhk8/gcK1ihy/h/WXevsS5Uvr1S19jnvHg=
X-Received: by 2002:a05:6102:72d:: with SMTP id u13mr1392649vsg.35.1587115890241;
 Fri, 17 Apr 2020 02:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200416182402.16858-1-natechancellor@gmail.com>
In-Reply-To: <20200416182402.16858-1-natechancellor@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 11:30:54 +0200
Message-ID: <CAPDyKFr4VX-3Z=iboMbDmhJvwh+GL5wg_50aPw+_j5jMLBWctg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Remove uninitialized ret variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 20:24, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/mmc/host/sdhci-of-arasan.c:784:9: warning: variable 'ret' is
> uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> drivers/mmc/host/sdhci-of-arasan.c:738:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> drivers/mmc/host/sdhci-of-arasan.c:860:9: warning: variable 'ret' is
> uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> drivers/mmc/host/sdhci-of-arasan.c:810:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 2 warnings generated.
>
> This looks like a copy paste error. Neither function has handling that
> needs ret so just remove it and return 0 directly.
>
> Fixes: f73e66a36772 ("sdhci: arasan: Add support for Versal Tap Delays")
> Link: https://github.com/ClangBuiltLinux/linux/issues/996
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 16e26c217a77..18bf0e76b1eb 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -735,7 +735,6 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>                 container_of(clk_data, struct sdhci_arasan_data, clk_data);
>         struct sdhci_host *host = sdhci_arasan->host;
>         u8 tap_delay, tap_max = 0;
> -       int ret;
>
>         /*
>          * This is applicable for SDHCI_SPEC_300 and above
> @@ -781,7 +780,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>                 sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static const struct clk_ops versal_sdcardclk_ops = {
> @@ -807,7 +806,6 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>                 container_of(clk_data, struct sdhci_arasan_data, clk_data);
>         struct sdhci_host *host = sdhci_arasan->host;
>         u8 tap_delay, tap_max = 0;
> -       int ret;
>
>         /*
>          * This is applicable for SDHCI_SPEC_300 and above
> @@ -857,7 +855,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>                 sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  static const struct clk_ops versal_sampleclk_ops = {
>
> base-commit: a3ca59b9af21e68069555ffff1ad89bd2a7c40fc
> --
> 2.26.1
>
