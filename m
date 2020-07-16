Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13EAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0A8206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgGPUOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:14:23 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50386 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgGPUOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:14:23 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B220420024;
        Thu, 16 Jul 2020 22:14:17 +0200 (CEST)
Date:   Thu, 16 Jul 2020 22:14:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jsarha@ti.com, tomi.valkeinen@ti.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tidss: Replace HTTP links with HTTPS ones
Message-ID: <20200716201416.GD2254583@ravnborg.org>
References: <20200713123913.34205-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713123913.34205-1-grandmaster@al2klimov.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8 a=sozttTNsAAAA:8 a=e5mUnYsNAAAA:8
        a=2b5M6aC5G-VBR2GjRbIA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
        a=aeg5Gbbo78KNqacMgKqU:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:39:13PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied to drm-misc-next.

	Sam

> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  drivers/gpu/drm/tidss/tidss_crtc.c        | 2 +-
>  drivers/gpu/drm/tidss/tidss_crtc.h        | 2 +-
>  drivers/gpu/drm/tidss/tidss_dispc.c       | 2 +-
>  drivers/gpu/drm/tidss/tidss_dispc.h       | 2 +-
>  drivers/gpu/drm/tidss/tidss_dispc_regs.h  | 2 +-
>  drivers/gpu/drm/tidss/tidss_drv.c         | 2 +-
>  drivers/gpu/drm/tidss/tidss_drv.h         | 2 +-
>  drivers/gpu/drm/tidss/tidss_encoder.c     | 2 +-
>  drivers/gpu/drm/tidss/tidss_encoder.h     | 2 +-
>  drivers/gpu/drm/tidss/tidss_irq.c         | 2 +-
>  drivers/gpu/drm/tidss/tidss_irq.h         | 2 +-
>  drivers/gpu/drm/tidss/tidss_kms.c         | 2 +-
>  drivers/gpu/drm/tidss/tidss_kms.h         | 2 +-
>  drivers/gpu/drm/tidss/tidss_plane.c       | 2 +-
>  drivers/gpu/drm/tidss/tidss_plane.h       | 2 +-
>  drivers/gpu/drm/tidss/tidss_scale_coefs.c | 2 +-
>  drivers/gpu/drm/tidss/tidss_scale_coefs.h | 2 +-
>  17 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index 89a226912de8..a591c70b8386 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.h b/drivers/gpu/drm/tidss/tidss_crtc.h
> index 09e773666228..040d1205496b 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.h
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 629dd06393f6..e7d28ec8f7f3 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Jyri Sarha <jsarha@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 902e612ff7ac..5984e0de2cd9 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> index 88a83a41b6e3..13feedfe5d6d 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Jyri Sarha <jsarha@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 99edc66ebdef..f00fadbead3e 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
> index 3b0a3d87b7c4..7de4bba52e6f 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.h
> +++ b/drivers/gpu/drm/tidss/tidss_drv.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
> index 30bf2a65949c..e278a9c89476 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.c
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.h b/drivers/gpu/drm/tidss/tidss_encoder.h
> index 06854d66e7e6..ace877c0e0fd 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.h
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
> index 1b80f2d62e0a..a5ec7931ef6b 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.c
> +++ b/drivers/gpu/drm/tidss/tidss_irq.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.h b/drivers/gpu/drm/tidss/tidss_irq.h
> index aa92db403cca..4aaad5dfd7c2 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.h
> +++ b/drivers/gpu/drm/tidss/tidss_irq.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
> index 4b99e9fa84a5..71dbd331640f 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.h b/drivers/gpu/drm/tidss/tidss_kms.h
> index 99aaff099f22..632d79f5983f 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.h
> +++ b/drivers/gpu/drm/tidss/tidss_kms.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index 0a563eabcbb9..43e72d0b2d84 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.h b/drivers/gpu/drm/tidss/tidss_plane.h
> index 80ff1c5a2535..e933e158b617 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.h
> +++ b/drivers/gpu/drm/tidss/tidss_plane.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_scale_coefs.c b/drivers/gpu/drm/tidss/tidss_scale_coefs.c
> index 5ec68389cc68..c2b84fea89a5 100644
> --- a/drivers/gpu/drm/tidss/tidss_scale_coefs.c
> +++ b/drivers/gpu/drm/tidss/tidss_scale_coefs.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Jyri Sarha <jsarha@ti.com>
>   */
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_scale_coefs.h b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
> index 64b5af5b5361..9c560d0fdac0 100644
> --- a/drivers/gpu/drm/tidss/tidss_scale_coefs.h
> +++ b/drivers/gpu/drm/tidss/tidss_scale_coefs.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>   * Author: Jyri Sarha <jsarha@ti.com>
>   */
>  
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
