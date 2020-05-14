Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BEDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830C4205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589468077;
	bh=XF7VqCo4FKHfUB4Zx6lTd0nl/oUWIyInCLXc99nPfpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lXh0OI/PAvs/0NYikNviw3Kd7ritzivrvsIyGcZUXlplROfvOcuNsKCb53hg+YG7y
	 rhZPP5x2UgMCNl9X6FuiMOLtMP9U24wNdXSlS+Wx8X7eauEC3rutMpFQsFgHLPcBCL
	 bncYGFoO3du+regZSsAvb9kCu0E0IROlUW4zs9BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgENOyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:54:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35577 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:54:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id o7so24782098oif.2;
        Thu, 14 May 2020 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yB9VTl8KywTt9Ux7iGL6NMMzFHRwNMMveEGo6bB/Nqs=;
        b=T0LHW//wg1PT5ZhYrD5YNYAJaFyvoLbvaDx5AvdpOhL/xcjcF7bgouQg23E1pzKwrh
         FTsUfm6uumwnDuAqUBSlF1+UxrAvB5aIroIXdil8bBXDfQ84m917KjJWv4cRhgRbhXkC
         viQn7d34JJxJYRxuqmDLJ+LSeFCwOA8C7K0pLgGK1w2weV99X/Rxcy6W5pQsRdRrc2hX
         ok0s3qhjJrCqmgoFd8rfYzn5UbyQF+GsoiMvXUQ4FFARGmUVkn/Oe2qzbfgO/Y+0GjBm
         m6d898f2rqwKLlRrBc5BuNq1kjQuMvs8/waZnm0qcCwbZx/Eh9ttZLAeITt65MRzHsJe
         ZUGA==
X-Gm-Message-State: AGi0PuYxShKp4+FFQ+g/8AwPi3VIdPLOJAPvgBLTTTyo+AFH1qJpORPw
        XmtKtcAnRsZQzh+AW5K/Bw==
X-Google-Smtp-Source: APiQypKK3YHethFZkt7Xx5I2o7MWAZ0bYDIOxjjLF2SWgo5qkdd1iKlpLeZMoOaRUFuLjsQuL2Qxeg==
X-Received: by 2002:a05:6808:a93:: with SMTP id q19mr31602743oij.6.1589468074296;
        Thu, 14 May 2020 07:54:34 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n9sm819299otl.76.2020.05.14.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:54:33 -0700 (PDT)
Received: (nullmailer pid 26910 invoked by uid 1000);
        Thu, 14 May 2020 14:54:32 -0000
Date:   Thu, 14 May 2020 09:54:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devicetree@vger.kernel.org, devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Message-ID: <20200514145432.GA6091@bogus>
References: <cover.1588747998.git.xji@analogixsemi.com>
 <b720f7d2c5338813d31b7f715f59ca68c367d5a8.1588747998.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b720f7d2c5338813d31b7f715f59ca68c367d5a8.1588747998.git.xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 03:04:20PM +0800, Xin Ji wrote:
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI to DisplayPort 1.3 4K.
> 
> You can add support to your board with binding.

We have an example in the binding, no reason to also put in the commit 
msg.

> 
> Example:
> 	anx7625_bridge: encoder@58 {
> 		compatible = "analogix,anx7625";
> 		reg = <0x58>;
> 		status = "okay";
> 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			mipi2dp_bridge_in: port@0 {
> 				reg = <0>;
> 				anx7625_in: endpoint {
> 					remote-endpoint = <&mipi_dsi>;
> 				};
> 			};
> 
> 			mipi2dp_bridge_out: port@1 {
> 				reg = <1>;
> 				anx7625_out: endpoint {
> 					remote-endpoint = <&panel_in>;
> 				};
> 			};
> 		};
> 	};
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> new file mode 100644
> index 0000000..6e54176
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analogix Semiconductor, Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
> +
> +maintainers:
> +  - Xin Ji <xji@analogixsemi.com>
> +
> +description: |
> +  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> +  designed for portable devices.
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true

These don't belong here.

> +
> +  compatible:
> +    items:
> +      - const: analogix,anx7625
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: used for interrupt pin B8.
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: used for power on chip control, POWER_EN pin D2.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: used for reset chip control, RESET_N pin B7.
> +    maxItems: 1
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      port@0:
> +        type: object
> +        description:
> +          Video port for MIPI DSI input.
> +
> +      port@1:
> +        type: object
> +        description:
> +          Video port for panel or connector.
> +
> +    required:
> +        - port@0
> +        - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        anx7625_bridge: encoder@58 {

Drop any unused labels.

> +            compatible = "analogix,anx7625";
> +            reg = <0x58>;
> +            enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                mipi2dp_bridge_in: port@0 {
> +                    reg = <0>;
> +                    anx7625_in: endpoint {
> +                        remote-endpoint = <&mipi_dsi>;
> +                    };
> +                };
> +
> +                mipi2dp_bridge_out: port@1 {
> +                    reg = <1>;
> +                    anx7625_out: endpoint {
> +                        remote-endpoint = <&panel_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 
