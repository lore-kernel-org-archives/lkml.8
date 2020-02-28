Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15045C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F752469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582912880;
	bh=QegyQo/HR+2pngYHKRkCTtN3MwRY9QFxvC/oTtQwhIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x6s8OdWv5iLbY3n+0hZWXh7bputwNblyHCj6BnEQ1gP8v8lTeUwN/JLMkXxpWaMak
	 m2Z55Pnyq9IYRj1bxSqkJwM2DXSwhqmAPoC4Zrpt6ykEn5Gq9ba22qmWO9B7oTC3MD
	 U9dwiVY81fZcL4B9vLaoscFNfw5N57Cp4V8hoTSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1SBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:01:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39919 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:01:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id x97so3394767ota.6;
        Fri, 28 Feb 2020 10:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pAsECt7PiBK62q88D+kfvQxUuJNH4AnYnLku6Y2cN8=;
        b=YNIJWFRH6PD6YH6SLwtDVe2BqkZ8ClZKE2ZrfPAHu3fXTLct8n7boO8SrhcJhRsr4/
         CV/WSU4jqXgbPVZLlkmg66qJDjU19MTlG9aiq5YbDKrgpsw5ZyrR58QGch0luPDQhbCF
         Zx1Ck+c/1B0EVfJtO3uuG5r7q60vzeOcFsmIU1E5qB5OHvusA2wZ07BJ/uG0Sxth4P2P
         TlTX6S6eqQEVQDNapnQjpRdkMku8W4M6Ui3PnloVPx1atZntCZFHio6Pk/PXBb9VDz1p
         VnO7gpGHFa8ozr7WO2sd1j3cth6J+dOV+72N578DygCHSLsalmZ5c2wYygobKwg9Q+OJ
         vhDw==
X-Gm-Message-State: APjAAAW7zLgC7C1nbGIviJ7+K4iWZMHF0bEdDFvyioNqGcPj+jf3DNok
        lACQtmqhb4O4qMi5QKU15Q==
X-Google-Smtp-Source: APXvYqyc028jTANUn0xgkw/a9kxcmZKUdVZYKQUcXfDjL8GahTISwR9AkN8XD+xx3EePlmjq7gsFvg==
X-Received: by 2002:a9d:518b:: with SMTP id y11mr4099645otg.349.1582912877111;
        Fri, 28 Feb 2020 10:01:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m185sm3318360oia.26.2020.02.28.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 10:01:16 -0800 (PST)
Received: (nullmailer pid 21022 invoked by uid 1000);
        Fri, 28 Feb 2020 18:01:15 -0000
Date:   Fri, 28 Feb 2020 12:01:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 5/9] ASoC: meson: convert axg fifo to schema
Message-ID: <20200228180115.GA14079@bogus>
References: <20200224145821.262873-1-jbrunet@baylibre.com>
 <20200224145821.262873-6-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224145821.262873-6-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:58:17PM +0100, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg audio FIFOs to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-fifo.txt       |  34 ------
>  .../bindings/sound/amlogic,axg-fifo.yaml      | 111 ++++++++++++++++++
>  2 files changed, 111 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
> deleted file mode 100644
> index fa4545ed81ca..000000000000
> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -* Amlogic Audio FIFO controllers
> -
> -Required properties:
> -- compatible: 'amlogic,axg-toddr' or
> -	      'amlogic,axg-toddr' or
> -	      'amlogic,g12a-frddr' or
> -	      'amlogic,g12a-toddr' or
> -	      'amlogic,sm1-frddr' or
> -	      'amlogic,sm1-toddr'
> -- reg: physical base address of the controller and length of memory
> -       mapped region.
> -- interrupts: interrupt specifier for the fifo.
> -- clocks: phandle to the fifo peripheral clock provided by the audio
> -	  clock controller.
> -- resets: list of reset phandle, one for each entry reset-names.
> -- reset-names: should contain the following:
> -  * "arb" : memory ARB line (required)
> -  * "rst" : dedicated device reset line (optional)
> -- #sound-dai-cells: must be 0.
> -- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
> -  		      is useful for determining certain configuration such
> -		      as the flush threshold of the fifo
> -
> -Example of FRDDR A on the A113 SoC:
> -
> -frddr_a: audio-controller@1c0 {
> -	compatible = "amlogic,axg-frddr";
> -	reg = <0x0 0x1c0 0x0 0x1c>;
> -	#sound-dai-cells = <0>;
> -	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
> -	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
> -	resets = <&arb AXG_ARB_FRDDR_A>;
> -	fifo-depth = <512>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> new file mode 100644
> index 000000000000..d9fe4f624784
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/amlogic,axg-fifo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic AXG Audio FIFO controllers
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^audio-controller@.*"
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const:
> +            amlogic,axg-toddr
> +      - items:
> +        - const:
> +            amlogic,axg-frddr
> +      - items:
> +        - enum:
> +          - amlogic,g12a-toddr
> +          - amlogic,sm1-toddr
> +        - const:
> +            amlogic,axg-toddr
> +      - items:
> +        - enum:
> +          - amlogic,g12a-frddr
> +          - amlogic,sm1-frddr
> +        - const:
> +            amlogic,axg-frddr
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: Memory ARB line
> +      - description: Dedicated device reset line
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: arb
> +      - const: rst
> +
> +  amlogic,fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Size of the controller's fifo in bytes

Aren't there some constraints on possible values? I'm sure it's more 
than 0 and less than 2^32.

> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - interrupts
> +  - reg
> +  - clocks
> +  - resets
> +  - amlogic,fifo-depth
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - amlogic,g12a-toddr
> +          - amlogic,sm1-toddr
> +          - amlogic,g12a-frddr
> +          - amlogic,sm1-frddr
> +then:
> +  properties:
> +    resets:
> +      minItems: 2
> +    reset-names:
> +      minItems: 2
> +  required:
> +    - reset-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/axg-audio-clkc.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
> +    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
> +
> +    frddr_a: audio-controller@1c0 {
> +        compatible = "amlogic,g12a-frddr", "amlogic,axg-frddr";
> +        reg = <0x0 0x1c0 0x0 0x1c>;
> +        #sound-dai-cells = <0>;
> +        interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
> +        resets = <&arb AXG_ARB_FRDDR_A>, <&clkc_audio AUD_RESET_FRDDR_A>;
> +        reset-names = "arb", "rst";
> +        amlogic,fifo-depth = <512>;
> +    };
> +
> -- 
> 2.24.1
> 
