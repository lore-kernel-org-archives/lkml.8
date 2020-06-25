Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34035C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120C62072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHHYFSoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403888AbgFYJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbgFYJla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:41:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6608C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:41:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g18so5154818wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1jD7J8NDVqOQc9AKq7CATicHwQZYtpzJ7cR9sOfFqw=;
        b=KHHYFSoy24G/mXyVtLft9wFkNpYC2Pktesf5tHqTuFFWhOYFY1uLmbdKS9K7U4hBvQ
         n7iwkmWESbQO2d3LySeThLR8EMVDTCNtpIF/0NoRbndmxwkd59b0E0TEA+EScemuQz3w
         BUZ82dIyTxeMrB+/XJg38uVhDfKVznLpqjf27nHqgvNpoAAyXfuX13zFn/cepgtKDKVf
         gos2hUBI6fOo+KynmRO1otG/CrSzPyazUoownlH2w66Xl1P2qh4QDEfkz8iC7yhmbao2
         hjyaIoRYWZwRMfSxsu5SExtGw8xmz9TPS5M3MyRUnRgnD5xIqmw7hKs5YJrpFIDnV4Uy
         gJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1jD7J8NDVqOQc9AKq7CATicHwQZYtpzJ7cR9sOfFqw=;
        b=K0aIVB1mA+YfMH1DixMKHpcAvtENk5whkenV+kRDy1E7cztcQQDcPDsCqDDJtiDV/H
         sEiLY9IXeZ4P4009TMDbvh7nu7eDgnYnfONowcqPXIdwBzYLVMkdynptbjSz/HAQHAQ7
         7L5hnx6B0n3WWoEVCrnlUiCoBCvBtXTLld92htDsiqqx3Qf2di/jM0gizCk01mlsZXNn
         PXZp2DGSmkYCQDQHZZwQ1SAoPZRRN7moBfVNAxXL0EvJrCd9cb40cGah+ZPv0fsdhJHn
         /d3V8AcvVHhcSzSaaU+dGOPpCyjbRdWZbiGleG0r0fUWOL7jFqw05Nmsmbqc11yKIZL5
         /UBg==
X-Gm-Message-State: AOAM5332YNo3MXTtdA5XK8ZcJ0cwuXPYJaOF9o77O44POT7DfODemf+5
        yTFq2sieXhR1pTtl5TWmr8C5esRoV88=
X-Google-Smtp-Source: ABdhPJwqVIF3U4RpHKFRh/x+HzkKFYCTnP8uQGV7G4OL1b+Bw0pR+kNSz0MBfG7un3od3TOn8lviaA==
X-Received: by 2002:adf:8462:: with SMTP id 89mr20649914wrf.420.1593078088492;
        Thu, 25 Jun 2020 02:41:28 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o7sm9921492wmb.9.2020.06.25.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:41:27 -0700 (PDT)
Date:   Thu, 25 Jun 2020 10:41:26 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: Re: [PATCH 4/8] backlight: ili922x: Remove invalid use of kerneldoc
 syntax
Message-ID: <20200625094126.jp5e7x64sjdu7med@holly.lan>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624145721.2590327-5-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:57:17PM +0100, Lee Jones wrote:
> Kerneldoc is for documenting function arguments and return values.
> 
> Prevents warnings like:
> 
>  drivers/video/backlight/ili922x.c:127: warning: cannot understand function prototype: 'int ili922x_id = 1; '
>  drivers/video/backlight/ili922x.c:136: warning: cannot understand function prototype: 'struct ili922x '
> 
> Cc: <stable@vger.kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Software Engineering <sbabic@denx.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/ili922x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> index 8cb4b9d3c3bba..cd41433b87aeb 100644
> --- a/drivers/video/backlight/ili922x.c
> +++ b/drivers/video/backlight/ili922x.c
> @@ -123,7 +123,7 @@
>  
>  #define set_tx_byte(b)		(tx_invert ? ~(b) : b)
>  
> -/**
> +/*
>   * ili922x_id - id as set by manufacturer
>   */
>  static int ili922x_id = 1;
> @@ -132,7 +132,7 @@ module_param(ili922x_id, int, 0);
>  static int tx_invert;
>  module_param(tx_invert, int, 0);
>  
> -/**
> +/*
>   * driver's private structure
>   */
>  struct ili922x {
> -- 
> 2.25.1
> 
