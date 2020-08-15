Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8999C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1860123B24
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHOVhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:37:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52718 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgHOVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:37:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6788EFB05;
        Sat, 15 Aug 2020 18:47:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rYMbM5R8wXQP; Sat, 15 Aug 2020 18:47:37 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4A9304576F; Sat, 15 Aug 2020 18:47:37 +0200 (CEST)
Date:   Sat, 15 Aug 2020 18:47:37 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add Mantix MLAF057WE51-X panel bindings
Message-ID: <20200815164737.GA3640@bogon.m.sigxcpu.org>
References: <cover.1597412076.git.agx@sigxcpu.org>
 <9345739df02b8b8630e7dccb61a80a7a7f692526.1597412076.git.agx@sigxcpu.org>
 <20200815083917.GA993113@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815083917.GA993113@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Sat, Aug 15, 2020 at 10:39:17AM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Fri, Aug 14, 2020 at 03:36:22PM +0200, Guido Günther wrote:
> > The panel uses a Focaltech FT8006p, the touch part is handled by the
> > already existing edt-ft5x06.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> A few trivialities.

Thanks for having a look. One remark inline:

> 
> > ---
> >  .../display/panel/mantix,mlaf057we51-x.yaml   | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > new file mode 100644
> > index 0000000000000..349f3380ac940
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/mantix,mlaf057we51-x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mantix MLAF057WE51-X 5.7" 720x1440 TFT LCD panel
> > +
> > +maintainers:
> > +  - Guido Günther <agx@sigxcpu.org>
> > +
> > +description: |
> > +             Mantix MLAF057WE51 X is a 720x1440 TFT LCD panel
> > +             connected using a MIPI-DSI video interface.
> Indent text with two spaces only.
> And I have learned that '|' is only needed to preserve formatting - so
> it can be dropped.
> 
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mantix,mlaf057we51-x
> This is a list - so needs an extra 2 spaces indent.
> See https://lore.kernel.org/linux-devicetree/f1963eb9-283f-e903-2a3a-4f324d71d418@lucaceresoli.net/T/#m65900317fb948f6c40e8fb521f2201fba3c301a7
> for examples where Rob fixes this.

Doesn't this only apply if the 'outer element' is a list too so e.g.:

   - enum
     - foo

trips up yamllint but

   enum
     - foo

doesn't. Since yamllint was happy i kept it as is (looking at your
reference suggests that too).

All the rest made sense and i fixed that for the upcoming v2.
Thanks for having a look!
 -- Guido

> 
> > +
> > +  port: true
> > +  reg:
> > +    maxItems: 1
> > +    description: DSI virtual channel
> > +
> > +  avdd-supply:
> > +    description: Positive analog power supply
> > +
> > +  avee-supply:
> > +    description: Negative analog power supply
> > +
> > +  vddi-supply:
> > +    description: 1.8V I/O voltage supply
> > +
> > +  reset-gpios:
> > +    description: GPIO used for the reset pin
> > +    maxItems: 1
> Use reset-gpios: true as we already have it in panel-common.yaml
> 
> > +
> > +  backlight:
> > +    description: Backlight used by the panel
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> Use backlight from panel-common.yaml.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +  - avee-supply
> > +  - vddi-supply
> > +  - reset-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    dsi {
> My personal preference is indent with 4 spaces in examples but there are
> no rules so feel free to ignore.
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      panel@0 {
> > +        compatible = "mantix,mlaf057we51-x";
> > +        reg = <0>;
> > +        avdd-supply = <&reg_avdd>;
> > +        avee-supply = <&reg_avee>;
> > +        vddi-supply = <&reg_1v8_p>;
> > +        reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> > +        backlight = <&backlight>;
> > +      };
> > +    };
> I think we need an ampty line here.
> > +...
> > -- 
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
