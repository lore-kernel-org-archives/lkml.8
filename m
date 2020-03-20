Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E686F20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584665728;
	bh=uhyOu1JeH5EJCRr0OxBe+uXGzIhZTNmys/6HAOcvk+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uqkg2eZE917Ws5V6LuWxpkF5GIASavjwwiBGLWpLIaDl/dY6Vf/6zZRE8X3TfmmyQ
	 MLmLoDeQ4dfjfsu2wYHFLpFJ2tbH/ti736cZ8cqXnmj+8S7hmjFHOEFGyYiEBpa++2
	 pgaMx/xJuiw3FIWSYC7hQ2D1yjTzUnv9dSkZ9mbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCTAz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:55:27 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45714 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCTAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:55:26 -0400
Received: by mail-il1-f193.google.com with SMTP id m9so4075989ilq.12;
        Thu, 19 Mar 2020 17:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hTX9N2of5jhjNnF3uYbcSwV8OolqfVP3rpImPzcroQ8=;
        b=t5rxHvgGpyHHoDAxZHK3lumLNYDat/W5zDZJ6NsMHDZQlD8cj0c0t6yVG5jRZ+pmYS
         RzrUfWZjltl9VH+tASz1iO1U4arVgz3qbXmnMvndvujKhJYtsdQEnraDSerBRYCC/5yd
         yj7Je+ApAR99UoFjN/sPLeG14yh71ztPCtQ6AE4Oj5mu+8CSxpJtrJTXVtiGxk9G+zwl
         DKa46t/SbSGumzyzaXvcZT4L21/HPLzgRFvreGvq6gyLIp6Szvh0Yl2zNFdsNDL4bNGO
         qg0tCwqxQBJWFv3aIGfUQQw1iCZ/Q6kULLmQsL4q49dj7yNDuXcSgIKi4rHsWpEYDthI
         sX2g==
X-Gm-Message-State: ANhLgQ3N8fwmc2YHbDhAQQqtnmYb9kPfssBFTaO545UmNSMBbWqHEFGr
        eutD5dY8uY2aWR46XSfGAA==
X-Google-Smtp-Source: ADFU+vvqztuZ1j2SOs3GaEwUpbB7sr5FIKsud65mVDnuJzJr2tFN1mpQMD0yWc3GzSp4Oy4AZSyONw==
X-Received: by 2002:a92:d0c1:: with SMTP id y1mr5794271ila.125.1584665725641;
        Thu, 19 Mar 2020 17:55:25 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w5sm1456074ilm.69.2020.03.19.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:55:24 -0700 (PDT)
Received: (nullmailer pid 8024 invoked by uid 1000);
        Fri, 20 Mar 2020 00:55:22 -0000
Date:   Thu, 19 Mar 2020 18:55:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: Add binding for IT6505.
Message-ID: <20200320005522.GA31982@bogus>
References: <1583735298-19266-1-git-send-email-allen.chen@ite.com.tw>
 <1583735298-19266-3-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583735298-19266-3-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:26:48PM +0800, allen wrote:
> Add a DT binding documentation for IT6505.
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml        | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> new file mode 100644
> index 00000000..e9f6b58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE it6505 Device Tree Bindings
> +
> +maintainers:
> +  - Allen Chen <allen.chen@ite.com.tw>
> +
> +description: |
> +  The IT6505 is a high-performance DisplayPort 1.1a transmitter,
> +  fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications.
> +  The IT6505 supports color depth of up to 36 bits (12 bits/color)
> +  and ensures robust transmission of high-quality uncompressed video
> +  content, along with uncompressed and compressed digital audio content.
> +
> +  Aside from the various video output formats supported, the IT6505
> +  also encodes and transmits up to 8 channels of I2S digital audio,
> +  with sampling rate up to 192kHz and sample size up to 24 bits.
> +  In addition, an S/PDIF input port takes in compressed audio of up to
> +  192kHz frame rate.
> +
> +  Each IT6505 chip comes preprogrammed with an unique HDCP key,
> +  in compliance with the HDCP 1.3 standard so as to provide secure
> +  transmission of high-definition content. Users of the IT6505 need not
> +  purchase any HDCP keys or ROMs.
> +
> +properties:
> +  compatible:
> +    const: ite,it6505
> +
> +  reg:
> +    maxItems: 1
> +    description: i2c address of the bridge

Can drop the description as there's nothing specific to this device.

> +
> +  ovdd-supply:
> +    maxItems: 1
> +    description: I/O voltage
> +
> +  pwr18-supply:
> +    maxItems: 1
> +    description: core voltage
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt specifier of INT pin
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: gpio specifier of RESET pin
> +
> +  extcon:
> +    maxItems: 1
> +    description: extcon specifier for the Power Delivery

Drop this. You should be using the usb-connector binding instead which 
means you should have a OF graph port to the connector. For TypeC, 
there's a defined port for DP.

> +
> +  port:
> +    type: object
> +    description: A port node pointing to DPI host port node
> +
> +required:
> +  - compatible
> +  - reg
> +  - ovdd-supply
> +  - pwr18-supply
> +  - interrupts
> +  - reset-gpios
> +  - extcon
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c3 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dp-bridge@5c {
> +            compatible = "ite,it6505";
> +            interrupts = <152 IRQ_TYPE_EDGE_FALLING 152 0>;
> +            reg = <0x5c>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&it6505_pins>;
> +            ovdd-supply = <&mt6358_vsim1_reg>;
> +            pwr18-supply = <&it6505_pp18_reg>;
> +            reset-gpios = <&pio 179 1>;
> +            extcon = <&usbc_extcon>;
> +
> +            port {
> +                it6505_in: endpoint {
> +                    remote-endpoint = <&dpi_out>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 1.9.1
> 
