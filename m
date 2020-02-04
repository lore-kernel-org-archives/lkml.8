Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58B22166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UX3nLFOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgBDJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:34:30 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33014 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgBDJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:34:30 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so13836759qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 01:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qpsKRCqtVgfj8tu6tU10wGF0V1/J4SqlhXKuSnenORM=;
        b=UX3nLFOHi3gIGKvTdXHJbFxYnvRnisObk0J3+wW2vTMQUOrIqhaWXQvhFg3/Zh1KVF
         ROu3c+tBy6SiaZWBOgVA7ubUPghwIq/emYPlFUytA8jV5nhaSr7gt7qx4UIZuo9IDCMx
         MckjYiQ97F4ATDnwoLQv/+EdJogrc94SwBlFk+IHPhMoSwhgwSH0XS62q4MLPrAlqxAv
         Jg7fbXUwmUQZkbWFljgkkPR3sMFfW2WfTb4LZqdGIs73ZYfnOZGavmFuNxqs1NFtmXOc
         bgc53w3AcSO1jqA38rrkQNe4WxbH/kDxcjJghdjiqweuGV9DDjAjh4LqGE8BxlQ+dh7J
         AWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qpsKRCqtVgfj8tu6tU10wGF0V1/J4SqlhXKuSnenORM=;
        b=fG92OHlGHUnSRTa+a/P5dL9DbKAmC0x0C2Uvg1ZiwuB3D9RIH/Np9Vlp5rPneT05oN
         qrZgtfC+CGkf423zmcuzSzv4gMDWBWW+V1aDU65BkyX75t2QR/bi7Aden1x8TGFn80Fy
         C4FxAYWVpS/4njT3GF3M6wxn+xejRYJ3ewtg7K0oTmoMGPRL7AF4iGqDt9Mh0x/dh1ic
         uRM3DyaZG8dh4AV3e/FpuX20aevY+6Vg87PhdACpgquM7lgdKFEriMCq3aP83NEfPdwN
         gj5I8KHtaEbFlsPjq/vjjZC63IdiseEw03xad0BjHjWWWXe3VkJUT7zMTmYKC1JXVxFd
         ldwg==
X-Gm-Message-State: APjAAAXqYTZz4ZhsTXE6R85Qa0C/linfpmgCxSWTT4mhg8AlTmKlwdDZ
        RW8p1gNeZwbmKlpvqYfSoxV/XOASMhQWfz9vH6T3xg==
X-Google-Smtp-Source: APXvYqyaC+88MpAySDesiNwLBufJcQEB/bABzBOCHTb3qij+8VwlxK2t9pFZcvefw7EuG7b9hgeV4sanl8A6Q+vWg2A=
X-Received: by 2002:ac8:3676:: with SMTP id n51mr27397583qtb.208.1580808868098;
 Tue, 04 Feb 2020 01:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20200203125551.84769-1-sachinagarwal@sachins-MacBook-2.local>
In-Reply-To: <20200203125551.84769-1-sachinagarwal@sachins-MacBook-2.local>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 4 Feb 2020 10:34:17 +0100
Message-ID: <CAMpxmJWBAx=_4=xPU9STN04tYficUrpKSu7B6qZ=Tu3-xta__w@mail.gmail.com>
Subject: Re: [PATCH 6/6] GPIO: it87: fixed a typo
To:     sachin agarwal <asachin591@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 3 lut 2020 o 13:56 sachin agarwal <asachin591@gmail.com> napisa=C5=82=
(a):
>
> From: sachin agarwal <asachin591@gmail.com>
>
> we had written "IO" rather than "I/O".
>
> Signed-off-by: Sachin Agarwal <asachin591@gmail.com>
> ---
>  drivers/gpio/gpio-it87.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
> index b497a1d18ca9..79b688e9cd2a 100644
> --- a/drivers/gpio/gpio-it87.c
> +++ b/drivers/gpio/gpio-it87.c
> @@ -53,7 +53,7 @@
>   * @io_size size of the port rage starting from io_base.
>   * @output_base Super I/O register address for Output Enable register
>   * @simple_base Super I/O 'Simple I/O' Enable register
> - * @simple_size Super IO 'Simple I/O' Enable register size; this is
> + * @simple_size Super I/O 'Simple I/O' Enable register size; this is
>   *     required because IT87xx chips might only provide Simple I/O
>   *     switches on a subset of lines, whereas the others keep the
>   *     same status all time.
> --
> 2.24.1
>

Patchwork seems to be confused by this series - or maybe you just sent
another iteration without a version number? Anyway - please see other
patches on the list, adjust your subject message and send the entire
series at once using git send-email.

Bart
