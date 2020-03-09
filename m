Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82F24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCIWWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:22:48 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51732 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgCIWWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:22:47 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 1EEAE634C87;
        Tue, 10 Mar 2020 00:22:00 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1jBQme-0001Fq-BM; Tue, 10 Mar 2020 00:22:00 +0200
Date:   Tue, 10 Mar 2020 00:22:00 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/3] dt-bindings: leds: Add binding for sgm3140
Message-ID: <20200309222200.GE2619@valkosipuli.retiisi.org.uk>
References: <20200309203558.305725-1-luca@z3ntu.xyz>
 <20200309203558.305725-3-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309203558.305725-3-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, Mar 09, 2020 at 09:35:57PM +0100, Luca Weiss wrote:
> Add YAML devicetree binding for SGMICRO SGM3140 charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since RFC:
> - new patch
> 
> I'm not sure about the completeness of this binding as it doesn't
> mention the led subnode at all.

I guess you'll need one --- the driver expects it as well.

> The only existing led yaml binding is leds/leds-max77650.yaml which
> mentions the subnode but duplicates properties from documented in 
> leds/common.txt.
> 
>  .../bindings/leds/leds-sgm3140.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> new file mode 100644
> index 000000000000..be9384573d02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-sgm3140.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SGMICRO SGM3140 500mA Buck/Boost Charge Pump LED Driver
> +
> +maintainers:
> +  - Luca Weiss <luca@z3ntu.xyz>
> +
> +description: |
> +  The SGM3140 is a current-regulated charge pump which can regulate two current
> +  levels for Flash and Torch modes.
> +
> +  It is controlled with two GPIO pins.
> +
> +  The data sheet can be found at:
> +    http://www.sg-micro.com/uploads/soft/20190626/1561535688.pdf
> +
> +properties:
> +  compatible:
> +    const: sgmicro,sgm3140
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: A connection to the 'EN' pin.
> +
> +  flash-gpios:
> +    maxItems: 1
> +    description: A connection to the 'FLASH' pin.

How about a regulator supply?

I guess the chip is meant to be connected to a li-ion cell but still...

> +
> +required:
> +  - compatible
> +  - flash-gpios
> +  - enable-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    sgm3140 {
> +        compatible = "sgmicro,sgm3140";
> +        flash-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +        enable-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> +
> +        sgm3140_flash: led {
> +            function = LED_FUNCTION_FLASH;
> +            color = <LED_COLOR_ID_WHITE>;
> +            flash-max-timeout-us = <250000>;
> +        };
> +    };

-- 
Regards,

Sakari Ailus
