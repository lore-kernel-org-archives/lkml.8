Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD6DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4720F206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lI6r3SdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgE2XaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgE2XaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:30:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EFAC08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:30:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e16so3446998qtg.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgsftlWzqWmhhm/8U5XEJqAohvGI5fbBITCTIcxvIcQ=;
        b=lI6r3SdLUTzlpoKU7fvokqbn7cfhcOy0Vt/qzdrnbve8x31HaAh9vi6Ad3RrcOI7uY
         gWpA4EB4zFsSYUEg8xYKHgSZ+thu1cC3eCp3pqXQDuFFm4JK2ocKHLvfYAKMESdPwKqd
         4tGY++b8hSQUgSqSAYpBPOWT5QXnyEDzgiyuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgsftlWzqWmhhm/8U5XEJqAohvGI5fbBITCTIcxvIcQ=;
        b=Qzr6WR6ldeigmoqCj9iMUAvj2ow85ZPvFv5r+h9eFCR7b9K0BV3xPIuAkNW/AUKIbA
         sHy0qJgxCnxWmU8RCIf/72FASIskfL+UlXZVwsAPsAyDOheQih4nt7ZcMs+5DxZRfVoU
         5br2XV/Bb+GCT1qHNoinY8c3LoMgdAK1NehWVgiyvoQ4M2ag+KQ20uN3mPFpwd1iBPIN
         sUod7w4IFBmWJTziiDt++KUSX0t6yDy7Wqjg8YovxB899980Q37pICvH0k2gBL3/CA9t
         SKy+j0q+JxRRmjaxPKyeTDXZjKIRpGF1PC8/vp7xcNMEAmmdgkMby3O56fcvIedIz2SE
         K9ZA==
X-Gm-Message-State: AOAM530x9+upsV1LqdKyPCs77Zg11628oJvCNmXYXMY9VgZ0I6/pQvU3
        uNf/n+ShGcghr6q4zIRzfPiRlDikZDo0Z497P1DrOg==
X-Google-Smtp-Source: ABdhPJy+kQ5NDOLgaiwe3Gm6FhWceoGXxb9ggCLnVNtdf7+kU7Jjogq2kjXKOs2U94gSImwqI9R+A1rNUZRuWiN7gcE=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr11234260qta.141.1590795014579;
 Fri, 29 May 2020 16:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200511192800.GA28762@bogus>
 <20200511204635.GC136540@google.com> <20200512134154.GC2085641@kuha.fi.intel.com>
 <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
In-Reply-To: <CAL_JsqJ2pbh5BbjGd9eEiD6-sV94=omk6o+mLXjCYiVnUOtO=g@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 29 May 2020 16:30:03 -0700
Message-ID: <CACeCKadiiokPdPB2Q5WBQFrPuxjpm3TiDgaaerncVR_Z7Z0nvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Rob Herring <robh@kernel.org>
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

Hi Rob,

Thanks for reviewing the patch! Kindly see inline:

On Fri, May 29, 2020 at 2:55 PM Rob Herring <robh@kernel.org> wrote:
>
> > > " Reference to a DT node for the USB Type C Multiplexer controlling the
> > > data lines routing for this connector. This switch is assumed registered
> > > with the Type C connector class framework, which requires it to be named
> > > this way."
> > > >
> > > > > +          mode-switch:
> > > > > +            description: Reference to a DT node for the USB Type C Multiplexer
> > > > > +              controlling the data lines routing for this connector.
> > > >
> > > > This is for alternate mode muxing I presume.
> > >
> > > Yes, that's right.
> > > >
> > > > We already have a mux-control binding. Why not use that here?
> > >
> > > Heikki might be able to offer more insight into why this is the case,
> > > since the connector class framework seems to expect a phandle and for
> > > the device driver to implement a "set" command. Heikki, would you happen to know?
> >
> > The mode-switch here would actually represent the "consumer" part in
> > the mux-control bindings. So the mux-controls would describe the
> > relationship between the "mode-switch" and the mux controller(s),
> > while the mode-switch property describes the relationship between
> > something like USB Type-C Port Manager (or this cros_ec function) and
> > the "mux consumer".
>
> The "USB Type-C Port Manager" is not just the parent node in your case?
>
> Can you point me to what you expect your DT to look like showing the
> mode switch node, the connector, the USB host(s), and the DP/HDMI
> bridge/output?

Caveat: I'm not a DT expert and not well-versed with the mux-control
bindings, so Heikki may be able to describe these better.
That said, here is my attempt to show the nodes you requested, cobbled
together from the Rockchip rk3399 DTSI[1] and
swboyd's connector binding example [2].

Nodes truncated and unrelated fields omitted in the interest of brevity:

// Chrome OS EC Type C Port Manager.
typec {
    compatible = "google,cros-ec-typec";
    #address-cells = <1>;
    #size-cells = <0>;

    connector@0 {
        compatible = "usb-c-connector";
        reg = <0>;
        power-role = "dual";
        data-role = "dual";
        try-power-role = "source";
        mode-switch = <&foo_mux>;
        // Other switches can point to the same mux.
        ....
    };
};

// Mux switch
// TODO: Can possibly embed this in the PHY controller node itself?
foo_mux {
    compatible = "vendor,typec-mux";
    mux-gpios = <&gpio_controller 23 GPIO_ACTIVE_HIGH>;

    ports {
        #address-cells = <1>;
        #size-cells = <0>;
        port@0 {
            reg = <0>;
            mux_dp_in: endpoint {
                remote-endpoint = <&dp_phy_out>;
            };
        };

        port@1 {
            reg = <1>;
            mux_usb_in: endpoint1 {
                remote-endpoint = <&usb3_phy_out>;
            };
        };
    };
};

// Type C PHY Controller.
tcphy0: phy@ff7c0000 {
    compatible = "rockchip,rk3399-typec-phy";
    reg = <0x0 0xff7c0000 0x0 0x40000>;
    ...
    tcphy0_dp: phy@dc00000 {
        compatible = "soc,dp-phy";
        reg = <0xdc00000 0x1000>;
        ports {
            port@0 {
                reg = <0>;
                dp_phy_out: endpoint {
                    remote-endpoint = <&mux_dp_in>;
                };
            };
        };
    };

    tcphy0_usb3: phy@db00000 {
        compatible = "soc,usb3-phy";
        reg = <0xdb00000 0x1000>;
        ports {
            port@0 {
                reg = <0>;
                usb3_phy_out: endpoint {
                    remote-endpoint = <&mux_usb3_in>;
                };
            };
        };
    };
};


// USB3 Host controller
usbdrd3_0: usb@fe800000 {
    compatible = "rockchip,rk3399-dwc3";
    #address-cells = <2>;
    #size-cells = <2>;
    clocks = ...;
    clock-names = ...;
    status = "disabled";

    usbdrd_dwc3_0: usb@fe800000 {
        compatible = "snps,dwc3";
        reg = <0x0 0xfe800000 0x0 0x100000>;
        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
        clocks = ...;
        clock-names = ...;
        dr_mode = "otg";
        phys = <&tcphy0_usb3>;
        phy-names = "usb3-phy";
        phy_type = "utmi_wide";
        power-domains = <&power RK3399_PD_USB3>;
        status = "disabled";
    };
};

// DP controller
cdn_dp: dp@fec00000 {
    compatible = "rockchip,rk3399-cdn-dp";
    reg = <0x0 0xfec00000 0x0 0x100000>;
    interrupts = ...;
    clocks = ...;
    clock-names = ...;
    phys = <&tcphy0_dp>;
    ...
    ports {
        dp_in: port {
            #address-cells = <1>;
            #size-cells = <0>;

            dp_in_vopb: endpoint@0 {
                reg = <0>;
                remote-endpoint = <&vopb_out_dp>;
            };

            dp_in_vopl: endpoint@1 {
                reg = <1>;
                remote-endpoint = <&vopl_out_dp>;
            };
        };
    };
};

[1] : https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/arch/arm64/boot/dts/rockchip/rk3399.dtsi
[2]: https://lkml.org/lkml/2020/2/28/1081

Hope this helps, and my apologies in advance for any errors.

Best regards,

-Prashant

>
> Rob
