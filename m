Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5169C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EE620637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucqglDNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCJOei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:34:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44680 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:34:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so6094096wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zXUts9AKiN/fKeCTOGQ7/e/tECu60a66Sq1qE2nSsj8=;
        b=ucqglDNfh+/t7dmNc1CoK4kO9k+WxOIJzAhBXn+Oh0STOsQnfHC/GDv6spYpC2ti0F
         WkhQA8v8uiST7Z2FuAl1vsyWSGLCSJLSeMFgLDT5TelHP3z9E5sty8LyyHNRfUDslRso
         p498ot405gbFzIQB8Gt7/kHjgUTRjDSPxJyPA9DIw7zogenq96fCCzMxkx/7v30uhgLQ
         MaUkhBksj+EQPUUo9C1nbNcAeQ7zVyr7DbaeRMuje32RNsSbERV6RjurO2HhIIVSVp5P
         1C58TiVwLcXXFWBZ6cIpe4SUvRGwDpB5RiViuB8j7/8j8KHchz/Q4771WMHVRqM0rp1w
         ddbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXUts9AKiN/fKeCTOGQ7/e/tECu60a66Sq1qE2nSsj8=;
        b=qjbk5j894eJYHzuCJwOCAfosoeKJnCeFEc+7vbQ3S4Xk2IzKV/5WuE1cQlKQ2JPtse
         WjOUwdDDBg1qR7vwjhrsbeSnCNzg9NNS3PlTKGJCqqeySJb1fhHHDxRXYYGDP0zjfHwz
         fr2lsyS8/3OhwDPXhfKn/ltuXjxZtrfrmK+SADC1PNHmePPx9mW0ZAHwAkFX7yblU4O3
         8DvGjM6Nhe2HRQnMu/bUo5rW9sP8fQx3cQtqh8LbLA0wA46/QdanWJi7em1QuiRIyYsu
         nfqHwHsBfMTl2SYlPtTS4oQUYuD8s49dCc0kKrAwA2Duotc5Tpnqz0iiEa+7Sui5Nr7k
         6w9w==
X-Gm-Message-State: ANhLgQ3ai1zVnTkchhmFxpP4GQc6Y8hb7IWoETNQKPKaJmh8I2Y479t7
        aTbeYIdVMl9Llnh93ClDC77MaA==
X-Google-Smtp-Source: ADFU+vvCn/r+CWrqGkHsSeFBVcE/wnMDHgQjwBF6p03Kfe11Rwc7vjt86tUuLleXNkWdlmNEvJ52Jg==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr29388013wrn.29.1583850875652;
        Tue, 10 Mar 2020 07:34:35 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o3sm4610328wme.36.2020.03.10.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:34:34 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:34:32 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v7 12/13] backlight: pwm_bl: Use 64-bit division macros
 for period and duty cycle
Message-ID: <20200310143432.cfjlqac5x6oinshj@holly.lan>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <bf6d8f6190d266f8992bd5451b12c9f3962fd18e.1583782035.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6d8f6190d266f8992bd5451b12c9f3962fd18e.1583782035.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:35:15PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined in the PWM framework structs
> as ints with units of nanoseconds, the maximum time duration that can be
> set is limited to ~2.147 seconds. Redefining them as u64 values will
> enable larger time durations to be set.
> 
> As a first step, prepare drivers to handle the switch to u64 period and
> duty_cycle by replacing division operations involving pwm period and duty cycle
> with their 64-bit equivalents as appropriate. The actual switch to u64 period
> and duty_cycle follows as a separate patch.
> 
> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
> macros:
> - DIV_ROUND_UP_ULL
> - DIV_ROUND_CLOSEST_ULL
> - div_u64
> 
> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
> DIV64_* macros:
> - DIV64_U64_ROUND_CLOSEST
> - div64_u64

This patch looks like it is a tiny change to get the pwm_backlight to
perform 64-bit division. Most of the above text is completely irrelevant
to the change contained in this patch. No need to justify the change in
the PWM structures here since that can go in the patch that changes
those structures.  Just describe what this patch does, perhaps something
like the following:

    The PWM API will shortly switch the state.period and
    state.duty_cycle fields to 64-bit values. Make pwm_bl
    ready for this transition by adopting 64-bit division
    macros.

Also please copy the backlight maintainers into the covering letter. It
is useful to place patches like this into context.


Daniel.

 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index efb4efc..3e5dbcf 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		pb->scale = data->max_brightness;
>  	}
>  
> -	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> +	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
> +				pb->scale));
>  
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = data->max_brightness;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
