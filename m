Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B837C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E587520724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584104785;
	bh=GBoQ3MqDRFli1EBY49R3aE32doe+ryd128nntjVUtpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mq5lT5Y2FWk/uy7PRZylx95RjukPphBmDCjSZ9o6ivJyhimeyxtVBihzHhsY8Yoxo
	 D6eSdU/ssDhIqgSrw4lpIxjjGoxiJO0Dspa+dRchLLCXPYnZYAuw1WtTdfwFZsbYxW
	 hIaWZPXqDDYD1r0OJRp1ONYuhtsWydV02/Y32nyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCMNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:06:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37357 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgCMNGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:06:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so4713648otp.4;
        Fri, 13 Mar 2020 06:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHdSid7s0H3VQaI6DYZg0oKHqhQK3N0vdw8WgkOoUMY=;
        b=m938stGIUcYbW0yoPh4Tr85UeDKatMHrFlEDluReq25JprZzlK79jFrz2yKsFtLS73
         w34w68dbI9l4hv3gnkA4GZeb8X0DtQ9CCko0E9u2gdd9A9+ZfL8XqQVHW/wWMAsA1iro
         8x7mcScvJMRnCt9ltj9gx6BV3iU5FIDE7Gg8riaFmkvfGQdsYSaIYCGm8qbZQ2lqyniY
         AAYpr3s1kuwlQLmaUMPRDmkU1A/bXyyps4PLQ11J30w7UO2Wz6k9Ba1oO5+vlMLJdKer
         hb6kLItTOzoFILG3JIr1H8aOY0ljkYctgYM7TgmYC5v02QagzJ4Rqj5Nsro2/m87H0ZM
         I5DQ==
X-Gm-Message-State: ANhLgQ0W2tPiy4dA3dLf1FzGMlu8RE7RgFALrTuNWhNkAp/wjOyjNPZx
        iFedlElOkcILRCAN8Hwq6g==
X-Google-Smtp-Source: ADFU+vtfB8VVfp0P94IerB6q0pCgYuN2fa65rdVAVLeK4GDYJ5TINq3nU+xCyQQH5pPph5x1HIHvTw==
X-Received: by 2002:a9d:6752:: with SMTP id w18mr10565258otm.123.1584104782282;
        Fri, 13 Mar 2020 06:06:22 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p130sm4070287oig.51.2020.03.13.06.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:06:21 -0700 (PDT)
Received: (nullmailer pid 19075 invoked by uid 1000);
        Fri, 13 Mar 2020 13:06:20 -0000
Date:   Fri, 13 Mar 2020 08:06:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org, baylibre-upstreaming@groups.io
Subject: Re: [PATCH v3 2/3] dt-bindings: leds: Shiji Lighting APA102C LED
Message-ID: <20200313130620.GA19369@bogus>
References: <1583502010-16210-1-git-send-email-nbelin@baylibre.com>
 <1583502010-16210-3-git-send-email-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583502010-16210-3-git-send-email-nbelin@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:40:09PM +0100, Nicolas Belin wrote:
> Document Shiji Lighting APA102C LED driver device tree bindings.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>  .../devicetree/bindings/leds/leds-apa102c.yaml     | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-apa102c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-apa102c.yaml b/Documentation/devicetree/bindings/leds/leds-apa102c.yaml
> new file mode 100644
> index 000000000000..21457fc3762d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-apa102c.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-apa102c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for Shiji Lighting - APA102C
> +
> +maintainers:
> +  - Nicolas Belin <nbelin@baylibre.com>
> +
> +description:
> +  Each RGB LED is represented as a rgb-led sub-node of the leds-apa102c
> +  device.  Each LED is a three color rgb LED with an additional 32 levels
> +  brightness adjustment. They can be cascaded so that multiple LEDs can be set
> +  with a single command.
> +
> +properties:
> +  compatible:
> +    const: shiji,apa102c
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^rgb-led@[0-9]+$":
> +    type: object
> +    description: |
> +      Array of connected RGB LEDs.

This should reference leds/common.yaml:

allOf:
  - $ref: common.yaml#

> +
> +    properties:
> +      reg:
> +        description: |
> +          This property corresponds to the led index. It has to be between 0
> +          and the number of managed leds minus 1
> +        maxItems: 1
> +
> +      label:
> +        description: |
> +          This property corresponds to the name of the RGB led.
> +        maxItems: 1
> +
> +      linux,default-trigger: true
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    required:
> +      - reg
> +      - label
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - '#address-cells'
> +  - '#size-cells'

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        led-controller@0 {
> +            compatible = "shiji,apa102c";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            rgb-led@0 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0>;
> +                label = "rgb_led1";
> +            };
> +            rgb-led@1 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <1>;
> +                label = "rgb_led2";
> +            };
> +        };
> +    };
> -- 
> 2.7.4
> 
