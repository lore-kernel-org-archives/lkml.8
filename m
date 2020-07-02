Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC13A20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGBHFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:05:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48396 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgGBHFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:05:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A4EB4FB03;
        Thu,  2 Jul 2020 09:05:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XkiwlLoqLj9N; Thu,  2 Jul 2020 09:05:14 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id C52E144F51; Thu,  2 Jul 2020 09:05:10 +0200 (CEST)
Date:   Thu, 2 Jul 2020 09:05:10 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] MAINTAINERS: Update entry for st7703 driver after the
 rename
Message-ID: <20200702070510.GA3275@bogon.m.sigxcpu.org>
References: <20200701184640.1674969-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701184640.1674969-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,
On Wed, Jul 01, 2020 at 08:46:40PM +0200, Ondrej Jirman wrote:
> The driver was renamed, change the path in the MAINTAINERS file.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  MAINTAINERS | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f186a661a9b..f5183eae08df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5487,12 +5487,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
>  F:	drivers/gpu/drm/panel/panel-raydium-rm67191.c
>  
> -DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
> +DRM DRIVER FOR SITRONIX ST7703 PANELS
>  M:	Guido Günther <agx@sigxcpu.org>
>  R:	Purism Kernel Team <kernel@puri.sm>
> +R:	Ondrej Jirman <megous@megous.com>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> -F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> +F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Thanks,
 -- Guido

>  
>  DRM DRIVER FOR SAVAGE VIDEO CARDS
>  S:	Orphan / Obsolete
> -- 
> 2.27.0
> 
