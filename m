Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB8F22B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596492732;
	bh=dEoKaoB1uWNxA3NS4spnKV6EdrXvCCXg5XaM8dESDug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ut6pFiiO4Kg+5Si2wP7qtIJKpbBId3bzaE0M93CgQqXtL2lif1cN4/sVr1vw/BEof
	 K4XmRluTgM20UvYleUQ9dAaftyV9QLRPV6j1ZwhnuFkT4SJcBRIEAMJVf93VmlkxK3
	 tBCzIhdMVTV/6gwRcs31B9mb6YDAWwwp19vKGGqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgHCWML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:12:11 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40086 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgHCWMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:12:10 -0400
Received: by mail-il1-f193.google.com with SMTP id x1so12173986ilp.7;
        Mon, 03 Aug 2020 15:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/G+y5a1CulurSgf3GNGJAhfTZQ4nZtYfiUH1dXA2L8=;
        b=JNUsEqcTAkD4Rl0niwz6eXTJQZFsqJbu0CePXayiXbkEjOvkKIKMEfDNU+WG/TmBft
         FEVFOE1ePNW21/TANMR0gk33SRC3grVpaxK+/qBaIl45sc0iazi3vjlg/co65YoQrwd2
         Fs6MO+5EQKuEpA0EsOzs5tHjqOKA+wQxGHE8CHy088FGeW7At0mqBsikaWiqAA20I7rq
         DUq0v3OJNwQq9LxUEwLoasHYoxg4uXYPDkSSOD68zxW6QSa7SYPwJGRTmqoGNLLAbRAv
         xGjWGfpx0H1QRqeWafFwRh2/klTXddH0gXKLBD46WkSAqIDtqzC+M03LUa8Z515mgaNN
         BzqA==
X-Gm-Message-State: AOAM533XMJfXeeHWFN5ImZuh94DTmK6OypEmVZiF8eRKDecUwWJjFG5B
        FZxszcLhcnylc0SeO1Jciw==
X-Google-Smtp-Source: ABdhPJxKs7B3ED/opXF0sv6y/TknD5KflytfUZYWoSR5a2+dQb5yClRUnwf/k+twQUpWiofuPyTBhA==
X-Received: by 2002:a92:d2c8:: with SMTP id w8mr1690728ilg.38.1596492729273;
        Mon, 03 Aug 2020 15:12:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v5sm11003966ilg.88.2020.08.03.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:12:07 -0700 (PDT)
Received: (nullmailer pid 3229293 invoked by uid 1000);
        Mon, 03 Aug 2020 22:12:06 -0000
Date:   Mon, 3 Aug 2020 16:12:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: at25: convert the binding document to yaml
Message-ID: <20200803221206.GA3211829@bogus>
References: <CAL_JsqK+Oj5AMDv5uvtQZZ6YMBzVKBPqvTfAsXEbjWvxqubQnQ@mail.gmail.com>
 <20200802174625.91809-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802174625.91809-1-ceggers@arri.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 07:46:26PM +0200, Christian Eggers wrote:
> Convert the binding document for at25 EEPROMs from txt to yaml. The
> compatible property doesn't use a regex pattern (as in at24), because
> the 'vendor' and the 'model' are an "infinite" list (even if only 5
> combinations are found in the current dts files). The settings required
> by a driver are given as separate properties.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> On Friday, Jul 31 2020, Rob Herring wrote:
> >> On Tue, Jul 28, 2020 at 1:34 AM Christian Eggers <ceggers@arri.de> wrote:
> >> When I specify
> >>
> >>   compatible:
> >>     enum:
> >>       - atmel,at25
> >>
> >> I get an error in dt_binding_check:
> >> ...
> >
> > You can do:
> >
> > items:
> >   - {}
> >   - const: atmel,at25
> >
> > But really, the possible compatible strings need to be listed out. See
> > at24.yaml as it had similar issues IIRC.
> 
> I think that at24 is very diffrent from at25 here (at least the linux
> driver). Whilst the at24 driver extracts parameters of the chip from the
> 'model' part, at25 gets this information from separate properties.
> 
> As there is virtually an infinite list of possible vendors and products
> for such type of hardware, is there any value to use expressions like in
> the at24 binding?

Maybe so, but there are only 4 compatible strings to document in the 
tree. That's not a lot to cover and we already have some of them in 
free-form text. If the infinite number becomes a problem we can always 
address that later. I'm sure that less than infinite buyers/products 
will prevent infinite producers.

So it is much less a mess compared to at24.

> 
> Other question: What is the meaning of the maintainers field in the
> binding? 

Someone who knows the h/w and can review binding changes. 

> Is it related to the binding itself or the linux driver? 
> I am
> not the maintainer of the driver...

Doesn't have to be the same person.

> 
> 
>  .../devicetree/bindings/eeprom/at25.txt       |  46 +------
>  .../devicetree/bindings/eeprom/at25.yaml      | 122 ++++++++++++++++++
>  2 files changed, 123 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/eeprom/at25.yaml
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
> index fe91ecf1f61b..9b1096fb3826 100644
> --- a/Documentation/devicetree/bindings/eeprom/at25.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at25.txt
> @@ -1,45 +1 @@
> -EEPROMs (SPI) compatible with Atmel at25.
> -
> -Required properties:
> -- compatible : Should be "<vendor>,<type>", and generic value "atmel,at25".
> -  Example "<vendor>,<type>" values:
> -    "anvo,anv32e61w"
> -    "microchip,25lc040"
> -    "st,m95m02"
> -    "st,m95256"
> -
> -- reg : chip select number
> -- spi-max-frequency : max spi frequency to use
> -- pagesize : size of the eeprom page
> -- size : total eeprom size in bytes
> -- address-width : number of address bits (one of 8, 9, 16, or 24).
> -  For 9 bits, the MSB of the address is sent as bit 3 of the instruction
> -  byte, before the address byte.
> -
> -Optional properties:
> -- spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
> -- spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
> -- read-only : this parameter-less property disables writes to the eeprom
> -- wp-gpios : GPIO to which the write-protect pin of the chip is connected
> -
> -Obsolete legacy properties can be used in place of "size", "pagesize",
> -"address-width", and "read-only":
> -- at25,byte-len : total eeprom size in bytes
> -- at25,addr-mode : addr-mode flags, as defined in include/linux/spi/eeprom.h
> -- at25,page-size : size of the eeprom page
> -
> -Additional compatible properties are also allowed.
> -
> -Example:
> -	eeprom@0 {
> -		compatible = "st,m95256", "atmel,at25";
> -		reg = <0>;
> -		spi-max-frequency = <5000000>;
> -		spi-cpha;
> -		spi-cpol;
> -		wp-gpios = <&gpio1 3 0>;
> -
> -		pagesize = <64>;
> -		size = <32768>;
> -		address-width = <16>;
> -	};
> +This file has been moved to at25.yaml.
> \ No newline at end of file

Fix this.

> diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
> new file mode 100644
> index 000000000000..437a28dab6fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/eeprom/at25.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: SPI EEPROMs compatible with Atmel's AT25
> +
> +maintainers:
> +  - Christian Eggers <ceggers@arri.de>
> +
> +properties:
> +  $nodename:
> +    pattern: "^eeprom@[0-9a-f]{1,2}$"
> +
> +  # There are multiple known vendors who manufacture EEPROM chips compatible
> +  # with Atmel's AT25. The compatible string requires two items where the
> +  # 'vendor' and 'model' parts of the first are the actual chip and the second
> +  # item is fixed to "atmel,at25".
> +  compatible:
> +    items:
> +      - {}
> +      - const: atmel,at25

This doesn't work for 'atmel,at25' alone. You'll need a 'oneOf' with a 
single entry.

> +    description:
> +      'Should be "<vendor>,<chip>", and generic value "atmel,at25".
> +      Example "<vendor>,<chip>" values:
> +        "anvo,anv32e61w"
> +        "microchip,25lc040"
> +        "st,m95m02"
> +        "st,m95256"'
> +
> +  reg:
> +    description:
> +      Chip select number.
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#definitions/uint32

This is common and already has a definition. Just need 'true'.

> +    description:
> +      Maximum SPI frequency to use.
> +
> +  pagesize:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Size of the eeprom page.

Constraints? I'd assume it's some power of 2 set.
> +
> +  size:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description:
> +      Total eeprom size in bytes.
> +
> +  address-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 8, 9, 16, 24 ]
> +    description:
> +      Number of address bits.
> +      For 9 bits, the MSB of the address is sent as bit 3 of the instruction
> +      byte, before the address byte.
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  read-only:
> +    description:
> +      Disable writes to the eeprom.
> +    type: boolean
> +
> +  wp-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO to which the write-protect pin of the chip is connected.
> +
> +  # Deprecated: at25,byte-len, at25,addr-mode, at25,page-size
> +  at25,byte-len:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +       Total eeprom size in bytes. Deprecated, use "size" property instead.
> +    deprecated: true
> +
> +  at25,addr-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +       Addr-mode flags, as defined in include/linux/spi/eeprom.h.
> +       Deprecated, use "address-width" property instead.
> +    deprecated: true
> +
> +  at25,page-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the eeprom page. Deprecated, use "pagesize" property instead.
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - pagesize
> +  - size
> +  - address-width
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        eeprom@0 {
> +            compatible = "st,m95256", "atmel,at25";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            spi-cpha;
> +            spi-cpol;
> +            wp-gpios = <&gpio1 3 0>;
> +
> +            pagesize = <64>;
> +            size = <32768>;
> +            address-width = <16>;
> +        };
> +    };
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
