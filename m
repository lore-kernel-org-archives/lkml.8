Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58369C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F58D24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582842109;
	bh=LXgJgAigabr62zw11QachDyxGLhSRPzXrO4MxYJBWac=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=Z6z9DPTKOODdAgG4KL/IaeavFpnq+/oRbEBTsDHmjQFlD26WOiYAVdZ6xV7UNwqTs
	 UfnR6aLfLkSuff5Lw19FrBQGeY1aDh5YmOfnhxek+l9Htxw0Czj+4GxE983rdIrg5E
	 cm/xkU4oHsm+O0Hmo7JOfHS6L37uehWHcz1nE4T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgB0WVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:21:48 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42063 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbgB0WVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:21:47 -0500
Received: by mail-oi1-f194.google.com with SMTP id l12so868982oil.9;
        Thu, 27 Feb 2020 14:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=du04IHx+HutirdW4IRyHgf7LAWxcnOztVFIEX1SqbB8=;
        b=AZhUDwD07uw22lDCsg0y1t0G9jW/UNdcLwykDwF97xRkcigG03CiboGdtTTlXV7s4J
         2OWiZcnQRgkrgecFZYdeQ/2rIlw2d7EZy2Eyx9tf5U2ECTje4i1MbMLZmwlBpIxrNWfW
         FYoV9h3uThyzQuE2SgZhmzSfvh6Htd9fhMSgukOSF9ltnJxLB7EIk54prACtdH9+KNFZ
         Pa2KvxuFU5UYUbXGF+GUc2kjdVOAvxrt33HJVFs4/p82SJqBEh1f6YKq6RRp3LxW7Uzc
         9ffTYFyQ/+VYMIsELN64oZQxb2tkPI7W9k3evEIXPLBo+mW90+cfxCrCjloqfvcBaS5B
         uOyw==
X-Gm-Message-State: APjAAAUIn1/ZDHMXjR4luf5d7E4lsRWhybH2+gGUUvMAg5fRq6zjmaGM
        KhwbOBndbFJ0Hb2QfFD8on8oFKA=
X-Google-Smtp-Source: APXvYqyEkDcaG0j8dAL0P9PQF1fWf4H41MVvV6Cb5ceuV0GzrQuoqmkuHkhHkuOq7dxd45/LCQIhtw==
X-Received: by 2002:a54:4106:: with SMTP id l6mr956240oic.76.1582842106769;
        Thu, 27 Feb 2020 14:21:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm2383610otl.71.2020.02.27.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:21:46 -0800 (PST)
Received: (nullmailer pid 24260 invoked by uid 1000);
        Thu, 27 Feb 2020 22:21:45 -0000
Date:   Thu, 27 Feb 2020 16:21:45 -0600
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
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH v2 11/13] dt-bindings: ipmi: Convert IPMI-SMIC bindings
 to json-schema
Message-ID: <20200227222145.GF26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-12-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-12-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:22:08PM +0000, Andre Przywara wrote:
> Convert the generic IPMI controller bindings to DT schema format
> using json-schema.
> 
> I removed the formerly mandatory device-type property, since this
> is deprecated in the DT spec, except for the legacy CPU and memory
> nodes.

Yes, but it is still used by the ipmi driver to match on, so we should 
keep it.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> ---
>  .../devicetree/bindings/ipmi/ipmi-smic.txt    | 25 ---------
>  .../devicetree/bindings/ipmi/ipmi-smic.yaml   | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt b/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
> deleted file mode 100644
> index d5f1a877ed3e..000000000000
> --- a/Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -IPMI device
> -
> -Required properties:
> -- compatible: should be one of ipmi-kcs, ipmi-smic, or ipmi-bt
> -- device_type: should be ipmi
> -- reg: Address and length of the register set for the device
> -
> -Optional properties:
> -- interrupts: The interrupt for the device.  Without this the interface
> -	is polled.
> -- reg-size - The size of the register.  Defaults to 1
> -- reg-spacing - The number of bytes between register starts.  Defaults to 1
> -- reg-shift - The amount to shift the registers to the right to get the data
> -	into bit zero.
> -
> -Example:
> -
> -smic@fff3a000 {
> -	compatible = "ipmi-smic";
> -	device_type = "ipmi";
> -	reg = <0xfff3a000 0x1000>;
> -	interrupts = <0 24 4>;
> -	reg-size = <4>;
> -	reg-spacing = <4>;
> -};
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
> new file mode 100644
> index 000000000000..c859e0e959b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0

Anything I wrote which should be most of the series, you can relicense 
to:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/ipmi-smic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IPMI device bindings
> +
> +description: IPMI device bindings
> +
> +maintainers:
> +  - Corey Minyard <cminyard@mvista.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ipmi-kcs
> +      - ipmi-smic
> +      - ipmi-bt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Interface is polled if this property is omitted.
> +    maxItems: 1
> +
> +  reg-size:
> +    description: The access width of the register in bytes. Defaults to 1.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2, 4, 8]

Does 8 really work?

> +
> +  reg-spacing:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of bytes between register starts. Defaults to 1.
> +
> +  reg-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The amount of bits to shift the register content to the right to get
> +      the data into bit zero.

either 24 or 56 would be the max, right?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    smic@fff3a000 {
> +        compatible = "ipmi-smic";
> +        reg = <0xfff3a000 0x1000>;
> +        interrupts = <0 24 4>;
> +        reg-size = <4>;
> +        reg-spacing = <4>;
> +    };
> -- 
> 2.17.1
> 
