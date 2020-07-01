Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B145C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF172067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="a/cVqSQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgGAKez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:34:55 -0400
Received: from vps.xff.cz ([195.181.215.36]:42944 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgGAKey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599692; bh=B7kWQsfpsGr8GvlX/z/EdaUkxTMac7sQsGSIptCqVQE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=a/cVqSQJeci9mwW2INPMd6BuXqViGSBir/xjSPUR3Df3hcV+pzYZosoSHUHT0o2GX
         Op3mZ9UoCxzoidvMK3P6lWYVlLNFONzbOF9a0NmK5IwJqY1ZJQPCynM7DKy7s118y3
         SQ/7qhljisG3F7W8VnkQ3GND12mq3LLxvLaryu+8=
Date:   Wed, 1 Jul 2020 12:34:51 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
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
Subject: Re: [PATCH v5 09/13] drm/panel: st7703: Add support for Xingbangda
 XBD599
Message-ID: <20200701103451.67worsg3wvupyuoh@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
References: <20200626005601.241022-1-megous@megous.com>
 <20200626005601.241022-10-megous@megous.com>
 <CACRpkdZcMA_Y_eH8_TL09Z0_DADDcUy5s_S45UfrnoSKmNgtXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZcMA_Y_eH8_TL09Z0_DADDcUy5s_S45UfrnoSKmNgtXw@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Wed, Jul 01, 2020 at 09:50:40AM +0200, Linus Walleij wrote:
> On Fri, Jun 26, 2020 at 2:56 AM Ondrej Jirman <megous@megous.com> wrote:
> 
> > Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel used in
> > PinePhone. Add support for it.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you very much for the review. :)

I've sent v6 which should fix the currently remaining issues with dt bindings
+ one timing issue I've found in this patch. I've kept your reviewed-by tag,
because it's a fairly trivial issue. But feel free to complain.

thank you again and regards,
	o.

> Yours,
> Linus Walleij
