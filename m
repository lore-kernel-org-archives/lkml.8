Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC7D20836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="bOsFxfpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGCKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:44:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:40334 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGCKov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593773088; bh=nrh0KH3J1yRnIENV/8zoqi7FGv+zeQdvh0IitngxK0Y=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=bOsFxfpm7+YVeVF6lMZ7ESyBG9Mwl6LGVE+CCno+DbO2ejqDClY6BUiSyoPu0TRYk
         Xa8+qSCWumhmlSTrd90JG6QCyWwxVOeP0KYLZVFFnmjy/fM6mfauaQF3X0jXFZQG+H
         FZw9vAu834beeDCk2qCS7l0BIkK+VRwyUrOKCbHM=
Date:   Fri, 3 Jul 2020 12:44:48 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
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
Message-ID: <20200703104448.iwhxk77d2hyrr3x5@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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
 <20200702210354.562wkzpdmyrlwojx@core.my.home>
 <20200703051155.GA1685118@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703051155.GA1685118@ravnborg.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On Fri, Jul 03, 2020 at 07:11:55AM +0200, Sam Ravnborg wrote:
> Hi Ondrej.
> 
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > > 
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: '#address-cells', '#size-cells', 'port@0' do not match any of the regexes: 'pinctrl-[0-9]+'
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'vcc-supply' is a required property
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'iovcc-supply' is a required property
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'reset-gpios' is a required property
> > 
> > Paths look bogus ^^^^
> > 
> > It should be .../rocktech,jh057n00900.yaml: ...
> 
> The example in nwl-dsi.yaml contains:
> 	compatible = "rocktech,jh057n00900";
> 
> So the example is checked against your updated binding.
> And the binding check fails because the example is no longer valid.

Ah, now I understand.

> This needs to be fixed as we do not wat to introduce new errors.
> Either the example or the binding needs the fix.

I think we can unrequire the supplies, but reset is needed really.

The panel only has one port, so there should be no address/size-cells
in the example, and port@0 should be just port to match existing binding.
If it had  multiple ports, port@0 would have to be inside ports { } node
anyway, according to the existing binding. Then add reset-gpios to
the example...

And that should fix it.

I'll prepare the patch shortly.

regards,
	o.

> 	Sam
> 
> 
> > 
> > regards,
> > 	o.
> > 
> > > 
> > > See https://patchwork.ozlabs.org/patch/1320690
> > > 
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure dt-schema is up to date:
> > > 
> > > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> > > 
> > > Please check and re-submit.
> > > 
