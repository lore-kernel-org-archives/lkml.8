Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0462FC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8F3214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgALUWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 15:22:16 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:32918 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733252AbgALUWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 15:22:16 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6BEE6804EB;
        Sun, 12 Jan 2020 21:22:08 +0100 (CET)
Date:   Sun, 12 Jan 2020 21:22:07 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm_panel: fix export of drm_panel_of_backlight, try
 #3
Message-ID: <20200112202207.GB24849@ravnborg.org>
References: <20200107203231.920256-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107203231.920256-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=0Qoab_-yLbQqVm7gteMA:9 a=CjuIK1q_8ugA:10 a=Z5ABNNGmrOfJ6cZ5bIyy:22
        a=bWyr8ysk75zN3GCy5bjg:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd.

On Tue, Jan 07, 2020 at 09:32:19PM +0100, Arnd Bergmann wrote:
> Making this IS_REACHABLE() was still wrong, as that just determines
> whether the lower-level backlight code would be reachable from the panel
> driver. However, with CONFIG_DRM=y and CONFIG_BACKLIGHT_CLASS_DEVICE=m,
> the drm_panel_of_backlight is left out of drm_panel.o but the condition
> tells the driver that it is there, leading to multiple link errors such as
> 
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sitronix-st7701.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sharp-ls043t1le01.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-seiko-43wvf1g.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-ronbo-rb070d30.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-rocktech-jh057n00900.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.ko] undefined!
> 
> Change the condition to check for whether the function was actually part
> of the drm module. This version of the patch survived a few hundred
> randconfig builds, so I have a good feeling this might be the last
> one for the export.
> 
> Fixes: 4a34a9dcec94 ("drm/drm_panel: Fix EXPORT of drm_panel_of_backlight() one more time")
> Fixes: 907aa265fde6 ("drm/drm_panel: fix EXPORT of drm_panel_of_backlight")
> Fixes: 152dbdeab1b2 ("drm/panel: add backlight support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I spent some hours this weekend trying to improve the Kconfig
logic around BACKLIGHT_CLASS_DEVICE and ACPI_VIDEO.

I did manage to change something but I did not manage to make something
that is a real improvement to the current situation.
So everything abandoned.

As we need this fixed I have applied your patch to drm-misc-next.
Thanks,

	Sam

> ---
>  include/drm/drm_panel.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 121f7aabccd1..6193cb555acc 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -198,7 +198,8 @@ static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
>  }
>  #endif
>  
> -#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +#if IS_ENABLED(CONFIG_DRM_PANEL) && (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> +	(IS_MODULE(CONFIG_DRM) && IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE)))
>  int drm_panel_of_backlight(struct drm_panel *panel);
>  #else
>  static inline int drm_panel_of_backlight(struct drm_panel *panel)
> -- 
> 2.20.0
