Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB18C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206C42074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598311848;
	bh=eKVglIVvchIxaIR2thCq+IK38yUeSOGWNy5bCLCtXhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eKxCedYayvNgzyMDrHWTrZiDOdzlPqYO/gBhQxo3jXsoQ83VKQn3L8wJjoIJb+FUg
	 r9rnx2deaOUC9TAmQeEgIcrmyZJMPFOHYd13Ojm7QT4ACwYs364mOLirVuxrvpfXyN
	 AAbZSszqKI8GpuywmUkDwp/uG6C0QXY1j9UGP+ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHXXaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:30:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37505 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:30:44 -0400
Received: by mail-io1-f65.google.com with SMTP id b16so10602652ioj.4;
        Mon, 24 Aug 2020 16:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ul5vsSQ0AC/DUuwVVIoms1HCf2oN0/YEUiAq/yjQxDE=;
        b=Ut3WcQ6bLanuewPTChONgcnarmYPcrWFQP43IfNlEjUvJpsfc0azDgv9f9EDXSc3ag
         r+1+/haRwW9Y6MzVH8hsikzWLKffHJRsYR0hM+VNf1mzrQmjvDl+LSFmE62/tMD80IMW
         F1BWdZNBZf0p0/kGol1jO3u4M2F0Qgtti+GRhX97Kemg3vTPJNEDIRsKz08TyJrexCkl
         THswXd+o9gG0ck8pOU+8cwnVncY7ScXp6SybutvdywoqfqemoaN7QzowY6nviSC45SkG
         s8JIFHv1WK9a3fYUhB1V4IEMTR6wOL9k6YOVrhOmTXueK2Fya+39j1FA0PJ7RHOp/Whe
         JsNQ==
X-Gm-Message-State: AOAM530B0mH/aSiw+ipZBi5gQNsiyMhbn/+sbN2uSzsNOAcfKFlyW8Ds
        kveTchRVgwJ01dGUOuu22Q==
X-Google-Smtp-Source: ABdhPJz+NQ1qdajPag/8+NvwhC0VZ3vzxnBW9ciupDP5U8wTD1qPKcV07ZiSre5zNxPrU8kgre3VRQ==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr6755255iog.124.1598311843191;
        Mon, 24 Aug 2020 16:30:43 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id e6sm7517181iod.53.2020.08.24.16.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:30:42 -0700 (PDT)
Received: (nullmailer pid 3540232 invoked by uid 1000);
        Mon, 24 Aug 2020 23:30:40 -0000
Date:   Mon, 24 Aug 2020 17:30:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map
 driver
Message-ID: <20200824233040.GA3532378@bogus>
References: <20200812202018.49046-1-alcooperx@gmail.com>
 <20200812202018.49046-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812202018.49046-2-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 04:20:16PM -0400, Al Cooper wrote:
> Add DT bindings for the Broadcom USB pin map driver. This driver allows
> some USB input and output signals to be mapped to any GPIO instead
> of the normal dedicated pins to/from the XHCI controller.

Is this a driver or h/w block because bindings are for h/w blocks?

> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/usb/brcm,usb-pinmap.yaml         | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> new file mode 100644
> index 000000000000..19cf6ad36373
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/brcm,usb-pinmap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom USB pin map Controller Device Tree Bindings
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +
> +properties:
> +  compatible:
> +      items:
> +          - const: brcm,usb-pinmap

2 space indentation please.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Must be defined if any out-gpios are specified.

'dependencies' can express this in schema.

> +
> +  in-gpios:
> +    description: Array of one or more GPIO pins used for input signals.

You need to define how many GPIOs are valid.

> +
> +  in-names:
> +    description: Array of input signal names, one per gpio in in-gpios.

No, this isn't how we name GPIOs. The part before '-gpios' is how.

> +
> +  in-masks:
> +    description: Array of enable and mask pairs, one per gpio in-gpios.

Needs a vendor prefix.

> +
> +  out-gpios:
> +    description: Array of one or more GPIO pins used for output signals.
> +
> +  out-names:
> +    description: Array of output signal names, one per gpio in out-gpios.
> +
> +  out-masks:
> +    description: Array of enable, value, changed and clear masks, one
> +      per gpio in out-gpios.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb_pinmap: usb-pinmap@22000d0 {
> +        compatible = "brcm,usb-pinmap";
> +        reg = <0x22000d0 0x4>;
> +        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
> +        in-names = "VBUS", "PWRFLT";
> +        in-masks = <0x8000 0x40000 0x10000 0x80000>;
> +        out-gpios = <&gpio 20 0>;
> +        out-names = "PWRON";
> +        out-masks = <0x20000 0x800000 0x400000 0x200000>;
> +        interrupts = <0x0 0xb2 0x4>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
