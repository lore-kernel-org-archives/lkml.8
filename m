Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F1C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B28222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1sFXJWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBZTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:06:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32878 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:06:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so605406qkm.0;
        Wed, 26 Feb 2020 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=M9niB/YnWE/mLPULIH87VulO14ku7TY288Cxvxcfeys=;
        b=m1sFXJWAMrJMsYaGgcCtAGpf8EaIm5PCgIxV1iKtHvR5+dpc9QTf8u/9ABYitkG6pd
         TwsZyKmjIRrTUsColw9pGQXQCoQNDIZd7WwGlTUjMliBWyK8lL2om+9ZK07C/wnLwmWN
         lC71l0SyiMyslAqAQKKdiKOsCt31Xu2kIU0rS5fyLp9vR/4+zsVwGo+NwzMHdAIwg/xT
         xeHZCSAseH+k80jLpc4q5H2bp3nD3XG9uZ1PjOxgzpdlAt2XFiyyZB0MAVn69B6+ryZN
         SDAK2u3KTjT4U7Z6s+hqWOs8q7xdQggpcqJ92L85lVRcT4qJVy1pqf7BWZ5Bi6Q+nWr9
         ly4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=M9niB/YnWE/mLPULIH87VulO14ku7TY288Cxvxcfeys=;
        b=FXtPPigFAH8Kjd9ZyvLON3uOaafpWnFkTaC7YQj6KhqDxwf3rfQv6WYauyGY0tmjEN
         LcAibq8c9uOAYHslhCDRXR7RMOAdAtpujh72oLUp+91y/KTZXJidsate6GlNKfD/BBvK
         UcN4emlz1Nyknm/5JQiXiMGwvdBnCi/VqrvTUTi+tzsBTzILAFhHIcHYPRIv0n5Q5zzz
         3ykwdzjyEJKDX4QjOAYagU3gZBhVKtvZqFUruz2aQl1fdGM+AVWyZXJSdaOVIqexS+Jr
         wCzpTM251MI3GDFZ35EOX5nciQVLPK2u3SLkqtwHckrZLVLMk/dyQIUYseawXB1X+t7S
         GlqA==
X-Gm-Message-State: APjAAAWVctJg/4Tw7xe1mRlumjk01HRmazshAJdzS0Wdk1af1Q9/GPxy
        YwKIXeKnIbbO9FMmZepG6wFHONIQMHWIeltPnpE=
X-Google-Smtp-Source: APXvYqyjurfsyKDoTMJ4WSbU70QdA9TtasCgybTEtfeAuvAhr0Qw4NI8q5lbdJVqkzh7xKqVEaAqdPQ+oRW7x7VyHlI=
X-Received: by 2002:ae9:f012:: with SMTP id l18mr712442qkg.22.1582744002146;
 Wed, 26 Feb 2020 11:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20200226081011.1347245-1-anarsoul@gmail.com> <20200226081011.1347245-2-anarsoul@gmail.com>
In-Reply-To: <20200226081011.1347245-2-anarsoul@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 26 Feb 2020 11:06:34 -0800
Message-ID: <CA+E=qVdUV5wBcyFpwPZvi4=8bPgVBZiRB0XrEE=SPJT+cTgZ9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/bridge: anx6345: Fix getting anx6345 regulators
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:10 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> From: Samuel Holland <samuel@sholland.org>

This patch can be dropped since equivalent was merged:

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6726ca1a2d531f5a6efc1f785b15606ce837c4dc

> We don't need to pass '-supply' suffix to devm_regulator_get()
>
> Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index 56f55c53abfd..0d8d083b0207 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -712,14 +712,14 @@ static int anx6345_i2c_probe(struct i2c_client *client,
>                 DRM_DEBUG("No panel found\n");
>
>         /* 1.2V digital core power regulator  */
> -       anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12-supply");
> +       anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
>         if (IS_ERR(anx6345->dvdd12)) {
>                 DRM_ERROR("dvdd12-supply not found\n");
>                 return PTR_ERR(anx6345->dvdd12);
>         }
>
>         /* 2.5V digital core power regulator  */
> -       anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25-supply");
> +       anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
>         if (IS_ERR(anx6345->dvdd25)) {
>                 DRM_ERROR("dvdd25-supply not found\n");
>                 return PTR_ERR(anx6345->dvdd25);
> --
> 2.25.0
>
