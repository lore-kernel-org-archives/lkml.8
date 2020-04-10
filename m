Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EADC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1512064A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540527;
	bh=9M12dbp0MvcuBK52wZqAxWvUuK1E7s5Rz0bu2eoj3V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q+GRLccvlMR1pmJQaNWmfDXACUKX1yO3mwPj7fGEJs2Tp1BjjXZAHdDMgdP21gXt4
	 zEVIZlrn/WN4LBBLcePURxGs4hy21fhMakYA7WuiiQxElMS/BO4tRFQS3Yrd45s+sf
	 ce341tClip2VyBqebvjG80TCsmYOtOdmbtuiwVo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgDJRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:42:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34900 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgDJRmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:42:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so2549474oto.2;
        Fri, 10 Apr 2020 10:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p3GtHQTWXIQaFnXHsApCjfV8Rah3qivLPAz5Wv7Len8=;
        b=WfGq17R3KOlmRk7js0308DuU0DcA8+i9Ulx+l/FFmwtrvpZFKtaljT4T+rwJLmL8tf
         T1F2r75x3n2yrhPSaiJluY1iaQSYn1ObLVHOd6XvL8uEQkFFFLkMGX5iD4Xg/jRWQDVr
         Bf9Zy9QMCVxeHAK/Vm3B4H9fC3YTB/SvLz31S8yGIjlJ2/aTVpJmT3AaU6xIINiIbTzZ
         5PHRSwDMLGBTdtC1gTSfGB7CQPiYgvhhupHW8a8/6cvhGsl7PSMk7mDtuyuUUxwUPSCG
         2nu3B6uEgnwKhnG4WIEW6Da/r2A3b5lbPH4lrpK/NxhlYJZ2KzNTD1ni0Ni9jHkWCxbN
         /fmg==
X-Gm-Message-State: AGi0Pub1L+x5GB98/7rF0GRBYxoXZUTdQA1oEs8qccXxS+AM3sNSRw8S
        L/9OmOO6K4IOYxtcozXCfg==
X-Google-Smtp-Source: APiQypLbfE0LHYQU4L4WPZigiXumpsnf69cXj/bKN0IhyHFYdZOnCo6DveWu0AeZFY66o2O86cmTKg==
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr5250391ota.341.1586540524909;
        Fri, 10 Apr 2020 10:42:04 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id i20sm1677495oos.19.2020.04.10.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:42:04 -0700 (PDT)
Received: (nullmailer pid 18322 invoked by uid 1000);
        Fri, 10 Apr 2020 17:41:42 -0000
Date:   Fri, 10 Apr 2020 12:41:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Add binding for sgm3140
Message-ID: <20200410174142.GA14153@bogus>
References: <20200330194757.2645388-1-luca@z3ntu.xyz>
 <20200330194757.2645388-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330194757.2645388-2-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 09:47:56PM +0200, Luca Weiss wrote:
> Add YAML devicetree binding for SGMICRO SGM3140 charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v1:
> - Add vin-supply
> - Add led subnode (common.yaml)
> 
>  .../bindings/leds/leds-sgm3140.yaml           | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> new file mode 100644
> index 000000000000..24ca178e5d0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> @@ -0,0 +1,61 @@
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
> +
> +  vin-supply:
> +    description: Regulator providing power to the 'VIN' pin.
> +
> +  led:

Needs 'type: object'

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    allOf:
> +      - $ref: common.yaml#
> +
> +required:
> +  - compatible
> +  - flash-gpios
> +  - enable-gpios
> +
> +additionalProperties: false
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
> +        vin-supply = <&reg_dcdc1>;
> +
> +        sgm3140_flash: led {
> +            function = LED_FUNCTION_FLASH;
> +            color = <LED_COLOR_ID_WHITE>;
> +            flash-max-timeout-us = <250000>;
> +        };
> +    };
> -- 
> 2.26.0
> 
