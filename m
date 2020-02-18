Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587DDC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3271622B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dvVr1s0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRTMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:12:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBRTMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:12:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so25334365wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jyp8LuSwA2auMcPCoIUKAuOfKUtLNBBbLjy1dsWtP7E=;
        b=dvVr1s0bycacg+In0wqQrojmPadziJAieySvCzTBv8iEY3pya7QSEzaG8fmXsMyZ1F
         3IhF7xoYN0ngRC94yTjPapg5nEKCwIpwmNUFUUPOUGETufFc+1rLMVyreHwB1g9YmOLc
         vgUkXYX5qVv/kiNBz82f2Qh7LzoPzZg6tZN9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Jyp8LuSwA2auMcPCoIUKAuOfKUtLNBBbLjy1dsWtP7E=;
        b=f1VamcTbg2lyU7NfXLNVaKZENMM+W3X93OdDwSDuA4hK+QhdSYew0ewp1qJeBsy7QK
         XApt7LQJgIpTV2SvXAioagM9GhVQ9CPDVW5QPrhjZ6wqTs3wuXLEkbygFjBm8N71drhh
         avSo1/LovLqMkqM+zHsEDTPF7uNEk85DSy58VI8hxlV57GfKAQQMpKDh4IQ7QGgCcVHQ
         9/Ibgz5F5B0sqOEgdtm2keGJmfzHzZlS+Rxmb8kCtdBqql0ptiJaT/WfvjYCrQr6IJ/w
         ZcwRdEOcad0H2986nQqMK8P+k9mQ0WDiZ+n8zcVhpDZ81XcI3DVI+M1MMU4A00EP4cMM
         IOew==
X-Gm-Message-State: APjAAAVIl6tjtBfojDg9IMDOQEVujT4+77kHOoi8HHk2Ht6JM2fOho2P
        adrbQHQXh+0KGTk0KhXXxfsPTw==
X-Google-Smtp-Source: APXvYqxClT746r2h9FGB0TvTr/y3V4FBjmNT1dRxRA9afN+AEr+lZCNRD9Ez91YSU3sZzckAyCqHug==
X-Received: by 2002:adf:8296:: with SMTP id 22mr31045914wrc.352.1582053172339;
        Tue, 18 Feb 2020 11:12:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z21sm4519847wml.5.2020.02.18.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:12:51 -0800 (PST)
Date:   Tue, 18 Feb 2020 20:12:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] drm/bridge: analogix-anx78xx: Fix drm_dp_link
 helper removal
Message-ID: <20200218191249.GO2363188@phenom.ffwll.local>
Mail-Followup-To: Torsten Duwe <duwe@lst.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200218155744.9675368BE1@verein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218155744.9675368BE1@verein.lst.de>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 04:57:44PM +0100, Torsten Duwe wrote:
> drm_dp_link_rate_to_bw_code and ...bw_code_to_link_rate simply divide by
> and multiply with 27000, respectively. Avoid an overflow in the u8 dpcd[0]
> and the multiply+divide alltogether.
> 
> fixes: ff1e8fb68ea06027 ("analogix-anx78xx: Avoid drm_dp_link helpers")
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Since same company I'm assuming Thomas Zimmermann will take care of these
patches for you. Or you need to ping maintainers again to push these for
you.

Also if you expect to regularlay contribut drm patches, just ask for
commit rights after 5-10 patches landed.

Cheers, Daniel

> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---
> https://patchwork.freedesktop.org/patch/343003/ (dropped the review mark)
> https://lists.freedesktop.org/archives/dri-devel/2020-January/253535.html
> 
> ---
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 41867be03751..864423f59d66 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -722,10 +722,9 @@ static int anx78xx_dp_link_training(struct anx78xx *anx78xx)
>  	if (err)
>  		return err;
>  
> -	dpcd[0] = drm_dp_max_link_rate(anx78xx->dpcd);
> -	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
>  	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0],
> -			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
> +			   SP_DP_MAIN_LINK_BW_SET_REG,
> +			   anx78xx->dpcd[DP_MAX_LINK_RATE]);
>  	if (err)
>  		return err;
>  

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
