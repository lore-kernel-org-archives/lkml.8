Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8E320709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERPML5Tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgIDLoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgIDLny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:43:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653AC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:43:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so6431774wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ysBV8EHmB5bF7bmhKaHH5XXdeOwwXfi3lB8yzT/cQJI=;
        b=ERPML5TfkAu4IeCukhG/Nhlef0bp6OEGWyqpI+H9cqWpmexGM/dwCjHvlLMpvGvX82
         s++1gsWLmCFIQqjtJ6gPxGZg64liHxtYHMNfzEwXjYUhG1pqLBkD6MzKYUkK5ioJ0e28
         1gE7JrRjKkvKi2dnQs5itiw0RcAflKbRtSmVy4BEyrD+youQszYtp+ZAq2TK2TQHQ3/Z
         NvPbd39Cf8+edAPlFgRmtHkYGb40/7T/A+vmU9uqJ1gqGH5frO/n3rDNoiuxeb6RzMiM
         DHqMTkB1Z03edqTnGiWf+N3I4VCcU3DMoQM+drbafMbvrHXFaQ6EpO+AEYAVV0xS+Nlh
         V0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ysBV8EHmB5bF7bmhKaHH5XXdeOwwXfi3lB8yzT/cQJI=;
        b=Ny02nXCR/nZSkQztAEbHo0UXB/7sjcALdzrjGVsHiOs18JqmXMmCx1v+e5YBOHLiEj
         atmOPgrN8XMltSoddM53v398MOAjApSCzsP4S3JjHAVTXeE3eBY746jTaUl+w5TunEtD
         oB0jKbSNuARC05/v27ry9GN/kpoA22l5nCRzLP9a1b2MAeaZ4u1Xd9BwyAHu/9/QwM1S
         p0zJgkaOZWSLVRaZ5MnPBjX64Bc46XnodbN1HUun6X3ntRA8Ctg0hq0crCyTcU0ve05p
         3GeEAL2HkVAcWaQ2sb4AeSHfvdHTccCiA9DsIWXAlDDYPZb/DDXNpSoAR82AzgIIUxrO
         uLxg==
X-Gm-Message-State: AOAM531J0EjSZU4ne98mthsucRvyyYMNUQ25cWz5tB3Aq3ltYjwwut3T
        YCNSq6HkiQmg+1syCNrgUgN1yA==
X-Google-Smtp-Source: ABdhPJy9JCvlhC4pfdcbOeNMvmI99h2ggyh5dFXaXSknmVKya2fRCYzaf1Gn4wvLYshTpHoPPGgO8g==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr6996379wrv.369.1599219832344;
        Fri, 04 Sep 2020 04:43:52 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o4sm6783818wru.55.2020.09.04.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:43:51 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:43:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: rockchip: Remove 0 point in backlight
Message-ID: <20200904114349.fq26qqozd4tz6sjs@holly.lan>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.3.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720212502.3.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:25:22PM -0700, Alexandru Stan wrote:
> After the "PWM backlight interpolation adjustments" patches, the
> backlight interpolation works a little differently. The way these
> dts files were working before was relying on a bug (IMHO).
> 
> Remove the 0-3 range since otherwise we would have a 252 long
> interpolation that would slowly go between 0 and 3, looking really bad
> in userspace.
> 
> We'll still have the 0% point available to userspace, "backlight:
> pwm_bl: Artificially add 0% during interpolation" takes care of that.
> 
> Signed-off-by: Alexandru Stan <amstan@chromium.org>

Hmnn... almost wish I hadn't seen this ;-)

This basically says that your first patch will produce some odd
behaviour for existing device trees! On the other hand I strongly
suspect this trick is only currently seen on Chromebooks (since IIRC
that's where backlight animation is popular).

To be clear I'm entirely in favour of the changes in this patch... I
just dubious about combining it with artifically adding that 0%


Daniel.


> ---
> 
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> index 171ba6185b6d..af4b21636c08 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> @@ -20,7 +20,7 @@ / {
>  
>  &backlight {
>  	/* Jaq panel PWM must be >= 3%, so start non-zero brightness at 8 */
> -	brightness-levels = <0 8 255>;
> +	brightness-levels = <8 255>;
>  	num-interpolated-steps = <247>;
>  };
>  
> diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> index 383fad1a88a1..b25aa2f3cbee 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> @@ -39,7 +39,7 @@ volum_up {
>  
>  &backlight {
>  	/* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
> -	brightness-levels = <0 3 255>;
> +	brightness-levels = <3 255>;
>  	num-interpolated-steps = <252>;
>  };
>  
> diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
> index 069f0c2c1fdf..52a84cbe7a90 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-tiger.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
> @@ -23,7 +23,7 @@ / {
>  
>  &backlight {
>  	/* Tiger panel PWM must be >= 1%, so start non-zero brightness at 3 */
> -	brightness-levels = <0 3 255>;
> +	brightness-levels = <3 255>;
>  	num-interpolated-steps = <252>;
>  };
>  
> -- 
> 2.27.0
