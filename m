Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7480C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832B6206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aCDU8S6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgFIX5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFIX5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:57:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83403C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:57:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so99034pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m5JmaasmCQcJ7OYsBb6zhdtgoMir5L8P8ZkBCz8MxFM=;
        b=aCDU8S6va0vmtHDB40FIYj/DwOG0KpvIjv+awafE2mJ2ugNyOajlcsHPZyZqa+L4L3
         yWX52sKiipXsxWLviI3hBSmkdMJ2EMtrMb18ptWergPEev20BcHHgYGK/nmANe6RLvyT
         QwSmsf74dk6zRja8hyw66I6EBP+4/Ow6VXx5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m5JmaasmCQcJ7OYsBb6zhdtgoMir5L8P8ZkBCz8MxFM=;
        b=ha140+52xzZNwdBcDK0lDa/TJJFq7xwlQ53fO/RbUH7I4226QAWa7nInHYZZ7MeJAL
         6j5Fl3/AeCMqQM96wDnD6CQ3yhGLnWL/PKA78D3skLWYQHCiRVV08GKwF+rRf0Pj6cEa
         5ZNj2WXnAYqcyZxF2uqawH8P6t4tocAumw5FQdSTusOFq1c1/a8CmaeRZND9Sc8/UTaO
         9hhyVKsVVJENhdvwZ1w945VkP3gA+T8uZjmDrlPuvwEa2ssxmRi5CUdS03425/nrEjgC
         OLbLYQhUgj+K6dLx7AQ8TlOXS3JRn5j85DaA7ii2BcnqBAXuw7EYEu09Pc3KGvqlWFFe
         l/HA==
X-Gm-Message-State: AOAM530wOCd95D0QYdD+LqDWa7v2Xw7ruOQRYBd0ZBhiHsnk/ZGdrBMs
        Z2M4xoodoAkOsySKTG0rAPDbKA==
X-Google-Smtp-Source: ABdhPJzWSSw/zzgzLeokFyu8kN1ZSHDkiBNamhRCrstu11VXT7HOYtbOzi+Iv5HdZj/uqYOoWqnGsQ==
X-Received: by 2002:a17:90b:46ca:: with SMTP id jx10mr274030pjb.3.1591747062753;
        Tue, 09 Jun 2020 16:57:42 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id h6sm10932421pfq.214.2020.06.09.16.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 16:57:41 -0700 (PDT)
Date:   Tue, 9 Jun 2020 16:57:40 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Message-ID: <20200609235740.GA154315@google.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com>
 <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
 <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
 <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+MM3-ugLvSGc_wc6RvHVyxyDUD0DkvwQaQJMYCCFpfHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks again for the comments and feedback. Kindly see responses inline:

(Trimming unrelated text from thread):

On Tue, Jun 09, 2020 at 02:30:11PM -0600, Rob Herring wrote:
> On Fri, May 29, 2020 at 5:30 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Nodes truncated and unrelated fields omitted in the interest of brevity:
> >
> > // Chrome OS EC Type C Port Manager.
> > typec {
> >     compatible = "google,cros-ec-typec";
> >     #address-cells = <1>;
> >     #size-cells = <0>;
> >
> >     connector@0 {
> >         compatible = "usb-c-connector";
> >         reg = <0>;
> >         power-role = "dual";
> >         data-role = "dual";
> >         try-power-role = "source";
> >         mode-switch = <&foo_mux>;
> >         // Other switches can point to the same mux.
> >         ....
> 
> The connector is supposed to have 'ports' for USB2, USB3, and Aux
> unless the parent is the USB controller.
Understood; so, coupled with Heikki's explanation (see below for where
I've pasted it), would it be something like so? (adding inline to the connector
node definition):

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                    reg = <0>;
                    usb_con_hs: endpoint {
                        remote-endpoint = <&foo_usb_hs_controller>;
                    };
                };

                port@1 {
                    reg = <1>;
                    usb_con0_ss: endpoint@0 {
                        remote-endpoint = <&mode_mux_in>;
                    };
                };

                port@2 {
                    reg = <2>;
                    usb_con_sbu: endpoint {
                        remote-endpoint = <&foo_dp_aux>;
                    };
                };
            };

> 
> >     };
> > };
> >
> > // Mux switch
> > // TODO: Can possibly embed this in the PHY controller node itself?
> > foo_mux {
> >     compatible = "vendor,typec-mux";
> >     mux-gpios = <&gpio_controller 23 GPIO_ACTIVE_HIGH>;
> >
> >     ports {
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >         port@0 {
> >             reg = <0>;
> >             mux_dp_in: endpoint {
> >                 remote-endpoint = <&dp_phy_out>;
> >             };
> >         };
> >
> >         port@1 {
> >             reg = <1>;
> >             mux_usb_in: endpoint1 {
> >                 remote-endpoint = <&usb3_phy_out>;
> >             };
> >         };
> 
> This all goes away if you have ports in the connector node. More below.

I think I my earlier example may have been a bit incorrect. Per Heikki's
explanation of who the consumer of the mux-control bindings is, the
foo_mux definition would now be like so:

foo_mux {
    compatible = "typec-mux-consumer";
    // This can be expanded to add more mux-controls for orientation,
    // data role etc.
    mux-controls = <&mode_mux_controller>;
    mux-control-names = "mode";
    #address-cells = <1>;
    #size-cells = <0>;

    port@0 {
        reg = <0>;
        mode_mux_in: endpoint {
            remote-endpoint = <&usb_con0_ss>
        };
    };

    port@1 {
        reg = <1>;
        mode_mux_out_usb3: endpoint {
            remote-endpoint = <&usb3_0_ep>
        };
    };

    port@2 {
        reg = <2>;
        mode_mux_out_dp: endpoint {
            remote-endpoint = <&dp0_out_ep>
        };
    };
};

and we add the definition for the mux-controller, where the mux-gpio
control actually resides:

mode_mux_controller: mux-controller {
    compatible = "vendor,typec-mode-mux";
    mux-gpios = <&gpio_controller 23 GPIO_ACTIVE_HIGH>;
};

> 
> >     };
> > };
> >
> > // Type C PHY Controller.
> > tcphy0: phy@ff7c0000 {
> >     compatible = "rockchip,rk3399-typec-phy";
> >     reg = <0x0 0xff7c0000 0x0 0x40000>;
> >     ...
> >     tcphy0_dp: phy@dc00000 {
> >         compatible = "soc,dp-phy";
> >         reg = <0xdc00000 0x1000>;
> >         ports {
> >             port@0 {
> >                 reg = <0>;
> >                 dp_phy_out: endpoint {
> >                     remote-endpoint = <&mux_dp_in>;
> >                 };
> >             };
> 
> This is wrong in that 'phys' are not part of the graph. It's the DP
> and USB controllers that should be part of the graph. Any phys are
> referenced with the phys binding and are not part of the graph.

Got it. So the new PHY definition would be just the same, but no
"ports".

> 
> >         };
> >     };
> >
> >     tcphy0_usb3: phy@db00000 {
> >         compatible = "soc,usb3-phy";
> >         reg = <0xdb00000 0x1000>;
> >         ports {
> >             port@0 {
> >                 reg = <0>;
> >                 usb3_phy_out: endpoint {
> >                     remote-endpoint = <&mux_usb3_in>;
> >                 };
> >             };
> >         };
> >     };
> > };
> >
> >
> > // USB3 Host controller
> > usbdrd3_0: usb@fe800000 {
> >     compatible = "rockchip,rk3399-dwc3";
> >     #address-cells = <2>;
> >     #size-cells = <2>;
> >     clocks = ...;
> >     clock-names = ...;
> >     status = "disabled";
> >
> >     usbdrd_dwc3_0: usb@fe800000 {
> >         compatible = "snps,dwc3";
> >         reg = <0x0 0xfe800000 0x0 0x100000>;
> >         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> >         clocks = ...;
> >         clock-names = ...;
> >         dr_mode = "otg";
> >         phys = <&tcphy0_usb3>;
> >         phy-names = "usb3-phy";
> >         phy_type = "utmi_wide";
> >         power-domains = <&power RK3399_PD_USB3>;
> >         status = "disabled";

This means a port definition here:
            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@0 {
                    reg = <0>;
                    usb3_0_ep: endpoint {
                        remote-endpoint = <&mode_mux_out_usb3>;
                    };
                };
            };

> >     };
> > };
> >
> > // DP controller
> > cdn_dp: dp@fec00000 {
> >     compatible = "rockchip,rk3399-cdn-dp";
> >     reg = <0x0 0xfec00000 0x0 0x100000>;
> >     interrupts = ...;
> >     clocks = ...;
> >     clock-names = ...;
> >     phys = <&tcphy0_dp>;
> >     ...
> >     ports {
> >         dp_in: port {
> >             #address-cells = <1>;
> >             #size-cells = <0>;
> >
> >             dp_in_vopb: endpoint@0 {
> >                 reg = <0>;
> >                 remote-endpoint = <&vopb_out_dp>;
> >             };
> >
> >             dp_in_vopl: endpoint@1 {
> >                 reg = <1>;
> >                 remote-endpoint = <&vopl_out_dp>;
> >             };
> >         };
> 
> This should have an output port and then that is connected to the USB
> connector. Given that DP is muxed with the USB SS signals, port@1
> (defined as USB SS) should then have 2 endpoints.

So, completing the example, another port here:

            dp_out: port@1 {
                reg = <1>;
                dp0_out_ep: endpoint {
                    remote-endpoint = <&mode_mux_out_dp>;
                };
            };

> 
> Then the only new thing here is how to represent the GPIO line
> controlling the mux. Normally, I'd expect this to be in the parent of
> the connector (the type-C controller), but since you have multiple
> connectors, that doesn't work so well. So you can put 'mux-gpios' in
> the port@1 node. (Or maybe it should be 'mux-controls' with a gpio mux
> defined elsewhere).

I think the updated example better helps delineate what we're trying to
achieve. Per Heikki's earlier explanation (re-quoting here) :

"
> > > > The mode-switch here would actually represent the "consumer" part in
> > > > the mux-control bindings. So the mux-controls would describe the
> > > > relationship between the "mode-switch" and the mux controller(s),
> > > > while the mode-switch property describes the relationship between
> > > > something like USB Type-C Port Manager (or this cros_ec function) and
> > > > the "mux consumer".
"

So the device that "mode-switch" points to (in this case, foo_mux) is the "consumer" of
the mux-control direct consumer). Heikki, does this example better
demonstrate what the Type C connector class expects?

Also, I think it might be better to move these *-switch properties into the
usb-connector.yaml binding in the event that we decide to take this route,
since the "Chrome EC Type C port driver" isn't expected to use them directly.
Rob, kindly LMK if you'd prefer that, and I can make the change in the
next patch version.

I can re-write this example in a non-inline form if that would be easier
to interpret. Kindly LMK, and also LMK if this graph connection scheme
example is acceptable.

Thanks again, and best regards,

-Prashant

> 
> Rob
