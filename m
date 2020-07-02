Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278AAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40422075D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lX8T++fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGBVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:03:58 -0400
Received: from vps.xff.cz ([195.181.215.36]:54796 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgGBVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593723835; bh=qx6y7nV6jj3BHruvR1/CLbOoFCUwVFPgvliOfLPoSqI=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=lX8T++fZST2Y6z6GOVTS2C6MYo+cHeZtLwodiQKkKzvlxsrpj54vsDxGeAV1RCtI2
         6bXixOpjS1KCD1AjK3ExUSJCaSiqmTDacRL67+zZ2DZqB74g45SyFzozPrOrkyU1j1
         4AkV/S+Avm44Z2p+Rha3WY8m85QT5CtiQTNaMsW0=
Date:   Thu, 2 Jul 2020 23:03:54 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, Bhushan Shah <bshah@kde.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-sunxi@googlegroups.com, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 02/13] dt-bindings: panel: Convert rocktech,
 jh057n00900 to yaml
Message-ID: <20200702210354.562wkzpdmyrlwojx@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>,
        Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, Bhushan Shah <bshah@kde.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-sunxi@googlegroups.com, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20200701162928.1638874-1-megous@megous.com>
 <20200701162928.1638874-3-megous@megous.com>
 <20200702205143.GA1670522@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702205143.GA1670522@bogus>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 02:51:43PM -0600, Rob Herring wrote:
> On Wed, 01 Jul 2020 18:29:17 +0200, Ondrej Jirman wrote:
> > Convert Rocktech MIPI DSI panel driver from txt to yaml bindings.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  .../display/panel/rocktech,jh057n00900.txt    | 23 -------
> >  .../display/panel/rocktech,jh057n00900.yaml   | 66 +++++++++++++++++++
> >  2 files changed, 66 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> > 
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: '#address-cells', '#size-cells', 'port@0' do not match any of the regexes: 'pinctrl-[0-9]+'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'vcc-supply' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'iovcc-supply' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'reset-gpios' is a required property

Paths look bogus ^^^^

It should be .../rocktech,jh057n00900.yaml: ...

regards,
	o.

> 
> See https://patchwork.ozlabs.org/patch/1320690
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 
