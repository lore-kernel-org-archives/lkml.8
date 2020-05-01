Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786CC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71187208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588367177;
	bh=+upNfW3UDo0fWTsLAprbNik/EFDEwCd+DNhnhnRvSTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sfb07BM0sXmKZL5tezgmW/LNnEM2ppHlnBMox7vT1x172bG7TpR9uva7d/j80UxM/
	 2h18182FqQ71GgIszy7KRlxW91xxzpiCtUbKxg3ovlt3e/V6C/UOjnykTJh+z2MmHH
	 6HemfPSTDUKBwbUQ4i0cvPlytx2n4CKIx38fgPVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgEAVGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:06:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43617 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:06:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id j16so854802oih.10;
        Fri, 01 May 2020 14:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OpLIzM5fC6RDjXcWC7jSJGMnm6huXsAlVMRW1uHqv9w=;
        b=XPg/Z544xe34RsIaQy3mTC9ubaIaf/WwuAihC9ZqjI7PRbbQdzut9Mj6VQQ7wyiSa/
         zs8ZgxxFKivTrB4VtxSLp2QefinpHQNyRyajvr0c53EFzsc52VOuds6IDnf/IoXv7+q6
         yknUdDcWQ2XdBH5Nx5XDGvbEIyrcb8zLOPfQMGQ0lOBQQypfZavAqjZfht1jhO2y+DCl
         v6cCieXS9EZNIj5mDbbVAr3X8DduQlp1DQpvgwzJBMB1/wRjBSRw1NRkHou++iWd5gcp
         99Jp47NYhUJYnkz0itz4f6LL7FmCiUN1NpBsqvKp9DR5DNfXw9XT3/BHE7R3kuQgBhTD
         b1xA==
X-Gm-Message-State: AGi0Pub9+U/GB/6oyK2zk9LJqwXDXEBOeTe6QP703Y7AyW0QWPf+VIE8
        JcFA7UcZlLPvMBsdKkOn/g==
X-Google-Smtp-Source: APiQypJ/+wF6VeKI4dobpnCRZchBnXTFHQ2LsIvG1ifgcaL31NE9ZM/VHZ3b1R7TKwE4A59yzL0yEQ==
X-Received: by 2002:aca:ecce:: with SMTP id k197mr1138036oih.127.1588367175211;
        Fri, 01 May 2020 14:06:15 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm1101352ott.17.2020.05.01.14.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:06:14 -0700 (PDT)
Received: (nullmailer pid 24617 invoked by uid 1000);
        Fri, 01 May 2020 21:06:13 -0000
Date:   Fri, 1 May 2020 16:06:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/6] ASoC: lochnagar: Move binding over to dtschema
Message-ID: <20200501210613.GD24163@bogus>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
 <20200427102812.23251-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427102812.23251-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:28:08AM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/sound/cirrus,lochnagar.txt | 39 ---------------
>  .../bindings/sound/cirrus,lochnagar.yaml           | 58 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
> deleted file mode 100644
> index 41ae2699f07a9..0000000000000
> --- a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -Cirrus Logic Lochnagar Audio Development Board
> -
> -Lochnagar is an evaluation and development board for Cirrus Logic
> -Smart CODEC and Amp devices. It allows the connection of most Cirrus
> -Logic devices on mini-cards, as well as allowing connection of
> -various application processor systems to provide a full evaluation
> -platform.  Audio system topology, clocking and power can all be
> -controlled through the Lochnagar, allowing the device under test
> -to be used in a variety of possible use cases.
> -
> -This binding document describes the binding for the audio portion
> -of the driver.
> -
> -This binding must be part of the Lochnagar MFD binding:
> -  [4] ../mfd/cirrus,lochnagar.txt
> -
> -Required properties:
> -
> -  - compatible : One of the following strings:
> -                 "cirrus,lochnagar2-soundcard"
> -
> -  - #sound-dai-cells : Must be set to 1.
> -
> -  - clocks : Contains an entry for each entry in clock-names.
> -  - clock-names : Must include the following clocks:
> -      "mclk" Master clock source for the sound card, should normally
> -      be set to LOCHNAGAR_SOUNDCARD_MCLK provided by the Lochnagar
> -      clock driver.
> -
> -Example:
> -
> -lochnagar-sc {
> -	compatible = "cirrus,lochnagar2-soundcard";
> -
> -	#sound-dai-cells = <1>;
> -
> -	clocks = <&lochnagar_clk LOCHNAGAR_SOUNDCARD_MCLK>;
> -	clock-names = "mclk";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
> new file mode 100644
> index 0000000000000..6a266793ebd16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,lochnagar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic Lochnagar Audio Development Board
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  Lochnagar is an evaluation and development board for Cirrus Logic
> +  Smart CODEC and Amp devices. It allows the connection of most Cirrus
> +  Logic devices on mini-cards, as well as allowing connection of various
> +  application processor systems to provide a full evaluation platform.
> +  Audio system topology, clocking and power can all be controlled through
> +  the Lochnagar, allowing the device under test to be used in a variety of
> +  possible use cases.
> +
> +  This binding document describes the binding for the audio portion of the
> +  driver.
> +
> +  This binding must be part of the Lochnagar MFD binding:
> +    [1] ../mfd/cirrus,lochnagar.yaml
> +
> +properties:
> +  lochnagar-sc:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +            - cirrus,lochnagar2-soundcard
> +
> +      '#sound-dai-cells':
> +        description:
> +          Must be 1. The first cell indicating the audio interface.

'Must be 1' is what the constraint says.

> +        const: 1
> +
> +      clocks:
> +        maxItems: 1
> +        description:
> +          Master clock source for the sound card, should normally be set to
> +          LOCHNAGAR_SOUNDCARD_MCLK provided by the Lochnagar clock driver.

blank line.

> +      clock-names:
> +        const: mclk
> +        description:
> +          Must contain the string mclk.

That's what the constraint says already.

> +
> +    required:
> +      - compatible
> +      - '#sound-dai-cells'
> +      - clocks
> +      - clock-names
> +
> +    additionalProperties: false
> -- 
> 2.11.0
> 
