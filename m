Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CBDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BF2208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591971644;
	bh=Fl3HUKMu1K3q6bPmTpsGaqOJ2dLXqqo2Jc+GTwYmfgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BfkIln94hbN+EhqRVWofkE3Amdp96BxA9YXMSOZ6Ek7XKLPOHXJXfI0Z6dUB+jCDA
	 QwmlPoqFdZIFj6fqZZHTUw4u/95b65gq03d6bl5S7a0iu1E9hMl1MPpu05LtwpMutw
	 sVQp4sP5GKmmn5oor3v+dI+15NOznqhwbLHWYC8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFLOUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgFLOUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:20:41 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D711020792;
        Fri, 12 Jun 2020 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591971641;
        bh=Fl3HUKMu1K3q6bPmTpsGaqOJ2dLXqqo2Jc+GTwYmfgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a/+/J1iS49mUnEeuImrCDcLO0z+eB0ouhjrEM85WcvIndatOtZTKJb0qpmLNOjgvu
         MNUlH9IMmN7Wwj24VAWDOSUQOaDgQq3L2ElPEIhnf5GF3fwIZNButRT84oBoN8dYp1
         5YBe6gl+xEB7duwoJ50xb9kKJ8Ix9QtHObrOUbLs=
Received: by mail-ot1-f54.google.com with SMTP id 69so7461803otv.2;
        Fri, 12 Jun 2020 07:20:40 -0700 (PDT)
X-Gm-Message-State: AOAM5314y+Y8AEOmiTKYZbUSdqDRlNEtYjtQ+64jNBFcIEwTR4FXZZVc
        Q+m20l0m/4yRYls8hZ8QZhuFb1OdPp60GcdifA==
X-Google-Smtp-Source: ABdhPJy1HC/0GsO5Wg92YDkWUmOMl7miyQft4+rXAimICcWWUmEDSlmxWKubpyp/0KIvb2B6kky77K3c9tjN1Sinu5s=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr11205503ots.192.1591971640172;
 Fri, 12 Jun 2020 07:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com> <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com> <20200612124634.GD3213128@kuha.fi.intel.com>
In-Reply-To: <20200612124634.GD3213128@kuha.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Jun 2020 08:20:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ORkzHchpD0qsH97zDJzXGj3jWy8=orXSVhNQd4kr9Kg@mail.gmail.com>
Message-ID: <CAL_Jsq+ORkzHchpD0qsH97zDJzXGj3jWy8=orXSVhNQd4kr9Kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 6:46 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2020 at 10:53:45AM -0600, Rob Herring wrote:
> > On Wed, Jun 10, 2020 at 9:34 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> > > > Hi Rob,
> > > >
> > > > Thanks again for the comments and feedback. Kindly see responses inline:
> > > >
> > > > (Trimming unrelated text from thread):
> > > >
> > > > On Tue, Jun 09, 2020 at 02:30:11PM -0600, Rob Herring wrote:
> > > > > On Fri, May 29, 2020 at 5:30 PM Prashant Malani <pmalani@chromium.org> wrote:
> > > > > >
> > > > > > Nodes truncated and unrelated fields omitted in the interest of brevity:
> > > > > >
> > > > > > // Chrome OS EC Type C Port Manager.
> > > > > > typec {
> > > > > >     compatible = "google,cros-ec-typec";
> > > > > >     #address-cells = <1>;
> > > > > >     #size-cells = <0>;
> > > > > >
> > > > > >     connector@0 {
> > > > > >         compatible = "usb-c-connector";
> > > > > >         reg = <0>;
> > > > > >         power-role = "dual";
> > > > > >         data-role = "dual";
> > > > > >         try-power-role = "source";
> > > > > >         mode-switch = <&foo_mux>;
> > > > > >         // Other switches can point to the same mux.
> > > > > >         ....
> > > > >
> > > > > The connector is supposed to have 'ports' for USB2, USB3, and Aux
> > > > > unless the parent is the USB controller.
> > > > Understood; so, coupled with Heikki's explanation (see below for where
> > > > I've pasted it), would it be something like so? (adding inline to the connector
> > > > node definition):
> > > >
> > > >             ports {
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >
> > > >                 port@0 {
> > > >                     reg = <0>;
> > > >                     usb_con_hs: endpoint {
> > > >                         remote-endpoint = <&foo_usb_hs_controller>;
> > > >                     };
> > > >                 };
> > > >
> > > >                 port@1 {
> > > >                     reg = <1>;
> > > >                     usb_con0_ss: endpoint@0 {
> > > >                         remote-endpoint = <&mode_mux_in>;
> > > >                     };
> > > >                 };
> > > >
> > > >                 port@2 {
> > > >                     reg = <2>;
> > > >                     usb_con_sbu: endpoint {
> > > >                         remote-endpoint = <&foo_dp_aux>;
> > > >                     };
> > > >                 };
> > > >             };
> > >
> > > The pins that can be reassigned can in practice go anywhere. We can't
> > > group them in any way. What do we do for example when the two sideband
> > > pins go to different locations?
> >
> > The sideband pins from the connector go to multiple places or the
> > sideband signal from a controller go to multiple connectors? Either
> > way, that's solved with multiple endpoints. In the former case, port@2
> > would have multiple endpoints with all the possible connections. The
> > general model of the graph is each port is a separate data channel and
> > multiple endpoints are either a mux or fanout depending on the data
> > direction.
>
> No, that's not what I'm trying to ask here. Bad example, sorry. I'm
> trying to understand why is it necessary to slit the connector into
> three separate interfaces?

Because it is easily 3 separate h/w components (nodes) that have a
link to the connector.

> There does not seem to be anything in the
> kernel that would benefit from that. Why isn't the connector described
> as a single interface in devicetree?

The connector was designed pretty much before there was any TypeC
support in the kernel. Bindings shouldn't be designed around the
*current* needs of a particular OS.

The simplest case for the connector would be:

usb@1234 {
  compatible = "vendor,some-usb-2and3-with-typec-controller";
  ...
  connector {
    compatible = "usb-type-c-connector";
    /* No ports! */
  };

In this case, the h/w for
"vendor,some-usb-2and3-with-typec-controller" can handle everything
for the connector. Doesn't need anything for alt modes because either
it is not supported or there's only one possible source.

> My concern with the three separate interfaces is that they may force
> us to know in kernel which of the three interfaces are association
> with a mode, and actually not just the mode, but the possible the pin
> configurations of the mode. That is something that we may end up
> having to hard code into the drivers, even though it does not provide
> any useful information to us, and that would not be OK.

Either you hard-code things in DT with "generic", low-level binding or
you hard-code things in a driver. Or maybe in your case, things are
hard-coded in the EC? But most platforms don't have that.

> Right now they also allow making assumptions regarding the alternate
> modes since there are no "bindings" for those, for example, if these
> OF graph ports have an endpoint to the DP, it means DP alt mode is
> supported. But that is of course not true. DisplayPort is used also
> with other alternate modes. We must never make any assumptions based
> on those interfaces. So again, why do we have them?

I'm pretty sure we have cases where the alt mode is HDMI. Maybe
there's not yet been a case of multiple alt modes til now. So now the
binding needs to be extended.

> Either I'm missing something, or the devicetree description of the
> Type-C connectors really is way too complex, way too "low level",
> causing us potential problems without providing anything that we could
> actually ever use in the operating system.

Well, all bindings are a balancing act of being flexible enough vs.
high-level enough to be stable. What I need is something that's going
to work for everyone, not just CrOS. Adding a new property at time is
death by 1000 cuts and usually a sign of someone only fixing their own
immediate problem.

Rob
