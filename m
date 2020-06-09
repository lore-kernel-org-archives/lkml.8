Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5772C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BA8207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591734637;
	bh=Ev9PIvYfFUc8Le4W0OMbc5IZPEJTDtjG+hW4todzOnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hYC9zRC7xIysbAPiXQtmHUBZzA43dGSXMNaqxaItGC+jOmwPPr5zd91LTRdl4m2fT
	 VFqLRRhfuEa1Dsnai1iblTyY6Rymwep9k1nJqLycBAhM5F7rV4Mu45nrJu4afWMZ2+
	 9DlxNGhNVAtfTeu6uhq3JhITqhn2JDjBryMrpQvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgFIUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387991AbgFIUaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:30:24 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF17E20737;
        Tue,  9 Jun 2020 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591734623;
        bh=Ev9PIvYfFUc8Le4W0OMbc5IZPEJTDtjG+hW4todzOnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wlWjMA+S6jOo9DBJZxP3IZYxQtJwcpqfMVf3fsOBuiWpehfck55/UrTZahL2LJNZr
         eM2On2eali9MzPeipPNRSphuj3yCGQ5JPeE4efOcedLxonac5rKvc3/tYi16Y/ujcD
         fywbOP0uGCtnKdUBYkm41XcwpUtOcFfdxbAXJdvU=
Received: by mail-ot1-f54.google.com with SMTP id 69so17727847otv.2;
        Tue, 09 Jun 2020 13:30:23 -0700 (PDT)
X-Gm-Message-State: AOAM531aEtRNodC7+WtEvYazoe6PTt7vsRE1rd0z4LNvcQ7TrLtX0HB0
        GByZ4ztcQfBlmSaTvFAFNSSUH37Uzh2btBvGOQ==
X-Google-Smtp-Source: ABdhPJytiNCkbeFZhm48iF0qA0Jj530C34uFCDMJSlxSKoYVqiAFCuP/cHwFk0FFmJFhcLALLmfSy7ZtNoDU4IkQv3w=
X-Received: by 2002:a05:6830:549:: with SMTP id l9mr23548411otb.129.1591734623009;
 Tue, 09 Jun 2020 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com> <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
In-Reply-To: <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Jun 2020 14:30:11 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
Message-ID: <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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

On Fri, May 29, 2020 at 5:30 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Rob,
>
> Thanks for reviewing the patch! Kindly see inline:
>
> On Fri, May 29, 2020 at 2:55 PM Rob Herring <robh@kernel.org> wrote:
> >
> > > > " Reference to a DT node for the USB Type C Multiplexer controlling the
> > > > data lines routing for this connector. This switch is assumed registered
> > > > with the Type C connector class framework, which requires it to be named
> > > > this way."
> > > > >
> > > > > > +          mode-switch:
> > > > > > +            description: Reference to a DT node for the USB Type C Multiplexer
> > > > > > +              controlling the data lines routing for this connector.
> > > > >
> > > > > This is for alternate mode muxing I presume.
> > > >
> > > > Yes, that's right.
> > > > >
> > > > > We already have a mux-control binding. Why not use that here?
> > > >
> > > > Heikki might be able to offer more insight into why this is the case,
> > > > since the connector class framework seems to expect a phandle and for
> > > > the device driver to implement a "set" command. Heikki, would you happen to know?
> > >
> > > The mode-switch here would actually represent the "consumer" part in
> > > the mux-control bindings. So the mux-controls would describe the
> > > relationship between the "mode-switch" and the mux controller(s),
> > > while the mode-switch property describes the relationship between
> > > something like USB Type-C Port Manager (or this cros_ec function) and
> > > the "mux consumer".
> >
> > The "USB Type-C Port Manager" is not just the parent node in your case?
> >
> > Can you point me to what you expect your DT to look like showing the
> > mode switch node, the connector, the USB host(s), and the DP/HDMI
> > bridge/output?
>
> Caveat: I'm not a DT expert and not well-versed with the mux-control
> bindings, so Heikki may be able to describe these better.
> That said, here is my attempt to show the nodes you requested, cobbled
> together from the Rockchip rk3399 DTSI[1] and
> swboyd's connector binding example [2].
>
> Nodes truncated and unrelated fields omitted in the interest of brevity:
>
> // Chrome OS EC Type C Port Manager.
> typec {
>     compatible = "google,cros-ec-typec";
>     #address-cells = <1>;
>     #size-cells = <0>;
>
>     connector@0 {
>         compatible = "usb-c-connector";
>         reg = <0>;
>         power-role = "dual";
>         data-role = "dual";
>         try-power-role = "source";
>         mode-switch = <&foo_mux>;
>         // Other switches can point to the same mux.
>         ....

The connector is supposed to have 'ports' for USB2, USB3, and Aux
unless the parent is the USB controller.

>     };
> };
>
> // Mux switch
> // TODO: Can possibly embed this in the PHY controller node itself?
> foo_mux {
>     compatible = "vendor,typec-mux";
>     mux-gpios = <&gpio_controller 23 GPIO_ACTIVE_HIGH>;
>
>     ports {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         port@0 {
>             reg = <0>;
>             mux_dp_in: endpoint {
>                 remote-endpoint = <&dp_phy_out>;
>             };
>         };
>
>         port@1 {
>             reg = <1>;
>             mux_usb_in: endpoint1 {
>                 remote-endpoint = <&usb3_phy_out>;
>             };
>         };

This all goes away if you have ports in the connector node. More below.

>     };
> };
>
> // Type C PHY Controller.
> tcphy0: phy@ff7c0000 {
>     compatible = "rockchip,rk3399-typec-phy";
>     reg = <0x0 0xff7c0000 0x0 0x40000>;
>     ...
>     tcphy0_dp: phy@dc00000 {
>         compatible = "soc,dp-phy";
>         reg = <0xdc00000 0x1000>;
>         ports {
>             port@0 {
>                 reg = <0>;
>                 dp_phy_out: endpoint {
>                     remote-endpoint = <&mux_dp_in>;
>                 };
>             };

This is wrong in that 'phys' are not part of the graph. It's the DP
and USB controllers that should be part of the graph. Any phys are
referenced with the phys binding and are not part of the graph.

>         };
>     };
>
>     tcphy0_usb3: phy@db00000 {
>         compatible = "soc,usb3-phy";
>         reg = <0xdb00000 0x1000>;
>         ports {
>             port@0 {
>                 reg = <0>;
>                 usb3_phy_out: endpoint {
>                     remote-endpoint = <&mux_usb3_in>;
>                 };
>             };
>         };
>     };
> };
>
>
> // USB3 Host controller
> usbdrd3_0: usb@fe800000 {
>     compatible = "rockchip,rk3399-dwc3";
>     #address-cells = <2>;
>     #size-cells = <2>;
>     clocks = ...;
>     clock-names = ...;
>     status = "disabled";
>
>     usbdrd_dwc3_0: usb@fe800000 {
>         compatible = "snps,dwc3";
>         reg = <0x0 0xfe800000 0x0 0x100000>;
>         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
>         clocks = ...;
>         clock-names = ...;
>         dr_mode = "otg";
>         phys = <&tcphy0_usb3>;
>         phy-names = "usb3-phy";
>         phy_type = "utmi_wide";
>         power-domains = <&power RK3399_PD_USB3>;
>         status = "disabled";
>     };
> };
>
> // DP controller
> cdn_dp: dp@fec00000 {
>     compatible = "rockchip,rk3399-cdn-dp";
>     reg = <0x0 0xfec00000 0x0 0x100000>;
>     interrupts = ...;
>     clocks = ...;
>     clock-names = ...;
>     phys = <&tcphy0_dp>;
>     ...
>     ports {
>         dp_in: port {
>             #address-cells = <1>;
>             #size-cells = <0>;
>
>             dp_in_vopb: endpoint@0 {
>                 reg = <0>;
>                 remote-endpoint = <&vopb_out_dp>;
>             };
>
>             dp_in_vopl: endpoint@1 {
>                 reg = <1>;
>                 remote-endpoint = <&vopl_out_dp>;
>             };
>         };

This should have an output port and then that is connected to the USB
connector. Given that DP is muxed with the USB SS signals, port@1
(defined as USB SS) should then have 2 endpoints.

Then the only new thing here is how to represent the GPIO line
controlling the mux. Normally, I'd expect this to be in the parent of
the connector (the type-C controller), but since you have multiple
connectors, that doesn't work so well. So you can put 'mux-gpios' in
the port@1 node. (Or maybe it should be 'mux-controls' with a gpio mux
defined elsewhere).

Rob
