Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0FDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB57021744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596227938;
	bh=MpqSfbO1kBWzvAqv+qsoKnGDz0Q+PQwa++RlBZ3bA8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sKREDVxs/ioCechRstCnr/Uibd3/FJB5vOeJqSbHqgk7od/haF9KR5t0BGd2n8D8G
	 ELFXxGQ+ng2rsb/TfZTHp6uxIFzTV3AbYDnBAy4DTUiTCO5mjn/0sqMttsd+FmhVKI
	 TYlm3HrsRKmF0hqdd4UudnVSde8V7CyKhTIf9290=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGaUi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:38:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36252 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGaUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:38:54 -0400
Received: by mail-io1-f67.google.com with SMTP id t15so24005732iob.3;
        Fri, 31 Jul 2020 13:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7XPWUIkqRlODZ7YR+Y+TIh8Lqv7i7GjZ1aMgIq7xzSU=;
        b=dOgcQtKWFRAO/FkcaAyn8rW5CyK2pLIKg9s/t2aBB21+3x/rur9CfEap8ZQaJMrDa6
         iWoCoA01QRj1+NFu00iJbJqoAm3rimxDOVp92Zp0ZRVlTdJQqMfX2U8Stok2JWnsPwfw
         xDUBZqaFVkQkj7oL5fUOfRy5y+sLHhlrvdk6oaerJSe4UerEPMWh52IREumQAsy9ZyRm
         IX3Yl0RRG3vxaYRGz83N+qOQEIigofh/hMXB70605U6dW+6TpDoBVn9NGqMJUTxElm23
         10XC4yAuIpzH7SJcwkwOaHR5gqDPiW9/pEnwfot2ieDLJnGXobduLnKpv87XGueR4O/M
         AzyQ==
X-Gm-Message-State: AOAM532aJhnggjE1OVUhASxAchO41HdX7f54nVIACJf86ewj+2Jj4xXU
        dzWHLlE+PaQecUyYN9Suvg==
X-Google-Smtp-Source: ABdhPJyCUTSCKDGyMHS9ZCxdxw2vpQJn23D2nUjQ/zmvdCRCUX1d4UFtwQEwXdEXhA2LGb7zFaKuGg==
X-Received: by 2002:a6b:9242:: with SMTP id u63mr5060547iod.92.1596227932607;
        Fri, 31 Jul 2020 13:38:52 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c67sm5031153iof.16.2020.07.31.13.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:38:52 -0700 (PDT)
Received: (nullmailer pid 743459 invoked by uid 1000);
        Fri, 31 Jul 2020 20:38:50 -0000
Date:   Fri, 31 Jul 2020 14:38:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: Add Microchip
 USB253x/USB3x13/USB46x4 support
Message-ID: <20200731203850.GA725935@bogus>
References: <20200726084116.GD448215@kroah.com>
 <20200727083333.19623-1-ceggers@arri.de>
 <20200727083333.19623-2-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727083333.19623-2-ceggers@arri.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:33:30AM +0200, Christian Eggers wrote:
> Add DT bindings for Microchip USB253x/USB3x13/USB46x4 driver.

Looks like a lot copied from usb251xb.txt. Many of these properties need 
to be defined in a common schema. That could be either common to USB 
devices, hubs, or Microchip hubs or some combination of those. 

> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  .../devicetree/bindings/usb/usb253x.yaml      | 234 ++++++++++++++++++
>  1 file changed, 234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb253x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb253x.yaml b/Documentation/devicetree/bindings/usb/usb253x.yaml
> new file mode 100644
> index 000000000000..88ea744147b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb253x.yaml
> @@ -0,0 +1,234 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usb253x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip USB253x/USB3x13/USB46x4 USB 2.0 Hi-Speed Hub Controller
> +
> +maintainers:
> +  - Christian Eggers <ceggers@arri.de>
> +
> +description: |
> +  http://ww1.microchip.com/downloads/en/AppNotes/00001801C.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,usb2532
> +      - microchip,usb2532i
> +      - microchip,usb2533
> +      - microchip,usb2533i
> +      - microchip,usb2534
> +      - microchip,usb2534i
> +      - microchip,usb3613
> +      - microchip,usb3613i
> +      - microchip,usb3813
> +      - microchip,usb3813i
> +      - microchip,usb4604
> +      - microchip,usb4604i
> +      - microchip,usb4624
> +      - microchip,usb4624i
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C address on the selected bus (usually <0x2D>).
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Specify the gpio for hub reset.
> +
> +  vdd-supply:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Specify the regulator supplying vdd.
> +
> +  skip-config:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Skip Hub configuration, but only send the USB-Attach command.
> +
> +  vendor-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 65535
> +    description:
> +      Set USB Vendor ID of the hub.
> +
> +  product-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 65535
> +    description:
> +      Set USB Product ID of the hub.
> +
> +  device-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 65535
> +    description:
> +      Set USB Device ID of the hub.
> +
> +  language-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 65535
> +    description:
> +      Set USB Language ID.
> +
> +  manufacturer:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Set USB Manufacturer string (max. a total of 93 characters for
> +      manufacturer, product and serial).
> +
> +  product:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Set USB Product string (max. a total of 93 characters for
> +      manufacturer, product and serial).
> +
> +  serial:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Set USB Serial string (max. a total of 93 characters for
> +      manufacturer, product and serial).
> +
> +  bus-powered:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Selects bus powered operation.
> +
> +  self-powered:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Selects self powered operation (default).
> +
> +  disable-hi-speed:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Disable USB Hi-Speed support.
> +
> +  multi-tt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Selects multi-transaction-translator (default).
> +
> +  single-tt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Selects single-transaction-translator.
> +
> +  disable-eop:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Disable End of Packet generation in full-speed mode.
> +
> +  ganged-sensing:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Select ganged over-current sense type in self-powered mode.
> +
> +  individual-sensing:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Select individual over-current sense type in self-powered mode (default).
> +
> +  ganged-port-switching:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Select ganged port power switching mode.
> +
> +  individual-port-switching:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Select individual port power switching mode (default).
> +
> +  dynamic-power-switching:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable auto-switching from self- to bus-powered operation if the local
> +      power source is removed or unavailable.
> +
> +  oc-delay-us:
> +    enum:
> +      - 100
> +      - 4000
> +      - 8000
> +      - 16000
> +    default: 8000
> +    description:
> +      Delay time (in microseconds) for filtering the over-current sense inputs.
> +      If an invalid value is given, the default is used instead.
> +
> +  compound-device:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Indicate the hub is part of a compound device.
> +
> +  port-mapping-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable port mapping mode.
> +
> +  non-removable-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Should specify the ports which have a non-removable device connected.
> +
> +  sp-disabled-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the ports which will be self-power disabled.
> +
> +  bp-disabled-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the ports which will be bus-power disabled.
> +
> +  power-on-time-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 100
> +    minimum: 0
> +    maximum: 510
> +    description:
> +      Specifies the time (in milliseconds) it takes from the time the host
> +      initiates the power-on sequence to a port until the port has adequate
> +      power.
> +
> +  hub-controller-port:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Hub port where the internal hub controller shall be connected. Usually
> +      <number of ports>+1.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      usb2534i@2d {
> +        compatible = "microchip,usb2534i";
> +        reg = <0x2d>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_usb_hub>;
> +        /* usb253x.c already assumes low-active, don't negate twice */
> +        reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +        /*skip-config;*/
> +        /* T_ON,max = 4 ms for NCP380 */
> +        power-on-time-ms = <4>;
> +        manufacturer = "Foo";
> +        product = "Foo-Bar";
> +        /* port 2 is connected to an internal SD-Card reader */
> +        non-removable-ports = <2>;
> +        /* hub controller mapped to logical port 5 */
> +        hub-controller-port = <5>;
> +      };
> +    };
> +
> +...
> -- 
> Christian Eggers
> Embedded software developer
> 
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
> Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
> Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler
> 
