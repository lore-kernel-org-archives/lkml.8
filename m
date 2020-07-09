Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D642065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="HMkT8gZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGIGwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGIGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:52:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7097C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 23:51:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so1102771eja.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qC6ikPyAkkZDEb9ir5eEV2kSBTjyBB0hcPesB8iDBzU=;
        b=HMkT8gZtcPJUF8GcOk4mhQA0XzCuo24QFbpsy/EQ++/a9dyIEzXHW5pWoHG+rdOYsm
         xoxASy9VtzcGgvTPgxN+Wxa8/m7Axkq2Hi3BJ94g6Vl5qwmM3gKpwebpczBWGvJBlIRK
         rzMZrOsMRep1fyOEpevHPW43USm2kdy7jah/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qC6ikPyAkkZDEb9ir5eEV2kSBTjyBB0hcPesB8iDBzU=;
        b=XeO5CTtkMKKsYIyORShuAib6u952pAplRxYLUmxwkMMXUZgSsWkuhEWN28eR4TXwHW
         n2aZfONEz+tI3C4o2iEn/Lb+j1FSFWHsil9MVlOnDIhMBQGyLA2pR24s5900G4EURoEH
         EDSGBLljECTLGLrHZ+z8vqmgBNSh3aK7qr5VplD2vX6fzgjFdHUu5ovPDmSWPualq3Um
         pEt1ucgZ4X47hWqPSs2R8gLTOoOFBNSMmDehcl4LQnEF/yZKEq/JSwr0TMXDwBBJShY9
         rB3mzbkp4YTNsDm089oaHdZJlnHmQDf8SBbdBWrI2vBK5WiH6kPGRbUftQ6hGOy18O4J
         H4bA==
X-Gm-Message-State: AOAM532Lj5NaEkQxzlke/UdXvY21lIb8yDjFjsjDmO7CxHi7J0ZnzuX2
        a/NlQY+zw7mYCvTgKHpjrR1CfTv67LfdcZFYa6eUHds9
X-Google-Smtp-Source: ABdhPJyk8qb4D04v5BrhicG+Xy3FGlw4wqFYNSQErh6C94HtP/sa7EmHdq4CIsCgiOB3EWMM+rqGoeThfN/1ns6BMRk=
X-Received: by 2002:a17:906:1455:: with SMTP id q21mr38382187ejc.139.1594277518385;
 Wed, 08 Jul 2020 23:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200701001002.74997-1-linux@roeck-us.net> <20200701091021.GA266726@ravnborg.org>
In-Reply-To: <20200701091021.GA266726@ravnborg.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 9 Jul 2020 06:51:46 +0000
Message-ID: <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>
Subject: Re: [PATCH] drm/aspeed: Call drm_fbdev_generic_setup after drm_dev_register
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>
Cc:     Guenter Roeck <linux@roeck-us.net>, g@ravnborg.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 09:10, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Guenter.
>
> On Tue, Jun 30, 2020 at 05:10:02PM -0700, Guenter Roeck wrote:
> > The following backtrace is seen when running aspeed G5 kernels.
> >
> > WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fbdev_generic_setup+0x138/0x198
> > aspeed_gfx 1e6e6000.display: Device has not been registered.
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
> > Hardware name: Generic DT based system
> > Backtrace:
> > [<8010d6d0>] (dump_backtrace) from [<8010d9b8>] (show_stack+0x20/0x24)
> > r7:00000009 r6:60000153 r5:00000000 r4:8119fa94
> > [<8010d998>] (show_stack) from [<80b8cb98>] (dump_stack+0xcc/0xec)
> > [<80b8cacc>] (dump_stack) from [<80123ef0>] (__warn+0xd8/0xfc)
> > r7:00000009 r6:80e62ed0 r5:00000000 r4:974c3ccc
> > [<80123e18>] (__warn) from [<80123f98>] (warn_slowpath_fmt+0x84/0xc4)
> > r9:00000009 r8:806a0140 r7:000008b9 r6:80e62ed0 r5:80e631f8 r4:974c2000
> > [<80123f18>] (warn_slowpath_fmt) from [<806a0140>] (drm_fbdev_generic_setup+0x138/0x198)
> > r9:00000001 r8:9758fc10 r7:9758fc00 r6:00000000 r5:00000020 r4:9768a000
> > [<806a0008>] (drm_fbdev_generic_setup) from [<806d4558>] (aspeed_gfx_probe+0x204/0x32c)
> > r7:9758fc00 r6:00000000 r5:00000000 r4:9768a000
> > [<806d4354>] (aspeed_gfx_probe) from [<806dfca0>] (platform_drv_probe+0x58/0xa8)
> >
> > Since commit 1aed9509b29a6 ("drm/fb-helper: Remove return value from
> > drm_fbdev_generic_setup()"), drm_fbdev_generic_setup() must be called
> > after drm_dev_register() to avoid the warning. Do that.
> >
> > Fixes: 1aed9509b29a6 ("drm/fb-helper: Remove return value from drm_fbdev_generic_setup()")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> I thought we had this fixed already - but could not find the patch.
> Must have been another driver then.
>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> I assume Joel Stanley will pick up this patch.

I do not have the drm maintainer tools set up at the moment. Could one
of the other maintainers put this in the drm-misc tree?

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

>
>         Sam
>
> > ---
> >  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > index 6b27242b9ee3..bca3fcff16ec 100644
> > --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> > @@ -173,8 +173,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
> >
> >       drm_mode_config_reset(drm);
> >
> > -     drm_fbdev_generic_setup(drm, 32);
> > -
> >       return 0;
> >  }
> >
> > @@ -225,6 +223,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto err_unload;
> >
> > +     drm_fbdev_generic_setup(&priv->drm, 32);
> >       return 0;
> >
> >  err_unload:
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
