Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C68E2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591905667;
	bh=vBJOsLq+MF7YPPfH33AW+SH207qD3c7ZoyMCXan7N6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yk9SvXAgWY262HIm6DoS0FlHrD2MfdnANxdFN0MF/23Lw15dtwnc/6j74Z2EFWZAz
	 +dKZT06lnsC2TOVqQxUkoKTU8Oqoo1IDNBc5sMKiS7YFir4EN0pbgrvLVvLyfU7zNN
	 aCAlyC841s2921TuUpeRqKXO2FWEVd1vvbvMrkmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFKUBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgFKUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:01:02 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7CA20829;
        Thu, 11 Jun 2020 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591905661;
        bh=vBJOsLq+MF7YPPfH33AW+SH207qD3c7ZoyMCXan7N6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RM0NQc90imUodIznICVV11Hdp8caVl144mfdAhxnSYeCxeb423vGRjqoFBU2IpJ+N
         vhPrFAWLl4kqhBTmPR/AcABKtdGSTSz/VRdCbx0qiGlylBZVHXsmnrbiqx0xys5CrK
         XE5PqvEhv4dmAe3qTKsJp/1OZbgd/Ujgwgou9vFk=
Received: by mail-oi1-f171.google.com with SMTP id p70so6530416oic.12;
        Thu, 11 Jun 2020 13:01:01 -0700 (PDT)
X-Gm-Message-State: AOAM531awlNa5CB0cxHO4S/eLpeL9ipA1saGl+x7sDm4lsNWOmfFRnBm
        W6o1vjYEWugG+SzxbFi4BgPpD/l228sw0PZD4g==
X-Google-Smtp-Source: ABdhPJza8D9UuymcUjm1xsz4J1CZxHk31faK5p3gBrGnmfebOkby+BbsncjLGk+4Sc/aNEYZBK3Yoelmkxgd7CcMJC4=
X-Received: by 2002:aca:d943:: with SMTP id q64mr7812611oig.147.1591905660418;
 Thu, 11 Jun 2020 13:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com> <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com> <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
In-Reply-To: <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Jun 2020 14:00:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
Message-ID: <CAL_JsqJQb5P26JC-KqkeHoWxAb63N+_XRK==b-WWJ+pYpdHO8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:49 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Rob,
>
> On Wed, Jun 10, 2020 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
> >
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
> >
> > > It looks like the OF graph for the USB Type-C connectors expects the
> > > pins to be grouped like that, which is too bad, because unfortunately
> > > it will not work. It would require that we have a separate port for
> > > every pin that can be reassigned on the connector, and let's not even
> > > consider that.
> >
> > I guess you are referring to the 4 SS signal pairs and that they could
> > be 2 USB links, 1 USB link and 1-2 Alt mode links, or 4 Alt mode
> > links. I think the grouping of SS signals is fine as I'd expect
> > there's a single entity deciding the routing. That would be 'mux' node
> > I think, but 'mux' is the wrong abstraction here. I guess we could
> > have 4 muxes (1 for each signal), but I'd hope we don't need that
> > level of detail in DT. I think we're in agreement on that.
>
> I think the updated example handles this grouping (port@1 going to a
> "SS mux") although as you said it should probably be a group of muxes,
> but I think the example illustrates the point. Is that assessment
> correct?

Yes, but let's stop calling it a mux. It's a "USB Type C signal routing blob".

> > > We need higher level description of the connections for the USB Type-C
> > > connectors. For example, a connector can be connected to this (or
> > > these) DisplayPort(s), this USB 2.0 port, this USB 3.x port, this USB4
> > > port, etc. And this is the mux that handles the pins on this
> > > connector, and these are the retimers, etc. etc.
> > >
> > > We also need a way to identify those connections, and relying on
> > > something like fixed port node addresses, so indexes in practice,
> > > feels really risky to me. A conflict may seem unlikely now, but we
> > > seen those so many times in the past other things like GPIOs, IRQs,
> > > etc. We really need to define string identifiers for these
> > > connections.
> >
> > I assume for IRQs you are referring to cases where we have a variable
> > number such as 'interrupts = <1 2 3>;' where 'interrupts = <1 3>'
> > doesn't work because we can't describe interrupt 2 is not present? The
> > graph binding doesn't suffer from that issue since we can easily omit
> > port or endpoint nodes.
> >
> > Also, the numbering is specific to a compatible string. If we need
> > different numbering, then we can do a new compatible.
> >
> > Rob
>
> Would this block the addition of the "*-switch" properties? IIUC the
> two are related but not dependent on each other.
>
> The *-switch properties are phandles which the Type C connector class
> framework expects (and uses to get handles to those switches).
> These would point to the "mux" or "group of mux" abstractions as noted earlier.

You don't need them though. Walk the graph. You get the connector
port@1 remote endpoint and then get its parent.

> I'd suggest we work on updating the Type C connector class to a model
> that can describe connections for both DT (using OF graph) and ACPI,
> if something
> like that exists, but let it not block the addition of these switches
> to usb-connector.yaml; they will be needed by the Type C connector
> class framework
> regardless of the form the connection description takes.
