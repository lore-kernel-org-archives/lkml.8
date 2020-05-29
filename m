Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7860C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819FF20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590789304;
	bh=90nMNMJZG3bE6EONlBgplDhLtYLcosIsBsMQPBXQX5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rRHJESFs/YKl9BtIZqTl9Z+bkyuieDROCcNjWF5RjkRXhEJoHH/DYM6i9mz0lvhDG
	 O9jiAFCcGvDClT33eTsby7SvcctA5QTIOZnQikZSM8EopIIYArCTN6GfZOiyOz+e3f
	 lV2BUjaw7Sslx2aipFGv/Yy2HCT7Dbjv7sDXTPyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgE2VzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgE2VzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:55:03 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE4920897;
        Fri, 29 May 2020 21:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590789302;
        bh=90nMNMJZG3bE6EONlBgplDhLtYLcosIsBsMQPBXQX5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vl65MHJ2VWrBN3QVABldy5J+oYUDjGIJIdHVsGWB4EAqqA2wh8iDjxttk1uv/G8u6
         AfNomewL5esdgfno+4IYHbkNA+dfyvq6dWntRDcXdSGAHjNl7sn00mnZPyLxEX/ZFi
         iatsQ0JyWihsGNcSybTjTPM1Pq70976o+gyQEymY=
Received: by mail-oi1-f179.google.com with SMTP id b3so3917849oib.13;
        Fri, 29 May 2020 14:55:02 -0700 (PDT)
X-Gm-Message-State: AOAM531eUE/8JyOiHZu87vlJ31e9JONAkvGGOlzsWLfcTs91A2RZ+iOZ
        5tlnRTGw4Yc2W7tN1wxRTmskGYwKbdBl6mofLA==
X-Google-Smtp-Source: ABdhPJxIY/0QhqrBJ9IPX5ItnGlWYG6SbttnUxbw31iB150uuosHqwH393VTbbRuU9m5Bwbq+6XIOKFUfnsaCLKBpGo=
X-Received: by 2002:aca:564a:: with SMTP id k71mr7374718oib.147.1590789301910;
 Fri, 29 May 2020 14:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
In-Reply-To: <20200512134154.GC2085641@kuha.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 May 2020 15:54:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
Message-ID: <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 7:42 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi guys,
>
> On Mon, May 11, 2020 at 01:46:35PM -0700, Prashant Malani wrote:
> > Hi Rob,
> >
> > Thank you for reviewing the patch. Kindly see my comments inline:
> >
> > On Mon, May 11, 2020 at 02:28:00PM -0500, Rob Herring wrote:
> > > On Wed, Apr 22, 2020 at 03:22:39PM -0700, Prashant Malani wrote:
> > > > Add properties for mode, orientation and USB data role switches for
> > > > Type C connectors. When available, these will allow the Type C connector
> > > > class port driver to configure the various switches according to USB PD
> > > > information (like orientation, alt mode etc.) provided by the Chrome OS
> > > > EC controller.
> > > >
> > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > ---
> > > >  .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
> > > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > > > index 6d7396ab8bee..b5814640aa32 100644
> > > > --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > > > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> > > > @@ -21,7 +21,21 @@ properties:
> > > >      const: google,cros-ec-typec
> > > >
> > > >    connector:
> > > > -    $ref: /schemas/connector/usb-connector.yaml#
> > > > +    allOf:
> > > > +      - $ref: /schemas/connector/usb-connector.yaml#
> > > > +      - type: object
> > > > +        properties:
> > >
> > > These don't seem CrOS EC specific, so why document them as such.
> >
> > Are you referring to the "mode-switch", "orientation-switch" and
> > "usb-role-switch" properties? If so, then yes, they aren't Cros EC
> > specific. The Type C connector class framework requires the nodes to be
> > named like this, and the cros-ec-typec driver uses this framework, hence
> > the description here (the Type C connector class framework doesn't have
> > any bindings).
> >
> > Would it be better to add in the description string that Type Connector
> > class expects these switches to be named this way? :
> >
> > " Reference to a DT node for the USB Type C Multiplexer controlling the
> > data lines routing for this connector. This switch is assumed registered
> > with the Type C connector class framework, which requires it to be named
> > this way."
> > >
> > > > +          mode-switch:
> > > > +            description: Reference to a DT node for the USB Type C Multiplexer
> > > > +              controlling the data lines routing for this connector.
> > >
> > > This is for alternate mode muxing I presume.
> >
> > Yes, that's right.
> > >
> > > We already have a mux-control binding. Why not use that here?
> >
> > Heikki might be able to offer more insight into why this is the case,
> > since the connector class framework seems to expect a phandle and for
> > the device driver to implement a "set" command. Heikki, would you happen to know?
>
> The mode-switch here would actually represent the "consumer" part in
> the mux-control bindings. So the mux-controls would describe the
> relationship between the "mode-switch" and the mux controller(s),
> while the mode-switch property describes the relationship between
> something like USB Type-C Port Manager (or this cros_ec function) and
> the "mux consumer".

The "USB Type-C Port Manager" is not just the parent node in your case?

Can you point me to what you expect your DT to look like showing the
mode switch node, the connector, the USB host(s), and the DP/HDMI
bridge/output?

Rob
