Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F55C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D393208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CEhHuPS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgEHHIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgEHHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:08:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D1C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:08:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so585726wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmTzp+J4aS4CxYYhCILNVwYfVehwX/dqCJCx5jKGlEM=;
        b=CEhHuPS/Sdlv7SlOF1Hc4wrg/jxQ0bfVMANuWCZjoRc8dNc/HsdgEoZO7HGBHXwoaf
         ruEIoF3gHK5AY6lSz66A+ROgs5JDNmxQyX5jJA9tVa0h0eLsOpexhZTVa8lNea46FiWB
         /GPsBiQ9zAcTAkVD8gFbnjr8OjE1EkxiL9eto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DmTzp+J4aS4CxYYhCILNVwYfVehwX/dqCJCx5jKGlEM=;
        b=kvQXzwLegRSpDpp906OQRMW9fu5LhRtV09RdpCD7UCi/+b7wyZEavT9EoDrt8y2SQb
         fh39S5wf6BgbgyjS7RfIcG2pDkUyrAnfNp0/1lVmBpvQ0JV9IVE4AkNbaQ73qrSS1Zop
         tG9lPCZQwVYzXRuWX5g4Kot/HlY+GZJvGvNWqOH+TW38+VGO76OhTXiSGY6mL5Pd63Gs
         kodi1TjcvXzXHUpjzcV+QZil96ekTNzDerfZEqnpofI9eYiJgZ91tO1GDB9Cu11OVMpu
         8XVTB/u+UShqVIjw4VhflMAEpcha6Eq/P8LXWfjjn/d6XGwRaH/jyjU1v4iaywR8AnYr
         h0Kw==
X-Gm-Message-State: AGi0PublbzuIRYRkKccOWo8GBIBdyNZbu4ZnEWB4NMpC7laicHLMScxL
        rOiJdR8Q8pBhMk8ou0WYVq2CLQ==
X-Google-Smtp-Source: APiQypIdXHZDbCY1mjOHI7A02KN/NFXcXdx0OSG3FPCPhGoilD6eSlbRaDrFn+uMA+JdV38nVB2Qsw==
X-Received: by 2002:adf:e791:: with SMTP id n17mr1265834wrm.217.1588921720359;
        Fri, 08 May 2020 00:08:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s24sm12302509wmj.28.2020.05.08.00.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:08:39 -0700 (PDT)
Date:   Fri, 8 May 2020 09:08:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: remove redundant initialization to variable
 'start'
Message-ID: <20200508070837.GF1383626@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200507202237.64350-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507202237.64350-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 09:22:37PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable 'start' is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 902938d2568f..b0b9cb1ec18f 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1150,7 +1150,7 @@ static bool exynos_dsi_transfer_finish(struct exynos_dsi *dsi)
>  {
>  	struct exynos_dsi_transfer *xfer;
>  	unsigned long flags;
> -	bool start = true;
> +	bool start;
>  
>  	spin_lock_irqsave(&dsi->transfer_lock, flags);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
