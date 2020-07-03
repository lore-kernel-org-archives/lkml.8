Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC91A208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omuPETJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCPTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:19:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18882C061794;
        Fri,  3 Jul 2020 08:19:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a11so19339331ilk.0;
        Fri, 03 Jul 2020 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZtgXI8eyf6R/eM3zMmGABuHuEawznAfaEEyn6Pbn8o=;
        b=omuPETJZ+kexr5sG7kkBZD3iuBoGL8jBfT+ti+8F6xuKzc4LqyNwrpLWg8WxsMP3jO
         eGAEW0f7f4npsFrUBxGYTyN/hH+Hub7jpGUA0ZHBezV3t/Lm0GU8lLFzHDdvc/DVJyWX
         Fqzp46IvQgxGUN0nvqjuE8Keq4ssxXhg7OYy8soLf3Q5YJTR+fApvofwx0bMTMF2nbSJ
         Dy9g4bF+9vNhSL/5tHNLAmUKm9z6mgl1dRqSrlEHmOi/Itld6VdS9aZqEpc9Wm4rbd45
         bk48fpsKoU6JwGxmHbXk5oXswvBszF4veif97zRIhktYklCxZj+MKH+RfKdmZfNJsYdA
         z3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZtgXI8eyf6R/eM3zMmGABuHuEawznAfaEEyn6Pbn8o=;
        b=WBWlZ1i+WxhbBP7iVl2oluaQkRciHUF7PtM/WV0Wo9lGXBZV86wdKB/2+boP+6sYvY
         cRJLcD9coPOxj7o2dW/dA0ZoX4n3J3MZCq3rmVn6mIOqYNliVXCwjve+M5F7GLiJhlYz
         GOjF5ILv8bfoXH8PBSYQLSsWJVWLWrdJPkIGefrcagyz7KhJhC9BRF6uVk4QspnN/vMM
         +Z4i3fYZEhW0Hp0JDBAum23QloZ1zQbe/7/j4jsGIV3S71IOSSbIiibHPUrUtsPq0sdc
         LmMg389YfZsrycdAOWNtvljY2U/cmeShe/CHqwzd3XSyxE5zkEJAl+g2Zo4Pw2rbYq8P
         XURw==
X-Gm-Message-State: AOAM533MooXw6+rszgwvpMSGGr3wIHq045el5vGWSLBqjD354HzAjw/v
        BC63xnoeRjIdU9NFteBvsmnaZLgn5pVUl7K+rjvvimEF2gI=
X-Google-Smtp-Source: ABdhPJwLMD4vK7kaR7C86dVW8A4N+UWBrCGUYGctwFNksN6VFayQZy2lRn18PnatW0b8AHya94OnWfx+uB1g9xdN0y0=
X-Received: by 2002:a92:ba0a:: with SMTP id o10mr17799773ili.217.1593789593236;
 Fri, 03 Jul 2020 08:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200702123651.12177-1-simhavcs@gmail.com> <20200703150637.GD25632@ravnborg.org>
In-Reply-To: <20200703150637.GD25632@ravnborg.org>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Fri, 3 Jul 2020 20:49:42 +0530
Message-ID: <CAGWqDJ7Uby1jVrCCQr2o7OzHHKYGL=fPh0-PaE5oZU4+BNBmPg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sam,

I will change to "GPL-2.0-only OR BSD-2-Clause", i thought running
dt_binding_check is enough for .yaml.

On Fri, Jul 3, 2020 at 8:36 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Vinay.
>
> On Thu, Jul 02, 2020 at 06:06:33PM +0530, Vinay Simha BN wrote:
> > Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> >
> > ---
> > v1:
> >  Initial version wast .txt file
> >
> > v2:
> >  From txt to yaml file format
> >
> > v3:
> > * Andrzej Hajda review comments incorporated
> >   dual port lvds implemented
> >
> > * Laurent Pinchart review comments incorporated
> >   dsi lanes property removed and it is dynamically
> >   picked from the dsi ports
> >   VESA/JEIDA format picked from panel-lvds dts
> >
> > v4:
> > * Sam Ravnborg review comments incorporated
> >   }' is indented properly in examples data-lanes
> >   description for single-link and dual-link lvds
> > ---
> >  .../display/bridge/toshiba,tc358775.yaml      | 215 ++++++++++++++++++
> >  1 file changed, 215 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> > new file mode 100644
> > index 000000000000..9ddd63bee403
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> > @@ -0,0 +1,215 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> One detail that I missed - any specific reason this is not (GPL-2.0-only OR BSD-2-Clause)
> This is the preferred license for new bindings - as checkpatch also
> tells you.
>
>         Sam
>
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358775.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Toshiba TC358775 DSI to LVDS bridge bindings
> > +
> > +maintainers:
> > + - Vinay Simha BN <simhavcs@gmail.com>
> > +
> > +description: |
> > + This binding supports DSI to LVDS bridge TC358775
> > +
> > + MIPI DSI-RX Data 4-lane, CLK 1-lane with data rates up to 800 Mbps/lane.
> > + Video frame size:
> > + Up to 1600x1200 24-bit/pixel resolution for single-link LVDS display panel
> > + limited by 135 MHz LVDS speed
> > + Up to WUXGA (1920x1200 24-bit pixels) resolution for dual-link LVDS display
> > + panel, limited by 270 MHz LVDS speed.
> > +
> > +properties:
> > +  compatible:
> > +    const: toshiba,tc358775
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: i2c address of the bridge, 0x0f
> > +
> > +  vdd-supply:
> > +    maxItems: 1
> > +    description:  1.2V LVDS Power Supply
> > +
> > +  vddio-supply:
> > +    maxItems: 1
> > +    description: 1.8V IO Power Supply
> > +
> > +  stby-gpios:
> > +    maxItems: 1
> > +    description: Standby pin, Low active
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: Hardware reset, Low active
> > +
> > +  ports:
> > +    type: object
> > +    description:
> > +      A node containing input and output port nodes with endpoint definitions
> > +      as documented in
> > +      Documentation/devicetree/bindings/media/video-interfaces.txt
> > +    properties:
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +      port@0:
> > +        type: object
> > +        description: |
> > +          DSI Input. The remote endpoint phandle should be a
> > +          reference to a valid mipi_dsi_host device node.
> > +
> > +      port@1:
> > +        type: object
> > +        description: |
> > +          Video port for LVDS output (panel or connector).
> > +
> > +      port@2:
> > +        type: object
> > +        description: |
> > +          Video port for Dual link LVDS output (panel or connector).
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > + - compatible
> > + - reg
> > + - vdd-supply
> > + - vddio-supply
> > + - stby-gpios
> > + - reset-gpios
> > + - ports
> > +
> > +examples:
> > + - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    /* For single-link LVDS display panel */
> > +
> > +    i2c@78b8000 {
> > +        /* On High speed expansion */
> > +        label = "HS-I2C2";
> > +        reg = <0x078b8000 0x500>;
> > +        clock-frequency = <400000>; /* fastmode operation */
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        tc_bridge: bridge@f {
> > +            compatible = "toshiba,tc358775";
> > +            reg = <0x0f>;
> > +
> > +            vdd-supply = <&pm8916_l2>;
> > +            vddio-supply = <&pm8916_l6>;
> > +
> > +            stby-gpios = <&msmgpio 99 GPIO_ACTIVE_LOW>;
> > +            reset-gpios = <&msmgpio 72 GPIO_ACTIVE_LOW>;
> > +
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                port@0 {
> > +                    reg = <0>;
> > +                    d2l_in_test: endpoint {
> > +                        remote-endpoint = <&dsi0_out>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg = <1>;
> > +                    lvds_out: endpoint {
> > +                        remote-endpoint = <&panel_in>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +    dsi@1a98000 {
> > +        reg = <0x1a98000 0x25c>;
> > +        reg-names = "dsi_ctrl";
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            port@1 {
> > +                reg = <1>;
> > +                dsi0_out: endpoint {
> > +                    remote-endpoint = <&d2l_in_test>;
> > +                    data-lanes = <0 1 2 3>;
> > +                };
> > +             };
> > +         };
> > +     };
> > +
> > + - |
> > +    /* For dual-link LVDS display panel */
> > +
> > +    i2c@78b8000 {
> > +        /* On High speed expansion */
> > +        label = "HS-I2C2";
> > +        reg = <0x078b8000 0x500>;
> > +        clock-frequency = <400000>; /* fastmode operation */
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        tc_bridge_dual: bridge@f {
> > +            compatible = "toshiba,tc358775";
> > +            reg = <0x0f>;
> > +
> > +            vdd-supply = <&pm8916_l2>;
> > +            vddio-supply = <&pm8916_l6>;
> > +
> > +            stby-gpios = <&msmgpio 99 GPIO_ACTIVE_LOW>;
> > +            reset-gpios = <&msmgpio 72 GPIO_ACTIVE_LOW>;
> > +
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                port@0 {
> > +                    reg = <0>;
> > +                    d2l_in_dual: endpoint {
> > +                        remote-endpoint = <&dsi0_out_dual>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    reg = <1>;
> > +                    lvds0_out: endpoint {
> > +                        remote-endpoint = <&panel_in0>;
> > +                    };
> > +                };
> > +
> > +                port@2 {
> > +                    reg = <2>;
> > +                    lvds1_out: endpoint {
> > +                        remote-endpoint = <&panel_in1>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +    dsi@1a98000 {
> > +        reg = <0x1a98000 0x25c>;
> > +        reg-names = "dsi_ctrl";
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            port@1 {
> > +                reg = <1>;
> > +                dsi0_out_dual: endpoint {
> > +                    remote-endpoint = <&d2l_in_dual>;
> > +                    data-lanes = <0 1 2 3>;
> > +                };
> > +             };
> > +         };
> > +     };
> > +...
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
regards,
vinaysimha
