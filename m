Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7648C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3FB21D95
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594696274;
	bh=N9A1CacG6wk1Bx82ulEMuV9ByOt9GMoggxmLNOI2pBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yylZggc0wwj+d+syQGWwL+m6aJ5TYKjEY/72S2+z8dkgkCAKK7NIi/0CQu1hKJjeI
	 MlppC+3dYH2LeC5DwS+R1j3Xj44wCOioh/CuHeEaUPP7aYrBKXh8i2PijD1MR9cYHS
	 BkIXuSMM9qNdIaTGoaBqgiynMD53PruQf2RG3qfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGNDLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:11:13 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37017 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:11:12 -0400
Received: by mail-il1-f193.google.com with SMTP id r12so13062230ilh.4;
        Mon, 13 Jul 2020 20:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB7EpZVGsgQ3decojJROTauPM9vJOZw3HOAwwkB7+aE=;
        b=AqFIcG+zWzjSM33RTowTxVnyV5RT2SpRxJ5r0T/wJ+uhISVuGnHthDIRawoRM9lsaU
         1OhLTvnfNStAGOL5flwQzkUsV3uhADNOF9CuSlNXoPm1PNavroYQn6aqmxWt+W/VMmhW
         sls8zzctK1idNJD5NhfQkEzhgPk3bJwgjkzWBe0CvcQCgpF2T1txbm5a0cFxafcRNnx5
         94TQgTy7a+oRY7uTkBLKzdGudTMcolXuz2tDd35m0+bAnKhhkGBLlgqKxsB4EYjfcHOq
         6yKA512lSmAjgcN8sk1EOrPn/rLrcA4YZCPuu14XO50JB5vd/i/3Wd2Ku3bcLOKnQPi9
         snuw==
X-Gm-Message-State: AOAM532ofR0zU1T8pJt6MJhX46iAPsbQh1p5DoLTFEDFMvLB7cnQhHIq
        ds821vypItxYHYfX2rXbDSJD0vLtnq6x
X-Google-Smtp-Source: ABdhPJxmPqX3ZolvpemY9HPtU4SvLgi9Hy8GgegBE8lJnxqZ3mXcnTGKCyO7PGG3w8xTpLzNPBSG3Q==
X-Received: by 2002:a92:c213:: with SMTP id j19mr3001215ilo.40.1594696271187;
        Mon, 13 Jul 2020 20:11:11 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a11sm4547579iow.26.2020.07.13.20.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 20:11:10 -0700 (PDT)
Received: (nullmailer pid 1216966 invoked by uid 1000);
        Tue, 14 Jul 2020 03:11:09 -0000
Date:   Mon, 13 Jul 2020 21:11:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: clk: versaclock5: convert to yaml
Message-ID: <20200714031109.GA1210492@bogus>
References: <20200708074035.31595-1-luca@lucaceresoli.net>
 <20200708074035.31595-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708074035.31595-4-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 09:40:35AM +0200, Luca Ceresoli wrote:
> Convert to yaml the VersaClock bindings document. The mapping between
> clock specifier and physical pins cannot be described formally in yaml
> schema, then keep it verbatim in the description field.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../bindings/clock/idt,versaclock5.txt        | 125 --------------
>  .../bindings/clock/idt,versaclock5.yaml       | 160 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 161 insertions(+), 125 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> deleted file mode 100644
> index 9656d4cf221c..000000000000
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -Binding for IDT VersaClock 5,6 programmable i2c clock generators.
> -
> -The IDT VersaClock 5 and VersaClock 6 are programmable i2c clock
> -generators providing from 3 to 12 output clocks.
> -
> -==I2C device node==
> -
> -Required properties:
> -- compatible:	shall be one of
> -		"idt,5p49v5923"
> -		"idt,5p49v5925"
> -		"idt,5p49v5933"
> -		"idt,5p49v5935"
> -		"idt,5p49v6901"
> -		"idt,5p49v6965"
> -- reg:		i2c device address, shall be 0x68 or 0x6a.
> -- #clock-cells:	from common clock binding; shall be set to 1.
> -- clocks:	from common clock binding; list of parent clock handles,
> -		- 5p49v5923 and
> -		  5p49v5925 and
> -		  5p49v6901: (required) either or both of XTAL or CLKIN
> -					reference clock.
> -		- 5p49v5933 and
> -		- 5p49v5935: (optional) property not present (internal
> -					Xtal used) or CLKIN reference
> -					clock.
> -- clock-names:	from common clock binding; clock input names, can be
> -		- 5p49v5923 and
> -		  5p49v5925 and
> -		  5p49v6901: (required) either or both of "xin", "clkin".
> -		- 5p49v5933 and
> -		- 5p49v5935: (optional) property not present or "clkin".
> -
> -For all output ports, a corresponding, optional child node named OUT1,
> -OUT2, etc. can represent a each output, and the node can be used to
> -specify the following:
> -
> -- idt,mode: can be one of the following:
> -                 - VC5_LVPECL
> -                 - VC5_CMOS
> -                 - VC5_HCSL33
> -                 - VC5_LVDS
> -                 - VC5_CMOS2
> -                 - VC5_CMOSD
> -                 - VC5_HCSL25
> -
> -- idt,voltage-microvolts:  can be one of the following
> -                 - 1800000
> -                 - 2500000
> -                 - 3300000
> --  idt,slew-percent: Percent of normal, can be one of
> -                 - 80
> -                 - 85
> -                 - 90
> -                 - 100
> -
> -==Mapping between clock specifier and physical pins==
> -
> -When referencing the provided clock in the DT using phandle and
> -clock specifier, the following mapping applies:
> -
> -5P49V5923:
> -	0 -- OUT0_SEL_I2CB
> -	1 -- OUT1
> -	2 -- OUT2
> -
> -5P49V5933:
> -	0 -- OUT0_SEL_I2CB
> -	1 -- OUT1
> -	2 -- OUT4
> -
> -5P49V5925 and
> -5P49V5935:
> -	0 -- OUT0_SEL_I2CB
> -	1 -- OUT1
> -	2 -- OUT2
> -	3 -- OUT3
> -	4 -- OUT4
> -
> -5P49V6901:
> -	0 -- OUT0_SEL_I2CB
> -	1 -- OUT1
> -	2 -- OUT2
> -	3 -- OUT3
> -	4 -- OUT4
> -
> -==Example==
> -
> -/* 25MHz reference crystal */
> -ref25: ref25m {
> -	compatible = "fixed-clock";
> -	#clock-cells = <0>;
> -	clock-frequency = <25000000>;
> -};
> -
> -i2c-master-node {
> -
> -	/* IDT 5P49V5923 i2c clock generator */
> -	vc5: clock-generator@6a {
> -		compatible = "idt,5p49v5923";
> -		reg = <0x6a>;
> -		#clock-cells = <1>;
> -
> -		/* Connect XIN input to 25MHz reference */
> -		clocks = <&ref25m>;
> -		clock-names = "xin";
> -
> -		OUT1 {
> -			idt,mode = <VC5_CMOS>;
> -			idt,voltage-microvolts = <1800000>;
> -			idt,slew-percent = <80>;
> -		};
> -		OUT2 {
> -			...
> -		};
> -		...
> -	};
> -};
> -
> -/* Consumer referencing the 5P49V5923 pin OUT1 */
> -consumer {
> -	...
> -	clocks = <&vc5 1>;
> -	...
> -}
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> new file mode 100644
> index 000000000000..4bdfd6187b48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/idt,versaclock5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for IDT VersaClock 5 and 6 programmable I2C clock generators
> +
> +description: |
> +  The IDT VersaClock 5 and VersaClock 6 are programmable I2C
> +  clock generators providing from 3 to 12 output clocks.
> +
> +  When referencing the provided clock in the DT using phandle and clock
> +  specifier, the following mapping applies:
> +
> +  - 5P49V5923:
> +    0 -- OUT0_SEL_I2CB
> +    1 -- OUT1
> +    2 -- OUT2
> +
> +  - 5P49V5933:
> +    0 -- OUT0_SEL_I2CB
> +    1 -- OUT1
> +    2 -- OUT4
> +
> +  - other parts:
> +    0 -- OUT0_SEL_I2CB
> +    1 -- OUT1
> +    2 -- OUT2
> +    3 -- OUT3
> +    4 -- OUT4
> +
> +maintainers:
> +  - Luca Ceresoli <luca@lucaceresoli.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - idt,5p49v5923
> +      - idt,5p49v5925
> +      - idt,5p49v5933
> +      - idt,5p49v5935
> +      - idt,5p49v6901
> +      - idt,5p49v6965
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C device address, shall be 0x68 or 0x6a.

Can be a schema:

enum: [ 0x68, 0x6a ]

> +
> +  '#clock-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^OUT[1-4]$":
> +    type: object
> +    description:
> +      Description of one of the outputs (OUT1..OUT4). See "Clock1 Output
> +      Configuration" in the Versaclock 5/6/6E Family Register Description
> +      and Programming Guide.
> +    properties:
> +      idt,mode:
> +        description:
> +          The output drive mode. Values defined in dt-bindings/clk/versaclock.h
> +        enum:
> +          - VC5_LVPECL

This is defining a string. Can't use defines here.

> +          - VC5_CMOS
> +          - VC5_HCSL33
> +          - VC5_LVDS
> +          - VC5_CMOS2
> +          - VC5_CMOSD
> +          - VC5_HCSL25
> +      idt,voltage-microvolts:
> +        description: The output drive voltage.
> +        $ref: /schemas/types.yaml#/definitions/uint32

Standard unit suffixes have a type already, so drop.

> +        enum: [ 1800000, 2500000, 3300000 ]
> +      idt,slew-percent:
> +        description: The Slew rate control for CMOS single-ended.
> +        $ref: /schemas/types.yaml#/definitions/uint32

Here too.

> +        enum: [ 80, 85, 90, 100 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - idt,5p49v5933
> +              - idt,5p49v5935
> +    then:
> +      # Devices with builtin crystal, optional external input
> +      properties:
> +        clock-names:
> +          const: clkin
> +        clocks:
> +          maxItems: 1
> +    else:
> +      # Devices without builtin crystal
> +      properties:
> +        clock-names:
> +          anyOf:
> +            - required: [ xin ]
> +            - required: [ clkin ]

This isn't valid. I think you want:

clock-names:
  minItems: 1
  items:
    - const: xin
    - const: clkin

This would mean 'xin' is always required, clkin is optional.

> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +      required:
> +        - clock-names
> +        - clocks
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clk/versaclock.h>
> +
> +    /* 25MHz reference crystal */
> +    ref25: ref25m {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <25000000>;
> +    };
> +
> +    i2c@0 {
> +        reg = <0x0 0x100>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* IDT 5P49V5923 I2C clock generator */
> +        vc5: clock-generator@6a {
> +            compatible = "idt,5p49v5923";
> +            reg = <0x6a>;
> +            #clock-cells = <1>;
> +
> +            /* Connect XIN input to 25MHz reference */
> +            clocks = <&ref25m>;
> +            clock-names = "xin";
> +
> +            OUT1 {
> +                idt,drive-mode = <VC5_CMOSD>;
> +                idt,voltage-microvolts = <1800000>;
> +                idt,slew-percent = <80>;
> +            };
> +
> +            OUT4 {
> +                idt,drive-mode = <VC5_LVDS>;
> +            };
> +        };
> +    };
> +
> +    /* Consumer referencing the 5P49V5923 pin OUT1 */
> +    consumer {
> +        /* ... */
> +        clocks = <&vc5 1>;
> +        /* ... */
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5aa16c245c63..09d6efd1d0d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8326,6 +8326,7 @@ F:	drivers/input/misc/ideapad_slidebar.c
>  IDT VersaClock 5 CLOCK DRIVER
>  M:	Luca Ceresoli <luca@lucaceresoli.net>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>  F:	drivers/clk/clk-versaclock5.c
>  
>  IEEE 802.15.4 SUBSYSTEM
> -- 
> 2.27.0
> 
