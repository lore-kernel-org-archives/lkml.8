Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E771C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D466206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CIeg/aln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHGIVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHGIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:21:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F95C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 01:21:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so845338wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqxiNGL80BLdDN30QUUee1y7IG4JiUdyhB9Ly20qJKI=;
        b=CIeg/alnrvDZeEY6m+aWi1luGEHJDycuJGQ7nP34JINNUyrrx8SIRKZnydaFDoEYsQ
         z3du814PWCYyYmKRpLUoCo4OvaLjTx0m5yxc2zFV5qSH9PQU/EOojpREL2YXSlg+Hkuj
         KaoGNZ5pUETPZShaeI0gLGd8YyADGy4nkkquE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UqxiNGL80BLdDN30QUUee1y7IG4JiUdyhB9Ly20qJKI=;
        b=SrjvuH1YYav2R/+3Gi8kzZfqW0SEKqvsWuEXudsfkpR1y98Ce4DjHowd3RGZLZX1Ly
         NXPHWcMyx+lZjyG3TTVHkKATW32FHHPb56cYALZcXIwULNY2vt4Ta8SyWbqxDmJj4I9z
         gB/bnzFpWFP3YXQaCADoB/4NHbq8V972ojnSkGmTSeWdXTLwB4IIFb6plQT+7f0Xt/8P
         YIaA9omKwM2zKnimRtEoWtitMKJ5DanJsIkdgQhQmjG5C2yOEv8UZuR3pR2kFBmKJhbl
         cqg2b1H18s5kWx880b3t9jONCItZ3QWlO0JNnurfNhNdC925z75Hjc2g5MRm8gqs0aTL
         QWLw==
X-Gm-Message-State: AOAM531mJKOTEIKQFlwQrwbD6YU2IEo/juuGrRSCaRfd7CX+LKk1Dcje
        ML+BfHzecI3eK7X+Wg725I61DQ==
X-Google-Smtp-Source: ABdhPJznfPys24FShDvFjWJ2NDzMFWVf+kHqgSLbgWxDZ+J7ylB679aTuEYbnHVK0dLGgOJMTEXglg==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr11703089wrv.280.1596788476358;
        Fri, 07 Aug 2020 01:21:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r3sm9649430wro.1.2020.08.07.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 01:21:15 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:21:13 +0200
From:   daniel@ffwll.ch
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during
 interpolation
Message-ID: <20200807082113.GI6419@phenom.ffwll.local>
Mail-Followup-To: Alexandru Stan <amstan@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> Some displays need the low end of the curve cropped in order to make
> them happy. In that case we still want to have the 0% point, even though
> anything between 0% and 5%(example) would be skipped.
> 
> Signed-off-by: Alexandru Stan <amstan@chromium.org>
> ---
> 
>  drivers/video/backlight/pwm_bl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 5193a72305a2..b24711ddf504 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  			/* Fill in the last point, since no line starts here. */
>  			table[x2] = y2;
>  
> +			/*
> +			 * If we don't start at 0 yet we're increasing, assume
> +			 * the dts wanted to crop the low end of the range, so
> +			 * insert a 0 to provide a display off mode.
> +			 */
> +			if (table[0] > 0 && table[0] < table[num_levels - 1])
> +				table[0] = 0;

Isn't that what the enable/disable switch in backlights are for? There's
lots of backligh drivers (mostly the firmware variety) where setting the
backlight to 0 does not shut it off, it's just the lowest setting.

But I've not been involved in the details of these discussions.
-Daniel

> +
>  			/*
>  			 * As we use interpolation lets remove current
>  			 * brightness levels table and replace for the
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
