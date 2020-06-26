Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F90C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EC820E65
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im1TNyjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgFZPdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgFZPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:33:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0AC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:33:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so9217982wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rpso9ySNKoLDGZyCP/hQvs97M6SXDiiUl7b7MavvpwM=;
        b=Im1TNyjYUqGtSxb3sVpOQyDfuWo+4jL/eqZNHs4NDDTYEFyid04tQdyu89ASBScZ4r
         wb24XBrOxce/WjPuyNXPXoUHQtfJiOu0kaAMJjR3M59cyn6Vkqe368y2feEo+qQEiBk1
         DGBfapEIfDFuUQ2BVVIu2qVIvQnFFinKhlLC/DFjzG2Vl42KM9ir4BThZQhjbOqbEaLn
         PIGe/3KXrsysRdikgnP8sEL3JiLrgrISIBIssg0wXfm9CiCOt594i2d+P+H+yy96DPWd
         chrGgttiyWu7uhIOKgZbaVf2bTgCFyCeXiE4mMc/P5bBOpgpq8XeNZk2VCtLj5y9RojH
         FdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rpso9ySNKoLDGZyCP/hQvs97M6SXDiiUl7b7MavvpwM=;
        b=JLX74GcKCdepLrDEnDQPAA/kGmLt9JH1CJ+FoduRL89tv8ZVBqzBcGd1UUNWFZjcMS
         wnS11q+hYGiMqROec9lvMtqV05KkMoQdf7wEGFCP0awBxG1N13ueC6wbUc0AAytS2o/P
         GvKJkmyPc2LJv2ZCFC5y+YQkMcoQ1sydMhbFa0FPfPIBqo/bD1esFZd2P00cGK1u9HpJ
         Dh+PFx8/Numc2XpvqzzUybyGd//39MNnH6zLmzvsCZ75q4hua5VuXOlrfuMMNW/0zzCV
         wO9GqO+aHAVdotEVdvA4KChFkBgxpF9/yiiHjvJLzCqpwLAzaIco+W0bejJ/JqFMtnvP
         WtEA==
X-Gm-Message-State: AOAM532ITjwdaCT5mK9FvTMv+4OkxQg6BQ9eMPxTVRBFY6xdRm067cpp
        debksE0cVMpcenzONkZ5rvKY8w==
X-Google-Smtp-Source: ABdhPJz9yrxY45T9SAy1cdsmEGjRTcOB+Cz9/AF+lu25KlsF3R66G6fdX+qT3KF8kVohKRgE/ySkTg==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr4112202wmy.79.1593185633299;
        Fri, 26 Jun 2020 08:33:53 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f16sm18168315wmh.27.2020.06.26.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:33:52 -0700 (PDT)
Date:   Fri, 26 Jun 2020 16:33:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: Re: [PATCH 3/8] backlight: ili922x: Add missing kerneldoc
 descriptions for CHECK_FREQ_REG() args
Message-ID: <20200626153351.GD177734@dell>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-4-lee.jones@linaro.org>
 <20200625094051.u4hanl3rycczlwiy@holly.lan>
 <20200625103334.GO954398@dell>
 <20200626095405.nzhqsfjegj6qg2ro@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626095405.nzhqsfjegj6qg2ro@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020, Daniel Thompson wrote:

> On Thu, Jun 25, 2020 at 11:33:34AM +0100, Lee Jones wrote:
> > On Thu, 25 Jun 2020, Daniel Thompson wrote:
> > 
> > > On Wed, Jun 24, 2020 at 03:57:16PM +0100, Lee Jones wrote:
> > > > Kerneldoc syntax is used, but not complete.  Descriptions required.
> > > > 
> > > > Prevents warnings like:
> > > > 
> > > >  drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 's' not described in 'CHECK_FREQ_REG'
> > > >  drivers/video/backlight/ili922x.c:116: warning: Function parameter or member 'x' not described in 'CHECK_FREQ_REG'
> > > > 
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > Cc: Software Engineering <sbabic@denx.de>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/video/backlight/ili922x.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> > > > index 9c5aa3fbb2842..8cb4b9d3c3bba 100644
> > > > --- a/drivers/video/backlight/ili922x.c
> > > > +++ b/drivers/video/backlight/ili922x.c
> > > > @@ -107,6 +107,8 @@
> > > >   *	lower frequency when the registers are read/written.
> > > >   *	The macro sets the frequency in the spi_transfer structure if
> > > >   *	the frequency exceeds the maximum value.
> > > > + * @s: pointer to controller side proxy for an SPI slave device
> > > 
> > > What's wrong with "a pointer to an SPI device"?
> > > 
> > > I am aware, having looked it up to find out what the above actually
> > > means, that this is how struct spi_device is described in its own kernel
> > > doc but quoting at that level of detail of both overkill and confusing.
> > 
> > I figured that using the official description would be better than
> > making something up.  However if you think it's better to KISS, then I
> > can change it.
> 
> Yes, I'd strongly prefer KISS here.
> 
> I know it is an "I am the world" argument[1] but I found using such a
> dogmatically accurate description out of context to be very confusing
> and therefore I don't think such a comment improves readability.
> 
> [1]: See #3 from http://www.leany.com/logic/Adams.html

It's fine, you are the world, I get it. ;)

Do you even like Country music?

Will fix!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
