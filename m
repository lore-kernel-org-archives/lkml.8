Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB895C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA532054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F6bo7NYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgENMfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:35:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14009C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:35:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l17so3859560wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMPqMUXRJ8HR36qud+AQIGafh+ptP/rX40+2ncxDmps=;
        b=F6bo7NYBe8KlL8c5Ee5aZ3Fg6TDASmUyQ2bsdJYvKKA5SUkjt3AsX9lByXqMhuh+aC
         1ocMJpC31cdVZNrN3tOfvow84NlAHBcY8fxofiZ/7pZwacMzcJpi/7gkm2Emn4P37tS2
         el5KCGCtum90arsPqhHV8s+udsUfg0+fmG6iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cMPqMUXRJ8HR36qud+AQIGafh+ptP/rX40+2ncxDmps=;
        b=S2yfFKu3A8z1jU2LZHcj2FqGlN7nShi4W44NZmG0TQROsJylloyKcdSEIGZZ1xRyhK
         MCbAu7cCLyzg3LnhbUzD2xQvaUrhIWFFSIXoh9Fe6TsODoVc0w7uinvhiS9CiQLOWEZM
         lESS+LM7ausGZVqeQDg1nSi4+Rs+VUFa/Dbq37oqJ2fRqFAVBs6FREsPJ41wYxiy+cBl
         C8Kv9tPBMnt5vFCQjSaAqPG8SYuDwMLzHwMI4GcuVJddJ+9m+/ap0EBRUB1wYnJf9mek
         tDmsvagDmG13CoHsCQno+SuU55LxwJ1XjiRV3K0CzJyrhJL66WicpaZPqWrOB8zzePVg
         Kgqg==
X-Gm-Message-State: AOAM5310lp0nXXKvemoqh89PYzaPKJLSXK49lp1vqEO4GB9dH8bmUpM8
        WJ6w/zbJM1TxoSgtfr4iUAkWHA==
X-Google-Smtp-Source: ABdhPJwmonACH5Sm2rDdGYdlIeF/qAIci3tHAGRz7t2FPWQSo5MIFYNXGt6XqqtCZJDu4Hp1J6/jhA==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr5369336wrn.266.1589459721770;
        Thu, 14 May 2020 05:35:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m3sm3804163wrn.96.2020.05.14.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 05:35:20 -0700 (PDT)
Date:   Thu, 14 May 2020 14:35:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: remove outdated and noisy output
Message-ID: <20200514123518.GS206103@phenom.ffwll.local>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200513201016.23047-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513201016.23047-1-wsa+renesas@sang-engineering.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:10:16PM +0200, Wolfram Sang wrote:
> The R-Car DU driver calls drm_vblank_init via some helper functions in
> probe(). From what I checked, most drivers do this as well. I have a
> config now where DU always stays in deferred_probe state because of a
> missing dependency. This means that every time I rebind another driver
> like MMC, the vblank init message is displayed again when the DU driver
> is retried. Because the message doesn't really carry a useful
> information, I suggest to simply drop it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Makes sense, queued up in drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/drm_vblank.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index da7b0b0c1090..ce9bed24c2da 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -483,8 +483,6 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
>  		seqlock_init(&vblank->seqlock);
>  	}
>  
> -	DRM_INFO("Supports vblank timestamp caching Rev 2 (21.10.2013).\n");
> -
>  	return 0;
>  
>  err:
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
