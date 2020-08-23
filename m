Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27164C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE70A206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpiYIcuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHWQna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHWQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:43:27 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6153C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 09:43:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g14so6339854iom.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72AGIyZ7/chrx66NON3xoDnq09zkWUqUGGzNHoZVAyo=;
        b=tpiYIcuK5fYZPl3R0jfV567+ZZwhWr0FSMVdo1+AVUdoyUmir0NcpghkWjorKhX+JS
         q1T/rA6tQd1gqvkjOoc4pZR9sCBkTCeYrfoxFjiRipYr3Gbdqj+MlL52PFaEqXGsACb8
         nZiCVXUTy5Bc+y44qidgcV2gaer3fUL43d95Tv4a57nqaO/SoLPLvRpFoP+WeP0oTJnk
         xDJn2ZwyVyPQ8HzphmX3PPntC1gzdvqkB9m2tgh6gF8s9Srh+Dfypa+183SYJF8rDvJa
         SFfJpu6A7iyxlPJ0xOpXBFT9oYGm0GO81prDMw3YfOc82KoGtvrSxIRXR7lUeT6aFO3y
         ulTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72AGIyZ7/chrx66NON3xoDnq09zkWUqUGGzNHoZVAyo=;
        b=EEKKEdW2XyZel0M0grsOfTNu7vfl2ZyEbxnKYVclV3evZeUgw8MuE7ysjcysG0LYL9
         JcumYXb8ycD+LJwxKj5/pJxaXWaKiWWh1si+mzFkBeKRsaZCnohzB6bfbQwwXAjis0h0
         v+NarKmzYUG349VuOCgCtgLBwRSpsDlvXYwDFgMhes9fMRaaLHmszi3fcf2Sz4xmvV14
         tIuBGq6RkVbWg0kEvBCukdXZg08xvW/VpGx8o8H+jyykA3Jq6P7JIYNVbtSSZxNQ5sP0
         4s6mkS4z0TV5bY3/9vnrhITz0Wsl55sjnhNTcNM5olrFqzAz1mmiIXLhNWjCjO3XWPJ9
         Goqw==
X-Gm-Message-State: AOAM531y8BX0KTPOJya43TMrP4b0Z6/w9r3XNGt5dcQj1XNPBfrehvra
        2rksAfP1PXd1RQD851MtkHYYABWBdJX5Wdb3Wg0=
X-Google-Smtp-Source: ABdhPJw9XW73Ks1Mk+SxJLl501UzmDyDGidOcFbVjWrKBsIzfALOsE7OQnp6iM6Z8bQvSq5pqlDi2W3eZtL4fNGsHtc=
X-Received: by 2002:a5e:8e0c:: with SMTP id a12mr1583460ion.147.1598200999791;
 Sun, 23 Aug 2020 09:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <1597557042-5154-1-git-send-email-simhavcs@gmail.com> <20200823150522.GA1047718@ravnborg.org>
In-Reply-To: <20200823150522.GA1047718@ravnborg.org>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Sun, 23 Aug 2020 22:13:07 +0530
Message-ID: <CAGWqDJ4-iBRmdDAdHj+0dwpMiXdW=p_SDySjdeU6PR7VOuGs_g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fix for PTR_ERR
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sam.

On Sun, Aug 23, 2020 at 8:35 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Sun, Aug 16, 2020 at 11:20:41AM +0530, Vinay Simha BN wrote:
> > passing zero to 'PTR_ERR'
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
>
> Applied to drm-misc-next - thanks.
>
>         Sam
>
> > ---
> >  drivers/gpu/drm/bridge/tc358775.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> > index 7da15cd..d951cdc 100644
> > --- a/drivers/gpu/drm/bridge/tc358775.c
> > +++ b/drivers/gpu/drm/bridge/tc358775.c
> > @@ -684,7 +684,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >
> >       tc->vdd = devm_regulator_get(dev, "vdd-supply");
> >       if (IS_ERR(tc->vdd)) {
> > -             ret = PTR_ERR(tc->vddio);
> > +             ret = PTR_ERR(tc->vdd);
> >               dev_err(dev, "vdd-supply not found\n");
> >               return ret;
> >       }
> > --
> > 2.7.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
regards,
vinaysimha
