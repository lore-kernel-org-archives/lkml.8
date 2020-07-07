Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E8AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C89F206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D7QOnmbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGGRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:55:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:55:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so1614wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sc9g6wGOzRwu+DnLXFZTX5cameYasawGNk3OVO7epl8=;
        b=D7QOnmbuxoxljwvQGT3yaEZJaRFUBDlp64fFWQE1ERpsuzJiBMUztTHlfqlUQ9so2Z
         H7kFoFEJ3xOi1f0Gb89ost5aAWVhD+vA8aUCzwj2K4+uwU3UHrSHDAkKsLiHN8KfECz7
         jyc+yQUOvIi3JJY9mZvnaj8Mfqu4S6MDdLTFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sc9g6wGOzRwu+DnLXFZTX5cameYasawGNk3OVO7epl8=;
        b=HdlxXDHuHwdy2b8ZfM/L9Ix6bblx1ETzPRbTppXjtgR9qrbb1S7ScixLUrh3YJPeYm
         MGfQaxCBAP0rJpD6L8p3EpAMcRFeNGobHwk6l25icTSyXYcQzw+HxK5tKgAB1QtiMhDD
         jCXdk8DwO6vi37EKbhxp1jRMMbS3+1jRM5U0Gb6MP+zu6KonyGptyBaRXXzB8JvQQwX7
         ih1EJvRoSYxUabCcGQyH+A3hsBEZYndTiTwbTOs3mX9a0CtsXDQOtG3xWI7G2zA9VMXv
         /+DBD0g7h7Yc8hWIcnLHhndpL9WK/hz07hijCErXbOSHV+MtyciB6diymHlY1m4VeXQp
         0G4g==
X-Gm-Message-State: AOAM533fHNUuZqhbSn1g8n+iHwkAZyiN2it1NOYIdYc9F+wSUXu2nlM0
        ACa2f5l9eSBlStcl4zrTkkDsMw==
X-Google-Smtp-Source: ABdhPJz88/m48rj8/5SglwbXt+8ksYS3fKh8+pilMr/CD6s/J2Lz8aV+iwPGIQEZ51STz91WaC41TA==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr3606166wmi.94.1594144519752;
        Tue, 07 Jul 2020 10:55:19 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id f16sm1980411wmf.17.2020.07.07.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:55:19 -0700 (PDT)
Date:   Tue, 7 Jul 2020 17:55:17 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] media: exynos4-is: Fix nullptr when no CSIS device
 present
Message-ID: <20200707175517.GC2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB0660EE7304C2BB2E603A8824A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660EE7304C2BB2E603A8824A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 25, 2020 at 07:26:42PM -0700, Jonathan Bakker wrote:
> Not all devices use the CSIS device, some may use the FIMC directly in
> which case the CSIS device isn't registered.  This leads to a nullptr
> exception when starting the stream as the CSIS device is always
> referenced.  Instead, if getting the CSIS device fails, try getting the
> FIMC directly to check if we are using the subdev API
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/media-dev.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
> index 9aaf3b8060d5..5c32abc7251b 100644
> --- a/drivers/media/platform/exynos4-is/media-dev.c
> +++ b/drivers/media/platform/exynos4-is/media-dev.c
> @@ -289,11 +289,26 @@ static int __fimc_pipeline_s_stream(struct exynos_media_pipeline *ep, bool on)
>  		{ IDX_CSIS, IDX_FLITE, IDX_FIMC, IDX_SENSOR, IDX_IS_ISP },
>  	};
>  	struct fimc_pipeline *p = to_fimc_pipeline(ep);
> -	struct fimc_md *fmd = entity_to_fimc_mdev(&p->subdevs[IDX_CSIS]->entity);
>  	enum fimc_subdev_index sd_id;
>  	int i, ret = 0;
>  
>  	if (p->subdevs[IDX_SENSOR] == NULL) {
> +		struct fimc_md *fmd;
> +		struct v4l2_subdev *sd = p->subdevs[IDX_CSIS];
> +
> +		if (!sd)
> +			sd = p->subdevs[IDX_FIMC];
> +
> +		if (!sd) {
> +			/*
> +			 * If neither CSIS nor FIMC was set up,
> +			 * it's impossible to have any sensors
> +			 */
> +			return -ENODEV;
> +		}
> +
> +		fmd = entity_to_fimc_mdev(&sd->entity);
> +

Are you sure this is the correct thing to do here? In general, the media
controller should be instantiated only if there are sensors in the system.

What do you mean by using "the FIMC directly"? Do you mean using it only as
an m2m image processor or with a sensor, but without the CSIS, which would
be the case for parallel I/F sensors?

Could you point me to the place where CSIS is always dereferenced? A quick
look through the code only revealed that everywhere it seems to be guarded
by a NULL check.

Another thought from looking at the implementation of
__fimc_pipeline_s_stream() is that it probably shouldn't call s_stream on
all the subdevices included in seq[], but only on those that are actually
included as a part of the pipeline. It would be quite a waste of power to
enable unnecessary hardware.

Best regards,
Tomasz
