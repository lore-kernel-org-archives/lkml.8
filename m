Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1647CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EC720663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LdnlEGic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbgF2UxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731337AbgF2TNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CCC00874C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:33:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so14509018wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JL/R2Gk95aMqnh/tOQo8+arLcYW1SEEkw+GXG7Cww8A=;
        b=LdnlEGiclZ040S0PvH/uCI8WKJc61uscxqQFG32CjFluZY/v34pQE8JQgmFmQvIUc9
         GTiSZYfWPQWyST6m5IYg7JVyEmhS5VwXue/3eNlKQ7XgaiFpjIhVfTKzRSoh055dHEAa
         GGhJ+zMVtf1/ybKgrQ1k0lcWRIyWH98pr/QEDf5QyDF4BCVnvysySZc/1J6i9eMKcVHk
         h0ieANMn67jrRhCtmalHq3VasAawNdNd5t7vjR9lVMB7ZHM5ifsBGUCBDX18ZGdsvbcx
         e8ZitnbQ/ruG1lH0JfJuN2Rsjtj2Ivio1H4tksSA/UWOobyw8rJRfHM48RqLq+DqD0dI
         2pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JL/R2Gk95aMqnh/tOQo8+arLcYW1SEEkw+GXG7Cww8A=;
        b=socKBuE6tMEHJRHF9YCP4EoXwiBfC53NWPNu/pt+8vc1TWSpEGHPFYzrWT1Ktrzp+u
         fA80alJw+woH0hCCHnrP4bPhLX/KHScJE1WcgzOYIt27ZB1lkoMUT3daXXNPLcyQgHXz
         KClnc0ImJugy9NB0NTz3taZzGthiJvHu4srmRgmVe6mI54kS16fl5Dx8EicM7qwGtvy2
         jcazOy0ojd2L7lwvn59vSly0uLQ7sQVVPzd1nvBPSr19Kno+PC7fc7THhwsipPukSHf4
         j9k0zahAAxXQGvL8ajdnvsit4DmKMhkrVr5zK/DJkvY7Qj0Pyc4kYDOUucbwY2xW471G
         H34w==
X-Gm-Message-State: AOAM532hyKQeB/jUy7/olOayfJ45+Y6E3grLDeq1Is39e2EF+eWytOPI
        DwQrXpDYA9FkBO8vMrjU0GTmNQ==
X-Google-Smtp-Source: ABdhPJxFsIK+1+mJoCnkvaEWujQLMpGkxdRXRSbuf57/8c2xw8a6zbtlo0FrgQZt5lSwuMDeWw721g==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr16120246wma.118.1593419592416;
        Mon, 29 Jun 2020 01:33:12 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id p17sm26734746wma.47.2020.06.29.01.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 01:33:11 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] drm/bridge/sii8620: fix resource acquisition error
 handling
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
References: <20200626100103.18879-1-a.hajda@samsung.com>
 <CGME20200626100110eucas1p24327c924dada0c2e86ecf0ab5b5af571@eucas1p2.samsung.com>
 <20200626100103.18879-4-a.hajda@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <15310ceb-64dc-db07-dad5-8a1fcb5433eb@baylibre.com>
Date:   Mon, 29 Jun 2020 10:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626100103.18879-4-a.hajda@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 12:01, Andrzej Hajda wrote:
> In case of error during resource acquisition driver should print error
> message only in case it is not deferred probe, using dev_err_probe helper
> solves the issue. Moreover it records defer probe reason for debugging.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/gpu/drm/bridge/sil-sii8620.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 92acd336aa89..389c1f029774 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -2299,10 +2299,9 @@ static int sii8620_probe(struct i2c_client *client,
>  	INIT_LIST_HEAD(&ctx->mt_queue);
>  
>  	ctx->clk_xtal = devm_clk_get(dev, "xtal");
> -	if (IS_ERR(ctx->clk_xtal)) {
> -		dev_err(dev, "failed to get xtal clock from DT\n");
> -		return PTR_ERR(ctx->clk_xtal);
> -	}
> +	if (IS_ERR(ctx->clk_xtal))
> +		return dev_err_probe(dev, PTR_ERR(ctx->clk_xtal),
> +				     "failed to get xtal clock from DT\n");
>  
>  	if (!client->irq) {
>  		dev_err(dev, "no irq provided\n");
> @@ -2313,16 +2312,14 @@ static int sii8620_probe(struct i2c_client *client,
>  					sii8620_irq_thread,
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>  					"sii8620", ctx);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to install IRQ handler\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to install IRQ handler\n");
>  
>  	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(ctx->gpio_reset)) {
> -		dev_err(dev, "failed to get reset gpio from DT\n");
> -		return PTR_ERR(ctx->gpio_reset);
> -	}
> +	if (IS_ERR(ctx->gpio_reset))
> +		return dev_err_probe(dev, PTR_ERR(ctx->gpio_reset),
> +				     "failed to get reset gpio from DT\n");
>  
>  	ctx->supplies[0].supply = "cvcc10";
>  	ctx->supplies[1].supply = "iovcc18";
> 

Nice helper, totally missed this patchset before !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
