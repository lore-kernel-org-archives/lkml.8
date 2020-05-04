Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B830C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8CE206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoPxsSKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEDTWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:22:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D95FC061A0E;
        Mon,  4 May 2020 12:22:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so468865wrx.4;
        Mon, 04 May 2020 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/wXZuQuJ7PnbeHEbQAWzwgKYTStvx6dUW/SJzOsLRoA=;
        b=CoPxsSKbVK8Wy2jX9jpaEFAsVrKicL9Ky010JZuo5GyRrrfUR4Op0dK5h8ShZrzcMg
         gLxcPLC5ozW8y8QjOdJ8f7PMGU75X1J1o0kx656eSKn897pq1hYDPq/MfsbjvcwK/b8Q
         Q7x3E7N0nmFnkjg4HxOKE21Dn9Wg8EvbMABdXxa6gfEPWSLGWHaG7DdIuArpB4AuYOI5
         +lR40B9lr3PVmcqC/7q+O9M0fgul0UIeJy5b1Zctf7oRtSH45mN+Q79p9r3j3CfyG5ne
         eZ/VhqehmdrvjrA9ORziKY17794r2OR87FD89jP8booS64hgALT20nJo1Zg28nG4ITeq
         o64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/wXZuQuJ7PnbeHEbQAWzwgKYTStvx6dUW/SJzOsLRoA=;
        b=YLqN1HagPKr7EfQgBX3FvItc1iptbEiUW8ZVkj5JsufEBC1x3MOl+qoqxdpKtCNz6O
         rsYPBPYxw9y04SRhfN1wx3+wUx+iiC+nODjfyM+Yz0ZGACJOgJWLGtViibJnZZrGBPXp
         D8/ZYRM09rxowsQcSHgW1cgIbOPZpJJcisuy3OpbRk8UuUCx1BLLRc8v7oNKseFBmJPO
         YHpJTq/uATekfUEBPyRwbGXGyWjLhrrJsBaquk5akoYzj2OgC1KMbj8en1NKYb9FY/Zq
         I0TnVgfRwlHoyu2GEgqGZ+R/Cbnn78aQYgrPOhfvtgmbuidyQrbe4Y0TbkFlUX66Vn8+
         GgFQ==
X-Gm-Message-State: AGi0PubwUXeuf3qEL7M/RdBKdI1BdPlDq3GrOrDIw2rgxjzP2prngVKh
        oKMwLUcOiGIqRKx6OqVbwEQ=
X-Google-Smtp-Source: APiQypJBCnbLLzGmzOZoTeVa2wShRwW4G5kxYHL4fAUySEqBFHKrWXJnqYh9/j/I7jSsqrQlC+zhpg==
X-Received: by 2002:adf:8563:: with SMTP id 90mr880519wrh.74.1588620126190;
        Mon, 04 May 2020 12:22:06 -0700 (PDT)
Received: from [192.168.1.23] (afde147.neoplus.adsl.tpnet.pl. [95.49.82.147])
        by smtp.gmail.com with ESMTPSA id k17sm630101wmi.10.2020.05.04.12.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 12:22:05 -0700 (PDT)
Subject: Re: [PATCH v24 01/16] dt: bindings: Add multicolor class dt bindings
 documention
To:     Dan Murphy <dmurphy@ti.com>, pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20200503123215.6449-1-dmurphy@ti.com>
 <20200503123215.6449-2-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4a316636-9e24-d74b-df46-ea894b5507b3@gmail.com>
Date:   Mon, 4 May 2020 21:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503123215.6449-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 5/3/20 2:32 PM, Dan Murphy wrote:
> Add DT bindings for the LEDs multicolor class framework.
> Add multicolor ID to the color ID list for device tree bindings.
> 
> CC: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   .../bindings/leds/leds-class-multicolor.yaml  | 71 +++++++++++++++++++
>   drivers/leds/led-core.c                       |  1 +
>   include/dt-bindings/leds/common.h             |  3 +-
>   3 files changed, 74 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
> new file mode 100644
> index 000000000000..16ffafc062ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-class-multicolor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common properties for the multicolor LED class.
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  Bindings for multi color LEDs show how to describe current outputs of
> +  either integrated multi-color LED elements (like RGB, RGBW, RGBWA-UV
> +  etc.) or standalone LEDs, to achieve logically grouped multi-color LED
> +  modules. This is achieved by adding multi-led nodes layer to the
> +  monochrome LED bindings.
> +  The nodes and properties defined in this document are unique to the multicolor
> +  LED class.  Common LED nodes and properties are inherited from the common.txt
> +  within this documentation directory.
> +
> +properties:
> +  color:
> +    description: |
> +      For multicolor LED support this property should be defined as
> +      LED_COLOR_ID_MULTI and further definition can be found in
> +      include/linux/leds/common.h.
> +
> +required:
> +  - color
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@14 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          compatible = "ti,lp5009";
> +          reg = <0x14>; > +
> +        multi-led@1 {

Whole multi-led subnode is contained in the led-controller
node, so it must have one more indentation level.

No need to resend whole patch set, just bump the version
of this single patch.

> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <1>;
> +          color = <LED_COLOR_ID_MULTI>;
> +          function = LED_FUNCTION_CHARGING;
> +
> +          led@0 {
> +            reg = <0>;
> +            color = <LED_COLOR_ID_RED>;
> +          };
> +
> +          led@1 {
> +            reg = <1>;
> +            color = <LED_COLOR_ID_GREEN>;
> +          };
> +
> +          led@2 {
> +            reg = <2>;
> +            color = <LED_COLOR_ID_BLUE>;
> +          };
> +        };
> +      };
> +    };
> +
> +additionalProperties: false
> +...
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index f1f718dbe0f8..846248a0693d 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -34,6 +34,7 @@ const char * const led_colors[LED_COLOR_ID_MAX] = {
>   	[LED_COLOR_ID_VIOLET] = "violet",
>   	[LED_COLOR_ID_YELLOW] = "yellow",
>   	[LED_COLOR_ID_IR] = "ir",
> +	[LED_COLOR_ID_MULTI] = "multicolor",
>   };
>   EXPORT_SYMBOL_GPL(led_colors);
>   
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 0ce7dfc00dcb..a463ce6a8794 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -30,7 +30,8 @@
>   #define LED_COLOR_ID_VIOLET	5
>   #define LED_COLOR_ID_YELLOW	6
>   #define LED_COLOR_ID_IR		7
> -#define LED_COLOR_ID_MAX	8
> +#define LED_COLOR_ID_MULTI	8
> +#define LED_COLOR_ID_MAX	9
>   
>   /* Standard LED functions */
>   /* Keyboard LEDs, usually it would be input4::capslock etc. */
> 

-- 
Best regards,
Jacek Anaszewski
