Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C22063A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0NeXiak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbgFYJYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390849AbgFYJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:24:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B5C061795
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:24:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so4836499wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EaOaR3l9HHxJyu97gRJLmzWQVTWMAcMmNEcB1lcmPNM=;
        b=l0NeXiakjdrXrLaBLIadefKz8F7+uyKt5t8RNkWbO405PGH/BZlG7ucw7IkjzZ9wK5
         pOFvA45fVJyNpEcvwKTJ4EG0KhFxxfY3pjjhc9JzCoT3kHSe1jOgmHODowQxUGG2FiKI
         yZKssraojrjtQZI6OtOlcrvQCZo1hNcJlSJyToTanRleQMoy+FooP2BSXH93BwrhKzi0
         +zryj2eO1f08xEkWifRc0qeLiBx2LzTlRzbY8yPbRKajweEMeycjGzvCiACtHFxLbRLK
         EgS2b5n252zk49kR0c4T7PyzpHEdZ1+hFE2Hkk25xROet1O/dW+JLLQjtJsCj4GzbSde
         JvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EaOaR3l9HHxJyu97gRJLmzWQVTWMAcMmNEcB1lcmPNM=;
        b=SgavM76QD6/FLlTwSRaojNarKxw+9e6IpPjjwxpmgK+05PSnoREwxLehgjSgHBJ5X6
         nNDdTKaLySPSW6d5AsenlIhGAeD1WSuoMoS+EYQab03VBYkydWPvgftOox9NcjuzkYWs
         x6sb3tYD1OBxDCBoGN4gLvSEu2DOSas/cYgUM3yUcbX2XlA1m6QKHAEKuoG1r+gVoddr
         w7OUUD446S0ApMczI2gPfcIjRHwXPnYIcL/Vh1hRdNdxiGaVGO9js79NKjQzYqcrS+kj
         xO3rHkKIewKjIwzwNjLdKHtrK8FF1GmyU84Tr+7cm5EXXDvSTq18c9K0GovuGOmgZIOc
         V2dA==
X-Gm-Message-State: AOAM531DuLOsnz0RnW+GmARRLplgXMLcBwH6fe+pIKyatUV/d+AozeGF
        Br6FwRPypc5xvWEnUqE27keRsA==
X-Google-Smtp-Source: ABdhPJxraWfUM9OicOYalfWG6fhp1iNyu1akGB9XabtzprNxns7odWMJc425dq+X61YgK7Y4EfXJrw==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2381038wmb.61.1593077077320;
        Thu, 25 Jun 2020 02:24:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 138sm12311705wma.23.2020.06.25.02.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:24:36 -0700 (PDT)
Date:   Thu, 25 Jun 2020 10:24:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/8] backlight: lms501kf03: Remove unused const variables
Message-ID: <20200625092434.szrdyt3sxmxmfajg@holly.lan>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624145721.2590327-2-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:57:14PM +0100, Lee Jones wrote:
> W=1 kernel build reports:
> 
>  drivers/video/backlight/lms501kf03.c:96:28: warning: ‘seq_sleep_in’ defined but not used [-Wunused-const-variable=]
>  96 | static const unsigned char seq_sleep_in[] = {
>  | ^~~~~~~~~~~~
>  drivers/video/backlight/lms501kf03.c:92:28: warning: ‘seq_up_dn’ defined but not used [-Wunused-const-variable=]
>  92 | static const unsigned char seq_up_dn[] = {
>  | ^~~~~~~~~
> 
> Either 'seq_sleep_in' nor 'seq_up_dn' have been used since the
> driver first landed in 2013.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lms501kf03.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
> index 8ae32e3573c1a..c1bd02bb8b2ee 100644
> --- a/drivers/video/backlight/lms501kf03.c
> +++ b/drivers/video/backlight/lms501kf03.c
> @@ -89,14 +89,6 @@ static const unsigned char seq_rgb_gamma[] = {
>  	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>  
> -static const unsigned char seq_up_dn[] = {
> -	0x36, 0x10,
> -};
> -
> -static const unsigned char seq_sleep_in[] = {
> -	0x10,
> -};
> -
>  static const unsigned char seq_sleep_out[] = {
>  	0x11,
>  };
> -- 
> 2.25.1
> 
