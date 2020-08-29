Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E9C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5A32076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgH2VHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:07:32 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51644 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgH2VHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:07:31 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B205680487;
        Sat, 29 Aug 2020 23:07:28 +0200 (CEST)
Date:   Sat, 29 Aug 2020 23:07:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Subject: Re: [PATCH v2 1/2] drm/ingenic: Fix leak of device_node pointer
Message-ID: <20200829210727.GE796939@ravnborg.org>
References: <20200827114404.36748-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827114404.36748-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=7_PQ8Af-TSOvrYyXnPkA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:44:03PM +0200, Paul Cercueil wrote:
> of_graph_get_remote_node() requires of_node_put() to be called on the
> device_node pointer when it's no more in use.
> 
> Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index ada990a7f911..c1bcb93aed2d 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -978,6 +978,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  	}
>  
>  	drm_of_component_match_add(dev, &match, compare_of, np);
> +	of_node_put(np);
>  
>  	return component_master_add_with_match(dev, &ingenic_master_ops, match);
>  }
> -- 
> 2.28.0
