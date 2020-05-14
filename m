Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81919C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D2B2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O18fRYkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgENQLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgENQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:11:38 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0F6C061A0C;
        Thu, 14 May 2020 09:11:37 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b18so1532738ilf.2;
        Thu, 14 May 2020 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pWAwL4iY43kHKyzq6JgPam8fDxHVDDtXpG7mRg32aJE=;
        b=O18fRYkJuCVHLzSDHMiTV/YEvTTqeLQpSzk7AUAl1veaDpHB0AhDrBCf6pG6NOIJ69
         IVKsNZ3fA75gmbzuDAe9ruH9MEFZd4RjPd5l7XMXsa9JnQglfU6WlqT5lKEfreMB5mpa
         yLiuZhfm1eIS1G/957nwLkHVLS+MHbLeJ+wOrXDXNXNqjYGERRRjU4frvhsoaaEfctCs
         TOK4ipsoWjopZW/F3wg+NJ2uwwRe8hgMBHYVXkuqgOqby141+OUTgLvFgNbfg3CODLo9
         TdoiXHXOZy+3W9snj2LFBt6LX/eRdGwR20ISOpHddhvO3HEKQmYx8gnopiazWe6kaubv
         UEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pWAwL4iY43kHKyzq6JgPam8fDxHVDDtXpG7mRg32aJE=;
        b=CK/IU3wAf7Ml7o/oouS4rFRY3+v0USZnpEHo30+KjSo5UuJbSgq3qwyTd37ReQDCzG
         BS1+2Lv/UzDrljWE75OekhkJH/sJvFps0z6j95f/Ocj91WdjmFs9tGN2y4Sr0PM1yt58
         cHraaJeDyriwLePOTXxzKebFYQMkhl+4hutVLqXqm5ZHzUeHq3OdZp1ZDHA2JDqyR+Xp
         bS8Y+GrIj7a35rqDHLjwyd5hyUL3O4S9BoQz/jaZhEErfx89C5GQ2M1CTiRHbW5FhFXm
         weIB2fU/sULEJ+m4EmAgp/KzTPSd/KhxidR9gM/nmG1UnUmTY7RvOwtoPZP4OqeFzjCd
         qJzA==
X-Gm-Message-State: AOAM530SHhqYJ+IAkVQkGiC542wOYKYcCrfv8m8cXzWcm2ZishK84uwC
        beqz0OP6KE0RcoThHZba6tiOWqP2/uBDBoN4U73wHDfn/Es=
X-Google-Smtp-Source: ABdhPJx6Rsp5ROFxXwYlYudzEUx9ly+h8b+Qj8M+Twx/mohFFLUuzJpw12Ch5e3R3mp3ipZq22gY7LfKaKb8NlNe79A=
X-Received: by 2002:a05:6e02:68e:: with SMTP id o14mr1854794ils.184.1589472696421;
 Thu, 14 May 2020 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-6-git-send-email-dillon.minfei@gmail.com>
 <CACRpkdbZoMDC-D12CByKJUZbu4shqixC=QrKwJUd8x=nyK7seQ@mail.gmail.com>
 <CAL9mu0LVsePqifEC+-FR+NxvuZT3UGpU86KhzaTqb7w_Px0z2g@mail.gmail.com> <CACRpkdbcD7i+kNoJ9YP5XXTtLi12=yzW5OBNzet5oRdwPYz=dA@mail.gmail.com>
In-Reply-To: <CACRpkdbcD7i+kNoJ9YP5XXTtLi12=yzW5OBNzet5oRdwPYz=dA@mail.gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 14 May 2020 16:11:00 +0800
Message-ID: <CAL9mu0Kdc4TqcGB7JYDWkOJqwvxX1m_026aB0iprkHTzN4HXoQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/panel: Add ilitek ili9341 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Walleij <linus.walleij@linaro.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:08=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, May 14, 2020 at 12:22 PM dillon min <dillon.minfei@gmail.com> wro=
te:
>
> > > > +       /* Gamma */
> > > > +       mipi_dbi_command(dbi, ILI9341_3GAMMA_EN, 0x00);
> > > > +       mipi_dbi_command(dbi, MIPI_DCS_SET_GAMMA_CURVE, 0x01);
> > > > +       mipi_dbi_command(dbi, ILI9341_PGAMMA,
> > > > +                        0x0f, 0x31, 0x2b, 0x0c, 0x0e, 0x08, 0x4e, =
0xf1,
> > > > +                        0x37, 0x07, 0x10, 0x03, 0x0e, 0x09, 0x00);
> > > > +       mipi_dbi_command(dbi, ILI9341_NGAMMA,
> > > > +                        0x00, 0x0e, 0x14, 0x03, 0x11, 0x07, 0x31, =
0xc1,
> > > > +                        0x48, 0x08, 0x0f, 0x0c, 0x31, 0x36, 0x0f);
> > >
> > > It seems to be copies of the stuff above, but why is there a differen=
t
> > > gamma if you use DBI?
>
> > for dbi interface, currently i just copy the code from tiny/ili9341.c.
> > as so many boards use this driver now, like raspberry pi, etc
> > i'm afraid it's will not work after modification. so, just leave the
> > original code there.
>
> OK if you move it to ili9341_config it will be clear which panels
> need this gamma and which panels need another gamma.
>
> I think there should be one ili9341_config for the new st,*
> variant and one for the old DBI variant.
>
Okay, it's a good idea to setup two different configs.  ili9341_dbi_config,
ili9341_dpi_config. first for old dbi variant, second for dpi variant.

> > anther question:
> > is there any panel driver have dbi & dpi or dpi & dsi supported? which
> > i mean support
> > two different panel interface in one driver.
> > thanks
>
> Usually you split the driver in three files becuase a driver can
> only list one initcall, and also it makes it modularized.
>
> There is nothing in-tree but look at my branch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/=
log/?h=3Dux500-skomer-v5.7-rc1
>
> You see how I split up the s6e63m0 driver in one SPI part
> and one DSI part:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/=
commit/?h=3Dux500-skomer-v5.7-rc1&id=3D6c0e1fb5df5fa8fa857dee65f6c0f54d06d1=
58a7
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/=
commit/?h=3Dux500-skomer-v5.7-rc1&id=3Dcfbf562cc709b53b62f5fbc7fedf176ffa17=
b088
>
> The overall idea should work the same with DBI.
>
> Yours,
> Linus Walleij
>
> Yours,
> Linus Walleij

Thanks for share, but i thinks it's not suitable to my case. the difference=
 is
for panel s6e63m0
1 spi only for panel register configuration
2 dpi for rgb video data transfer (drm_panel_init(..., DRM_MODE_CONNECTOR_D=
PI);)

my case:
1 support ili9341 by drm mipi dbi (only spi bus,  "3/4 line serial
interface", pdf chap 7.6.1), Ie, raspberry pi + ili9341 + spi
2 support ili9341 by spi & dpi (spi for register set, dpi for rgb
data, "6/16/18 bit parallel rgb interface", pdf chap 7.6.8)
   Ie, stm32f429+ili9341+ltdc+spi
these two communication type has no dependency with each other.

DBI has much more difference than DPI & SPI, or DSI & SPI in drm.
   drm_mipi_dbi support both panel register configuration and video
data transfer via spi
   with or without dc pins.
   also the registration to drm is difference, for dbi is
mipi_dbi_dev_init and drm_fbdev_generic_setup
   for panel driver is drm_panel_init and drm_panel_add
at soc's view, we can drive ili9341 to work just by drm mipi dbi
(actually it's dbi -> spi bus) without host's lcd or dsi controller
but for some panel can't transfer video data by spi, and with dpi or
dsi interface, must connect to host's lcd or dsi controller.

so, for ilitek-ili9341 , it's use different dts binding drive to
register different client type (dbi, or dpi & spi) to drm.
actually, there is a driver tiny/ili9341.c support this panel by spi
bus only already. but, from Sam's suggestion, should extend this
driver
to support dpi & spi interface, this is the background of panel-ilitek-ili9=
341.c

thanks.

best regards.

dillon
