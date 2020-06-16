Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35653C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1202E2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FDxXN5LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFPMLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPMK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:10:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A240C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:10:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q25so2829368wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QWjCps9FQO9o//U7Sgj6WRAuJJOpmMo6AsQMUTmG1I=;
        b=FDxXN5LNMQhJ+U0Lbq6FL19TnObJXisz0N6E5K81GMnjKG7EeF+tQDAYsgtjlv3k9j
         IvIzjcQoJM74t0X6StRdDHj06/FHTN9r/gtA7/R6eJicd3XRUrtXx5Ymiz/ATd+LroLA
         sRLA8+1uGBypwIpt7WFzdzF3fkQ4CAlYxyeRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5QWjCps9FQO9o//U7Sgj6WRAuJJOpmMo6AsQMUTmG1I=;
        b=D6Dr9af/Kyzpi8y7oeIj+N9PFb+PkC8xzApa07v0aAHF67pBbYZgFIBfVu5X2hRr6P
         sH9PMKf/xNpPme5GIpB2DAnZD3zXksvgJlFp+ASYnm6NCFupdXbCD4UnTl+vzSgvGDov
         E4YZ6ADS2ltoGbWfSfMPZqs/UJ+vqLKwL0vg8DsTQA2QuT66FII/4OHe1FHT0yer7gqN
         AtSbNPYr4ldGb+7F+L5d90H53aE5maJQ37AefzqXetMFM+R6RAVuVRN1J16Rp0Y+d9ya
         TF4n4alQSRjmBRt8K43Du2k64S81hTqma1aDFWZXNFfATN5sbaGc0bvHMmyt+L7sGFeo
         7KMg==
X-Gm-Message-State: AOAM530jhbq7KX61i6JKGxoNRUnq8YZHZqKYSHMLV7zf5ZcqfbV647O0
        6V0LlYM3a8JM3yp2hLGzELH4SA==
X-Google-Smtp-Source: ABdhPJzr5tEYt0yBuPjN1sXIbPUe6J1xRlewI7i+jrZI2ek42MJkm+CWMwjQCfntoJ1csgCZhjRLEQ==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr2984082wmj.149.1592309457330;
        Tue, 16 Jun 2020 05:10:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z16sm28964586wrm.70.2020.06.16.05.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:10:56 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:10:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu, wu000273@umn.edu,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] drm/bridge: fix reference count leaks due to
 pm_runtime_get_sync()
Message-ID: <20200616121054.GM20149@phenom.ffwll.local>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu, wu000273@umn.edu,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200614024005.125578-1-pakki001@umn.edu>
 <20200614134655.GA5960@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614134655.GA5960@pendragon.ideasonboard.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 04:46:55PM +0300, Laurent Pinchart wrote:
> Hi Aditya,
> 
> (CC'ing Rafael)
> 
> Thank you for the patch.
> 
> On Sat, Jun 13, 2020 at 09:40:05PM -0500, Aditya Pakki wrote:
> > On calling pm_runtime_get_sync() the reference count of the device
> > is incremented. In case of failure, decrement the
> > reference count before returning the error.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> I've seen lots of similar patches recently. Instead of mass-patching the
> drivers this way, shouldn't pm_runtime_get_sync() (and similar
> functions) decrease the refcount on their failure path ? That would
> require patching drivers that already handle this issue, but I believe
> that would cause less churn, and more importantly, avoid the issue once
> and for good for new code.

Yeah the current interface looks rather dodgy, generally drivers aren't
expected to clean up if the first function failed.

Rafael and Greg, what's your take on this here? See patch below and
Laurent's comment above.
-Daniel

> 
> > ---
> >  drivers/gpu/drm/bridge/cdns-dsi.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> > index 69c3892caee5..583cb8547106 100644
> > --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> > +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> > @@ -788,8 +788,10 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
> >  	u32 tmp, reg_wakeup, div;
> >  	int nlanes;
> >  
> > -	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
> > +	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
> > +		pm_runtime_put(dsi->base.dev);
> >  		return;
> > +	}
> >  
> >  	mode = &bridge->encoder->crtc->state->adjusted_mode;
> >  	nlanes = output->dev->lanes;
> > @@ -1028,8 +1030,10 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
> >  	int ret, i, tx_len, rx_len;
> >  
> >  	ret = pm_runtime_get_sync(host->dev);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		pm_runtime_put(host->dev);
> >  		return ret;
> > +	}
> >  
> >  	cdns_dsi_init_link(dsi);
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
