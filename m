Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87141C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEBE20885
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHJRiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:38:50 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50752 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgHJRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:38:50 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BCDDA20023;
        Mon, 10 Aug 2020 19:38:44 +0200 (CEST)
Date:   Mon, 10 Aug 2020 19:38:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vinay Simha B N <simhavcs@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Message-ID: <20200810173843.GB292825@ravnborg.org>
References: <1594388491-15129-1-git-send-email-simhavcs@gmail.com>
 <CAGWqDJ74bveHPKXqdPhwbZjb=cXPPQLTEng4oi+dkZa-1fRz_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWqDJ74bveHPKXqdPhwbZjb=cXPPQLTEng4oi+dkZa-1fRz_Q@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8
        a=gEfo2CItAAAA:8 a=e5mUnYsNAAAA:8 a=njpYwi7_WxjI1lOXyc8A:9
        a=0t7fiu_16AWWzKjv:21 a=kFrMhexQLHq2BP0q:21 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=sptkURWiP4Gy88Gu7hUp:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinay.

On Wed, Jul 29, 2020 at 06:01:21PM +0530, Vinay Simha B N wrote:
> Hi All,
> 
> Please Review the patch
> 
> On Fri, Jul 10, 2020 at 7:11 PM Vinay Simha BN <simhavcs@gmail.com> wrote:
> 
> > - license modified to (GPL-2.0-only OR BSD-2-Clause)
> > - single-link and dual-link lvds description and
> >   examples are added
> > - proper indentation
> > - VESA/JEIDA formats picked from panel-lvds dts
> > - dsi data-lanes property removed, it will be picked
> >   from dsi0 ports
> > - dual-link lvds port added and implemented
> > - converted from .txt to .yaml
> >
> > Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>

The binding is already reviewed by Rob and me - as you have recorded
above. It will be applied when the driver is ready.

	Sam

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
> >
> > v5:
> > * Sam Ravnborg review comments incorporated
> >   license modified to (GPL-2.0-only OR BSD-2-Clause)
> >   changelog added
> >
> > v6:
> > * No changes, revision version mentioned to inline with
> >   driver file
> >
> > v7:
> > * change log added
> >   Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > v8:
> > * Reviewed-by: Rob Herring <robh@kernel.org>
> > * change log modified in reverse chronological order
> > ---
> >  .../bindings/display/bridge/toshiba,tc358775.yaml  | 215
> > +++++++++++++++++++++
> >  1 file changed, 215 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> > b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> > new file mode 100644
> > index 0000000..31f085d
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> > @@ -0,0 +1,215 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
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
> > + Up to 1600x1200 24-bit/pixel resolution for single-link LVDS display
> > panel
> > + limited by 135 MHz LVDS speed
> > + Up to WUXGA (1920x1200 24-bit pixels) resolution for dual-link LVDS
> > display
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
> > +      A node containing input and output port nodes with endpoint
> > definitions
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
> > 2.1.2
> >
> >
> 
> -- 
> regards,
> vinaysimha

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

