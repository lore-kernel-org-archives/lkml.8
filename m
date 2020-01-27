Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC47C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274952467E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580150983;
	bh=kO2tl9xh3S+wJoE1RompZdhl0zGRQ120O8Xl7S1IYlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=epWnX8CTYP0NwyEYqroJCpSEl760yRUtkeXx7TNeXEh4YAD84zAwcoJrQuwzV6Atv
	 UjaDXrcHbMccd4k/cYUXJ1Ij2o1W/7+fdeC0frFWx24p8rSJn1mqPj/919tQxceREP
	 6izOm263H2vBwiGdtnYu3TcEze44fBy1MXur1P00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA0Stm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:49:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32868 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0Stm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:49:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so9476057otp.0;
        Mon, 27 Jan 2020 10:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGBm/FHBYQPO3SnIsbIyzOljZ22wv42ASP4mKhEoOFM=;
        b=JBSGSmDZiuJ9+VZ+/25sodsnHuCM6KHP7q77nNFVsBSJc/UF8JYelu6FyB3frm765R
         MSbBjWND6m6+rFldCgIbdULpCuOsimm4pMsa7U8tDBKs3hO74YjfndJ0gH7XQmJbh7xw
         Rq+eTRrRkZhA8TLzLq6rXPRDbsovkEfhyAElq40KTYI3fdQyBsVZBW8u9ZicNw/fs+lR
         RhqQHp8O/49WtP+IjHp8AuE4RB4yVbS0WagiFPPnXjbqTn7SsLtH64kXu9WB+7moOG40
         QUcrUEyGu1XvhchtOFmJrji3ZAh7WW0IBEyqJQsWHUF6TbHaHTsJ8hwe0lwPrVdk1FHL
         9vow==
X-Gm-Message-State: APjAAAVV5e23Iy29lUbMHwbPOpYSjdUS5MhV+5ZG4J5fbysK7Gvg0XER
        p6JoBpsuDR1H7CEEc7B3FA==
X-Google-Smtp-Source: APXvYqyJiWy4dlUsawGnDmHPwC0KvTg3gRd2eqBgWW0mBSa+a6zqBV8eI8voaNEYtpy9DO4pEOPbkg==
X-Received: by 2002:a9d:784b:: with SMTP id c11mr13010105otm.246.1580150980656;
        Mon, 27 Jan 2020 10:49:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w20sm3119264otj.21.2020.01.27.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 10:49:40 -0800 (PST)
Received: (nullmailer pid 11942 invoked by uid 1000);
        Mon, 27 Jan 2020 18:49:39 -0000
Date:   Mon, 27 Jan 2020 12:49:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add documentation
 for Toshiba tc358768
Message-ID: <20200127184939.GA4237@bogus>
References: <20200127105634.7638-1-peter.ujfalusi@ti.com>
 <20200127105634.7638-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127105634.7638-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:56:33PM +0200, Peter Ujfalusi wrote:
> TC358768/TC358778 is a Parallel RGB to MIPI DSI bridge.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../display/bridge/toshiba,tc358768.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> new file mode 100644
> index 000000000000..8dd8cca39a77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358768.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toschiba TC358768/TC358778 Parallel RGB to MIPI DSI bridge
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The TC358768/TC358778 is bridge device which converts RGB to DSI.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - toshiba,tc358768
> +      - toshiba,tc358778
> +
> +  reg:
> +    maxItems: 1
> +    description: base I2C address of the device
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to active low RESX pin
> +
> +  vddc-supply:
> +    description: Regulator for 1.2V internal core power.
> +
> +  vddmipi-supply:
> +    description: Regulator for 1.2V for the MIPI.
> +
> +  vddio-supply:
> +    description: Regulator for 1.8V - 3.3V IO power.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: refclk
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        additionalProperties: false
> +
> +        description: |
> +          Video port for RGB input
> +
> +        properties:
> +          reg:
> +            const: 0
> +
> +        patternProperties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              data-lines:
> +                enum: [ 16, 18, 24 ]
> +
> +              remote-endpoint: true
> +
> +        required:
> +          - reg
> +
> +      port@1:
> +        type: object
> +        additionalProperties: false
> +
> +        description: |
> +          Video port for DSI output (panel or connector).
> +
> +        properties:
> +          reg:
> +            const: 1
> +
> +        patternProperties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              remote-endpoint: true
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddc-supply
> +  - vddmipi-supply
> +  - vddio-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c1 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dsi_bridge: tc358768@0e {

Generic node names and no leading 0s:

dsi-bridge@e

> +        compatible = "toshiba,tc358768";
> +        reg = <0x0e>;
> +
> +        clocks = <&tc358768_refclk>;
> +        clock-names = "refclk";
> +
> +        /* GPIO line is inverted before going to the bridge */
> +        reset-gpios = <&pcf_display_board 0 1 /* GPIO_ACTIVE_LOW */>;

You just need to add the include for the define to work.

> +
> +        vddc-supply = <&v1_2d>;
> +        vddmipi-supply = <&v1_2d>;
> +        vddio-supply = <&v3_3d>;
> +
> +        dsi_bridge_ports: ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            rgb_in: endpoint {
> +              remote-endpoint = <&dpi_out>;
> +              data-lines = <24>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            dsi_out: endpoint {
> +              remote-endpoint = <&lcd_in>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +    
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
