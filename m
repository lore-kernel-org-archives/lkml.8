Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25169C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4E123133
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgHOVe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:34:57 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46896 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHOVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:34:56 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6EA3080548;
        Sat, 15 Aug 2020 23:28:41 +0200 (CEST)
Date:   Sat, 15 Aug 2020 23:28:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
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
Subject: Re: [PATCH v2 2/3] dt-bindings: Add Mantix MLAF057WE51-X panel
 bindings
Message-ID: <20200815212840.GC1244923@ravnborg.org>
References: <cover.1597526107.git.agx@sigxcpu.org>
 <c171b488e883e26eaef7906c007a5cabcbf9e33d.1597526107.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c171b488e883e26eaef7906c007a5cabcbf9e33d.1597526107.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=7gkXJVJtAAAA:8 a=gEfo2CItAAAA:8
        a=cjlgXKyR3KIVCA3-0ZEA:9 a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=sptkURWiP4Gy88Gu7hUp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 11:16:21PM +0200, Guido Günther wrote:
> The panel uses a Focaltech FT8006p, the touch part is handled by the
> already existing edt-ft5x06.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will apply yourself, otherwise I will do so when we have
seen a backmerge.

	Sam

> ---
>  .../display/panel/mantix,mlaf057we51-x.yaml   | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> new file mode 100644
> index 0000000000000..937323cc9aaac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/mantix,mlaf057we51-x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mantix MLAF057WE51-X 5.7" 720x1440 TFT LCD panel
> +
> +maintainers:
> +  - Guido Günther <agx@sigxcpu.org>
> +
> +description:
> +  Mantix MLAF057WE51 X is a 720x1440 TFT LCD panel connected using
> +  a MIPI-DSI video interface.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mantix,mlaf057we51-x
> +
> +  port: true
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  avdd-supply:
> +    description: Positive analog power supply
> +
> +  avee-supply:
> +    description: Negative analog power supply
> +
> +  vddi-supply:
> +    description: 1.8V I/O voltage supply
> +
> +  reset-gpios: true
> +
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - avee-supply
> +  - vddi-supply
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "mantix,mlaf057we51-x";
> +            reg = <0>;
> +            avdd-supply = <&reg_avdd>;
> +            avee-supply = <&reg_avee>;
> +            vddi-supply = <&reg_1v8_p>;
> +            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> +            backlight = <&backlight>;
> +        };
> +    };
> +
> +...
> -- 
> 2.26.2
