Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 04:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB853207D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 04:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZsxxHm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgGDEZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 00:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgGDEZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 00:25:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0932CC061794;
        Fri,  3 Jul 2020 21:25:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so29313412iof.12;
        Fri, 03 Jul 2020 21:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UPXD/iK4lkAOYf+tM3eqOazrdC4wjGMNCYGet5n4fc=;
        b=BZsxxHm1TMVWBJ47l8VHZ0BMlWqCNJcsbkVGrEe7ShfoNKT6LynOTIUWTnbi38pGpP
         /nfdiE1ajFPDCSCZ+Q5RVTjYAj0XIbZgDuqJAnJHKrr/avX3KH6x658tqlgVqI6yFaph
         glBj0tNLD2nR6WDvVeCwBvbOOl9INtDn5luH8r2rSeEOM8ote42udweZIgu+bh3/4DEg
         Xtox+8bksYsD0Ish9w8XJtEcUqbBQBVUoJXKst3TFRacP2ZmoweTMwkdFhkVJTXZbDll
         RBcqbWlZzv7weNeptLwYQwHe8KTFZegqDBB225zP5yYrliDanDkcij+/rNzK7dI30pEp
         Tc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UPXD/iK4lkAOYf+tM3eqOazrdC4wjGMNCYGet5n4fc=;
        b=ezHZ98sUZH0+yDrYvVWUQXBtY5c6QodR8Bkn7bBppUFWq5VCTyvIglFHb0PN4eSjuW
         RKKLD40Qknh+acFqsuITyY6WtBIc9T+0btwqBOKQv9XOWWsu0Vq9KGbouqTC601s400l
         JdyghlN5/F6L/MDwKTXGMw/WrRhLc3YzH03A+I8PhNOhasBvKaiSfU0iEe1/xL89SP5N
         8VU9mvpW/JQrsYFSo2/wkwuiI/e/BIRRHJRtrKSDTF6eR6Ye/9zKUn1ieFkSUqvzhPv9
         gZlYTIpx2JR2tSsvUmkLAdF8v+ltE39bpllAmRdKe4TPs7s7+XVskbdDgYXx1lWzjJqK
         9W3A==
X-Gm-Message-State: AOAM531FTm8bN9UVXT4LM7IwbDwvs4ZvYw8r3gm24h4/TnOGMeXU2BHe
        0J/5N8JsYV8Wq+Hw+NY/ZXIpL75suXznahmqV86F4Jl6
X-Google-Smtp-Source: ABdhPJytPTHPUtXvxENGDlf4+5FbWJAuLYCWlYn3hSHnskudx24q1x8oV38vRxjB2qembsdZjwCKTzuMmeEDzQd72kw=
X-Received: by 2002:a6b:691d:: with SMTP id e29mr15272167ioc.159.1593836709115;
 Fri, 03 Jul 2020 21:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200703132012.579-1-linux.amoon@gmail.com> <20200703164349.GA2914@kozik-lap>
In-Reply-To: <20200703164349.GA2914@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 4 Jul 2020 09:54:58 +0530
Message-ID: <CANAwSgQrTobDjPF7AF96FNoiihBjhwf9CQMBgCKBVuqza4v3Bg@mail.gmail.com>
Subject: Re: [PATCH] phy: samsung: Use readl_poll_timeout function
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Krzysztof,

On Fri, 3 Jul 2020 at 22:13, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Jul 03, 2020 at 01:20:12PM +0000, Anand Moon wrote:
> > User readl_poll_timeout function instead of open
> > coded handling in crport_handshake function.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/phy/samsung/phy-exynos5-usbdrd.c | 37 +++++++++---------------
> >  1 file changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > index e510732afb8b..83274c5e3820 100644
> > --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mutex.h>
> > @@ -556,40 +557,28 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
> >  static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
> >                           u32 val, u32 cmd)
> >  {
> > -     u32 usec = 100;
> > +     u32 timeout_us = 1000, sleep_us = 10;
> >       unsigned int result;
>
> You silently (without mentioning in commit msg and explaining why)
> changed both the sleep time and total timeout.
>

Ok I will stick with the original default value.
  timeout_us = 100, sleep_us = 1;

> Nope, please explain why you chosen such values and change them in
> separate patch..

I choose these values following Alim Akhtar's UFS PHY patches.

>
> > +     int err;
> >
> >       writel(val | cmd, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
> >
> > -     do {
> > -             result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> > -             if (result & PHYREG1_CR_ACK)
> > -                     break;
> > -
> > -             udelay(1);
> > -     } while (usec-- > 0);
> > -
> > -     if (!usec) {
> > -             dev_err(phy_drd->dev,
> > -                     "CRPORT handshake timeout1 (0x%08x)\n", val);
> > +     err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
> > +                     result, (result & PHYREG1_CR_ACK), sleep_us, timeout_us);
> > +     if (err) {
> > +             dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
> >               return -ETIME;
> >       }
> >
> > -     usec = 100;
> > +     timeout_us = 1000;
> > +     sleep_us = 10;
>
> The same.
>
> Best regards,
> Krzysztof
>

Best regards,
-Anand
