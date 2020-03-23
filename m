Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC4AC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4218F20753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585001353;
	bh=xQT8swUoLwKV5Y2meayMOiwAHXpbKeGXizKxTn6kaIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZtpiMjo+IdRv6S2DnYWx2dU6a8+oMMf35OCQ3mvR8urH3WJ+OQgxUyruWgvx3Xocl
	 TcKa3Snv54BNHY3SwfPI8VaYG8G5KN9LsAEXXaK8BpoBZfOvbU0HXR36dPCrsUFdcK
	 qO0SGgN9qDdD/Eh3m2LDEIVBReYjyTg3Vxyjsi9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgCWWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:09:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37594 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:09:11 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so2506599ilr.4;
        Mon, 23 Mar 2020 15:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZ81zxCZMIgmSeBafIK/lYfMctImcol2Rgukq3RX2VQ=;
        b=Nekm2bO6tM/m8Uwi3xip+7HE3c9F+IZ0H80k0U6gRp9BVaSDVrWqZHnyv/T8t9mb46
         UvAcqRbZH9Ts/Z5OhOAXQkADQPDUBMW51HUe6uSNo86JQHhFCKD1bqdO3EmSl/2AAL7r
         27nFuDWCe/dlasExaGMwIOrQqW1uV378Bi9ciNk3AepM7PpFEF1RHFnHfnR5dtXzj70p
         fUTzvJi2yxTgOHzyZ+YOpqobuXWjE+m8GClWhMK7rvEKnOvXNeNny/8/RIBWsAAynnG8
         d7h+jXKojawp58DbKJyNvid8JObjpN6mPI5vHMZY6aJNvmDIcLxJWGLOQgDqQaeXO2X8
         yw8A==
X-Gm-Message-State: ANhLgQ15/5JnaRM1gFXr1Zq4RqG6rGUhUoYOQWrWGCzrp2XQvsDvk47b
        xLDTuuLHwFCIdRxtTQeSLA==
X-Google-Smtp-Source: ADFU+vsd05AO0Mnjm8m1n+SJIbnJIylZaJUIeQ09QPhBI7256Cv2qE4OXA4s9daeooy1ivHTyfr2Uw==
X-Received: by 2002:a92:8510:: with SMTP id f16mr23770430ilh.208.1585001350772;
        Mon, 23 Mar 2020 15:09:10 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 82sm920263iou.54.2020.03.23.15.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:09:10 -0700 (PDT)
Received: (nullmailer pid 24507 invoked by uid 1000);
        Mon, 23 Mar 2020 22:09:05 -0000
Date:   Mon, 23 Mar 2020 16:09:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Phong LE <ple@baylibre.com>
Cc:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: display: bridge: add it66121 bindings
Message-ID: <20200323220905.GA17573@bogus>
References: <20200311125135.30832-1-ple@baylibre.com>
 <20200311125135.30832-3-ple@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311125135.30832-3-ple@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:51:33PM +0100, Phong LE wrote:
> Add the ITE bridge HDMI it66121 bindings.
> 
> Signed-off-by: Phong LE <ple@baylibre.com>
> ---
>  .../bindings/display/bridge/ite,it66121.yaml  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> new file mode 100644
> index 000000000000..1717e880d130
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it66121.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE it66121 HDMI bridge Device Tree Bindings
> +
> +maintainers:
> +  - Phong LE <ple@baylibre.com>
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The IT66121 is a high-performance and low-power single channel HDMI
> +  transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward compatible
> +  to DVI 1.0 specifications.
> +
> +properties:
> +  compatible:
> +    const: ite,it66121
> +
> +  reg:
> +    maxItems: 1
> +    description: base I2C address of the device
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to active low reset
> +
> +  vrf12-supply:
> +    maxItems: 1

Drop this. Supplies are always a single item.

> +    description: Regulator for 1.2V analog core power.
> +
> +  vcn33-supply:
> +    maxItems: 1
> +    description: Regulator for 3.3V digital core power.
> +
> +  vcn18-supply:
> +    maxItems: 1
> +    description: Regulator for 1.8V IO core power.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  pclk-dual-edge:
> +    maxItems: 1

Not a valid property if this is boolean.

> +    description: enable pclk dual edge mode.
> +
> +  port:

You should have an output port to a connector node.

> +    type: object
> +
> +    properties:
> +      endpoint:
> +        type: object
> +        description: |
> +          Input endpoints of the bridge.
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vrf12-supply
> +  - vcn33-supply
> +  - vcn18-supply
> +  - interrupts
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c6 {

i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      it66121hdmitx: it66121hdmitx@4c {
> +        compatible = "ite,it66121";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&ite_pins_default>;
> +        vcn33-supply = <&mt6358_vcn33_wifi_reg>;
> +        vcn18-supply = <&mt6358_vcn18_reg>;
> +        vrf12-supply = <&mt6358_vrf12_reg>;
> +        reset-gpios = <&pio 160 1 /* GPIO_ACTIVE_LOW */>;
> +        interrupt-parent = <&pio>;
> +        interrupts = <4 8 /* IRQ_TYPE_LEVEL_LOW */>;
> +        reg = <0x4c>;
> +        pclk-dual-edge;
> +
> +        port {
> +          it66121_in: endpoint {
> +            remote-endpoint = <&display_out>;
> +          };
> +        };
> +      };
> +    };
> -- 
> 2.17.1
> 
