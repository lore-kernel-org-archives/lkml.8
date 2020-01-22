Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A96C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7521734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rocHCsiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAVKzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:55:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39927 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgAVKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:55:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so6636469wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yy5Pm6Chzs3nZ800EbMSsW7jSH1HwjtkYzsQKIFnm8w=;
        b=rocHCsiCeMC1gpXVMEd5t5GK6MZu9gxeI/GUSwU8+8FCQI16R2LHI3G4MWOh1lr3g3
         i1wiLGTmuLwe05mlGIErWGWzGoqLVAABV3NaILq2JqpGu7mjVMG0VWhHTkzHQYAGnHNW
         w5UKpjmG4Gd1NbGZRzJrNdIP/C0xnSuRunOmteVNAKpUcHu5mklqKMhQn+wY5GlzLYaj
         zeQwQ2vkEOUjwaMVA0Tjz2cECH5crF8FweVqeBt52Eur64fEAaeJKGW7XhCjUe0/IUTI
         B/X/CNzrO1eWv0TSaH0s7OQ+Zv9Ob8TeRHde5yOBtBPlR1dWivNW/PIeEIc/nhgezLE8
         ju5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yy5Pm6Chzs3nZ800EbMSsW7jSH1HwjtkYzsQKIFnm8w=;
        b=VdcSSgHqgZm1U7e9wu+eGTiyJajVXiONBgB1a6PRUf/VU7AyQmlEHM8uCHruuuTbhh
         IwROS0+VwpcmMVeqnwzyyZKUJ8j/8fdwb5yzHAETDXOzng/xy8tWOLNKxuhl+I0t19/i
         QMrHF4unheo1OUl2YBPt1YLXtK74kMww+5qe5fWVKM9rb/I/2I9I4pt+/jy4EvgokKVT
         JthpiJMwW/w2JUSXIVdKY4gz0siocfBPp5FeHl9Zsna7T8CkXHX3rCZfKSXyOisXRio1
         uByXRiu4LuQIsZut/eVQZDVmaKD4B/XY4uMTaRrx6cu0bxtB0ISxQMY8o8mN+F9tp3Zu
         MZoA==
X-Gm-Message-State: APjAAAXi48sTBSrtzLnm3VJFCZSzaNH3QmVunwCMEcTkssn35y1ZBFiM
        A0c6K4tYAILQjPw9qXFTXmj0AA==
X-Google-Smtp-Source: APXvYqzNbQ3MeYMpzTRW08neyXYjeyY3mAyF76V58Qsal/cqNuXZMYb5EXT6tBXSUfJrJImtvdHofw==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr2227038wmi.146.1579690542801;
        Wed, 22 Jan 2020 02:55:42 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z133sm1370588wmb.7.2020.01.22.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:55:42 -0800 (PST)
Date:   Wed, 22 Jan 2020 10:55:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, kgunda@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] backlight: qcom-wled: fix unsigned comparison
 to zero
Message-ID: <20200122105540.w5vrvs34zxmhkjae@holly.lan>
References: <20200122013240.132861-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122013240.132861-1-chenzhou10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 09:32:40AM +0800, Chen Zhou wrote:
> Fixes coccicheck warning:
> ./drivers/video/backlight/qcom-wled.c:1104:5-15:
> 	WARNING: Unsigned expression compared with zero: string_len > 0
> 
> The unsigned variable string_len is assigned a return value from the call
> to of_property_count_elems_of_size(), which may return negative error code.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> changes in v2:
> - fix commit message description.
> 
> ---
>  drivers/video/backlight/qcom-wled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index d46052d..3d276b3 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -956,8 +956,8 @@ static int wled_configure(struct wled *wled, int version)
>  	struct wled_config *cfg = &wled->cfg;
>  	struct device *dev = wled->dev;
>  	const __be32 *prop_addr;
> -	u32 size, val, c, string_len;
> -	int rc, i, j;
> +	u32 size, val, c;
> +	int rc, i, j, string_len;
>  
>  	const struct wled_u32_opts *u32_opts = NULL;
>  	const struct wled_u32_opts wled3_opts[] = {
> -- 
> 2.7.4
> 
