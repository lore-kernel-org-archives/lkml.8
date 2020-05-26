Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC466C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAFB2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxHGmW0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgEZLcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgEZLcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:32:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA373C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:32:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l15so23680185lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3aU8bQ2jt19toIdkwK4iimsCUAHj37+zUJ/z8dG82c=;
        b=TxHGmW0M/1J5kA67dTHib6mjP7IqlmXB9GlPXLnj3brNAtLjENIk88ciWY00CFrxgh
         m+RVHnNpqmSoAmn0koZ4VVVv6Q8kij/9A1DQWcHw5NKCJPlqkcB/PoNqDhyiWHyl1iaj
         zEPAGqTTOUnZBomUlkcEEjud7qxatQaGdOU7DXRnWr8MnBbpiXXPwEQFgujvP3Mhq0jt
         KgGPg0GPrFObpIdq9Qmg9LZXRK6i2WYpw5FgQEWoJqeiLwnsW8YIpZroi2BnnirKRE1u
         Te3lMIxX9v3MiDlAkkFy2ES3BpkILyrkkioDjGf+EdIFsoI0j5f3Z1YOQU0m5o9ZCAGa
         zNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3aU8bQ2jt19toIdkwK4iimsCUAHj37+zUJ/z8dG82c=;
        b=AGIqaLRJlWZNzawFegAJuD9cwVCqrzLM6EE4bbzaji0JwYvNdNerJGbtbAGtL6pg61
         vFOJ0mQC+o6SyRpukFP8v1Q5DgVGuezxtb8ApQhwjq5VQff+pjU5NJYSMVjXOwCJ/StS
         3EDH5CA0t8rstAOOzLfisGbFW9l8w1aIgG3URG3AZhgmKyWYloFZRElCpVC4cmp8qDEw
         8ED2jYppqDBj5jZZzfzBmSegMQkeVCNo5cAfdu5dcXqBmigmo/LRjx/FjsPrmiP3ov/3
         j0mmjG65sG2IvKR+WVM7hVZh/oU9rECnCnb65BOy1115mcP3E4C7kOaes4EFK7q1eVjA
         xCQQ==
X-Gm-Message-State: AOAM531PpdrrFmx5jFl06ZLyoZqs6ppA2ghkhy6dtfipqV8IN0RpStZ5
        rRSbJeaHBU6TpKLxLQIrCWSxYp6bOpv6D3XuCD/NKA==
X-Google-Smtp-Source: ABdhPJxM6A8ot4e/2DXXh6aue4hLFO5ial0ZBwWU8vJG+VNoWIczU4kxVWFCMR36ozh5h1OSlYeLxEUkI+61oop6giU=
X-Received: by 2002:a05:651c:32d:: with SMTP id b13mr401630ljp.283.1590492757082;
 Tue, 26 May 2020 04:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200513212451.1919013-1-megous@megous.com> <20200513212451.1919013-4-megous@megous.com>
In-Reply-To: <20200513212451.1919013-4-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 13:32:25 +0200
Message-ID: <CACRpkdZpiQ7E_v-Gfk6vFcUEiMazvixYaL0ksKeP=Tq3O6Fh=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm: panel: Add Xingbangda XBD599 panel (ST7703 controller)
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

I see you took over this driver submission from
Icenowy.

On Wed, May 13, 2020 at 11:24 PM Ondrej Jirman <megous@megous.com> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
>
> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI IPS LCD panel made by
> Xingbangda, which is used on PinePhone final assembled phones.
>
> It is based on Sitronix ST7703 LCD controller.
>
> Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

(...)
>  create mode 100644 drivers/gpu/drm/panel/panel-sitronix-st7703.c

Nice!

> +       /*
> +        * Init sequence was supplied by the panel vendor.
> +        */
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETEXTC,
> +                         0xF1, 0x12, 0x83);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETMIPI,
> +                         0x33, 0x81, 0x05, 0xF9, 0x0E, 0x0E, 0x20, 0x00,
> +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
> +                         0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4F, 0x11,
> +                         0x00, 0x00, 0x37);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER_EXT,
> +                         0x25, 0x22, 0x20, 0x03);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETRGBIF,
> +                         0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
> +                         0x00, 0x00);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETSCR,
> +                         0x73, 0x73, 0x50, 0x50, 0x00, 0xC0, 0x08, 0x70,
> +                         0x00);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0xF0);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETEQ,
> +                         0x00, 0x00, 0x0B, 0x0B, 0x10, 0x10, 0x00, 0x00,
> +                         0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
> +       dsi_dcs_write_seq(dsi, 0xC6, 0x01, 0x00, 0xFF, 0xFF, 0x00);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER,
> +                         0x74, 0x00, 0x32, 0x32, 0x77, 0xF1, 0xFF, 0xFF,
> +                         0xCC, 0xCC, 0x77, 0x77);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP, 0x07, 0x07);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM, 0x2C, 0x2C);
> +       dsi_dcs_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
> +
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
> +                         0x82, 0x10, 0x06, 0x05, 0xA2, 0x0A, 0xA5, 0x12,
> +                         0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
> +                         0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
> +                         0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
> +                         0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
> +                         0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> +                         0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
> +                         0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                         0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
> +                         0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
> +                         0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> +                         0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
> +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0A,
> +                         0xA5, 0x00, 0x00, 0x00, 0x00);
> +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
> +                         0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41, 0x35,
> +                         0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12, 0x12,
> +                         0x18, 0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41,
> +                         0x35, 0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12,
> +                         0x12, 0x18);
> +       msleep(20);

This stuff is really hard or impossible to understand without the
datasheet.

In my previous review I wrote:

It appears that the Himax HX8363 is using the same display controller
if you look at the datasheet:
http://www.datasheet-pdf.com/PDF/HX8369-A-Datasheet-Himax-729024
There you find an explanation to some of the commands.

That means, try to get rid of as much of the magic bytes as you can
and use proper #defines. I know it takes some work but the result
is so much more useful and readable.

Further I wrote:

You should definately insert code to read the MTP bytes:
0xDA manufacturer
0xDB driver version
0xDC LCD module/driver
And print these, se e.g. my newly added NT35510 driver or
the Sony ACX424AKP driver.

So please do that.

Yours,
Linus Walleij
