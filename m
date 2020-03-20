Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBFC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CE720754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s09Wp38Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCTNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:30:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39236 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgCTNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:30:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so3277504wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s6NlNBz5JabYM7cmGqE8XzWKbyl9fJfmEfdQ5l/oU3Q=;
        b=s09Wp38Yl9D/BXm38cmJgGPi0UqMy1rBmBFtHIfPgWs3qOVc4KyCW68gFgC6sqGOlB
         jz/2CgAIG4Z86LceTEe+1zjlO/Fo1IECFE5A+avANLmx8T9hSj8HpV1PNp0HJ4nkbvr9
         w/6J0RX5hWBJZHJkXMqtDVmhO7Oi3GPGv8l+Mw9OcKAQNTXnBhNgE65/RtWoz2KBhGCo
         T6SZZwu/9P54Us9BE+P3EeQ4kpcOe+/TxL5F+jeppKCmwyECfpUfo9D+5HwthNn+XOZQ
         2/+ahfHQtav6UCiN/qtcm9rOmsdcm1rRpK/30JxrAvC2jNt6WBWPBDuSuypXAshrAOCU
         j4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s6NlNBz5JabYM7cmGqE8XzWKbyl9fJfmEfdQ5l/oU3Q=;
        b=uaJV2iULPCNIWQLHmYt8zOzy0fK6VcpALhh74IashMR96CMjgl0UopF+O4CskeVgZ5
         3ul3ss8bI+EPnabtY8PTfdWpG/ZwbCyFSk5+vhMcVamgd6YCS9n05OGIicAb1ePtWOfv
         opYyxY0y9aJGxNWD9tc5vypS/OQil7WQzr4k18GOh9sOpGNgg6ZYADriD3VVfMwAsfrz
         q88OwJua8D0eWMXj0MorlOSQkic1OBY9ncXoRGbuuHFv2/yysZpsU/jMuiDHu5bBm5T8
         kl6T+eu8HDvjoBckOP2MYg12qzTkm0If0/hsH0HRlh5BXCk2bquoJPfVS76W6Ics5GQh
         3rNA==
X-Gm-Message-State: ANhLgQ1Y9LitD8QBLlKeFrVrBmLG9o1unsv3LJsrQS8Jf6V09mnhHdvu
        6j74Iv6X+dtSftSkzWQRGhS6ZQ==
X-Google-Smtp-Source: ADFU+vvlGfEGMnbI0JopCMtHtW1bL0mgS+eqdDxppBiwUxn2gHI7t8tKpw60msVbIuQpZZ91pK0jiA==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr10440117wmg.139.1584711038190;
        Fri, 20 Mar 2020 06:30:38 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id i4sm8758565wrm.32.2020.03.20.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:30:37 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:31:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Message-ID: <20200320133123.GD5477@dell>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:

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

Can this patch be taken on its own?

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
