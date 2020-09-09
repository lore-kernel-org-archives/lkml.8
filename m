Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5EBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B0E22269
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lq0jJ4wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIIPLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgIIL6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:58:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D9C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:58:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so3180498ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veMOlwm85HGnlMSTVN952J/Jqjc/7rvdCvDfPKEre0c=;
        b=Lq0jJ4whRo5WT/1EwrgGOl0XtPUPtvtGXLC81q5hE5FLoHPxnCgByqRckcoRWhj69y
         8POlYqx76p1PczfUYqXfb+R7q5w0oL+bb5PyhrPpsQU6UKMKeUmSKkDaAL+s7kMke30d
         YiGusFifL3kjDo2Y3BUUdRoscclcabbbQiDZACAMH/75Q1mpxTyMd9tTtFm3ATcURbyg
         04CbyAHdOELljt3QOr0smY9DXjCBobqHTrbDupSNhYUX41fkK4Xwy4UFEbq3Cdo/dBpR
         ZqwdOCqg5JfSW9dyYIRNMjwnVLuw8KhzqqZqiD74IP0vOQ4EN43WzK6XOkONzPBpOh5Y
         r9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veMOlwm85HGnlMSTVN952J/Jqjc/7rvdCvDfPKEre0c=;
        b=ByCsIqsI5CX2yvVEeg17Tz2XcGU7UOtDH4jB3aK6BD0VZ9LvHGDaOWnihs3tkyH9F7
         z+zaCy6V38NVp5etFhBztolHuvh++kGCZ1Kpfh2tbrqowmhcGP+jlHKd4XsdVkYdq0pr
         tGVZKQ8g/Pe2DpwsDvPFmZ4Gen1yFFiXwNxBYs8O6d5Kms5dB9m7FDjLWE8L6BrFY5NT
         Xq6wqolVQtPYFU3qNhSBRvNxvUjf443kOdcajm+Xs041Kf23pvHovLXPCsZjPKzy1UFY
         2dIRAWSVidkc8/+cBn1TMUsxJlJDE+YEotJH/SofzA+6LYV0eRxj4kQk4RNIP4rFU1tJ
         AZVg==
X-Gm-Message-State: AOAM531/QdD3HJ6EW9HXhiJHED7VY4fM5EZ6A4fw9LZGTN9hBeeJXubB
        8tTZgBMPDHYDCjnXBd5GO3W8HmObxmRy08zZPe9Ijw==
X-Google-Smtp-Source: ABdhPJwCf3FmxgZrTisFeaRuj2pxBcn3CZA8Jzyk/0TkRmXwR5H+xd9VJWHscFXDHtkwCveC2Trx20irnwH9IVujNcM=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr1687459ljl.104.1599652679725;
 Wed, 09 Sep 2020 04:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200822163250.63664-1-paul@crapouillou.net> <20200822163250.63664-4-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-4-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Sep 2020 13:57:48 +0200
Message-ID: <CACRpkdaN7S9PoYd2d-hxUNq9NXA52P0TugwRzyFuCTCc6Onp=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm: Add SPI DBI host driver
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I looked a bit at this patch

On Sat, Aug 22, 2020 at 6:33 PM Paul Cercueil <paul@crapouillou.net> wrote:

> +config DRM_MIPI_DBI_SPI
> +       tristate "SPI host support for MIPI DBI"
> +       depends on DRM && OF && SPI

I think you want to depend on SPI_HOST actually.

> +       struct gpio_desc *dc;

This dc is very much undocumented, so I can only guess what
it is for, please add some kerneldoc explaining what it is.
I suppose it is in the DBI spec but I don't have it.

> +       gpiod_set_value_cansleep(dbi->dc, 0);

Since it is optional I usually prefer to do it like this:

if (dbi->dc)
   gpiod_set_value_cansleep(dbi->dc, 0);

> +  gpiod_set_value_cansleep(dbi->dc, 1);

Since you drive this low when you assert it and
high when you de-assert it, inverse this and mark the
GPIO line as GPIO_ACTIVE_LOW in the device tree
instead.

> +       dbi->dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
> +       if (IS_ERR(dbi->dc)) {
> +               dev_err(dev, "Failed to get gpio 'dc'\n");
> +               return PTR_ERR(dbi->dc);
> +       }

Currently you are requesting the line asserted according to the
above logic. Is that what you want?

If you change the DT to GPIO_ACTIVE_LOW then this seems
correct.

But I am overall a bit curious about this "dc" thing. What is it
really? It seems suspiciously similar to a SPI chip select,
and then that is something that should be handled by the
SPI core and set as cs-gpios in the device tree instead.
It is certainly used exactly like a chip select as far as I can
tell.

Yours,
Linus Walleij
