Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0575C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A012C206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T2KW9+cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHaSfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHaSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:35:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:35:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id np15so352592pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PaGS2uzZD7Kro0ekXrFmFn9ksemHuyaMEDFaP9+HbTs=;
        b=T2KW9+cbq+bqJgzBohyRO9AXZ3t79XlryYl2YWgCmE3YqwFUr81ry3FUWcjyJVBn2p
         xjUiO7MYKO0Tw2gcFcTizQ+dODXK/SBA/KJoFX14hCv9TfWUpeCFG8aMapGwzAQzQ/jC
         CUxdbq35dkUogDSODZNByRWqf3iSNZL4s+x/7gdWYV4MO23W0Bqllva69SV6xWeoO1bW
         AoeECFKdDvFuMr1sobC9HzMtIWYkGrNGudHSNN/e/cXOkz5RJ9ypvz5zfeEc8uX6cXfH
         xf1+FbWEUCOlvRUfKptkUNx4keIbYJlo65lPoprmtXsrrdyMhf91Dq6Q82Mp3bsvfIsM
         8WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PaGS2uzZD7Kro0ekXrFmFn9ksemHuyaMEDFaP9+HbTs=;
        b=TZp/W1o8AKk7T6wxxVMFToFXyhNChQVhd3JQQGCzcRZCyHZ+JdATrM91fSaRCk6QoR
         CG3dcU6ziRpUHgOEzBYODqrveDC0Vr6Bz+n7KQYSmzwviDsX7ycrXFH/Vj/8TcgN51iP
         qJdACxROZga7/kYayQWrRG6+Hf8164K2KvIEU89sAJtnfnr9wSwt+vw6N/J2aFgzkbHS
         lcRTvKYyoq927Cne7UZQLL40aJFMnLC/S1yJFEYoBtdgghGQVxjM322pkS+wp39pDSQH
         8lf6T1B7h/qZ/UGWh2Oy8rWXRpLHTbttG6XQHSc5ZojVfbAsIrEcsMY59+YDcX0U/3KI
         WucA==
X-Gm-Message-State: AOAM533067fLPmezfQqV7lvW3X4YprM7Knk+OyPlX9jyyIErir78OJJf
        y/wf7NZqbf66bEn2TALfAZ4iaQ==
X-Google-Smtp-Source: ABdhPJxl7Hyfd0zkkHCY81kxkFxx+yC3S6h+KZ79YUwFh9A3MjdXBXFG/oy7hPyTVIgBJNx4CMvGKw==
X-Received: by 2002:a17:90a:764d:: with SMTP id s13mr611974pjl.58.1598898944292;
        Mon, 31 Aug 2020 11:35:44 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y1sm8088311pgr.3.2020.08.31.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:35:43 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: use wrapper to avoid accessing internal vars
In-Reply-To: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
References: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
Date:   Mon, 31 Aug 2020 11:35:43 -0700
Message-ID: <7hv9gy7jeo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa+renesas@sang-engineering.com> writes:

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
> Only buildtested. Found while analyzing retune-handling in the core.
>
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05acb..a1db8685e30e 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -521,7 +521,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
>  	val |= ADJUST_ADJ_EN;
>  	writel(val, host->regs + host->data->adjust);
>  
> -	if (mmc->doing_retune)
> +	if (mmc_doing_retune(mmc))
>  		dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
>  	else
>  		dly = 0;
> -- 
> 2.20.1
