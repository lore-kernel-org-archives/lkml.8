Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF7C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 02:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2242075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 02:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="v7KJ5PF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEGCkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 22:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbgEGCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:40:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A91C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 19:40:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so3223327eje.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 19:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eZPaamE0lbeQ2MzIL/SDhviNajRasVE2XwCqHm8H6I=;
        b=v7KJ5PF+0CnuiOtNR5Afa/XvAYOq0LwhOVZFPTclvX9NF+rResHMybnZxK7G8Y/uCp
         bJmt5kJpzOcwhjoEx+Wsg1Zr/fBSYZsS0tVrJgOVIw++rV9zY/WIa1D6Xibsp5hJXrOW
         uYz+7/2xAWHVv8UmR3184sBIiVlF7vwUnKhJ4gZlt0nPcrFboVDDY+KB7xhfouWaS/sE
         KLMPQOilFoev6EOfGFgIYE008ukXNl254fYi/SPhoQBbGgGlc76N4eCylKmFFDg2FOj6
         GzeaT8/flEyhRBZkOIh7OxoAgB2MNIaLR+7zEOnGTmabUW6SnW2fzZQk9NAsuV1TqArS
         vEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eZPaamE0lbeQ2MzIL/SDhviNajRasVE2XwCqHm8H6I=;
        b=rExCe4W78tBTdgbBWSLGK4xjKMgzzR+TH1zFD9xrswle+AoeeJjOWrXwn16m5OCcIE
         kSGpFDXxIEBA0drfDKyPbVKri1/ZvhaCcyt789/BEb59uQebwyG4ea4MIVPeDvI/aQji
         odhD3sgesb/ow4N3BKeSwvXVCEvEsJTak/gF3ZCzpKnoDM+6GmWVMHmJmVTUHNAhMA7y
         Uk3Peys6WggzewA8cJ64bet0qiZlH0v1+s3mFftdEfxmWfdTvQ9i+qG1oLC2Zp6jtFNA
         GykQtDjVmId7rhsDPq3FKa7YbKgS/ekHLLGYaR4IdUZcjsmHe+F217NXE+Rfrr9yjj92
         r37A==
X-Gm-Message-State: AGi0PualEObCmeGT+qFSHiO/ZYnX8JFJs9bgTFx0r330TP/g+4HPclBR
        5+HsknpVEQP2wthay5WPFmfCIWZCQ2Zxvl8UXYVmTg==
X-Google-Smtp-Source: APiQypJ+my7liklkzTVPzRWAcyz6Lh1mnhuTKF6LGhVfdEXQrAqyR1AkJh3Z5XCtC56OSvnRVkY3y9VuwSoD0mbE/8s=
X-Received: by 2002:a17:906:af6f:: with SMTP id os15mr10323118ejb.78.1588819199589;
 Wed, 06 May 2020 19:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200414220943.6203-1-ezequiel@collabora.com> <CADBw62oJj_x046piRbPP48A04ALo-w2J6jZXNspyN5eOGj-TEg@mail.gmail.com>
In-Reply-To: <CADBw62oJj_x046piRbPP48A04ALo-w2J6jZXNspyN5eOGj-TEg@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 6 May 2020 23:39:48 -0300
Message-ID: <CAAEAJfDDOwhjiTX4eXkHnU=+NTRXroFXCbEqa1B43C41LaTkBg@mail.gmail.com>
Subject: Re: [PATCH] hwspinlock: Simplify Kconfig
To:     Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 15 Apr 2020 at 10:33, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Ezequiel,
>
> On Wed, Apr 15, 2020 at 6:09 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> >
> > Every hwspinlock driver is expected to depend on the
> > hwspinlock core, so it's possible to simplify the
> > Kconfig, factoring out the HWSPINLOCK dependency.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>
> Looks reasonable to me.
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
>

Gentle ping.

Thanks!
Ezequiel

> > ---
> >  drivers/hwspinlock/Kconfig | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> > index 826a1054100d..32cd26352f38 100644
> > --- a/drivers/hwspinlock/Kconfig
> > +++ b/drivers/hwspinlock/Kconfig
> > @@ -6,9 +6,10 @@
> >  menuconfig HWSPINLOCK
> >         bool "Hardware Spinlock drivers"
> >
> > +if HWSPINLOCK
> > +
> >  config HWSPINLOCK_OMAP
> >         tristate "OMAP Hardware Spinlock device"
> > -       depends on HWSPINLOCK
> >         depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3 || COMPILE_TEST
> >         help
> >           Say y here to support the OMAP Hardware Spinlock device (firstly
> > @@ -18,7 +19,6 @@ config HWSPINLOCK_OMAP
> >
> >  config HWSPINLOCK_QCOM
> >         tristate "Qualcomm Hardware Spinlock device"
> > -       depends on HWSPINLOCK
> >         depends on ARCH_QCOM || COMPILE_TEST
> >         select MFD_SYSCON
> >         help
> > @@ -30,7 +30,6 @@ config HWSPINLOCK_QCOM
> >
> >  config HWSPINLOCK_SIRF
> >         tristate "SIRF Hardware Spinlock device"
> > -       depends on HWSPINLOCK
> >         depends on ARCH_SIRF || COMPILE_TEST
> >         help
> >           Say y here to support the SIRF Hardware Spinlock device, which
> > @@ -43,7 +42,6 @@ config HWSPINLOCK_SIRF
> >  config HWSPINLOCK_SPRD
> >         tristate "SPRD Hardware Spinlock device"
> >         depends on ARCH_SPRD || COMPILE_TEST
> > -       depends on HWSPINLOCK
> >         help
> >           Say y here to support the SPRD Hardware Spinlock device.
> >
> > @@ -52,7 +50,6 @@ config HWSPINLOCK_SPRD
> >  config HWSPINLOCK_STM32
> >         tristate "STM32 Hardware Spinlock device"
> >         depends on MACH_STM32MP157 || COMPILE_TEST
> > -       depends on HWSPINLOCK
> >         help
> >           Say y here to support the STM32 Hardware Spinlock device.
> >
> > @@ -60,7 +57,6 @@ config HWSPINLOCK_STM32
> >
> >  config HSEM_U8500
> >         tristate "STE Hardware Semaphore functionality"
> > -       depends on HWSPINLOCK
> >         depends on ARCH_U8500 || COMPILE_TEST
> >         help
> >           Say y here to support the STE Hardware Semaphore functionality, which
> > @@ -68,3 +64,5 @@ config HSEM_U8500
> >           SoC.
> >
> >           If unsure, say N.
> > +
> > +endif # HWSPINLOCK
> > --
> > 2.26.0.rc2
> >
>
>
> --
> Baolin Wang
