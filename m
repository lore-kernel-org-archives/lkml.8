Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2049C33CA6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5112072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAJRMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:12:31 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:33072 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgAJRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:12:31 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5463420053;
        Fri, 10 Jan 2020 18:12:27 +0100 (CET)
Date:   Fri, 10 Jan 2020 18:12:26 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/5] dt-bindings: panel: add Feixin K101 IM2BA02 MIPI-DSI
 panel
Message-ID: <20200110171226.GB25099@ravnborg.org>
References: <20200110155225.1051749-1-icenowy@aosc.io>
 <20200110155225.1051749-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110155225.1051749-3-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=gEfo2CItAAAA:8
        a=q9ad5_0hBVDqaoZWYP0A:9 a=AFdBQuwNfT9Z_ji9:21 a=HW4JGcA6RQc568Jt:21
        a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy.

On Fri, Jan 10, 2020 at 11:52:22PM +0800, Icenowy Zheng wrote:
> Feixin K101 IM2BA02 is a 10.1" 800x1280 4-lane MIPI-DSI panel.
> 
> Add device tree binding for it.
Thanks for using the new meta-schema format and with the correct
license.


The example fails dt_binding_check - I had to do the following to make
it pass:

diff --git a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
index 7176d14893ff..c43f884de6ac 100644
--- a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
+++ b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
@@ -37,7 +37,9 @@ additionalProperties: false
 
 examples:
   - |
-    &dsi {
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
         #address-cells = <1>;
         #size-cells = <0>;
         panel@0 {

Added include to get definition of GPIO_...
And dropped the "&" as it is not OK in the example here.

And please consider if backlight really is a required property.

	Sam
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../display/panel/feixin,k101-im2ba02.yaml    | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
> new file mode 100644
> index 000000000000..7176d14893ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/feixin,k101-im2ba02.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Feixin K101 IM2BA02 10.1" MIPI-DSI LCD panel
> +
> +maintainers:
> +  - Icenowy Zheng <icenowy@aosc.io>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: feixin,k101-im2ba02
> +  reg: true
> +  backlight: true
> +  reset-gpios: true
> +  avdd-supply:
> +     description: regulator that supplies the AVDD voltage
> +  dvdd-supply:
> +     description: regulator that supplies the DVDD voltage
> +  cvdd-supply:
> +     description: regulator that supplies the CVDD voltage
> +
> +required:
> +  - compatible
> +  - reg
> +  - backlight
> +  - avdd-supply
> +  - dvdd-supply
> +  - cvdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    &dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "feixin,k101-im2ba02";
> +            reg = <0>;
> +            avdd-supply = <&reg_dc1sw>;
> +            dvdd-supply = <&reg_dc1sw>;
> +            cvdd-supply = <&reg_ldo_io1>;
> +            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>;
> +            backlight = <&backlight>;
> +        };
> +    };
> +
> +...
> -- 
> 2.23.0
