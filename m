Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E262C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDA520679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0CHlPpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbgFYJqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389894AbgFYJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:46:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:46:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a6so6325613wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vxl/tdv9kpWIOuN2YYNY6bKce9KEtpxUCz4B4fhlwMs=;
        b=E0CHlPpOfBqGZD74u+uo1w2hr2b1CGencolNHf1PknVTcOxLfkAyK0NwwnxeXTXuU0
         erbhuiFNXLPZwf1SAvTRASh2mqXkZ6aTB0SJCg80WaNjT0ezOSXNsgviYZTjcM8OEWmi
         sZi2QRcp/wO3FZSK3XqSW0FOB/fkmUZFzoG1824UAes7Ig//VM0qw6HVxGoqQNFcX3iS
         jd+jf4R1MrEAS00a7umB5+6Hy5isDM2yy7brQkbH8HIect9U6iorDx0D1413r8gJC0+n
         m+MUBrJP00jUMujNhu4sivLcL4lh/QUbL+cj4zhkfaAN0qF93X6bLZzJZmR7ZsS154gf
         Ov9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vxl/tdv9kpWIOuN2YYNY6bKce9KEtpxUCz4B4fhlwMs=;
        b=XNd2ER3j5AgglUuy/tPnq7j21Iny7n/6OkKMBAnBfriGth+xyKPs39zNRuA3X4jAXo
         cvml5e+04yvRmss+GyNQmlJu5UfEQed4SEDrvcdl02SQ+h17t+zEm6yTf358yKSDUFmj
         MpyAUN5HfH7SbhJo8CKqOSLE0xY5f8J6Vatup0vdMXkfMhqT8P7Isf9ct6bMXoft8mXt
         CrOwucbmAaZ7sN5/jodw1IjT/i+/9ply71tVOZTyfqPvftZastJNiAA1esyhuSrqkec4
         +BWQ4+DiddY2ZNWJZFCnB2ZQ2AAuhDTWdjy+NAcYdEjeZ0jcyhKj9SMHVQma8Jtus7Hb
         oXNQ==
X-Gm-Message-State: AOAM533gB4kCwZmAPnKFqtlVY0/F6IQhHZ5TGfp68V2al4sNWj4I6sj6
        ed/qomiVDrcptgBxSmYAHO0Q7w==
X-Google-Smtp-Source: ABdhPJyJPSUnMWkYym/l/M3quKvkj6eev/Am+p1MkAozrU5ybki4gZEqiO8/NowLH+fVWnbtW2vWew==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr2445278wme.42.1593078374694;
        Thu, 25 Jun 2020 02:46:14 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id w2sm19962496wrs.77.2020.06.25.02.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:46:14 -0700 (PDT)
Date:   Thu, 25 Jun 2020 10:46:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 8/8] backlight: qcom-wled: Remove unused configs for LED3
 and LED4
Message-ID: <20200625094612.fn3o5bd37t7vadsc@holly.lan>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624145721.2590327-9-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:57:21PM +0100, Lee Jones wrote:
> Fixes W=1 warnings:
> 
>  drivers/video/backlight/qcom-wled.c:1294:34: warning: ‘wled4_string_cfg’ defined but not used [-Wunused-const-variable=]
>  1294 | static const struct wled_var_cfg wled4_string_cfg = {
>  | ^~~~~~~~~~~~~~~~
>  drivers/video/backlight/qcom-wled.c:1290:34: warning: ‘wled3_string_cfg’ defined but not used [-Wunused-const-variable=]
>  1290 | static const struct wled_var_cfg wled3_string_cfg = {
>  | ^~~~~~~~~~~~~~~~
> 
> Cc: <stable@vger.kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/qcom-wled.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 4c8c34b994414..c25c31199952c 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1287,14 +1287,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
>  	.size = ARRAY_SIZE(wled4_string_i_limit_values),
>  };
>  
> -static const struct wled_var_cfg wled3_string_cfg = {
> -	.size = 8,
> -};
> -
> -static const struct wled_var_cfg wled4_string_cfg = {
> -	.size = 16,
> -};
> -
>  static const struct wled_var_cfg wled5_mod_sel_cfg = {
>  	.size = 2,
>  };
> -- 
> 2.25.1
> 
