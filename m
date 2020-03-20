Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F5C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F93620773
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rq2K7aZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCTJSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:18:45 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41397 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCTJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:18:44 -0400
Received: by mail-vk1-f196.google.com with SMTP id q8so1536689vka.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ISVSnKmF/MakKn5Kt0SsXbF6hSdLTpfQPG8zF5GUvw=;
        b=rq2K7aZqr5ZlhOCPpZDpZZiXqSl7sFlboUSiiy7sgodjfwz6wWG+P0EVz8CZ/UOzxa
         U0ZfibIhlKx+gZUKS8l6/75yq9SVgK0fbSTixwbezuj2CpY69I03yIgXTsdnPdhUO4Qs
         sZLenYxULnV9MLchiMUHXbkcD503elboyjYY/AHedah/zjCh9jGyjs5iRi5rpys+pweK
         196yoqvVJbB9zapDDPEiny07lhgx4MKp6VgxRDcKht3JthA8nAY7idDdkUh3i0wVlYZ9
         C7JMu/jb/gzm8L3cQRU/qAcXRyUybgZ/9+W4qWY2QZ5uuKq8+xnVAQ1aSV2XvL0II9+s
         0OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ISVSnKmF/MakKn5Kt0SsXbF6hSdLTpfQPG8zF5GUvw=;
        b=SREOrNXZyr39gvpGdRFlrEPMvahZ/fdE9ZtiOqApxQPf7HIBySWzwCbzGpqBuLQiJk
         GolJPiH1vOPioXeUWhHBiB13qGe9/WEAFxl2gSEKuW/2GgvtOYmNvp++vym2t860DqBp
         eU2vpvYGvM80Dn1WnC214WImG4qzwfjpIDa7nzGZisx5o/634YR34paQB8U0yzj/Tw7k
         jELGUUhUlIOzC1nS8uDVEF/51LyOTbtgk7Xv9TvGdnjEPv//JlofXQRBE5NOXkjkAYeu
         kU9fifDMbpECzEKwPomgoOvb7BScVL2kXlnFK5KLslce4T3wCttG5DHc0oQQyTWSgM4Z
         qggQ==
X-Gm-Message-State: ANhLgQ0nmB26hL5x4YZmZ3PWiXMl4Pf0aJbDo3s+rFSnPyP4CRzNFw45
        g0Fp6sSJkIObE8Tfqhd3z86Gd3VbNe2kBHQbnB0MRQ==
X-Google-Smtp-Source: ADFU+vubD841oKMXD9X/IHF/SwMMr59cNF12qIJGQC98Ru0PzxwUkbXhLRuj3tsujKYP/IY02djiUsWk8Nnpg/XpzVE=
X-Received: by 2002:a1f:e9c1:: with SMTP id g184mr4605100vkh.30.1584695923452;
 Fri, 20 Mar 2020 02:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200316133503.144650-1-icenowy@aosc.io> <20200316133503.144650-4-icenowy@aosc.io>
 <CACRpkdahrHmXWpdqoApFEq6cW2gatMfds9SMZGwsUnNHt+J0aQ@mail.gmail.com>
In-Reply-To: <CACRpkdahrHmXWpdqoApFEq6cW2gatMfds9SMZGwsUnNHt+J0aQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Mar 2020 10:18:31 +0100
Message-ID: <CACRpkdZnTf2jPrPV++1HDk4tf2BK2NJnv5gkd-1Nc5KT3pu0NQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm: panel: add Xingbangda XBD599 panel
To:     Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So following up on this:

We should state in the commit message that this driver is for all
displays using the Sitronix ST770x display controllers.
The driver should be named panel-sitronix-st770x.c.

On Thu, Mar 19, 2020 at 3:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > +/* Manufacturer specific Commands send via DSI */
> > +#define ST7703_CMD_ALL_PIXEL_OFF 0x22
> > +#define ST7703_CMD_ALL_PIXEL_ON         0x23
> > +#define ST7703_CMD_SETDISP      0xB2
> > +#define ST7703_CMD_SETRGBIF     0xB3
> > +#define ST7703_CMD_SETCYC       0xB4
> > +#define ST7703_CMD_SETBGP       0xB5
> > +#define ST7703_CMD_SETVCOM      0xB6
> > +#define ST7703_CMD_SETOTP       0xB7
> > +#define ST7703_CMD_SETPOWER_EXT         0xB8
> > +#define ST7703_CMD_SETEXTC      0xB9
> > +#define ST7703_CMD_SETMIPI      0xBA
> > +#define ST7703_CMD_SETVDC       0xBC
> > +#define ST7703_CMD_SETSCR       0xC0
> > +#define ST7703_CMD_SETPOWER     0xC1
> > +#define ST7703_CMD_UNK_C6       0xC6
> > +#define ST7703_CMD_SETPANEL     0xCC
> > +#define ST7703_CMD_SETGAMMA     0xE0
> > +#define ST7703_CMD_SETEQ        0xE3
> > +#define ST7703_CMD_SETGIP1      0xE9
> > +#define ST7703_CMD_SETGIP2      0xEA

I should have seen the ST7703 prefix shouldn't I...

> This actually looks very much like an Ilitek display controller.
> Some commands are clearly identical to Ilitek ILI9342:
> http://www.ampdisplay.com/documents/pdf/ILI9342_DS_V008_20100331.pdf

I'm still wondering about the apparent similarity between
ST770x and Ilitek ILI9342, haha :D

> 1. Try to determine what the actual display controller
>   is. I think it is some Ilitek.

OK so this is Sitronix ST770x.

> 2. Write a panel-ilitek-ili9342.c (if that is the actual controller)
>   and parameterize it for this display controller the same
>   way we do in e.g. panel-novatek-nt35510.c or
>   panel-ilitek-ili9322.c, so you use the compatible string
>   to set up the actual per-display settings for this display
>   controller.

This should be panel-sitronix-st770x.c

Yours,
Linus Walleij
