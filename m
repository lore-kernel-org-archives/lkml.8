Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6745720714
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="itHGOg+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHVKtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHVKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 06:49:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD4C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 03:49:16 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C84E329E;
        Sat, 22 Aug 2020 12:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1598093351;
        bh=6ZFChGwd762tCp/370F4TKuD3RwxOvJ1DZ6OuHN5zuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itHGOg+ZIvnoNWi+pGYY56X7MbWkLwzzVhseWqf3t6LdEpx0eM0qu9Jwnx1mYU0LA
         inxtDv8xCDX5FDPhV299gaj36blqWuqmApICGtJHTi6PcK+Pcqg05ap06jxodZY3WJ
         RWte8cGrZs4xZQcPxiSDaIOA9a2tzD2ic4DSQcLI=
Date:   Sat, 22 Aug 2020 13:48:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        zhengbin <zhengbin13@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omap: Fix runtime PM imbalance in dsi_runtime_get
Message-ID: <20200822104852.GA5966@pendragon.ideasonboard.com>
References: <20200821074506.32359-1-dinghao.liu@zju.edu.cn>
 <5123d7ae-f491-d2d2-788d-b5250ae9e31d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5123d7ae-f491-d2d2-788d-b5250ae9e31d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Fri, Aug 21, 2020 at 03:06:59PM +0300, Tomi Valkeinen wrote:
> On 21/08/2020 10:45, Dinghao Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter
> > even when it returns an error code. However, users of
> > dsi_runtime_get(), a direct wrapper of pm_runtime_get_sync(),
> > assume that PM usage counter will not change on error. Thus a
> > pairing decrement is needed on the error handling path to keep
> > the counter balanced.
> > 
> > Fixes: 4fbafaf371be7 ("OMAP: DSS2: Use PM runtime & HWMOD support")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > index eeccf40bae41..973bfa14a104 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > @@ -1112,8 +1112,11 @@ static int dsi_runtime_get(struct dsi_data *dsi)
> >  	DSSDBG("dsi_runtime_get\n");
> >  
> >  	r = pm_runtime_get_sync(dsi->dev);
> > -	WARN_ON(r < 0);
> > -	return r < 0 ? r : 0;
> > +	if (WARN_ON(r < 0)) {
> > +		pm_runtime_put_noidle(dsi->dev);
> > +		return r;
> > +	}
> > +	return 0;
> >  }
> 
> Thanks! Good catch. I think this is broken in all the other modules in omapdrm too (e.g. dispc.c,
> venc.c, etc).
> 
> Would you like to update the patch to cover the whole omapdrm?

Just for yoru information, there has been quite a few similar patches
submitted all across the kernel. I believe this is an issue of the
pm_runtime_get_sync() API, which really shouldn't require a put() when
it fails. For drivers that really don't expect pm_runtime_get_sync() to
fail (no I2C access to a regulator for instance, only SoC-internal
operations) I've instead decided to ignore the error completely. I don't
think poluting the whole kernel code base with this kind of "fixes" is a
good idea.

-- 
Regards,

Laurent Pinchart
