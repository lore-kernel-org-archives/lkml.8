Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D589E22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgHCTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:44:58 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42938 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgHCTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:44:56 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id ACF8380503;
        Mon,  3 Aug 2020 21:44:52 +0200 (CEST)
Date:   Mon, 3 Aug 2020 21:44:51 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     trix@redhat.com
Cc:     b.zolnierkie@samsung.com, jhubbard@nvidia.com,
        daniel.vetter@ffwll.ch, gustavo@embeddedor.com, arnd@arndb.de,
        jani.nikula@intel.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: fbdev: pvr2fb: initialize variables
Message-ID: <20200803194451.GB525506@ravnborg.org>
References: <20200720191845.20115-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720191845.20115-1-trix@redhat.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8 a=e5mUnYsNAAAA:8
        a=qnTn4qAwrYwZIjOlhbIA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, Jul 20, 2020 at 12:18:45PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this repesentative error
> 
> pvr2fb.c:1049:2: warning: 1st function call argument
>   is an uninitialized value [core.CallAndMessage]
>         if (*cable_arg)
>         ^~~~~~~~~~~~~~~
> 
> Problem is that cable_arg depends on the input loop to
> set the cable_arg[0].  If it does not, then some random
> value from the stack is used.
> 
> A similar problem exists for output_arg.
> 
> So initialize cable_arg and output_arg.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/pvr2fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 2d9f69b93392..f4add36cb5f4 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -1028,6 +1028,8 @@ static int __init pvr2fb_setup(char *options)
>  	if (!options || !*options)
>  		return 0;
>  
> +	cable_arg[0] = output_arg[0] = 0;
> +
>  	while ((this_opt = strsep(&options, ","))) {
>  		if (!*this_opt)
>  			continue;
> -- 
> 2.18.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
