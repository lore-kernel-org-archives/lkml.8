Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08ECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B713D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPOmhpn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgGJUgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJUgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:36:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9675C08C5DC;
        Fri, 10 Jul 2020 13:36:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f2so2712888plr.8;
        Fri, 10 Jul 2020 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/g5Ik4XxeXHychspflxS0Ipi8xCX8rGY0IAzYGaiEE=;
        b=ZPOmhpn/yEv3Hq5GaGhNywYoYKWi5DwBF+PgbNfwQS566GAiFsFlXCtM/LJLr0F3RE
         7YWhwXh0JCDWjgaWyRi8VP1jkGLEPpHIwdjNRza0bUmkNb/AXczDBQ8nZg0auMTURqgy
         /f8u5/MujHHwTRKiIGsUNl8bI4Ho42evW6G/YSdWupEqNUzL/ocUpZih+0Tk6MsTc36T
         otcPPkCw+x128F2+VS1BZynuQ0umPOIMulveSvoqjfTUZyFCMsIhM03TyHjNdVCa/jFt
         ipe7pYPD0hH8OprOcaNVGe8JzUAblvp/SOaLCyJXMjuXuPTnIjmyvL1cSgYZ8gW/BWY+
         s93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/g5Ik4XxeXHychspflxS0Ipi8xCX8rGY0IAzYGaiEE=;
        b=hzpH4G5dsPPlRHh2TaDDac6GoWzRslUmezFFTUV9ByosMnxNOMnvmvuEnfkvNCKteG
         GaagYGEysAUWNBLroY6oiPGttdepWRR0oKgAufmAdVQKVKoWN2zPq60J15OJTleZi26k
         R6s3LbMQKk9pA8fo3eqMhZwNK8HX9l+daOh3l3OOccaYWFyMEZmfC1KvwSid5FzOMJBx
         RBGEXOB/8nPrm30qji2JrQ6QilYG9eJskx57IQDF+vuKzQW1jGd4ELBKstqO4AaLxrGm
         nqEijOUlK+VbND0+v92D4x6HqkaWksNJEJk7RmKDh+bo7ohnOtXNZ0eVfZJ6t3WKT3XV
         RJ3w==
X-Gm-Message-State: AOAM532aQ6he2cPK/H64VbeZjH4seN1cqF4KoJvDIcNSQR8xIyPoulKC
        lPBzXsLSUVhV7E0XaQcmwOVQUb66G0uAs6WHG/g=
X-Google-Smtp-Source: ABdhPJxb0Hbc0iAwqzzvWKgvkq+Bd+3y6ilkaPBBehR+XumxcMmqm0tgPauRnfVQdgZvox+7S2zVpaQT8/eRFh8xKyA=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr7449485pjb.181.1594413404291;
 Fri, 10 Jul 2020 13:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200625061616.85278-1-sathyanarayana.nujella@intel.com>
In-Reply-To: <20200625061616.85278-1-sathyanarayana.nujella@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:36:28 +0300
Message-ID: <CAHp75VfzHCudPC90j=6T1UQqF8TPmxXk0wQ_AS4aU5Dc3tjjcg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: update TGL's LPM0 reg bit
 map name
To:     Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Arava Jairaj <jairaj.arava@intel.com>,
        "David E . Box" <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 9:16 AM Sathyanarayana Nujella
<sathyanarayana.nujella@intel.com> wrote:
>
> PMC debug tools use lpm0's 23rd bit to reflect Main PLL, not just
> Audio PLL. So, update tgl_lpm0 debug reg bit map name.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
> Signed-off-by: Arava Jairaj <jairaj.arava@intel.com>
> Acked-by: David E. Box <david.e.box@intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index d2a5d4c36715..60bf93638f55 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -415,7 +415,7 @@ static const struct pmc_bit_map tgl_lpm0_map[] = {
>         {"PCIe_Gen3PLL_OFF_STS",                BIT(20)},
>         {"OPIOPLL_OFF_STS",                     BIT(21)},
>         {"OCPLL_OFF_STS",                       BIT(22)},
> -       {"AudioPLL_OFF_STS",                    BIT(23)},
> +       {"MainPLL_OFF_STS",                     BIT(23)},
>         {"MIPIPLL_OFF_STS",                     BIT(24)},
>         {"Fast_XTAL_Osc_OFF_STS",               BIT(25)},
>         {"AC_Ring_Osc_OFF_STS",                 BIT(26)},
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
