Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C50FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A68E246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582910324;
	bh=k1hRL5DeZtkyFL/eURkkMrJR8KB4iCX+iuuPzyAjih4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uUhTOefLSk8DrNUfPKcl5tMZvwCebJfVDP7YI1WNw7bGvHA1Lp8EznB/2oayZdpj6
	 SMziwrQlRipodULiQO+LTSgRoutivPUnYUlHe/Y26oIWbKmLZe3zEw1RI457DZqcV7
	 rbUbhiCgYK2/6NedZRrs1zkevT2e/q5KoVK9X3PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1RSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:18:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40724 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:18:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id a36so3262261otb.7;
        Fri, 28 Feb 2020 09:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pb+PJoJtW2sA5x/kLQp2vnmzDsqGqr65TnSBcPMbR7g=;
        b=E2mwvy0jwFxBpHSSU+X1mxXeFxw1vTw0rZl4V9k0m6/khPt7BSRVq3cdGvkQfIZHTq
         j5ptbdqOB5jPNwrM+PRHoAkIhJRP3iuQgvMLlNArt5oTsIe2MK50WEE7gXRNg+xYhQml
         MB0r45iBPLHlIKf4U7VDqBrr40MF3SdYrypK5yxfByfCi3QnSZHiSJouIR5393/2fihd
         gSkUS/5yEzuWfYdZ3GJ3d/QWiyisioK4cMknOekDqpRTJ+ip5v7xZk1UjDp/76zFcE14
         3leOf8JGgRKhF52Na9w4fYsGWgRSHvBqycvhPpOclGc9CN5t5PxxepqltSD7ThE32xdL
         qRWg==
X-Gm-Message-State: APjAAAX1GD8QcrXWj4SQEE0qUGy9iWl+1VnoEziI+0qSxVUkg+9u7X7m
        sCf0cHfVYOxDEOqNOiTuzg==
X-Google-Smtp-Source: APXvYqzab5ENBUX7/Dqgb0kBzOfn28/rFZnWr1rJG7CNXgNlbWqOdHwOkN1Yv4PRdvFnNLEteaDSbQ==
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr4121358otr.82.1582910320121;
        Fri, 28 Feb 2020 09:18:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z17sm3296727oic.15.2020.02.28.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 09:18:39 -0800 (PST)
Received: (nullmailer pid 26488 invoked by uid 1000);
        Fri, 28 Feb 2020 17:18:38 -0000
Date:   Fri, 28 Feb 2020 11:18:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 3/9] ASoC: meson: convert axg tdm formatters to schema
Message-ID: <20200228171838.GA27450@bogus>
References: <20200224145821.262873-1-jbrunet@baylibre.com>
 <20200224145821.262873-4-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224145821.262873-4-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:58:15PM +0100, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic tdm formatters to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../sound/amlogic,axg-tdm-formatters.txt      | 36 --------
>  .../sound/amlogic,axg-tdm-formatters.yaml     | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
> deleted file mode 100644
> index 5996c0cd89c2..000000000000
> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -* Amlogic Audio TDM formatters
> -
> -Required properties:
> -- compatible: 'amlogic,axg-tdmin' or
> -	      'amlogic,axg-tdmout' or
> -	      'amlogic,g12a-tdmin' or
> -	      'amlogic,g12a-tdmout' or
> -	      'amlogic,sm1-tdmin' or
> -	      'amlogic,sm1-tdmout
> -- reg: physical base address of the controller and length of memory
> -       mapped region.
> -- clocks: list of clock phandle, one for each entry clock-names.
> -- clock-names: should contain the following:
> -  * "pclk"     : peripheral clock.
> -  * "sclk"     : bit clock.
> -  * "sclk_sel" : bit clock input multiplexer.
> -  * "lrclk"    : sample clock
> -  * "lrclk_sel": sample clock input multiplexer
> -
> -Optional property:
> -- resets: phandle to the dedicated reset line of the tdm formatter.
> -
> -Example of TDMOUT_A on the S905X2 SoC:
> -
> -tdmout_a: audio-controller@500 {
> -	compatible = "amlogic,axg-tdmout";
> -	reg = <0x0 0x500 0x0 0x40>;
> -	resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
> -	clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
> -		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
> -		 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
> -		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
> -		 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
> -	clock-names = "pclk", "sclk", "sclk_sel",
> -		      "lrclk", "lrclk_sel";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
> new file mode 100644
> index 000000000000..f6f3bfb546f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please as you're the only author of the .txt file.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-formatters.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Audio AXG TDM formatters
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^audio-controller@.*"
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - amlogic,g12a-tdmout
> +          - amlogic,sm1-tdmout
> +          - amlogic,axg-tdmout
> +      - items:
> +        - enum:
> +          - amlogic,g12a-tdmin
> +          - amlogic,sm1-tdmin
> +        - const:
> +            amlogic,axg-tdmin
> +      - items:
> +        - const:
> +            amlogic,axg-tdmin
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +      - description: Bit clock
> +      - description: Bit clock input multiplexer
> +      - description: Sample clock
> +      - description: Sample clock input multiplexer
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: sclk
> +      - const: sclk_sel
> +      - const: lrclk
> +      - const: lrclk_sel
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - amlogic,g12a-tdmin
> +          - amlogic,sm1-tdmin
> +          - amlogic,g12a-tdmout
> +          - amlogic,sm1-tdmout
> +then:
> +  required:
> +    - resets
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/axg-audio-clkc.h>
> +    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
> +
> +    tdmout_a: audio-controller@500 {
> +        compatible = "amlogic,g12a-tdmout",
> +                     "amlogic,axg-tdmout";

This fails validation.

> +        reg = <0x0 0x500 0x0 0x40>;
> +        resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
> +        clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
> +                 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
> +                 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
> +                 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>,
> +                 <&clkc_audio AUD_CLKID_TDMOUT_A_LRCLK>;
> +        clock-names = "pclk", "sclk", "sclk_sel",
> +                      "lrclk", "lrclk_sel";
> +    };
> +
> -- 
> 2.24.1
> 
