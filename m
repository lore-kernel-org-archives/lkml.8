Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE19C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB84206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgGPUNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:13:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50318 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgGPUNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:13:11 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7B1DC20024;
        Thu, 16 Jul 2020 22:13:08 +0200 (CEST)
Date:   Thu, 16 Jul 2020 22:13:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     hdegoede@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vboxvideo: Replace HTTP links with HTTPS ones
Message-ID: <20200716201307.GC2254583@ravnborg.org>
References: <20200713124923.34282-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713124923.34282-1-grandmaster@al2klimov.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8 a=hOkPH7apAAAA:8 a=e5mUnYsNAAAA:8
        a=XgQJnKahRCJPmaHFw9QA:9 a=CjuIK1q_8ugA:10 a=q5qCbkKORm8A:10
        a=EzwKAMo-yAEA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=hPNTZtN9UGdAj5b0s3uK:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:49:23PM +0200, Alexander A. Klimov wrote:
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
>  drivers/gpu/drm/vboxvideo/hgsmi_defs.h | 2 +-
>  drivers/gpu/drm/vboxvideo/vbox_hgsmi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_defs.h b/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
> index 6c8df1cdb087..3cb52f2b2274 100644
> --- a/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
> +++ b/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
> @@ -58,7 +58,7 @@ struct hgsmi_buffer_tail {
>  	/* Reserved, must be initialized to 0. */
>  	u32 reserved;
>  	/*
> -	 * One-at-a-Time Hash: http://www.burtleburtle.net/bob/hash/doobs.html
> +	 * One-at-a-Time Hash: https://www.burtleburtle.net/bob/hash/doobs.html
>  	 * Over the header, offset and for first 4 bytes of the tail.
>  	 */
>  	u32 checksum;
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c b/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
> index 94b60654a012..a9ca4d0c3eca 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
> @@ -8,7 +8,7 @@
>  #include "vboxvideo_vbe.h"
>  #include "hgsmi_defs.h"
>  
> -/* One-at-a-Time Hash from http://www.burtleburtle.net/bob/hash/doobs.html */
> +/* One-at-a-Time Hash from https://www.burtleburtle.net/bob/hash/doobs.html */
>  static u32 hgsmi_hash_process(u32 hash, const u8 *data, int size)
>  {
>  	while (size--) {
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
