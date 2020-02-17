Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B6C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Hh/ThQir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgBQJaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:30:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37776 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBQJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:30:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so17604364wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 01:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKg7XiJ/GLLJjLdRvNSgFQgROKwiVOwcJdz0oi8UtDo=;
        b=Hh/ThQirk64sRarp4K2nfV4nfY4B76979U0ugyExyBI6OMsR6In8ElqUATCwZqCdax
         4DbZZbbZy0qQorECO3iNk49pN/U8GtlYX9MAwIE5xOyu8DqGOJp/3Nr4IOBYt0Mj1vLq
         Xt5uRZwZaShRcNvwJRR1hZ7srQe75Ho9rUyQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zKg7XiJ/GLLJjLdRvNSgFQgROKwiVOwcJdz0oi8UtDo=;
        b=T3LPVzYPjxK720k0Zo8v7GNEfKjdPtjnhP9HZbc/SPLKpoPYtTSBjQ1o6GQBDGYlPC
         8zqWpCcuK4LPZBi16FQ8LmzD3iz2Z2Vrud3RymGY1fpkwauCG58HsOdNdUeyzx3+Xepo
         2sP8GyBSTxdX0dXCwmjD4t1Jilr6h9kAJe8POxSwHqTF+NNsr0vtuJ5SOv9Iwr+RgMdz
         H7M3OIjNTun4txQJuamAybbtUfccWEyKOGZWk1bxxQ4OzlSadiXjsLfi5AQBeXZHc3Dp
         RNjp7T0Nb2XAXzpLCYneEi/3uMk6cd1TQWZN8wnnoxsC1IIzYiIKPGJLweGJRrrrfXU2
         QEVQ==
X-Gm-Message-State: APjAAAUmNIMRHPbieLWcUwvVfJBfltbVkaVhUXkthA986NlTYZKBc9Hg
        vRucbH++dGb4zrUvqQBq8fCd2w==
X-Google-Smtp-Source: APXvYqykVR15o/hfxeC2vzZ33YgzV4NVTjQMaDTRPmaqE/aR1B/Va/SX6ImZfiG9GAu0dPqCvPPmoA==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr21088262wmc.122.1581931804205;
        Mon, 17 Feb 2020 01:30:04 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a62sm20406877wmh.33.2020.02.17.01.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:30:03 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:30:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] gpu/drm: ingenic: Switch emulated fbdev to 16bpp
Message-ID: <20200217093001.GG2363188@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200216155811.68463-1-paul@crapouillou.net>
 <20200216155811.68463-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216155811.68463-2-paul@crapouillou.net>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 12:58:10PM -0300, Paul Cercueil wrote:
> The fbdev emulation is only ever used on Ingenic SoCs to run old SDL1
> based games at 16bpp (rgb565). Recent applications generally talk to
> DRM directly, and can request their favourite pixel format; so we can
> make everybody happy by switching the emulated fbdev to 16bpp.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index 034961a40e98..9aa88fabbd2a 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -808,7 +808,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  		goto err_devclk_disable;
>  	}
>  
> -	ret = drm_fbdev_generic_setup(drm, 32);
> +	ret = drm_fbdev_generic_setup(drm, 16);

If you're really bored, could we make everyone even more happy by exposing
format switching in the drm fbdev emulation? Only for the drivers which
have a full format list on the primary plane (gets too tricky otherwise).
And obviously only formats that have lower bpp than the one we booted with
(can't reallocate the framebuffer because fbdev).

Just as an idea, this shouldn't be too horrible amounts of work to wire
up. But ofc more than this oneliner :-)

Cheers, Daniel

>  	if (ret)
>  		dev_warn(dev, "Unable to start fbdev emulation: %i", ret);
>  
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
