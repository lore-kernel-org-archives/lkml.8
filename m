Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86B2C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9009120753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3kGD60T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbgELX02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:26:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33449C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:26:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so10278269pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQXNcvMIvuLWXBulBjsu4xZzdHuqAR8TIZKekjTyhlo=;
        b=P3kGD60Tv5PddUoiNeSk5xXwUVHvLr8agI3C6C8WLsfQDozJYIzFZ0lMUSwRFAPqr5
         4EFSuXqSC+og26lTAhRn1qtMV9BX5ZyMdUkwohwcVlY/368tH2swkasQovIKKKqqFxky
         OrLOk+aFrN6IABcWZh4qrejDALHz39LiMN4KocGTHdUJKUGynHQDx2Nu8/PimfntZyGo
         OtgVgrkRpXzU8UNhGQD201B3QfyqA9GlGqypmNi1G1rvigKjvuQpjIpFg+vTQx0oGA1p
         Y0T1CdvzRyzCYUo05Vb9DAnMmqIEZLxjol/FyOl3iNzuKg7U6+sh5NCuyVg9Phc+uJ9C
         rZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQXNcvMIvuLWXBulBjsu4xZzdHuqAR8TIZKekjTyhlo=;
        b=UYq0NApB82+dBtWb0zWfyjU5XmedMptcjZWQoFEe2hLfXvHMjXreNYPreZbWzR+PO6
         wpLG/1UjW57NjPkRdaj8etlF3zTCOmJ2f+/jOiEOda+Og3cbF3K2YUpoxofy7FHZKhOA
         5K/e7RgQzkhEaAAsfAA39bfGQQy4Ij3QkPS61uZ0E9aWamWmdGzpGVRk+BhlrM1+Rrr2
         8bG2dKhKReR6Xk2D2cbeL/vsYE9y8v67L9zsK4pQL6kgVco9v26a+ClLQUrX/4EfMTsg
         3d54trBBXiox55MOnKDj6lDamSIsoQqSa5K16jtcByQiwBV3tytfETk56LUP0NUi4WUR
         W4yA==
X-Gm-Message-State: AGi0PuY911ij9Z7pmXuKPTpTVgQ3THW5dmmHR4NqoeqPrXhuRT3uGqf1
        Cna99lvD0d/iX/MZWW/zfN3R/g==
X-Google-Smtp-Source: APiQypKXiCxAFgVP7ryK8y1SNwvYRfjGXKCvOmqnPlYZne/14774FvtVroFdvtm9PAXltVFfaj8AtA==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2mr21186869plx.219.1589325986556;
        Tue, 12 May 2020 16:26:26 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i2sm4584284pgb.14.2020.05.12.16.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:26:25 -0700 (PDT)
Date:   Tue, 12 May 2020 16:24:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        kernel@collabora.com
Subject: Re: [PATCH] hwspinlock: Simplify Kconfig
Message-ID: <20200512232453.GD16107@builder.lan>
References: <20200414220943.6203-1-ezequiel@collabora.com>
 <CADBw62oJj_x046piRbPP48A04ALo-w2J6jZXNspyN5eOGj-TEg@mail.gmail.com>
 <CAAEAJfDDOwhjiTX4eXkHnU=+NTRXroFXCbEqa1B43C41LaTkBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEAJfDDOwhjiTX4eXkHnU=+NTRXroFXCbEqa1B43C41LaTkBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 May 19:39 PDT 2020, Ezequiel Garcia wrote:

> Hello,
> 
> On Wed, 15 Apr 2020 at 10:33, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Ezequiel,
> >
> > On Wed, Apr 15, 2020 at 6:09 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > >
> > > Every hwspinlock driver is expected to depend on the
> > > hwspinlock core, so it's possible to simplify the
> > > Kconfig, factoring out the HWSPINLOCK dependency.
> > >
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> >
> > Looks reasonable to me.
> > Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> 
> Gentle ping.
> 

Applied.

Thanks,
Bjorn

> Thanks!
> Ezequiel
> 
> > > ---
> > >  drivers/hwspinlock/Kconfig | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> > > index 826a1054100d..32cd26352f38 100644
> > > --- a/drivers/hwspinlock/Kconfig
> > > +++ b/drivers/hwspinlock/Kconfig
> > > @@ -6,9 +6,10 @@
> > >  menuconfig HWSPINLOCK
> > >         bool "Hardware Spinlock drivers"
> > >
> > > +if HWSPINLOCK
> > > +
> > >  config HWSPINLOCK_OMAP
> > >         tristate "OMAP Hardware Spinlock device"
> > > -       depends on HWSPINLOCK
> > >         depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3 || COMPILE_TEST
> > >         help
> > >           Say y here to support the OMAP Hardware Spinlock device (firstly
> > > @@ -18,7 +19,6 @@ config HWSPINLOCK_OMAP
> > >
> > >  config HWSPINLOCK_QCOM
> > >         tristate "Qualcomm Hardware Spinlock device"
> > > -       depends on HWSPINLOCK
> > >         depends on ARCH_QCOM || COMPILE_TEST
> > >         select MFD_SYSCON
> > >         help
> > > @@ -30,7 +30,6 @@ config HWSPINLOCK_QCOM
> > >
> > >  config HWSPINLOCK_SIRF
> > >         tristate "SIRF Hardware Spinlock device"
> > > -       depends on HWSPINLOCK
> > >         depends on ARCH_SIRF || COMPILE_TEST
> > >         help
> > >           Say y here to support the SIRF Hardware Spinlock device, which
> > > @@ -43,7 +42,6 @@ config HWSPINLOCK_SIRF
> > >  config HWSPINLOCK_SPRD
> > >         tristate "SPRD Hardware Spinlock device"
> > >         depends on ARCH_SPRD || COMPILE_TEST
> > > -       depends on HWSPINLOCK
> > >         help
> > >           Say y here to support the SPRD Hardware Spinlock device.
> > >
> > > @@ -52,7 +50,6 @@ config HWSPINLOCK_SPRD
> > >  config HWSPINLOCK_STM32
> > >         tristate "STM32 Hardware Spinlock device"
> > >         depends on MACH_STM32MP157 || COMPILE_TEST
> > > -       depends on HWSPINLOCK
> > >         help
> > >           Say y here to support the STM32 Hardware Spinlock device.
> > >
> > > @@ -60,7 +57,6 @@ config HWSPINLOCK_STM32
> > >
> > >  config HSEM_U8500
> > >         tristate "STE Hardware Semaphore functionality"
> > > -       depends on HWSPINLOCK
> > >         depends on ARCH_U8500 || COMPILE_TEST
> > >         help
> > >           Say y here to support the STE Hardware Semaphore functionality, which
> > > @@ -68,3 +64,5 @@ config HSEM_U8500
> > >           SoC.
> > >
> > >           If unsure, say N.
> > > +
> > > +endif # HWSPINLOCK
> > > --
> > > 2.26.0.rc2
> > >
> >
> >
> > --
> > Baolin Wang
