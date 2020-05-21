Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D354820759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgEUVJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:09:29 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:52236 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgEUVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:09:29 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A1330804A3;
        Thu, 21 May 2020 23:09:25 +0200 (CEST)
Date:   Thu, 21 May 2020 23:09:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/vblank: Fix -Wformat compile warnings on some arches
Message-ID: <20200521210924.GA1056842@ravnborg.org>
References: <20200521204647.2578479-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521204647.2578479-1-lyude@redhat.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8 a=e5mUnYsNAAAA:8
        a=pm5h8qfB858e3dYQ7kEA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:46:47PM -0400, Lyude Paul wrote:
> On some architectures like ppc64le and aarch64, compiling with
> -Wformat=1 will throw the following warnings:
> 
>   In file included from drivers/gpu/drm/drm_vblank.c:33:
>   drivers/gpu/drm/drm_vblank.c: In function 'drm_update_vblank_count':
>   drivers/gpu/drm/drm_vblank.c:273:16: warning: format '%llu' expects
>   argument of type 'long long unsigned int', but argument 4 has type
>   'long int' [-Wformat=]
>     DRM_DEBUG_VBL("updating vblank count on crtc %u:"
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/drm/drm_print.h:407:22: note: in definition of macro
>   'DRM_DEBUG_VBL'
>     drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
>                         ^~~
>   drivers/gpu/drm/drm_vblank.c:274:22: note: format string is defined here
>            " current=%llu, diff=%u, hw=%u hw_last=%u\n",
>                      ~~~^
>                      %lu
> 
> So, fix that with a typecast.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-developed-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index acb3c3f65b579..1a96db2dd16fa 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -342,7 +342,7 @@ static void drm_update_vblank_count(struct drm_device *dev, unsigned int pipe,
>  
>  	DRM_DEBUG_VBL("updating vblank count on crtc %u:"
>  		      " current=%llu, diff=%u, hw=%u hw_last=%u\n",
> -		      pipe, atomic64_read(&vblank->count), diff,
> +		      pipe, (unsigned long long)atomic64_read(&vblank->count), diff,
>  		      cur_vblank, vblank->last);

While touching this you could consider introducing drm_dbg_vbl().
An maybe as a follow-up patch replace all logging in this file with the drm_* variants.

	Sam

>  
>  	if (diff == 0) {
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
