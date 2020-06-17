Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D4020DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="RSTp/x25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgFQCAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:00:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:45304 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgFQCAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1592359249; bh=nfSFk/xxv2HPjCmgiQmTzC85XO7JsaYmjsZ2Hf0O8WA=;
        h=Date:From:To:Cc:Subject:References:From;
        b=RSTp/x25+vrf98bzteSPi+kPYJSJl7O5J4mEvqeDFgtzOodDhGQfnygpDh84JiXmH
         7U6a1om3H+8zqs/Y+QMNPTl24XwrWut/xPnaaHdCyotCcDDbC7Wqd3W7Oo213aSY9N
         XoVIbzOov26zePoClavc9rZy25sVMXE7VaGg/5M8=
Date:   Wed, 17 Jun 2020 04:00:49 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Linus Walleij <linus.walleij@linaro.org>
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
Subject: Re: [linux-sunxi] Re: [PATCH v3 3/5] drm: panel: Add Xingbangda
 XBD599 panel (ST7703 controller)
Message-ID: <20200617020049.iz6vujrs25kuipl6@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
References: <20200513212451.1919013-1-megous@megous.com>
 <20200513212451.1919013-4-megous@megous.com>
 <CACRpkdZpiQ7E_v-Gfk6vFcUEiMazvixYaL0ksKeP=Tq3O6Fh=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZpiQ7E_v-Gfk6vFcUEiMazvixYaL0ksKeP=Tq3O6Fh=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Tue, May 26, 2020 at 01:32:25PM +0200, Linus Walleij wrote:
> Hi Ondrej,
> 

[...]

> > +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
> > +                         0x82, 0x10, 0x06, 0x05, 0xA2, 0x0A, 0xA5, 0x12,
> > +                         0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
> > +                         0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
> > +                         0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
> > +                         0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
> > +                         0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> > +                         0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> > +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
> > +                         0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +                         0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
> > +                         0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
> > +                         0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> > +                         0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
> > +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0A,
> > +                         0xA5, 0x00, 0x00, 0x00, 0x00);
> > +       dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
> > +                         0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41, 0x35,
> > +                         0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12, 0x12,
> > +                         0x18, 0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41,
> > +                         0x35, 0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12,
> > +                         0x12, 0x18);
> > +       msleep(20);
> 
> This stuff is really hard or impossible to understand without the
> datasheet.
> 
> In my previous review I wrote:
> 
> It appears that the Himax HX8363 is using the same display controller
> if you look at the datasheet:
> http://www.datasheet-pdf.com/PDF/HX8369-A-Datasheet-Himax-729024
> There you find an explanation to some of the commands.

It is st7703, and we have a fairly complete datasheet available
publicly. I posted links in the cover letter.

> That means, try to get rid of as much of the magic bytes as you can
> and use proper #defines. I know it takes some work but the result
> is so much more useful and readable.

I've added some descriptions from the datasheet as comments next
to the values in v4.

Thank you and regards,
	o.

> Further I wrote:
> 
> You should definately insert code to read the MTP bytes:
> 0xDA manufacturer
> 0xDB driver version
> 0xDC LCD module/driver
> And print these, se e.g. my newly added NT35510 driver or
> the Sony ACX424AKP driver.
> 
> So please do that.
> 
> Yours,
> Linus Walleij
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/CACRpkdZpiQ7E_v-Gfk6vFcUEiMazvixYaL0ksKeP%3DTq3O6Fh%3DQ%40mail.gmail.com.
