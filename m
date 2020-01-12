Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFAC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88561214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgALUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 15:19:36 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:60958 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733269AbgALUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 15:19:36 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7666F80516;
        Sun, 12 Jan 2020 21:19:28 +0100 (CET)
Date:   Sun, 12 Jan 2020 21:19:27 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] drm: panel: fix excessive stack usage in
 td028ttec1_prepare
Message-ID: <20200112201927.GA24849@ravnborg.org>
References: <20200108135116.3687988-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108135116.3687988-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=Akj0eHOMqQ7sJVUrYHYA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
        a=jd6J4Gguk5HxikPWLKER:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd.

On Wed, Jan 08, 2020 at 02:51:05PM +0100, Arnd Bergmann wrote:
> With gcc -O3 in combination with the structleak plug, the compiler can
> inline very aggressively, leading to rather large stack usage:
> 
> drivers/gpu/drm/panel/panel-tpo-td028ttec1.c: In function 'td028ttec1_prepare':
> drivers/gpu/drm/panel/panel-tpo-td028ttec1.c:233:1: error: the frame size of 2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  }
> 
> Marking jbt_reg_write_*() as noinline avoids the case where
> multiple instances of this function get inlined into the same
> stack frame and each one adds a copy of 'tx_buf'.
> 
> The compiler is clearly making some bad decisions here, but I
> did not open a new bug report as this only happens in combination
> with the structleak plugin.
> 
> Link: https://lore.kernel.org/lkml/CAK8P3a3jAnFZA3GFRtdYdg1-i-oih3pOQzkkrK-X3BGsFrMiZQ@mail.gmail.com/
> Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2:
> - mark all three functions as noinlien
> - add code comment
> - add link to more detailed analysis

Thanks for the updated patch.
Applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-tpo-td028ttec1.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> index cf29405a2dbe..5034db8b55de 100644
> --- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> @@ -86,7 +86,12 @@ struct td028ttec1_panel {
>  
>  #define to_td028ttec1_device(p) container_of(p, struct td028ttec1_panel, panel)
>  
> -static int jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
> +/*
> + * noinline_for_stack so we don't get multiple copies of tx_buf
> + * on the stack in case of gcc-plugin-structleak
> + */
> +static int noinline_for_stack
> +jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
>  {
>  	struct spi_device *spi = lcd->spi;
>  	u16 tx_buf = JBT_COMMAND | reg;
> @@ -105,7 +110,8 @@ static int jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
>  	return ret;
>  }
>  
> -static int jbt_reg_write_1(struct td028ttec1_panel *lcd,
> +static int noinline_for_stack
> +jbt_reg_write_1(struct td028ttec1_panel *lcd,
>  			   u8 reg, u8 data, int *err)
>  {
>  	struct spi_device *spi = lcd->spi;
> @@ -128,7 +134,8 @@ static int jbt_reg_write_1(struct td028ttec1_panel *lcd,
>  	return ret;
>  }
>  
> -static int jbt_reg_write_2(struct td028ttec1_panel *lcd,
> +static int noinline_for_stack
> +jbt_reg_write_2(struct td028ttec1_panel *lcd,
>  			   u8 reg, u16 data, int *err)
>  {
>  	struct spi_device *spi = lcd->spi;
> -- 
> 2.20.0
