Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF05C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A7820768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qoYyJyh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgDHUBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:01:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34952 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:01:53 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9613159E;
        Wed,  8 Apr 2020 22:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586376111;
        bh=61QBxElcESJR0QqO2K++tyWrWFyA7zoUCeDLp6hC+aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoYyJyh+jqyAYLHY0BVUnl3jCFhNUaTaNTUhldIrMbPqukGr0bP38btQyrpHhVjBa
         cKxx8DIgd3DkTUzF9sxryDEAlfYD3P1dbHsaqiO2TYGXuzYFk3XpsWfdB3ponKZ39S
         pr5AIEYTQWPD3vfSFXkdUtoYt+qCDGop56gP/FN0=
Date:   Wed, 8 Apr 2020 23:01:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-fbdev@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] fbdev: mx3fb: const pointer to ipu_di_signal_cfg
Message-ID: <20200408200141.GM4881@pendragon.ideasonboard.com>
References: <20200408162551.3928330-1-arnd@arndb.de>
 <87pnchhp2s.fsf@intel.com>
 <20200408180216.GC24828@ravnborg.org>
 <20200408182926.GA21997@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408182926.GA21997@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Wed, Apr 08, 2020 at 08:29:26PM +0200, Sam Ravnborg wrote:
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> and
> Jani Nikula <jani.nikula@intel.com> both
> suggested to make the pointer to struct ipu_di_signal_cfg const.
> 
> Fix this.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Fixes: 3f6c93ec9254 ("fbdev: mx3fb: avoid warning about psABI change")
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Enrico Weigelt <info@metux.net>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org

Assuming this is compile-tested,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Again, sorry. I should have waited a day before applying.
> 
> 	Sam
> 
>  drivers/video/fbdev/mx3fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index e13fea3a292f..603731a5a72e 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  			  uint16_t h_start_width, uint16_t h_sync_width,
>  			  uint16_t h_end_width, uint16_t v_start_width,
>  			  uint16_t v_sync_width, uint16_t v_end_width,
> -			  struct ipu_di_signal_cfg *sig)
> +			  const struct ipu_di_signal_cfg *sig)
>  {
>  	unsigned long lock_flags;
>  	uint32_t reg;

-- 
Regards,

Laurent Pinchart
