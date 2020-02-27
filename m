Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F355C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D57246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582841112;
	bh=0ihjnXhr5rAzfNmh4KEWjS21hSY9s9S2m9nhLlMYXeU=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=ZdSr5Nwi87XgG6lQdy5iEGB4ft5hspdCIqZPVrnwMjVwA2Wiq71LyO5lHj+MVcIt4
	 Y78xTqzo/4XEJOOAeQ/13ED2SQ9WIrkEbJfsHH/4oyLlYAdqqLUM7dB3kkz7FpTKA0
	 zbZLYN+dD1VjKKicuRXZ2X2zxSJuA914W+wkfhF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgB0WFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:05:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46516 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgB0WFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:05:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id g96so672730otb.13;
        Thu, 27 Feb 2020 14:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LDNhNs7r6soPU3FC796GU50umB+K7uQ7Dt/MTOuohM=;
        b=cDmp48yucSO/eKm3wLSXPyHpa9hv7ZCs0xp76Oc4wm8d6MnTbi/yyr+l4NNVXDRTjN
         4OtZ1x0lMPSBgebTlc6BVCodDQowAXGPzoQoECzUQqee40omoNWy/dYe+64gz1xekH9c
         j5eOsX+IjfDjRfYLDJbS+OKzceiVTw98s3zZdLKOfQjdv+T3f1qT7qOADBvR+nuyfRqU
         qngUCaQzudvSXsxxB8bmZxjwPmpmQh+TxZ+YjxfqSdGLQHN10/cYuEvyXsFu/tX8H8rL
         uihlnxRAdJzIv7xwIStNQKXal8yXJ5I9DYahBzN3GbK4DRwKdzysfelox8t0IEqWt2HI
         DOgQ==
X-Gm-Message-State: APjAAAXCzig/Rkx6e3DseIkKMUJnsO8xnF55UES/iJACTQbTjCJfXe9d
        WnwJI72IsfOxcBmGl9c+ig==
X-Google-Smtp-Source: APXvYqz483UTkmhXETzVPut22diHPjpIUjyvi6kkf0SgJXjG53JFOHWMPBWFSUslFGRMSY5ZATtrVQ==
X-Received: by 2002:a9d:6e02:: with SMTP id e2mr876041otr.194.1582841109953;
        Thu, 27 Feb 2020 14:05:09 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x17sm1291122oia.0.2020.02.27.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:05:09 -0800 (PST)
Received: (nullmailer pid 1161 invoked by uid 1000);
        Thu, 27 Feb 2020 22:05:08 -0000
Date:   Thu, 27 Feb 2020 16:05:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 06/13] dt-bindings: sata: Convert Calxeda SATA
 controller to json-schema
Message-ID: <20200227220508.GE26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-7-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:22:03PM +0000, Andre Przywara wrote:
> Convert the Calxeda Highbank SATA controller binding to DT schema format
> using json-schema.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  .../devicetree/bindings/ata/sata_highbank.txt | 44 ---------
>  .../bindings/ata/sata_highbank.yaml           | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.txt b/Documentation/devicetree/bindings/ata/sata_highbank.txt
> deleted file mode 100644
> index aa83407cb7a4..000000000000
> --- a/Documentation/devicetree/bindings/ata/sata_highbank.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -* Calxeda AHCI SATA Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -The Calxeda SATA controller mostly conforms to the AHCI interface
> -with some special extensions to add functionality.
> -Each SATA controller should have its own node.
> -
> -Required properties:
> -- compatible        : compatible list, contains "calxeda,hb-ahci"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- reg               : <registers mapping>
> -
> -Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> -- calxeda,port-phys : phandle-combophy and lane assignment, which maps each
> -			SATA port to a combophy and a lane within that
> -			combophy
> -- calxeda,sgpio-gpio: phandle-gpio bank, bit offset, and default on or off,
> -			which indicates that the driver supports SGPIO
> -			indicator lights using the indicated GPIOs
> -- calxeda,led-order : a u32 array that map port numbers to offsets within the
> -			SGPIO bitstream.
> -- calxeda,tx-atten  : a u32 array that contains TX attenuation override
> -			codes, one per port. The upper 3 bytes are always
> -			0 and thus ignored.
> -- calxeda,pre-clocks : a u32 that indicates the number of additional clock
> -			cycles to transmit before sending an SGPIO pattern
> -- calxeda,post-clocks: a u32 that indicates the number of additional clock
> -			cycles to transmit after sending an SGPIO pattern
> -
> -Example:
> -        sata@ffe08000 {
> -		compatible = "calxeda,hb-ahci";
> -		reg = <0xffe08000 0x1000>;
> -		interrupts = <115>;
> -		dma-coherent;
> -		calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
> -					&combophy0 2 &combophy0 3>;
> -		calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
> -		calxeda,led-order = <4 0 1 2 3>;
> -		calxeda,tx-atten = <0xff 22 0xff 0xff 23>;
> -		calxeda,pre-clocks = <10>;
> -		calxeda,post-clocks = <0>;
> -        };
> diff --git a/Documentation/devicetree/bindings/ata/sata_highbank.yaml b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> new file mode 100644
> index 000000000000..6dcf91e1bac0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata_highbank.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/sata_highbank.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Calxeda AHCI SATA Controller
> +
> +description: |
> +  The Calxeda SATA controller mostly conforms to the AHCI interface
> +  with some special extensions to add functionality, to map GPIOs for
> +  activity LEDs and for mapping the ComboPHYs.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  compatible:
> +    const: calxeda,hb-ahci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  calxeda,pre-clocks:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Indicates the number of additional clock cycles to transmit before
> +      sending an SGPIO pattern.
> +
> +  calxeda,post-clocks:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Indicates the number of additional clock cycles to transmit after
> +      sending an SGPIO pattern.
> +
> +  calxeda,led-order:
> +    description: Maps port numbers to offsets within the SGPIO bitstream.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 8
> +
> +  calxeda,port-phys:
> +    description: |
> +      phandle-combophy and lane assignment, which maps each SATA port to a
> +      combophy and a lane within that combophy
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - minItems: 1
> +        maxItems: 8
> +
> +  calxeda,tx-atten:
> +    description: |
> +      Contains TX attenuation override codes, one per port.
> +      The upper 24 bits of each entry are always 0 and thus ignored.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 8
> +
> +  calxeda,sgpio-gpio:
> +    description: |
> +      phandle-gpio bank, bit offset, and default on or off, which indicates
> +      that the driver supports SGPIO indicator lights using the indicated
> +      GPIOs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata@ffe08000 {
> +        compatible = "calxeda,hb-ahci";
> +        reg = <0xffe08000 0x1000>;
> +        interrupts = <115>;
> +        dma-coherent;
> +        calxeda,port-phys = <&combophy5 0 &combophy0 0 &combophy0 1
> +                             &combophy0 2 &combophy0 3>;
> +        calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;

Need to fix the bracketing here too.

BTW, no system ever shipped with SGPIO support, so all this could just 
be removed.

Rob
