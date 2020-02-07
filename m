Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35122C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D88E21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KweCKsSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGNpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:45:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41348 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBGNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:45:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so2740457wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=W87WpaWUIMWEzf16nCu+kjtH/ULuExTweZWvlCZh9vo=;
        b=KweCKsSYFAeEB8nkF2obgfg6/ji+M1HIeZdvJCMGXICAfr2WhJFKLKFY1ccTotWH5i
         QnIpv+zv4NCsTq9wipeq9t/HGWV8bi2Bv4RjZTg34Xpm3yZNX9e7u7f72C+UYWhe/dm2
         RPbST5HLM1/etiFYjk3X24aJW/pKXWdcu5lmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=W87WpaWUIMWEzf16nCu+kjtH/ULuExTweZWvlCZh9vo=;
        b=LsbfVlrkZQpULPMelQqHZKAgBZR/WiOuXIZPy5vSGk0KVyNa9Mf6N72cjxHLaaJv81
         eRZuVLjKhtkDGNNrwILqS9w3kBahIcogsfDKC4yYyMueUA0PbOsfbjfj8bPjOkI99eOG
         XXu022M8XKHoBUiiLDNbwxA6gcK/g1pyjizxwnk3+HY1izvC1/7a+2LrJc4JW/4fz4sq
         rIejhm8DyP5Rgi2CtKOaIOuQBQHfjoqH3FI+RQQVTjELPOGaRktXHU3hPeDcG9DTb3mj
         2K13qSPk6V72guaFSpogDP0tMyUHoumRFRwxgJeLgCEt+FeGqfCRWnYARg1/roydKXpS
         m9PQ==
X-Gm-Message-State: APjAAAU8BTCm5j+QHA9BIGo41WGFMR4JTNsxvzqiG4Yg4c9tHox1Qq3A
        D13b4310YvKxHrvL4YpYHZtyhQ==
X-Google-Smtp-Source: APXvYqxxNjn3TBVZ2sWHL8lxLoKYhY0lLxey0dpUSCuua134oriUvSkdZsxS7RB5Ee1iiSAGU8jz/g==
X-Received: by 2002:adf:db48:: with SMTP id f8mr4594950wrj.146.1581083138401;
        Fri, 07 Feb 2020 05:45:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a5sm3399500wmb.37.2020.02.07.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:45:37 -0800 (PST)
Date:   Fri, 7 Feb 2020 14:45:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bochs: deinit bugfix
Message-ID: <20200207134536.GC43062@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200207124348.21641-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207124348.21641-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:43:48PM +0100, Gerd Hoffmann wrote:
> Check whenever mode_config was actually properly
> initialized before trying to clean it up.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Really need to get managed drm cleanup going ...
-Daniel
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index cc93ff74fbd8..3a755c911342 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -164,6 +164,9 @@ int bochs_kms_init(struct bochs_device *bochs)
>  
>  void bochs_kms_fini(struct bochs_device *bochs)
>  {
> +	if (!bochs->dev->mode_config.num_connector)
> +		return;
> +
>  	drm_atomic_helper_shutdown(bochs->dev);
>  	drm_mode_config_cleanup(bochs->dev);
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
