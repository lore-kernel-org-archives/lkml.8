Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E37BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7890520674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3N/FiQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgGGGzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGGGzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:55:24 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613EFC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 23:55:24 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o15so21922279vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R5BjuHDM7SvbwjX2Wy0yK9rZ3kvZqwci6rTlVHchQms=;
        b=u3N/FiQEU/C/kO2T73BlHN0SZ7p0aso1DFhdA3lZ7DW8LAGykkaHH2i+XXtXsWEqhx
         2oZftQS3TbmOAeem+c/Ykimd/yZVKGFScenD6Ql31xaBx1OMGL73tvizuPBaGVuHZPKV
         dWQa+7nduTPNA193emz8Qjc5qY8xal2QyyewGgr5G6NWqWMeHmOBvdRoYGZs5yZrN31H
         4hojVcG6VhV2rQwnVFCA1g2Ed4lR2lvb0Z2vBIJVB6pup/VMvTvlJJ/cBbLhHEezzS9j
         4SMFXHh2OqjD4C4n2P9JfpvUH7OCFS5Dcso8LaoYIIfNhxbHR52barpQSRtgrBJCMAOR
         X81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R5BjuHDM7SvbwjX2Wy0yK9rZ3kvZqwci6rTlVHchQms=;
        b=rmEPF1UAC4FiLicQ4fpBmxUYWX7W1M687U/csUPiL/FhTPnxIfVCaplTGiZvtEqBp/
         7lU/5fU2PZ2kHxlRu9tFJVm4JvBuM2OB/QG1/lQP2GemaiY6ThX9Q5MlGVynvA3oOIJg
         lHZ9/dHYqRLEzedNHqfD5yz1fYDFC6h/XR9c4ZAKy4yOi/0LbaGs0Ubgn2ac1AC9RnBz
         Xd5a7NCMl4Kw4h3sWTdeeb5X2wF/t3l5D01hMOTHRlnWh2jwJrw8O45rHRB1o743wnYe
         Q+5ZfnVIhagOh4o/gD8YgsY0Zmnt7y8RdE9SqnCjfQAiG+pyFyogxIaFcuBLdIDy4Z8K
         GaIg==
X-Gm-Message-State: AOAM5332gurGMuS6r26GwWyqSJpbB3AFnEiRskH3oX6mifixqQ17N+eD
        ZHXv3iHfsGh4WZkGiYVPYuTCNTL8HR8TcRfmVmRIKA==
X-Google-Smtp-Source: ABdhPJxBYFpArr21ZuEa8iqd08YvBimLIpo2Sv9wNImWbaG78jmphcf8G/Cb+SRyEWPEqwFoz62WDpVw5zzTvOldd3w=
X-Received: by 2002:a67:ca03:: with SMTP id z3mr31570079vsk.34.1594104923449;
 Mon, 06 Jul 2020 23:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200701102317.235032-1-lee.jones@linaro.org>
In-Reply-To: <20200701102317.235032-1-lee.jones@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 08:54:47 +0200
Message-ID: <CAPDyKFonM1AJro7UEY0V=OmGEhMEQHpx5zQM6aMvJidEXFiWpA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: arm: mach-omap2: mmc: Move omap_mmc_notify_cover_event()
 prototype
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 12:23, Lee Jones <lee.jones@linaro.org> wrote:
>
> When building the kernel with W=3D1 the build system complains of:
>
>  drivers/mmc/host/omap.c:854:6: warning: no previous prototype for =E2=80=
=98omap_mmc_notify_cover_event=E2=80=99 [-Wmissing-prototypes]
>  854 | void omap_mmc_notify_cover_event(struct device *dev, int num, int =
is_closed)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> If we move the prototype into a shared headerfile the build system
> will be satisfied.  Rather than create a whole new headerfile just
> for this purpose, it makes sense to use the already existing
> mmc-omap.h.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  arch/arm/mach-omap2/mmc.h              | 4 ----
>  include/linux/platform_data/mmc-omap.h | 3 +++
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
> index 7f4e053c34344..b5533e93cb632 100644
> --- a/arch/arm/mach-omap2/mmc.h
> +++ b/arch/arm/mach-omap2/mmc.h
> @@ -16,7 +16,3 @@ static inline int omap_msdi_reset(struct omap_hwmod *oh=
)
>         return 0;
>  }
>  #endif
> -
> -/* called from board-specific card detection service routine */
> -extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
> -                                       int is_closed);
> diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platf=
orm_data/mmc-omap.h
> index 9acf0e87aa9be..f0b8947e6b07d 100644
> --- a/include/linux/platform_data/mmc-omap.h
> +++ b/include/linux/platform_data/mmc-omap.h
> @@ -116,3 +116,6 @@ struct omap_mmc_platform_data {
>
>         } slots[OMAP_MMC_MAX_SLOTS];
>  };
> +
> +extern void omap_mmc_notify_cover_event(struct device *dev, int slot,
> +                                       int is_closed);
> --
> 2.25.1
>
