Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880CE2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591808040;
	bh=5l99DsraoOPZV1OU1YHuYjZOzAMxH54iUhG8bur9rnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q/Z8RuT+1GZT8oqOgYv768QX/vUly2BnSP8KY9l0ZOOQwkdVddTvgldf+Gl5nUwXn
	 lBpJMUUYhpx5+fUqjANWj7KZgs67msAXcLoI4PwHK5XrTw/Qk3SDpJuL0lacZDAowW
	 IydnC5DtRGeyCsRudbLHdF6YtFCyY7P3P0sgbhHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFJQx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgFJQx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:53:58 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0ED20734;
        Wed, 10 Jun 2020 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591808037;
        bh=5l99DsraoOPZV1OU1YHuYjZOzAMxH54iUhG8bur9rnM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VKAC3CH1sASX4nfgzMqpFP+edv/gqOVS5WUTKjJX0NX4h3ac+MYrPZ6yhmNCna8Fu
         cCOVVrFS8zCmP9bLKmf948XY3+q1iIZeKKNz9AhKxOdwQpf1adSEWATaWuKuzTxCZx
         +e4Sc4bm7L5U3Fb0ONJhJLRXQaY2M2dAzaOm4+HU=
Received: by mail-oo1-f42.google.com with SMTP id e12so639444oou.2;
        Wed, 10 Jun 2020 09:53:57 -0700 (PDT)
X-Gm-Message-State: AOAM5312i7ipcBZKH5D8bs3bvX4cl423qsvIw9wyUpWT3N1+y48jMZDk
        Wr/ak3M9rkFrCN6FtjOj4eRQhmXJ4bJdBwfXWQ==
X-Google-Smtp-Source: ABdhPJxqdlrg8qy3QKsG2cIpbwK3twksjEC7SO767My3VTyuKvrDAhv7M8etIZefVyHhyd3wjSboxGEPLEyJMeei2C8=
X-Received: by 2002:a4a:6156:: with SMTP id u22mr2935115ooe.50.1591808036515;
 Wed, 10 Jun 2020 09:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com> <20200610153356.GC3213128@kuha.fi.intel.com>
In-Reply-To: <20200610153356.GC3213128@kuha.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Jun 2020 10:53:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
Message-ID: <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
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

On Wed, Jun 10, 2020 at 9:34 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> > Hi Rob,
> >
> > Thanks again for the comments and feedback. Kindly see responses inline:
> >
> > (Trimming unrelated text from thread):
> >
> > On Tue, Jun 09, 2020 at 02:30:11PM -0600, Rob Herring wrote:
> > > On Fri, May 29, 2020 at 5:30 PM Prashant Malani <pmalani@chromium.org> wrote:
> > > >
> > > > Nodes truncated and unrelated fields omitted in the interest of brevity:
> > > >
> > > > // Chrome OS EC Type C Port Manager.
> > > > typec {
> > > >     compatible = "google,cros-ec-typec";
> > > >     #address-cells = <1>;
> > > >     #size-cells = <0>;
> > > >
> > > >     connector@0 {
> > > >         compatible = "usb-c-connector";
> > > >         reg = <0>;
> > > >         power-role = "dual";
> > > >         data-role = "dual";
> > > >         try-power-role = "source";
> > > >         mode-switch = <&foo_mux>;
> > > >         // Other switches can point to the same mux.
> > > >         ....
> > >
> > > The connector is supposed to have 'ports' for USB2, USB3, and Aux
> > > unless the parent is the USB controller.
> > Understood; so, coupled with Heikki's explanation (see below for where
> > I've pasted it), would it be something like so? (adding inline to the connector
> > node definition):
> >
> >             ports {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> >                 port@0 {
> >                     reg = <0>;
> >                     usb_con_hs: endpoint {
> >                         remote-endpoint = <&foo_usb_hs_controller>;
> >                     };
> >                 };
> >
> >                 port@1 {
> >                     reg = <1>;
> >                     usb_con0_ss: endpoint@0 {
> >                         remote-endpoint = <&mode_mux_in>;
> >                     };
> >                 };
> >
> >                 port@2 {
> >                     reg = <2>;
> >                     usb_con_sbu: endpoint {
> >                         remote-endpoint = <&foo_dp_aux>;
> >                     };
> >                 };
> >             };
>
> The pins that can be reassigned can in practice go anywhere. We can't
> group them in any way. What do we do for example when the two sideband
> pins go to different locations?

The sideband pins from the connector go to multiple places or the
sideband signal from a controller go to multiple connectors? Either
way, that's solved with multiple endpoints. In the former case, port@2
would have multiple endpoints with all the possible connections. The
general model of the graph is each port is a separate data channel and
multiple endpoints are either a mux or fanout depending on the data
direction.

> It looks like the OF graph for the USB Type-C connectors expects the
> pins to be grouped like that, which is too bad, because unfortunately
> it will not work. It would require that we have a separate port for
> every pin that can be reassigned on the connector, and let's not even
> consider that.

I guess you are referring to the 4 SS signal pairs and that they could
be 2 USB links, 1 USB link and 1-2 Alt mode links, or 4 Alt mode
links. I think the grouping of SS signals is fine as I'd expect
there's a single entity deciding the routing. That would be 'mux' node
I think, but 'mux' is the wrong abstraction here. I guess we could
have 4 muxes (1 for each signal), but I'd hope we don't need that
level of detail in DT. I think we're in agreement on that.

> We need higher level description of the connections for the USB Type-C
> connectors. For example, a connector can be connected to this (or
> these) DisplayPort(s), this USB 2.0 port, this USB 3.x port, this USB4
> port, etc. And this is the mux that handles the pins on this
> connector, and these are the retimers, etc. etc.
>
> We also need a way to identify those connections, and relying on
> something like fixed port node addresses, so indexes in practice,
> feels really risky to me. A conflict may seem unlikely now, but we
> seen those so many times in the past other things like GPIOs, IRQs,
> etc. We really need to define string identifiers for these
> connections.

I assume for IRQs you are referring to cases where we have a variable
number such as 'interrupts = <1 2 3>;' where 'interrupts = <1 3>'
doesn't work because we can't describe interrupt 2 is not present? The
graph binding doesn't suffer from that issue since we can easily omit
port or endpoint nodes.

Also, the numbering is specific to a compatible string. If we need
different numbering, then we can do a new compatible.

Rob
