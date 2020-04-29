Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4FDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B973E206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588194786;
	bh=s9TT0lMxNNaV9BNhB/68BjoWi5w0tNu+nqeW3fIn3c0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EErhvi3JtWkMxGcrjwEBnIZrCkmdq3IX5FRRox7gES7YNaZSohBRgn7TLcthY0P/q
	 tbeZLq/e0DWrenjaQ3mtvFAsGUS+MZ9elgtH5HHKjrvDs0HJPNoHa4avGL9fdr6c4K
	 Ga5B1m4XdwVUtK1cxUuLj7EmxBJ84+4rMhniexDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2VNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:13:06 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:39275 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2VNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:13:05 -0400
Received: by mail-oo1-f67.google.com with SMTP id c83so770032oob.6;
        Wed, 29 Apr 2020 14:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wram8/kvGtBAPhudD3mqn9Lg4Z/ZgDC7ak83b1h5db8=;
        b=FpCbEo3CH4WjBqpa1CKbLXD5++Sh6aAw+lwIq2wQOyJMzu0PQeN4Xo2oPVijTW9XRo
         NmEz+2+UuDN7mfqto3nYUsvO2aRCUVqh5lCs3+crjawi+UofvUIr4FtcksgDjkXmk/Ab
         vpT6EO/kfGae7pGP9QhcAbUtNK/YSXlZ9KkmmWwnKu8FSbhyaS5F7zhAq1BS2Z+KKK/x
         9ZNPbFg3YS/vNGM4/1Qs68oYyT3Awwn9DFmbZAKs3+MYLtKXYD+Fvd0AgpJAKcKggIUo
         4s5FQgbR9QIhaOHhI1lenS4noMYQlpZRwceLR2/JtqQgfaWUlne7OfN8tddsaFsgReQh
         6RDg==
X-Gm-Message-State: AGi0PuYsNdIsCQYJU1R+0f3NtVYhbQzTPXFBr9u4ZLtJB6J+4hvqglqo
        m95KuOG/8Ci7AfJsAB6b1A==
X-Google-Smtp-Source: APiQypLPtKMDPynnB2XXcurJjkj+Cn6H8/fxekGEw0MPH9dURNDuAQSyJXCcqt/ccUdZs51T2QL4tA==
X-Received: by 2002:a4a:accf:: with SMTP id c15mr8418oon.29.1588194784387;
        Wed, 29 Apr 2020 14:13:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s10sm648162otd.69.2020.04.29.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:13:03 -0700 (PDT)
Received: (nullmailer pid 7846 invoked by uid 1000);
        Wed, 29 Apr 2020 21:13:02 -0000
Date:   Wed, 29 Apr 2020 16:13:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add Broadcom STB USB support
Message-ID: <20200429211302.GA4535@bogus>
References: <20200429200826.20177-1-alcooperx@gmail.com>
 <20200429200826.20177-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429200826.20177-2-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:08:23PM -0400, Al Cooper wrote:
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
> index 000000000000..7c67f7dd7a67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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

Drop contains. Other strings present are not allowed.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

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
> +    maxItems: 1
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
> index dc025f126d71..23e89d798b1b 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -24,6 +24,7 @@ Required properties:
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
