Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA06C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5D206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXd2NakA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGFDrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 23:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgGFDrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 23:47:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3230C061794;
        Sun,  5 Jul 2020 20:47:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q8so37889774iow.7;
        Sun, 05 Jul 2020 20:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbFKvwUAZYidEEuDI3n6ueyYMeGnBHxKERKc5eSxw+c=;
        b=PXd2NakAyUx5SjY38+/3VFE5sAGCgZ9aBGUq/ScZpncOh9+s2PP5Sl4F/sigLmGNoB
         3DWbg8XVnymQXfm9NzZugObhNcTtdwNaAOuwmS67c5icYy3Lk0crSRK/BkdO8p4eRi6W
         vv8PXOnuz69lz1LloiXbV3eTXD3NL8Zh8O4PobTFibsF/eMoAN35uyDgf8xLOwbqw+xB
         Xm1YL7eRVOula8mR8Tes43+TDH50NGELPtDolE+1AR7uttajcyof8rz4Dbt3Gc/v0kkM
         10yHonaMVG+eAuCJkGUZYxtJsqfRys2m/m5BwlpSm78x/5Gb9NQYALJUH4tzveU8+1lg
         KOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbFKvwUAZYidEEuDI3n6ueyYMeGnBHxKERKc5eSxw+c=;
        b=uKXYGrf5fWKhzscpnee2LUGADBEBhxrdwVbli58B4DUzdnnpQgR39jX9Clkj3pZY7U
         zBvYjmCKwjydDyxbJZl2kQvblub/ABQjgmlTu5Uk9HRkPFuk3NfDLOI/u2fEDXfJOZr+
         fcNa2NYRzfd5B/S8LsRoTta0EdoaAAYW5+kcEiqqIMGUNJc2+sJj30sTFP7e8bv/6u5Z
         etjLEY4lplB4WRSZ2eXiupUd0JdMliofNKn6aa9iv5xvfpM3FvRXIYf/rtHF5pc18/1c
         EjhTneJUoG4Csumza4eKIlcAIp3YIN+BZ0iuQjg8XPqNdntKprBoJPMsz4N6eiCbbGce
         cehg==
X-Gm-Message-State: AOAM5312u2lcj7EiVZiOLUzANgVs3hIlCBE4nP9TY5iBIF30nL0l8nJk
        SrlsdxRSH4ditht2PyPOIZqjBMGIQFfyzKvKiHg=
X-Google-Smtp-Source: ABdhPJyTjmaguZSDwR71fF4ldBSLkkKOt6qXIwC1RPm0/zFCPQUQ4QDhV1oO5ORP1DeBUObkMEgkS9VhRJqR9hekIZ4=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr23198425iok.43.1594007239994;
 Sun, 05 Jul 2020 20:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200705060435.504-1-linux.amoon@gmail.com> <20200705180248.GA2765@kozik-lap>
In-Reply-To: <20200705180248.GA2765@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 6 Jul 2020 09:17:09 +0530
Message-ID: <CANAwSgQzQuP5i8ZkvxHS===oVO2y-ZWZZRt9CyRtq1AiyrL81w@mail.gmail.com>
Subject: Re: [PATCH v2] phy: samsung: Use readl_poll_timeout function
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

Hi Krzysztof,

Thanks for your review comments.

On Sun, 5 Jul 2020 at 23:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, Jul 05, 2020 at 06:04:35AM +0000, Anand Moon wrote:
> > User readl_poll_timeout function instead of open
> > coded handling in crport_handshake function.
>
> Your change does not replace only the "open coded handling" with
> readl_poll_timeout(). Your change does more - switches busy waiting with
> udelay to a sleeping mode. I am not sure if it is correct but definitly
> it should be mentioned.  Otherwise how can we be sure that you checked
> if this is allowed in this section? Did you test everything with
> DEBUG_ATOMIC_SLEEP?
Yes this DEBUG_ATOMIC_SLEEP is enabled in exynos_defconfig.
>
Ok how about the below commit message.

Instead of a busy waiting loop while loop using udelay use readl_poll_timeout
function to check the condition is met or timeout occurs in
crport_handshake function.

> >
> > Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes v2:
> > --used the default timeout values.
> > --Added missing Fixed tags.
> > ---
> >  drivers/phy/samsung/phy-exynos5-usbdrd.c | 37 +++++++++---------------
> >  1 file changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > index e510732afb8b..c97f5fb6a9a0 100644
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
> > +     u32 timeout_us = 100, sleep_us = 1;
>
> No need for the variables actually and their type does not match. Just
> use the values directly.
Ok thanks
>
> >       unsigned int result;
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
> > +     timeout_us = 100;
> > +     sleep_us = 1;
>
> Why defining then again?
I had removed this in this but last minute I added this code again.
>
> Best regards,
> Krzysztof
>

Best Regards
-Anand
