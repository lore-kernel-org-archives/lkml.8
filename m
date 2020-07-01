Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA3E20842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="CqKMPGfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbgGAQaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:30:23 -0400
Received: from vps.xff.cz ([195.181.215.36]:52700 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732502AbgGAQaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593621018; bh=S9sJvCFzXl3kRUEWnli4aokEH2QvfST8BIb1PIlWyhE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=CqKMPGfG+ZJjZFaUD1dUbV5kVUWVCS7R5aZdNFpb5wdgXELQscUaejOgiiEwCNQ1d
         8LU+q3KpyDQGV6ex0l/Vyg7KIZOxF4t0oeexWKdOWtia6k35AJ0KnYOk2jj/aBAo6F
         LSNVSGFpCFfeGDtEg+xZ8fwR2kPMshbOjQ4UZjZA=
Date:   Wed, 1 Jul 2020 18:30:18 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v6 00/13] Add support for PinePhone LCD panel
Message-ID: <20200701163018.cfweuzp76qx5nsew@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701152532.GA670324@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701152532.GA670324@ravnborg.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On Wed, Jul 01, 2020 at 05:25:32PM +0200, Sam Ravnborg wrote:
> Hi Ondrej.
> 
> On Wed, Jul 01, 2020 at 12:31:13PM +0200, Ondrej Jirman wrote:
> > This patchset adds support for the LCD panel of PinePhone.
> > 
> > I've tested this on PinePhone 1.0 and 1.2.
> > 
> > Please take a look.
> > 
> > thank you and regards,
> >   Ondrej Jirman
> > 
> > Changes in v6:
> > - Fixed spacing in yaml
> > - Fixed wrong vccio->iovcc supply name in the bindings doc
> > - I noticed that the original driver uses a delay of 20ms in the init
> >   function to achieve a combined total of 120ms required from post-reset
> >   to display_on. I've added a similar delay to xbd599_init, so that
> >   xbd599 panel also has the right timing. (patch 9)
> > - v5->v6 diff: https://megous.com/dl/tmp/v5-v6.patch
> > - Added review/ack tags
> > - Learned to run dt_binding_check by myself ;)
> The patch-set does not apply clean on top of drm-misc-next - due to
> vrefresh removal.
> Please re-spin.

Sorry for that. Rebased and retested.

thank you,
	o.

> 	Sam
