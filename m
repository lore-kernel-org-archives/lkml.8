Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA7C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847D720724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCRS5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:57:22 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48866 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCRS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:57:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5739D80521;
        Wed, 18 Mar 2020 19:57:15 +0100 (CET)
Date:   Wed, 18 Mar 2020 19:57:13 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: Convert feiyang,
 fy07024di26a30d to DT schema
Message-ID: <20200318185713.GA28092@ravnborg.org>
References: <20200318171003.5179-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318171003.5179-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8
        a=gEfo2CItAAAA:8 a=e5mUnYsNAAAA:8 a=8gF--RGPhfDgffNwR7kA:9
        a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

On Wed, Mar 18, 2020 at 10:40:01PM +0530, Jagan Teki wrote:
> Convert the feiyang,fy07024di26a30d panel bindings to DT schema.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Thanks for the resend.

Please fix so the two bindings uses panel-common.yaml.

And then only properties specific for this binding shall have a
description.

See below - please fix both bindings and resend.

	Sam

> ---
> Changes for v2:
> - fix dt_binding_check 
> 
>  .../display/panel/feiyang,fy07024di26a30d.txt | 20 -------
>  .../panel/feiyang,fy07024di26a30d.yaml        | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> deleted file mode 100644
> index 82caa7b65ae8..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
> -
> -Required properties:
> -- compatible: must be "feiyang,fy07024di26a30d"
> -- reg: DSI virtual channel used by that screen
> -- avdd-supply: analog regulator dc1 switch
> -- dvdd-supply: 3v3 digital regulator
> -- reset-gpios: a GPIO phandle for the reset pin
> -
> -Optional properties:
> -- backlight: phandle for the backlight control.
> -
> -panel@0 {
> -	compatible = "feiyang,fy07024di26a30d";
> -	reg = <0>;
> -	avdd-supply = <&reg_dc1sw>;
> -	dvdd-supply = <&reg_dldo2>;
> -	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
> -	backlight = <&backlight>;
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
> new file mode 100644
> index 000000000000..f292c57a5bd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/feiyang,fy07024di26a30d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
> +
> +maintainers:
> +  - Jagan Teki <jagan@amarulasolutions.com>
> +
> +properties:
> +  compatible:
> +    const: feiyang,fy07024di26a30d
> +
> +  reg:
> +    description: DSI virtual channel used by that screen
reg is already described elsewhere so no description.
Thus is becomes:

    reg: true

> +
> +  avdd-supply:
> +    description: analog regulator dc1 switch
> +
> +  dvdd-supply:
> +    description: 3v3 digital regulator
> +
> +  reset-gpios:
> +    description: a GPIO phandle for the reset pin
This would become:
    reset-gpios: true

> +
> +  backlight:
> +    description: Backlight used by the panel
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
This would become:

    backlight: true

> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
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
> +
> +        panel@0 {
> +            compatible = "feiyang,fy07024di26a30d";
> +            reg = <0>;
> +            avdd-supply = <&reg_dc1sw>;
> +            dvdd-supply = <&reg_dldo2>;
> +            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
> +            backlight = <&backlight>;
> +        };
> +    };

Example looks good.



> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
