Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9252072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="r+YcyHmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHVBUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgHVBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:20:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFD2C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:20:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h21so2529144qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=alqsuLjRIbrXdAlbW9c5s4ZuhliUbHIiXWeuZS/UsUs=;
        b=r+YcyHmi3Ads0IkAGbm6Tg7P9IhT1PkYzo3vq5csouLShpbtuxhXK9HpZilSnPjShT
         HBCzedlhq9HehZ+1ohCVUxuoySSAN7sG7EX+3276XxYxNoq1sQ6K2mILIazpXJ6rD54I
         d0WdsaaWUCHtoeYeOzMLONgoeMnuBgau7T2AFLc0QaSihvWaL6df0UKMAp5avYCmUdzj
         znphFfwkX2pKhKn9kt4JI3mRvb/fK0vYZLooarVtDoqd4v9Uw1hqzKokv8ZWCZTyGqCj
         8FfHNinLZ5lkgB1V/7cOejmLMtzUgmOggUlIL3kZFLkrg4p2PwdYuB6DAjUg4X67zMts
         G3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=alqsuLjRIbrXdAlbW9c5s4ZuhliUbHIiXWeuZS/UsUs=;
        b=SVafoSWgcTn/ruH+LFeDlfA6CPD5jaKJcAzoyLPqQ9pUyysZmqQANLKgyPQ72rVVSr
         EkppAot0bjT7wJKU+KiRPxuxjQ07Tz027W8ScTe1SFhJuWJCZjHJrtULBxvB8PZTkRQi
         NVjo25Jaq6bceEtgwL7VSSGk+aRlgG6F5eGJzd02BI/jSQh5n2kAWdGQnlq51i+RK4/x
         k5k5LFpgSHSiOo/IDxbM9+yih0JD/SE4TvJkTgts9kFMo85CS4jix4SiHx1gM7rd7mCm
         t2/GSK3vza+jYXg6C+w12fEV9rzFYwOXeJsnFswwf44tzx1WPbAe7nwMy6JJKu8J19DG
         LbMA==
X-Gm-Message-State: AOAM532ieSJnzVwAPa7mAsSi6QKzzSWJX63mdkixUd2WGlI8rSsH4U2u
        Wy/BLU3QjGh01fJmyGHL58CTcs/Ce0zqVQ==
X-Google-Smtp-Source: ABdhPJxeDssrajw6JuftjZhYmAJqOu1G4f1+FhQrVW3m1ZYoHj7OW72Xb2a+KA1xkh/G9V0FMhugVA==
X-Received: by 2002:ac8:78d:: with SMTP id l13mr5351576qth.188.1598059244689;
        Fri, 21 Aug 2020 18:20:44 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w2sm3150752qkf.6.2020.08.21.18.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 18:20:44 -0700 (PDT)
Date:   Fri, 21 Aug 2020 21:20:37 -0400
From:   Qian Cai <cai@lca.pw>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/rcar-du: DRM_RCAR_WRITEBACK depends on DRM
Message-ID: <20200822012036.GA26224@lca.pw>
References: <20200608025340.3050-1-cai@lca.pw>
 <20200608031442.GP22208@pendragon.ideasonboard.com>
 <20200608031622.GQ22208@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608031622.GQ22208@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:16:22AM +0300, Laurent Pinchart wrote:
> Hi Qian,
> 
> I forgot to mention, I think the subject line should be
> 
> drm/rcar-du: Make DRM_RCAR_WRITEBACK depend on DRM_RCAR_DU
> 
> Could you please let me know if you're OK with these two small changes ?

Laurent, this patch is still not in the latest linux-next. Can you take a look?

> 
> On Mon, Jun 08, 2020 at 06:14:43AM +0300, Laurent Pinchart wrote:
> > On Sun, Jun 07, 2020 at 10:53:40PM -0400, Qian Cai wrote:
> > > There is no need to select DRM_RCAR_WRITEBACK if DRM=n which just make
> > 
> > s/DRM=n/DRM_RCAR_DU=n/ here.
> > 
> > > the generated .config a bit ugly.
> > > 
> > >  # ARM devices
> > >  #
> > >  # end of ARM devices
> > > 
> > >  CONFIG_DRM_RCAR_WRITEBACK=y
> > > 
> > >  #
> > >  # Frame buffer Devices
> > > 
> > > Let DRM_RCAR_WRITEBACK depend on DRM_RCAR_DU instead.
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > No need to submit a v3 if you agree with the above change, I'll fix it
> > in my tree.
> > 
> > > ---
> > >  drivers/gpu/drm/rcar-du/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
> > > index 0919f1f159a4..3304b41f5611 100644
> > > --- a/drivers/gpu/drm/rcar-du/Kconfig
> > > +++ b/drivers/gpu/drm/rcar-du/Kconfig
> > > @@ -48,3 +48,4 @@ config DRM_RCAR_VSP
> > >  config DRM_RCAR_WRITEBACK
> > >  	bool
> > >  	default y if ARM64
> > > +	depends on DRM_RCAR_DU
> 
> -- 
> Regards,
> 
> Laurent Pinchart
