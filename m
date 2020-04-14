Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C9C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4063C20578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586872300;
	bh=xygoIyX9KgqcvJoRci1V8WnxjdzucOJRHJgc686jKvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tFfFEQxYJfGG6x+woXmIDkNCJjyIYVJ+5awdt9DrM+xzAgEuGO6MXv7nlTRQu+41t
	 W8rnfEmJbGc6Uwsj6Y5CgpNQ4KnHoKlxsKvjCHb7sEvqnUaeK42iYzQbmDybGFoHTc
	 QwL5mSgyhDmzhARfNsVKRYpikN9mmbzPFI0XK/yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbgDNNvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:51:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36442 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732954AbgDNNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:50:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id b13so8570464oti.3;
        Tue, 14 Apr 2020 06:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C310fwJjsqMN77N1UzYbOt1HSD0OyElfoVqL7lO5IlA=;
        b=Yvyv4BYpQi/LGR/LkjEmJ9ysChvfpNwwAMuigCl4gIbbo2nUCzTCWcVj2Mr8YsdioA
         wUoKo/ApISLab1N0VOg3m07bv9ovuiGxUZkRz4Vd38/IJB1YWhIHVmXpJgU1oldOOuxI
         FN0h+reOoN7/B+FRsTv9/6y9coOSoaRjf21ICmRfWIlp0IHNC5lVund09Tv3QilfflWX
         t5tiEsGqAm5Ut+Dj0SYQkHGH4OTpKJLTdwK5MHwhMIJjqp74Xr2r3vc3R4c/gPb4nLmH
         0tbCNqy8nFUqQB2lWhrQywPiDjG/RMosBVfPVb2NOp+H8OkNEkQCzl8Hj/Wi7ZJVm55S
         IJtA==
X-Gm-Message-State: AGi0PubHxS+4emTAoKA6RtQJQJKXrnZfEXuNSZGuQwI7QE5HEHYZpYkw
        V0tK3NUNn8LTtQRd3dgWZQ==
X-Google-Smtp-Source: APiQypIhHs1TriKn/WY0g92zfK/p1ITDYwn7KHy/jB5xYjLLeSpqejcriNR0GRo2qQH25dAfzFd9sQ==
X-Received: by 2002:a9d:64cd:: with SMTP id n13mr18490222otl.274.1586872250194;
        Tue, 14 Apr 2020 06:50:50 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 85sm618190oie.17.2020.04.14.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:50:48 -0700 (PDT)
Received: (nullmailer pid 19040 invoked by uid 1000);
        Tue, 14 Apr 2020 13:50:47 -0000
Date:   Tue, 14 Apr 2020 08:50:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add Broadcom STB USB support
Message-ID: <20200414135047.GA8093@bogus>
References: <20200408181406.40389-1-alcooperx@gmail.com>
 <20200408181406.40389-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408181406.40389-2-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:14:03PM -0400, Al Cooper wrote:
> Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
> 
> NOTE: The OHCI driver is not included because it uses the generic
>       platform driver.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/usb/brcm,bcm7445-ehci.yaml       | 60 +++++++++++++++++++
>  .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> new file mode 100644
> index 000000000000..d41710574b5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/brcm,bcm7445-ehci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom STB USB EHCI Controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "usb-hcd.yaml"
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: brcm,bcm7445-ehci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Clock specifier for the EHCI clock
> +
> +  clock-names:
> +    const: sw_usb
> +
> +  phys:
> +    description: PHY specifier for the USB PHY

maxItems: 1

And you can drop the description.

> +
> +  phy-names:
> +    const: usbphy
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - phys
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb@f0b00300 {
> +        compatible = "brcm,bcm7445-ehci";
> +        reg = <0xf0b00300 0xa8>;
> +        interrupts = <0x0 0x5a 0x0>;
> +        phys = <&usbphy_0 0x0>;
> +        phy-names = "usbphy";
> +        clocks = <&usb20>;
> +        clock-names = "sw_usb";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index 3f378951d624..aafc316b5a8e 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -23,6 +23,7 @@ Required properties:
>        device
>      - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 or RZ/G2 compatible
>        device
> +    - "brcm,bcm7445-xhci" for Broadcom STB SoCs with XHCI
>      - "xhci-platform" (deprecated)
>  
>      When compatible with the generic version, nodes must list the
> -- 
> 2.17.1
> 
