Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0DF20720
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YouvTwzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBCXeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:34:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCXeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:34:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so8441020pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CRRDli79xE8LIu9zwaoq3HKVinZzj5LHxKyaS7ghdP8=;
        b=YouvTwznNYnoG+2f/OterSj77UFSEOFMw8fwMy4fgu8UlXX9NqGegRgyVlR03x50We
         FP/q0O3sHzgvntfxYyBg/ek2TGSmWxioJoesvHnkq0JKFn00Lwb3xrAF1Um74dcW0EgL
         wOwMYY/JFtoFnGQSVcOLgbGm66oB1jSHBDf9+DgaIuNbwSJuRWuBex24sA2ynzcZsKds
         WZ9TknN93NjOzLZ5XZt/wf89dPpK/aO0ZgHtt/Q9hk+eYNtt3qX3moG3v9YoDr4+Yv3E
         4fCoq9dbluTJDPuy/V7jfA332en3wkv7YA7UDdhKS4BxIYH8paUvjBRRIPsJX1rYy8Pq
         2mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRRDli79xE8LIu9zwaoq3HKVinZzj5LHxKyaS7ghdP8=;
        b=Eu9wDrSRpd1RwoYWzwL6cOtIJgjQpUH2iLos+dk8FisI4hhvniMwnziQgRGwAnQqOA
         pUfv6UODJTlzLuO6XsUnsi+QpS30hKufPAtCl5lTkCUbf8K+ZySlNMTHQuWcW5di04lt
         wMbHCOcreacIL9lld99jVMmJBz+LTTMsTNyvURFpZaMqvmfZ1bperK6dN8xmWBikwm+e
         jRGVtMKF7w0X+4fIqaVobUuzAtF8Ff+jOUy+I3q8IwlnYuNs65fq8rOJz7UGEhjkFI3p
         fiCX4QBlLfz3F7BnAeP5D84fI8opWZzRhURnu/6Sb2Vy3LzNZmNq7Afb3qoFHLOTS+Ne
         c/Tw==
X-Gm-Message-State: APjAAAV+XCHev5xVrYXPMmUFHq+esT76dnfBiBg5De0LEfBubtDRN7gC
        89mPKJfFimNyC5l4uMT89wkwGA==
X-Google-Smtp-Source: APXvYqyD0yQtMSMVUy8QHav9nE32wkPgiPb4hwzH5mtiPqE1/LxdbmKtFgTTIVfpCqxgSMNoTDmxCw==
X-Received: by 2002:aa7:9f5e:: with SMTP id h30mr3472249pfr.137.1580772864660;
        Mon, 03 Feb 2020 15:34:24 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w131sm22329038pfc.16.2020.02.03.15.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 15:34:24 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:34:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 4/9] drm/bridge: ti-sn65dsi86: Config number of DP
 lanes Mo' Betta
Message-ID: <20200203233421.GD311651@builder>
References: <20191218223530.253106-1-dianders@chromium.org>
 <20191218143416.v3.4.If3e2d0493e7b6e8b510ea90d8724ff760379b3ba@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218143416.v3.4.If3e2d0493e7b6e8b510ea90d8724ff760379b3ba@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Dec 14:35 PST 2019, Douglas Anderson wrote:

> The driver used to say that the value to program into bridge register
> 0x93 was dp_lanes - 1.  Looking at the datasheet for the bridge, this
> is wrong.  The data sheet says:
> * 1 = 1 lane
> * 2 = 2 lanes
> * 3 = 4 lanes
> 
> A more proper way to express this encoding is min(dp_lanes, 3).
> 
> At the moment this change has zero effect because we've hardcoded the
> number of DP lanes to 4.  ...and (4 - 1) == min(4, 3).  How fortunate!
> ...but soon we'll stop hardcoding the number of lanes.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Rob Clark <robdclark@gmail.com>
> Reviewed-by: Rob Clark <robdclark@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index ab644baaf90c..d55d19759796 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -523,7 +523,7 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
>  			   CHA_DSI_LANES_MASK, val);
>  
>  	/* DP lane config */
> -	val = DP_NUM_LANES(pdata->dp_lanes - 1);
> +	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
>  	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
>  			   val);
>  
> -- 
> 2.24.1.735.g03f4e72817-goog
> 
