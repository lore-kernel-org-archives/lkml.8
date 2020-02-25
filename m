Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80732C35E02
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D094222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582639391;
	bh=4qn639jYpkdf96gHfdgJKSoL+lKpXNE16GpYcCHFXTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RR88g4Ap/JMDJwoSpErMbQhcf8EPHnPKa8lzsMML5FCjb41XLp3c8sOWNUIk8lQ3X
	 I17PM8iftOfROEOLHo2Z3AQM9srumxDo+4CUcZAoupawEqcmVOmvCYpIBz8AR2BpXp
	 2o/dEfXsLLCZt8G/5GyA5QFOcCo1zTRV33mp4u/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgBYODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgBYODJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:03:09 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304F3222C2;
        Tue, 25 Feb 2020 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582639388;
        bh=4qn639jYpkdf96gHfdgJKSoL+lKpXNE16GpYcCHFXTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqaAjA+1J37y6usfnHDwA4/OPvt8xEEcMGoo7tGxh/P0Vae37EDc4g8FeFQ734fso
         ujnVJrGDk7kz88ouzyl4RZj7pyWvILr85MF/rZsmxEpQDWYfMHPagkvnTe4Bvmfi6c
         +ZMYg64fbo2gpCPpTf/D5pugasetDk/eo77dBmBM=
Received: by mail-qt1-f176.google.com with SMTP id p34so9083679qtb.6;
        Tue, 25 Feb 2020 06:03:08 -0800 (PST)
X-Gm-Message-State: APjAAAXs5FRU0HuEtJQiGxCQYniLbIicK3XZno69ZKtiXGjBUPvtd6K0
        dJho0kJKKaRlJwC0OC/2AJjR0Y7SOZlZx2rmQg==
X-Google-Smtp-Source: APXvYqyY0f8YCsY0KVybyegDUL7R6z4tio3DOIbnu6bhfP9ELYYo0gmY/zYUsN5JJ1tibdP6DSvSpwzCZG6i3yyhwsE=
X-Received: by 2002:ac8:59:: with SMTP id i25mr54944784qtg.110.1582639387281;
 Tue, 25 Feb 2020 06:03:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <bf8aa2deea50cc3599caeb9ed1a07556353415df.1582533919.git-series.maxime@cerno.tech>
 <20200224184107.GA4189@bogus> <20200225115447.yntzkh3vfnw67ial@gilmour.lan>
In-Reply-To: <20200225115447.yntzkh3vfnw67ial@gilmour.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Feb 2020 08:02:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kBNkTApDoyQ55gwW2WpHo7ywJ-UJ=-vGmWYsvshRijw@mail.gmail.com>
Message-ID: <CAL_Jsq+kBNkTApDoyQ55gwW2WpHo7ywJ-UJ=-vGmWYsvshRijw@mail.gmail.com>
Subject: Re: [PATCH 29/89] dt-bindings: display: Convert VC4 bindings to schemas
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 5:54 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Rob,
>
> On Mon, Feb 24, 2020 at 12:41:07PM -0600, Rob Herring wrote:
> > On Mon, 24 Feb 2020 10:06:31 +0100, Maxime Ripard wrote:
> > > The BCM283x SoCs have a display pipeline composed of several controllers
> > > with device tree bindings that are supported by Linux.
> > >
> > > Now that we have the DT validation in place, let's split into separate
> > > files and convert the device tree bindings for those controllers to
> > > schemas.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > >  Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt              | 174 +------------------------------------------------------------------------
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml         |  66 +++++++++++++++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml        |  73 ++++++++++++++++++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml        |  75 +++++++++++++++++++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml         |  37 +++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml |  40 +++++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml         |  37 +++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml         |  42 +++++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml         |  34 ++++++++++++++-
> > >  Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml         |  44 ++++++++++++++++++-
> > >  MAINTAINERS                                                             |   2 +-
> > >  11 files changed, 449 insertions(+), 175 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > warning: no schema found in file: Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml: ignoring, error in schema: properties
> > Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'
> > Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.example.dts' failed
> > make[1]: *** [Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.example.dts] Error 1
> > Makefile:1263: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> >
> > See https://patchwork.ozlabs.org/patch/1242907
> > Please check and re-submit.
>
> Yeah, that was fixed in patch 31 ("dt-bindings: display: vc4: dsi: Add
> missing clock properties"). I'm not quite sure what the preferred
> approach here would be: I did a conversion as is of the binding, and
> then fixed it, or do you prefer having it all in the same patch?

A note in this patch should be enough. I do review these before
sending them. I was puzzled having one from you fail.

Rob
