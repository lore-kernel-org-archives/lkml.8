Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3C2221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNRrNT1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgIKHFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgIKHFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:05:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B0C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so11427899ljk.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccFFbA9B/80814O047PWW9IYr+YcSRpx5Jz4CVkD9V0=;
        b=FNRrNT1viu436RH4fQuWLx7CxRGHkp9KJGRLQAfP58OGhvAUHAqPH70pcezhd4bbJn
         pt/z0CTcG1EOVjs03KytRaGjTljrUdlRSZReupBDG0eNoCAHEnMVZRQqayw9Luu9UbH+
         KtqKGi4SxcfZIJ/++LwOclntQXmdDZjw8iVrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccFFbA9B/80814O047PWW9IYr+YcSRpx5Jz4CVkD9V0=;
        b=lBf2CZd2IjWSV1mG+VNh0z3jIaCt3h9mTl8A7m1EWaMNDaeqjRybLxTslM7nBs1l14
         9Ycuerx4f6RGS6GxZluQMDLaPXR/SxoId0DvqkFXq33euq++2eac07DRH1EeFJkyUv9l
         LWl1+yvlepzpe2YtdXFdoe6vmHEygdKgs0ehg5nAqdWpDUA503eRpdGLhS25qlZ4de2a
         KVwhtha27j2E4LEQ+8OeqenJCJ4wBfX62jyPEQTOhgwJ1rFGTJr6s0fpbth/c2NhI8rQ
         FG2VPPtA04SuEJ9yhN3jaT3H+IbwRHwa8sALs7wcys+V+zjfWOngKgPTgXUQEYY2XW9n
         OF8w==
X-Gm-Message-State: AOAM533VJNEVWPFXhdkQHKjGe8+KymYweK6eFU1SkaoqujONgq4GRDrl
        dQzeaM6sONot41HyxTvbXy4uum84spcOPAmum6sa6Q==
X-Google-Smtp-Source: ABdhPJwv6DXrKoR0IN5OWRKjTqCiKrPiykNlvWutGaeY/OwjMRAOdZqKocPqRHR2iYhu2W6z5TehyPBdDRmIQ2lvr24=
X-Received: by 2002:a2e:6c03:: with SMTP id h3mr245615ljc.212.1599807901466;
 Fri, 11 Sep 2020 00:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200730120054.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
In-Reply-To: <20200730120054.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 11 Sep 2020 15:04:50 +0800
Message-ID: <CANMq1KDqDgdKcDWa0A15XLhS6ny3btejx5CKs07eLC8j-3Li=g@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: Check if power domains can be powered on
 at boot time
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias, gentle ping on the patch below >>>

Thanks!

On Thu, Jul 30, 2020 at 12:01 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> In the error case, where a power domain cannot be powered on
> successfully at boot time (in mtk_register_power_domains),
> pm_genpd_init would still be called with is_off=false, and the
> system would later try to disable the power domain again, triggering
> warnings as disabled clocks are disabled again (and other potential
> issues).
>
> Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> ---
>
>  drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d3754627dad..0055a52a49733d5 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>         for (i = 0; i < num; i++) {
>                 struct scp_domain *scpd = &scp->domains[i];
>                 struct generic_pm_domain *genpd = &scpd->genpd;
> +               bool on;
>
>                 /*
>                  * Initially turn on all domains to make the domains usable
> @@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                  * software.  The unused domains will be switched off during
>                  * late_init time.
>                  */
> -               genpd->power_on(genpd);
> +               on = genpd->power_on(genpd) >= 0;
>
> -               pm_genpd_init(genpd, NULL, false);
> +               pm_genpd_init(genpd, NULL, !on);
>         }
>
>         /*
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
