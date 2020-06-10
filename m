Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A129CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B22072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g3r9royA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgFJRtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:49:05 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811FC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:49:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so1418491qvx.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owlfl2QM8eWUh1aUgcBMdltZkMJgzpmGiQXuiegxJgY=;
        b=g3r9royAyXykHLro3udc39oDnOo2MQJzMuGU8oQYCZH2kH7fl4Ns4aUH8oT7ee2kWK
         ZUEXtfhB9fJn3aMVj3v2iBVAR3N/jUh9wDK4YAMQxNDfyyPSSf6WtBNlWkVSl7HW8Wf5
         48M9Lm86qyWzG9Bq7XtocYgkZ0qY82unIh8+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owlfl2QM8eWUh1aUgcBMdltZkMJgzpmGiQXuiegxJgY=;
        b=WcVXVibzRqWtZ3F4EzFTVBD9vhe5H3ERc++gHhRdaz2a1nKYAcuf+CxnXPaIDs8vyY
         H7BLDbgaEqioMh408a2NFsbqe/vC7yfzsAe/pOcLyb3zaXeQOQqEBUnrRHR96C1uNAJq
         fSZR1XT0NX/svfRWkQv05qowtZIVU8gMrwRYPUQCKmuDkrTPH8UNr+PgYjvDSBkmnOOq
         6/p0uML6TIclWKBNkEnmBIYMBkO0syoi0fN5lyLdThVBj89dSLxoslufrv4FNldAf+IS
         AXgUN+34srJtGcG3Q4WF1fJOWxRrEAhLzQEruhv0M5ljolCxpp0vfFXk/cdDIE/nX1Ax
         Wqhw==
X-Gm-Message-State: AOAM533iBQdKRENZZybnjHpo3rkL8LI77qhdkMzy21Mo7UZcU1Y1fbni
        27zPLPF0nk8Nvge3/kykx9TTVnlBW9PRYErni+9RAQ==
X-Google-Smtp-Source: ABdhPJyGnlxqozswRrXouKmcSRCE7+Lm8ACMFEvGT8Z2iuSc8FxaabUYWBQsCAkj8cUTQGzC1i509vt5M+nFP6l/ndA=
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr4181689qvv.18.1591811343757;
 Wed, 10 Jun 2020 10:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
 <20200609235740.GA154315@google.com> <20200610153356.GC3213128@kuha.fi.intel.com>
 <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
In-Reply-To: <CAL_JsqKsObFhC+J6gK2EDXdpBLO6t+rswXDipnjt4uMr2Qx2zg@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 10 Jun 2020 10:48:52 -0700
Message-ID: <CACeCKadq6tuqzR_6DuiZeL+=aOMb05EWd4o0sNyGOcZJ=dYx8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Rob Herring <robh@kernel.org>
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

Hi Rob,

On Wed, Jun 10, 2020 at 9:53 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 10, 2020 at 9:34 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Jun 09, 2020 at 04:57:40PM -0700, Prashant Malani wrote:
> > > Hi Rob,
> > >
> > > Thanks again for the comments and feedback. Kindly see responses inline:
> > >
> > > (Trimming unrelated text from thread):
> > >
> > >
> > >             ports {
> > >                 #address-cells = <1>;
> > >                 #size-cells = <0>;
> > >
> > >                 port@0 {
> > >                     reg = <0>;
> > >                     usb_con_hs: endpoint {
> > >                         remote-endpoint = <&foo_usb_hs_controller>;
> > >                     };
> > >                 };
> > >
> > >                 port@1 {
> > >                     reg = <1>;
> > >                     usb_con0_ss: endpoint@0 {
> > >                         remote-endpoint = <&mode_mux_in>;
> > >                     };
> > >                 };
> > >
> > >                 port@2 {
> > >                     reg = <2>;
> > >                     usb_con_sbu: endpoint {
> > >                         remote-endpoint = <&foo_dp_aux>;
> > >                     };
> > >                 };
> > >             };
> >
> > The pins that can be reassigned can in practice go anywhere. We can't
> > group them in any way. What do we do for example when the two sideband
> > pins go to different locations?
>
> The sideband pins from the connector go to multiple places or the
> sideband signal from a controller go to multiple connectors? Either
> way, that's solved with multiple endpoints. In the former case, port@2
> would have multiple endpoints with all the possible connections. The
> general model of the graph is each port is a separate data channel and
> multiple endpoints are either a mux or fanout depending on the data
> direction.
>
> > It looks like the OF graph for the USB Type-C connectors expects the
> > pins to be grouped like that, which is too bad, because unfortunately
> > it will not work. It would require that we have a separate port for
> > every pin that can be reassigned on the connector, and let's not even
> > consider that.
>
> I guess you are referring to the 4 SS signal pairs and that they could
> be 2 USB links, 1 USB link and 1-2 Alt mode links, or 4 Alt mode
> links. I think the grouping of SS signals is fine as I'd expect
> there's a single entity deciding the routing. That would be 'mux' node
> I think, but 'mux' is the wrong abstraction here. I guess we could
> have 4 muxes (1 for each signal), but I'd hope we don't need that
> level of detail in DT. I think we're in agreement on that.

I think the updated example handles this grouping (port@1 going to a
"SS mux") although as you said it should probably be a group of muxes,
but I think the example illustrates the point. Is that assessment
correct?

>
> > We need higher level description of the connections for the USB Type-C
> > connectors. For example, a connector can be connected to this (or
> > these) DisplayPort(s), this USB 2.0 port, this USB 3.x port, this USB4
> > port, etc. And this is the mux that handles the pins on this
> > connector, and these are the retimers, etc. etc.
> >
> > We also need a way to identify those connections, and relying on
> > something like fixed port node addresses, so indexes in practice,
> > feels really risky to me. A conflict may seem unlikely now, but we
> > seen those so many times in the past other things like GPIOs, IRQs,
> > etc. We really need to define string identifiers for these
> > connections.
>
> I assume for IRQs you are referring to cases where we have a variable
> number such as 'interrupts = <1 2 3>;' where 'interrupts = <1 3>'
> doesn't work because we can't describe interrupt 2 is not present? The
> graph binding doesn't suffer from that issue since we can easily omit
> port or endpoint nodes.
>
> Also, the numbering is specific to a compatible string. If we need
> different numbering, then we can do a new compatible.
>
> Rob

Would this block the addition of the "*-switch" properties? IIUC the
two are related but not dependent on each other.

The *-switch properties are phandles which the Type C connector class
framework expects (and uses to get handles to those switches).
These would point to the "mux" or "group of mux" abstractions as noted earlier.

I'd suggest we work on updating the Type C connector class to a model
that can describe connections for both DT (using OF graph) and ACPI,
if something
like that exists, but let it not block the addition of these switches
to usb-connector.yaml; they will be needed by the Type C connector
class framework
regardless of the form the connection description takes.

Best regards,
