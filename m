Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC75320DD4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDmQb17J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGHI36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgGHI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:29:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D064C08C5DC;
        Wed,  8 Jul 2020 01:29:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a6so21623695ilq.13;
        Wed, 08 Jul 2020 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uv6kbmlO0hEyYsST4okZKcXm+NCBJlrtxwfuLCRV0s=;
        b=YDmQb17J7ITLd0DSFM6/ndDEM802ghYJSP/6szbfm197i2t72YsN6fL3Vu4gjQdSsi
         KCbF5z/fM8iYJW3bPe/yUrvAFMx4yHDgAXY39ZLj+VUmC/hRhPHq6GksJydYpM25pIC/
         fuvSH/SARVXA4/JJ9bRb1r2fssGrqoLX9pbh8Nvku+SJ0jj1BLpMZSAilJm8haUXGhPC
         0HSChBV2eO0cW9sPVWr1qu9VE6K8ahjsvNKu3IS6xHcvuHAhhTkz1EG99M/6+uoO7d5d
         vP9zhh/me1AqIw4+xmSQ9Kcla1ZzQt0QtXB/ff22twa5KiQxJkRX/6kC3K6D53DZCKiT
         F21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uv6kbmlO0hEyYsST4okZKcXm+NCBJlrtxwfuLCRV0s=;
        b=G5IpQUiSpw2nbNFcJsd9oxDtOYaaeMvyN8Yo1DwJfIm1ZORorvEr2tiypmR2lsoYxS
         /m+stIcjOucY4d2/4DOKA6psfHocO+TMBkwf8iz0T4Y10IntPrMA2aWPsjvYn8FFu/T6
         g3LrA8nfgFaOebBr6t09W7moRVh6Ztk/147VpDSVBveENwE2WvYWBhcU1Z5XSWSsES5G
         fn3p2EF3wWxl4vk41kWSfCt+BFRqywM3vgWE5o7acfLuwNYqv+ufFzUy93bQvCuPqK6w
         ApiPauWWUbXxUYJRv1PRcGKWZbLUalLyD14oKvX2/VNIkwZkZC2LnlKxgIyyR/IShFVt
         6RrQ==
X-Gm-Message-State: AOAM532Y1XckW/XcSB1OnqrEt93guyGIVrpixuNXY3LB4jRYcpbkBRgT
        oHBw6Rj8t1OrH2esGkqDEbQBqOkSrahux3+smww=
X-Google-Smtp-Source: ABdhPJxnYE+NQYi7O0671Vi9Qpck6x7kcV4a5r2gHNBU3pOlnUpIqZl+zOw9uyd8DB/pymJqrm3eITPFpYb+9T7mGn0=
X-Received: by 2002:a92:98c2:: with SMTP id a63mr38841081ill.246.1594196996887;
 Wed, 08 Jul 2020 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200707095908.372-1-linux.amoon@gmail.com> <20200707113645.GA27280@kozik-lap>
In-Reply-To: <20200707113645.GA27280@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 8 Jul 2020 13:59:46 +0530
Message-ID: <CANAwSgQ_LXx=oHuu1dcHBZqo0zr-mHYWKnVPFJn+_G44JRarPA@mail.gmail.com>
Subject: Re: [PATCH v3] phy: samsung: Use readl_poll_timeout function
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

On Tue, 7 Jul 2020 at 17:06, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 09:59:08AM +0000, Anand Moon wrote:
> > Instead of a busy waiting loop while loop using udelay
>
> You doubled "loop".
>
I will fix this in the next version.
> > use readl_poll_timeout function to check the condition
> > is met or timeout occurs in crport_handshake function.
>
> Still you did not mention that you convert the function to use sleeping
> primitive.  You also did not mention whether it is actually allowed in
> this context and I am not sure if you investigated it.
>
OK, I am not sure how to resolve your query.
I learned some new things.

So here are some points.
-- Yes read_poll_timeout internally used might_sleep if sleep_us != 0
under some condition.
-- None of the code in phy-exynos5-usbdrd.c is called using kernel
synchronization
     methods like spinlock / mutex.
-- I have checked this function is called non atomic context.
see below.
[    6.006395] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.013042] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.019646] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.026174] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.032699] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.039246] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.045707] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.052276] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.058760] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.065189] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.071631] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.078033] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.084433] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.090812] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.097102] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.103413] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.109670] exynos5_usb3drd_phy 12500000.phy: Not In atomic context
[    6.115871] exynos5_usb3drd_phy 12500000.phy: Not In atomic context

> Best regards,
> Krzysztof
>
> >
> > Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes v3:
> > --Fix the commit message.
> > --Drop the variable, used the value directly.
> > Changes v2:
> > --used the default timeout values.
> > --Added missing Fixed tags.
> > ---
> >  drivers/phy/samsung/phy-exynos5-usbdrd.c | 35 +++++++-----------------
> >  1 file changed, 10 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > index e510732afb8b..fa75fa88da33 100644
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
> > @@ -556,40 +557,24 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
> >  static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
> >                           u32 val, u32 cmd)
> >  {
> > -     u32 usec = 100;
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
> > +                     result, (result & PHYREG1_CR_ACK), 1, 100);
> > +     if (err) {
> > +             dev_err(phy_drd->dev, "CRPORT handshake timeout1 (0x%08x)\n", val);
> >               return -ETIME;
Here return should be -ETIMEDOUT;
> >       }
> >
> > -     usec = 100;
> > -
> >       writel(val, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
> >
> > -     do {
> > -             result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> > -             if (!(result & PHYREG1_CR_ACK))
> > -                     break;
> > -
> > -             udelay(1);
> > -     } while (usec-- > 0);
> > -
> > -     if (!usec) {
> > -             dev_err(phy_drd->dev,
> > -                     "CRPORT handshake timeout2 (0x%08x)\n", val);
> > +     err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
> > +                     result, !(result & PHYREG1_CR_ACK), 1, 100);
> > +     if (err) {
> > +             dev_err(phy_drd->dev, "CRPORT handshake timeout2 (0x%08x)\n", val);
> >               return -ETIME;
> >       }
> >

Best Regards
-Anand
