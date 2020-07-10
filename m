Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3351AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4CA2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGJR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:56:47 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:51740 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:56:47 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 83AFE20037;
        Fri, 10 Jul 2020 19:56:44 +0200 (CEST)
Date:   Fri, 10 Jul 2020 19:56:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
Message-ID: <20200710175643.GF17565@ravnborg.org>
References: <cover.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594136880.git.usuraj35@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=D_To5w3uyQa5RXxL-6MA:9
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suraj.

On Tue, Jul 07, 2020 at 10:04:14PM +0530, Suraj Upadhyay wrote:
> 
> This patchset converts logging to drm_* functions in drm core.
> 
> The following functions have been converted to their respective
> DRM alternatives :
> dev_info()      --> drm_info()
> dev_err()       --> drm_err()
> dev_warn()      --> drm_warn()
> dev_err_once()  --> drm_err_once().

I would prefer that DRM_* logging in the same files are converted in the
same patch. So we have one logging conversion patch for each file you
touches and that we do not need to re-vist the files later to change
another set of logging functions.
If possible WARN_* should also be converted to drm_WARN_*
If patch is too large, then split them up but again lets have all
logging updated when we touch a file.

Care to take a look at this approach?

Also please consider if coccinelle can make this job easier.
There is a lot of files...

	Sam

> 
> Suraj Upadhyay (4):
>   drm: mipi-dsi: Convert logging to drm_* functions.
>   drm: mipi-dbi: Convert logging to drm_* functions.
>   drm: edid: Convert logging to drm_* functions.
>   drm: fb-helper: Convert logging to drm_* functions.
> 
>  drivers/gpu/drm/drm_edid.c      |  7 +++----
>  drivers/gpu/drm/drm_fb_helper.c |  2 +-
>  drivers/gpu/drm/drm_mipi_dbi.c  |  4 ++--
>  drivers/gpu/drm/drm_mipi_dsi.c  | 15 +++++++--------
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> -- 
> 2.17.1
> 
> 



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

