Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83557C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430422226A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emliJK5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIIMSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgIIMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:02:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:38:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w3so3075892ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TRB6Tic1GvoiGHPifsUtG58oe6V1YvsitjQ6KJ/66o=;
        b=emliJK5rA3zlTRxM+50luD9JVQB0ZPuvNY685ZMFxWp093fTPI0cJqm8aTAbNsIiTz
         2ds0tcD3ClYK8rjenrmcTXJOSVRgu7vkGfdKXf5zBJHCYJlZnHthW81lKRdcw2KUhJ6S
         xjec6W8J4CK6kt7lSeqSbOI6n/zS7Q2YLGb1zoQgu4LmMmmwMhWwMiHED8UtEuyJ3pI/
         nje9lEDTdBZn54St/XUWCZkAMJhHArjPQyOHTT2d9xuNX6jbP/FN+FIfxw0dRd/B0hFI
         7cROlmz53FPr1jZDSK4O8YLelfhkSbWRC5sNHFNzmFsV1D31DecSDQvKgqGrD61dKzUW
         Gbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TRB6Tic1GvoiGHPifsUtG58oe6V1YvsitjQ6KJ/66o=;
        b=uQNMIDTFw0tNCYYIjTRSn7nfXBGC+iGBl8Bmzn3+RnD0On156v3P+kMtlBQUPsb7Ur
         PJRyE+R9QY6CK1N/3EOZjuHBvIv1GNjdzIBoFacaMgrFpZJy0E0P5Z9gBN/iQ6Wg+Ax5
         NAyMz5tOqKZZw8GnbLqYoIFJdv+we5tbe1XqGHsUY5u+ahR9NATqWkSzW33+pXQx44vG
         zalh+tBohr3miRzfYmFEtPfCuEBqdCcq/M/ueis0i0pa7SfFL5w0XMp11lP+wnPKU4ht
         nW4p4/giXTh4D5nMlsl50IfjENP5Qe+24qhS8egVDdnNN9VqJ18n8fSKHKuKrRAIiq7q
         toZQ==
X-Gm-Message-State: AOAM5333ICqnMf7kw2LsQJzxdNHVO9hDtLixFCKdJN1FVxgXpBFe8Oxm
        tC0fNGRoAZEPLvj8NO7KIH8YDPmVXrs+A47Zw3bMMA==
X-Google-Smtp-Source: ABdhPJxzR/ZCIG9jECMBKx/8boudGCTyC6bXc41iHHQbYiHLiewFVe1Xa8ySlp8DVpYdpTLW5W3ulcJ/fOZNxZYlnqk=
X-Received: by 2002:a2e:810e:: with SMTP id d14mr1827296ljg.100.1599651516160;
 Wed, 09 Sep 2020 04:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200822163250.63664-1-paul@crapouillou.net> <20200822163250.63664-7-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-7-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Sep 2020 13:38:25 +0200
Message-ID: <CACRpkdY8GnpK_Xiz6zRtj0G_LPKpLiopMsHR=9M3DU56eZMVzA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/panel: Add Ilitek ILI9341 DBI panel driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        od@zcrc.me,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

just a drive-by comment:

On Sat, Aug 22, 2020 at 6:33 PM Paul Cercueil <paul@crapouillou.net> wrote:

> +       gpiod_set_value_cansleep(priv->reset_gpiod, 0);
> +       usleep_range(20, 1000);
> +       gpiod_set_value_cansleep(priv->reset_gpiod, 1);

This implies that the reset line is active low.

I would specify in the DT GPIO handle that it is active low
and invert the above.

So:

reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;

gpiod_set_value_cansleep(priv->reset_gpiod, 1);
usleep_range(20, 1000);
gpiod_set_value_cansleep(priv->reset_gpiod, 0);

> +       priv->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(priv->reset_gpiod)) {
> +               dev_err(dev, "Couldn't get our reset GPIO\n");
> +               return PTR_ERR(priv->reset_gpiod);
> +       }

This would then fetch the GPIO as asserted (device in reset)
unless changed, but that may be the right thing to do actually.

> +static const struct ili9341_pdata yx240qv29_pdata = {
> +       .mode = { DRM_SIMPLE_MODE(240, 320, 37, 49) },
> +       .width_mm = 0, // TODO
> +       .height_mm = 0, // TODO

When nothing else works and data sheets are incomplete I
just take out a ruler and measure on the actual device.

Yours,
Linus Walleij
