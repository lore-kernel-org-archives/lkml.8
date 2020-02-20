Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5832EC11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F58A206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q19syPFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgBTVhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:37:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39150 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:37:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id a141so5048353qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvOgxeV6q/hz2jhw1BkYuFW6F6UgnXyc569e2Apg3tI=;
        b=Q19syPFVhTWGp6aA8lun7A2sKPtueu+qDwkZzlHsVmpLdjYgwB91YcQG/QrVmDN1Sn
         +6b+40av8D746PqIyCMbOjNcm+rHX8lhkgtuILyQPRf3wyWUC/mXsCliywHmhQz4FOHs
         qaN4tU6vq7eTotiGTpgvTd+SxZ55u6/LLf4rmBwtFFuzGEOhLOoVl/YhpoD9cibv6m8V
         0myYdFJ5oN8kLfUTjXAJgA0BIdP+3s7L6MV9NMA7n4xuNhq3nwa2XaG5bcbcxDCl8SnC
         WwUYOhGdacD7XtVU82PQAMiDwpgLSFIwkAgEwvePPoIo+Pkwzkq8Rd4K5AhJqzDY9cwo
         //xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvOgxeV6q/hz2jhw1BkYuFW6F6UgnXyc569e2Apg3tI=;
        b=WxkbIbxWTWa1/HiytqpDVNWwgy0bnCWQ3PAn1cHU2oZw01cSvC+C3/IajrEnrq3pV1
         GrdN+Cmul/qw6fj6KQK3IO0fV5tktZtvrcRz18+OL8GFE4wNOR585xuqT1WY8Z2cBeUj
         UkPXlMbWZegfatxl/6LDmmu+DsVd5RYlnyLygiNx6l3i+lb87kXM4/M9oGiAcvmVlIq2
         PkOzDb876VyLf9MkjWThHGPpDWaKkJGG4SnY1snb6Vc+P35LUDoTE49NpqFKr6gzTRkM
         4Kr93xQPHCqYuOJKm674HfMAtW3QEHb18/eLyZ5+ELyNev4najGOKNr6AqQdxqG8OZ7w
         iKdQ==
X-Gm-Message-State: APjAAAWvUQKN40lXV5RgNPFEsfRWZXsAaCQna7Y6q6c8GCsq5+sagHyL
        FCYxS9SSCA3BBNk1MSRbGDR/N1/a3BPrp96E+pk=
X-Google-Smtp-Source: APXvYqwuaNU/g8DZUMOkoTNKLgQBVvRTS4yLUHrZxtp6GWR40atVUC4MMgB8849+KTbNIVrCXT1WjazgLPyKD1Pt5zY=
X-Received: by 2002:a37:b285:: with SMTP id b127mr3341955qkf.413.1582234634423;
 Thu, 20 Feb 2020 13:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20200220083508.792071-1-anarsoul@gmail.com> <20200220083508.792071-3-anarsoul@gmail.com>
 <20200220135259.GC4998@pendragon.ideasonboard.com>
In-Reply-To: <20200220135259.GC4998@pendragon.ideasonboard.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 20 Feb 2020 13:37:01 -0800
Message-ID: <CA+E=qVeJfFZudSfM_U8n1r543oyYf+oGCma_fH-vNEQ9vZUP2w@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/bridge: anx6345: Clean up error handling in probe()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 5:53 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Vasily,

Hi Laurent,

> Thank you for the patch.
>
> On Thu, Feb 20, 2020 at 12:35:04AM -0800, Vasily Khoruzhick wrote:
> > devm_regulator_get() returns either a dummy regulator or -EPROBE_DEFER,
> > we don't need to print scary message in either case.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > index 0d8d083b0207..0204bbe4f0a0 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > @@ -713,17 +713,13 @@ static int anx6345_i2c_probe(struct i2c_client *client,
> >
> >       /* 1.2V digital core power regulator  */
> >       anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
> > -     if (IS_ERR(anx6345->dvdd12)) {
> > -             DRM_ERROR("dvdd12-supply not found\n");
> > +     if (IS_ERR(anx6345->dvdd12))
> >               return PTR_ERR(anx6345->dvdd12);
> > -     }
>
> There could be other errors such as -EBUSY or -EPERM. The following
> would ensure a message gets printed in those cases, while avoiding
> spamming the kernel log in the EPROBE_DEFER case.
>
>         if (IS_ERR(anx6345->dvdd12)) {
>                 if (PTR_ERR(anx6345->dvdd12) != -EPROBE_DEFER)
>                         DRM_ERROR("Failed to get dvdd12 supply (%d)\n",
>                                   PTR_ERR(anx6345->dvdd12));
>                 return PTR_ERR(anx6345->dvdd12);
>         }
>
> But maybe it's overkill ? With or without that change (for the second
> regulator below too),

Thanks, I'll do as you suggested.



> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> >       /* 2.5V digital core power regulator  */
> >       anx6345->dvdd25 = devm_regulator_get(dev, "dvdd25");
> > -     if (IS_ERR(anx6345->dvdd25)) {
> > -             DRM_ERROR("dvdd25-supply not found\n");
> > +     if (IS_ERR(anx6345->dvdd25))
> >               return PTR_ERR(anx6345->dvdd25);
> > -     }
> >
> >       /* GPIO for chip reset */
> >       anx6345->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>
> --
> Regards,
>
> Laurent Pinchart
