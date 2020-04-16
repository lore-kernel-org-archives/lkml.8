Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC7C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FBB21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF93gO4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504080AbgDPJn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503681AbgDPJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:43:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E843AC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:43:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so3859116wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HGxQAf4jzO0Y72QET7kmxlzHV6ZBerU4O88zy1fdfpU=;
        b=MF93gO4SxOKB+qMBCapHcHMZU0uM5bpS0SLZlRWzKz2vzZa6uzWpvbbHmobJw6Axls
         QFbr4PiLPQVCBaA283wChwtst2isWHpmYZCkMdabMfE5kIfxyqwTGzA0Oh3gLfQ7+qht
         Gr+qzkKMNCKQBYc4xDFiFXf+bN+ljZmDJTXOSbEbkin7y9u1t1lVjadCyGVDT7u3Qlvg
         MLFFL50zXCqauyOmSnhvmXGHAU4QsZNR56g0QGsGJk1OJc37DNYzZ8A0B7v53rZEave3
         +dAJT6Hw1W5aJbccuFdyz7QCBJGawOEsWCQtES9T5+pEJd3hRu7iNIcAQh12pLwlmDF5
         pajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HGxQAf4jzO0Y72QET7kmxlzHV6ZBerU4O88zy1fdfpU=;
        b=oLNPsOIC6o7VZTb6LwvS1Nskw0az1m8YDzlC2hljqziO6v/wT2RdKAT9fQt3bFzOki
         BDkPTlLbiAiSn0xQKMqNvJ70QExklMN4JW2x2UpjqvG6whCa4FwmYn7u1nIvPIcXtAGH
         lkK8DL92Qubs1CH/LxS3Ee/AXVsmAOv29li5I+UnLtO9QCJ8SdeqJMmfUy8jmu1mBr7V
         8KXCuSYcveLDFCz1I/m5NPOk6VkRfjblEsuVNPKuY3IGOIsQL7eE6qq9YEj8jpxbYBEU
         +XaRvfvLf9y0cvotDcW1BCX46reZpR1oG0AN3Qc2QeWOzofTNutIQ5damYFsonyLwCNy
         314g==
X-Gm-Message-State: AGi0Pub+4QJoVEzfBjtI/TVBTJWqoSnxEJ4QSilmfxsB7rYMupesH0dg
        6+xxlD4mpIUIxZRDse6G4ZustA==
X-Google-Smtp-Source: APiQypJ76t5SrWztUDY3rBe8WJkYQzpZ53gL1ZUvzn8pvMoGaJezCgphDoFggL9MkZuivZ/hxX5NFA==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr3721926wml.132.1587030200692;
        Thu, 16 Apr 2020 02:43:20 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id z15sm14612513wrs.47.2020.04.16.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 02:43:19 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:44:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v12 09/11] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200416094420.GB2167633@dell>
References: <cover.1586414867.git.gurus@codeaurora.org>
 <e2139a83008e9f301889f9384487c55de475a6a2.1586414867.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2139a83008e9f301889f9384487c55de475a6a2.1586414867.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020, Guru Das Srinagesh wrote:

> Since the PWM framework is switching struct pwm_state.period's datatype
> to u64, prepare for this transition by using div_u64 to handle a 64-bit
> dividend instead of a straight division operation.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I see that this is part of a large set, but the remainder of the
patches have been hidden from me.

Does this mean I can apply this patch on its own?

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

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
