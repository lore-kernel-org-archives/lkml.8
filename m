Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3417C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1606221F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ah+p8bhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGNGid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:38:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60808 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgGNGic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:38:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06E6cMrg005962;
        Tue, 14 Jul 2020 01:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594708702;
        bh=E6XLSTEMp1cR4YzAIPgti1IZa4bpe311JjazS/NnXuE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Ah+p8bhkTYz1WDNEkqRZFOkcY3jtmgikJLuAjr8Jril9i3cm10DDYpJTVILuWwLVt
         bvOkqklBZFl7cnSVdvCqfHXzTdSoOGHuUZgm5L+dM3YnjGtFT6H1DQhWm4155riHSe
         eyYU6BjlhO4T9r4m0gzXOciSk9kJHxCd+rlnqM0g=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06E6cMht087751
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 01:38:22 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 14
 Jul 2020 01:38:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 14 Jul 2020 01:38:22 -0500
Received: from [10.250.219.243] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06E6cIX4029748;
        Tue, 14 Jul 2020 01:38:19 -0500
Subject: Re: [PATCH] drm/tidss: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        <tomi.valkeinen@ti.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200713123913.34205-1-grandmaster@al2klimov.de>
From:   Jyri Sarha <jsarha@ti.com>
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a51d529c-37ed-5198-70ff-38886b8bdab3@ti.com>
Date:   Tue, 14 Jul 2020 09:38:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200713123913.34205-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 15:39, Alexander A. Klimov wrote:
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

Acked-by: Jyri Sarha <jsarha@ti.com>

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
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
