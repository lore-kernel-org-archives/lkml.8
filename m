Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B017C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC7D20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JSXqRKqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGGSJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgGGSJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:09:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB99C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:09:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so18229206wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0m2aoBIP5GJAb10zyANIdy2YC3UULtv1aWEwGmldE04=;
        b=JSXqRKqzNi8wby85ZOPYM8+WlbCbPrGifr8g3X3OVWXFVbASCxiEVbote2kigrv8wv
         JQD7OBWXUBKKot5/flogEoaBHkhPsvwOwkfD207E+UwGA7Miz0eMQoJ7zQzwhPL61Rre
         EuI9y+FhVrM1NKYullsJN25lGamvzcwlqp6z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0m2aoBIP5GJAb10zyANIdy2YC3UULtv1aWEwGmldE04=;
        b=kW/rG5Xvt8/UdIcYp5fEtQeIYReUD8k+rgkHoe+Dq1n2d7UqXf8VMuyROepdGB0kRb
         rCR/CfIga3LxsKhArxtwXo6hd6RrUcC3MuhhNFuvL4a254Zlf6JxsW8qX4zMQQxSh1wz
         uAnyAryZsHhc71gzovJZSak/3ysDcwKvwHj4WUBGWmY2F/pz/u6ofMzF3fR/xMSS2Q8v
         kUZ1ko6mGCPABWdeiCO7Cl9hCa34fb9z4j46y71pIBBsmjv7Ar8pKQlLKvaXpxcm5d75
         zhDJ/L3C8Lb5liENCUOHT7lkuF8LBAo7sdzRn3C161dakRELZK3RFyQAShl/8PsOpYzQ
         d4xg==
X-Gm-Message-State: AOAM532XJLu1VsXWO/X6tdEYyxH59NiiQ2WRg9Y70WRwZLRjFxI6Sbw9
        CRPFR7esQkqXZ1RXWvPR2gOY6Q==
X-Google-Smtp-Source: ABdhPJyQWxqFc1PHki3J/nn4kM+S8X1Xh3twrKQaB7PZs8HSIA+iXCuj+fKvvuYm4me4y3tj/6LZ2g==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr54971954wrw.300.1594145359012;
        Tue, 07 Jul 2020 11:09:19 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id v12sm2026423wrt.31.2020.07.07.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:09:18 -0700 (PDT)
Date:   Tue, 7 Jul 2020 18:09:17 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kyungmin.park@samsung.com, s.nawrocki@samsung.com,
        mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] media: exynos4-is: Correct missing entity function
 initialization
Message-ID: <20200707180917.GD2621465@chromium.org>
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB0660E680A4F69E3037D87E70A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660E680A4F69E3037D87E70A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 25, 2020 at 07:26:43PM -0700, Jonathan Bakker wrote:
> Commit bae4500399c4 ("[media] exynos4-is: Add missing entity function
> initialization") tried to suppress the warnings such as
> 
> s5p-fimc-md camera: Entity type for entity FIMC.0 was not initialized!
> 
> However, this didn't work in all cases.  Correct this by calling the set
> function earlier.
> 
> Fixes: bae4500399c4 ("exynos4-is: Add missing entity function initialization")
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/media/platform/exynos4-is/fimc-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thank you for the patch. Please see my comments inline.

> diff --git a/drivers/media/platform/exynos4-is/fimc-capture.c b/drivers/media/platform/exynos4-is/fimc-capture.c
> index 705f182330ca..86c233e2f2c9 100644
> --- a/drivers/media/platform/exynos4-is/fimc-capture.c
> +++ b/drivers/media/platform/exynos4-is/fimc-capture.c
> @@ -1799,7 +1799,6 @@ static int fimc_register_capture_device(struct fimc_dev *fimc,
>  	vid_cap->wb_fmt.code = fmt->mbus_code;
>  
>  	vid_cap->vd_pad.flags = MEDIA_PAD_FL_SINK;
> -	vfd->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;

Isn't vfd->entity above a different entity than sd->entity below? If so,
this line must stay.

>  	ret = media_entity_pads_init(&vfd->entity, 1, &vid_cap->vd_pad);
>  	if (ret)
>  		goto err_free_ctx;
> @@ -1898,6 +1897,7 @@ int fimc_initialize_capture_subdev(struct fimc_dev *fimc)
>  		return ret;
>  
>  	sd->entity.ops = &fimc_sd_media_ops;
> +	sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;

My understanding is that this is the capture subdev and not the scaler.
Looking at the other drivers, MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER
could be the right function to use here.

Best regards,
Tomasz
