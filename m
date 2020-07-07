Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8934C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F22063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cMV4O526"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGGObA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:31:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:30:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so45341979wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/oOweGFZ71/+tsNkwIzGzUP4aNTXLla47u2EcUT5RrM=;
        b=cMV4O526QIuFt9d/79h4qZvrbkvrAYfmp5ZdUgWcthRR3sDFbrkCdPi2fN7qBP8K5+
         loagT9pLRQBPfiP1fzOfHStXtw04NWgrAiXxdzxQl31ieCSZFoFJCmPZQaC7T16hB46u
         bt2q1+6LihVig2zj4ZMd2+z0Eo5smjK98Y2/HLvBr0yLeE0d46/I8NdARlmTov8jlsOQ
         RsWovZIXQqHZZbWLCz26hHQANmc6JgUstJvNzhWZ32LjgQ/AmvumkJ0+Cg5261j0SqjA
         YvjoDUUvXY4oHICbeyD2YEus5nh6bQHUOVJFe01GW4jvWVm6cPyyy7somBcjgMvPf65K
         esQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/oOweGFZ71/+tsNkwIzGzUP4aNTXLla47u2EcUT5RrM=;
        b=bnVAVY4II1zXUe7ivJ7rQyjwdWyF6VSjVMvZQQS1cYkmV846DngC1ew3ukPajfptEK
         UwFUWfv7ZCOy8rnIoKyjeIFJ6qgoshul29niM4GJisHddFxaFXbbSb2Qne9OiFj172DD
         mevLBGa8VzRzufrXoGEaFglb7gpjqCqc+l56Y//99OHu3f+ZbcDj8Nkz0wOiZygABMZ9
         6ZUYUoSvvot27KDjKmosl0MhKc8C0YFnvWY/yNMw/ZGbZJTh2GtdwkYpnBoGRm3ilo1G
         X20ZD4JWhCmn7nL3kCB2tOmhbr1QU3v2/ke7j6SpNr2Cv8YAm5wHaHG6qF7FBT5J+0NX
         eM5g==
X-Gm-Message-State: AOAM530eK4A3Qvznchk/hY4MqGvrZONe1AvXtj4LV9ozkYXT8BvpyJOf
        7b9GH+6aNoKJL3vHvJYpvH/o/JiE/fuDhQ==
X-Google-Smtp-Source: ABdhPJy0E1hLYBsajAh5TcPYK/0DuF9Dd79KM1DEWe8SSbPHhaFUGOoVXjODs9Gbr5AqlFeL7pdTgA==
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr54148798wrr.202.1594132258354;
        Tue, 07 Jul 2020 07:30:58 -0700 (PDT)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l14sm1392235wrn.18.2020.07.07.07.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:30:57 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: overlay: fix build failure
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20200707135009.32474-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <0b645063-22bd-46ae-9b5f-f0beb3afb3b7@baylibre.com>
Date:   Tue, 7 Jul 2020 16:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707135009.32474-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2020 15:50, Neil Armstrong wrote:
> The recent GCC compiler is very picky with the VD_H_START() and
> AFBC_DEC_PIXEL_BGN_H() macros, triggering a runtime assert error as:
> 
> In function 'meson_overlay_setup_scaler_params',
>     inlined from 'meson_overlay_atomic_update' at
> drivers/gpu/drm/meson/meson_overlay.c:542:2:
> ./include/linux/compiler.h:392:38: error: call to
> '__compiletime_assert_341' declared with attribute error: FIELD_PREP:
> value too large for the field
> 
> drivers/gpu/drm/meson/meson_overlay.c:413:4: note: in expansion of macro
> 'AFBC_DEC_PIXEL_BGN_H'
>   413 |    AFBC_DEC_PIXEL_BGN_H(hd_start_lines - afbc_left) |
>       |    ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:392:38: error: call to
> '__compiletime_assert_401' declared with attribute error: FIELD_PREP:
> value too large for the field
> 
> It's not expected to overflow these fields, but the compiler did
> find a case where it overflows.
> We can safely ignore this, so mask the value with the field width.
> 
> Fixes: e860785d57306 ("drm/meson: overlay: setup overlay for Amlogic FBC")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> Got Daniel's Ack from irc
> 
>  drivers/gpu/drm/meson/meson_overlay.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
> index 1f7b2055e012..646e605f30f3 100644
> --- a/drivers/gpu/drm/meson/meson_overlay.c
> +++ b/drivers/gpu/drm/meson/meson_overlay.c
> @@ -58,7 +58,8 @@
>  
>  /* VPP_POSTBLEND_VD1_H_START_END */
>  #define VD_H_END(value)			FIELD_PREP(GENMASK(11, 0), value)
> -#define VD_H_START(value)		FIELD_PREP(GENMASK(27, 16), value)
> +#define VD_H_START(value)		FIELD_PREP(GENMASK(27, 16), \
> +						   (value & GENMASK(13, 0)))
>  
>  /* VPP_POSTBLEND_VD1_V_START_END */
>  #define VD_V_END(value)			FIELD_PREP(GENMASK(11, 0), value)
> @@ -144,7 +145,8 @@
>  #define AFBC_MIF_BLK_END_V(value)	FIELD_PREP(GENMASK(11, 0), value)
>  
>  /* AFBC_PIXEL_HOR_SCOPE */
> -#define AFBC_DEC_PIXEL_BGN_H(value)	FIELD_PREP(GENMASK(28, 16), value)
> +#define AFBC_DEC_PIXEL_BGN_H(value)	FIELD_PREP(GENMASK(28, 16), \
> +						   (value & GENMASK(12, 0)))
>  #define AFBC_DEC_PIXEL_END_H(value)	FIELD_PREP(GENMASK(12, 0), value)
>  
>  /* AFBC_PIXEL_VER_SCOPE */
> 

Applied to drm-misc-next
