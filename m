Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE184C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C6C20826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589926896;
	bh=Ahw8srE0nbbe3jb4xG7Lotaxsk6bz/JlQZOCw8dzLf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wkUOVqa476Bf4RKFgWfflxmgJWhebBczsZ35BtaTm8vep8lEPUFxVzKzFVWpNu7YB
	 7y1mXJyEn7/vxzvPUbUfeL9igo5/S95Zc1ncB0tegweL4vGiuypl4Wl41nIF4D94O5
	 +/FzUc7DcmWHy366yr3+H7cCLVZL3WrT7d//rDvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgESWVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:21:36 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:32784 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESWVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:21:35 -0400
Received: by mail-il1-f193.google.com with SMTP id o67so1119793ila.0;
        Tue, 19 May 2020 15:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BEN+tw7z4mCkQ24uiqe88N26f3zgm2QQ47/AnQ840b8=;
        b=BPluzFLppr57v+Bmew/wypLFdx7g2o4ohBt+lWZ41Jdqu7mZFtUzJSI6xCfDSnAKJx
         L+/fxWFe9NM0oidK+84QdfZiGe+p5uaOJOkdKGgofNZpG/U6IUQwIQffTbLRkWDLyzJ3
         gWO32UryU2RXYVzvz3f2dPsojN/l5y8BWKAX/jKQGKQ6kyr6nBH+6gUrs5BzHrNv6Rni
         SahqgbnG8LIwUjzgSlU0c+dCdRdAUwgryjI67oorIUvYTzT28FpjRXseLeTkJpyr9fzs
         0v7nLfGohW4aKfHby2wQlaUz56VaR9cOnerfJhM32GWh1o3ExQCQfND73Eg7xf9BZxGo
         S3QA==
X-Gm-Message-State: AOAM532HvGjQU3iwmWVoXiIGr7S47mPWA7T3Kt0qeq4c6A17A1QKp4ML
        vNRa2Z9WrpPsSJTaQr1vyw==
X-Google-Smtp-Source: ABdhPJx/FMKP9R0H7RKVQpRSG+nSgWCZKRAGXE9/bSi+QvQyjbN8nfD5MxhgfzOgsFYY8McNgXX2Tg==
X-Received: by 2002:a92:5c06:: with SMTP id q6mr1309504ilb.236.1589926893566;
        Tue, 19 May 2020 15:21:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o15sm341350ilg.46.2020.05.19.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 15:21:32 -0700 (PDT)
Received: (nullmailer pid 791975 invoked by uid 1000);
        Tue, 19 May 2020 22:21:32 -0000
Date:   Tue, 19 May 2020 16:21:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bindings: sound: Add documentation for TI j721e
 EVM (CPB and IVI)
Message-ID: <20200519222132.GA488519@bogus>
References: <20200512131633.32668-1-peter.ujfalusi@ti.com>
 <20200512131633.32668-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512131633.32668-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:16:32PM +0300, Peter Ujfalusi wrote:
> The audio support on the Common Processor Board board is using
> pcm3168a codec connected to McASP10 serializers in parallel setup.
> 
> The Infotainment board plugs into the Common Processor Board, the support
> of the extension board is extending the CPB audio support by adding
> the two codecs on the expansion board.
> 
> The audio support on the Infotainment Expansion Board consists of McASP0
> connected to two pcm3168a codecs with dedicated set of serializers to each.
> The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../bindings/sound/ti,j721e-cpb-audio.yaml    |  93 ++++++++++++
>  .../sound/ti,j721e-cpb-ivi-audio.yaml         | 142 ++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
> new file mode 100644
> index 000000000000..0355ffc2b01b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,j721e-cpb-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments J721e Common Processor Board Audio Support
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The audio support on the board is using pcm3168a codec connected to McASP10
> +  serializers in parallel setup.
> +  The pcm3168a SCKI clock is sourced from j721e AUDIO_REFCLK2 pin.
> +  In order to support 48KHz and 44.1KHz family of sampling rates the parent
> +  clock for AUDIO_REFCLK2 needs to be changed between PLL4 (for 48KHz) and
> +  PLL15 (for 44.1KHz). The same PLLs are used for McASP10's AUXCLK clock via
> +  different HSDIVIDER.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,j721e-cpb-audio
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  ti,cpb-mcasp:
> +    description: phandle to McASP10
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,cpb-codec:
> +    description: phandle to the pcm3168a codec used on the CPB
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  clocks:
> +    items:
> +      - description: PLL4 clock
> +      - description: PLL15 clock
> +      - description: McASP10 auxclk clock
> +      - description: PLL4_HSDIV0 parent for McASP10 auxclk (for 48KHz)
> +      - description: PLL15_HSDIV0 parent for McASP10 auxclk (for 44.1KHz)
> +      - description: AUDIO_REFCLK2 clock
> +      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK2 clock (for 48KHz)
> +      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK2 clock (for 44.1KHz)

What h/w are these connected to? You have no control interface here, so 
how do you have clocks?

Defining parent clocks seems wrong, too. This seems to just be a 
collection of clocks a driver happens to need. Really, you should be 
able query possible parents and select one with the right frequency 
multiple.

> +
> +  clock-names:
> +    items:
> +      - const: pll4
> +      - const: pll15
> +      - const: cpb-mcasp
> +      - const: cpb-mcasp-48000
> +      - const: cpb-mcasp-44100
> +      - const: audio-refclk2
> +      - const: audio-refclk2-48000
> +      - const: audio-refclk2-44100
> +
> +required:
> +  - compatible
> +  - model
> +  - ti,cpb-mcasp
> +  - ti,cpb-codec
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    sound {
> +        compatible = "ti,j721e-cpb-audio";
> +        model = "j721e-cpb";
> +
> +        status = "okay";

Don't show status in examples.

> +
> +        ti,cpb-mcasp = <&mcasp10>;
> +        ti,cpb-codec = <&pcm3168a_1>;
> +
> +        clocks = <&pll4>, <&pll15>,
> +                 <&k3_clks 184 1>,
> +                 <&k3_clks 184 2>, <&k3_clks 184 4>,
> +                 <&k3_clks 157 371>,
> +                 <&k3_clks 157 400>, <&k3_clks 157 401>;
> +        clock-names = "pll4", "pll15",
> +                      "cpb-mcasp",
> +                      "cpb-mcasp-48000", "cpb-mcasp-44100",
> +                      "audio-refclk2",
> +                      "audio-refclk2-48000", "audio-refclk2-44100";
> +    };
> diff --git a/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
> new file mode 100644
> index 000000000000..3951c1320fae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,j721e-cpb-ivi-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments J721e Common Processor Board Audio Support
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@ti.com>
> +
> +description: |
> +  The Infotainment board plugs into the Common Processor Board, the support of the
> +  extension board is extending the CPB audio support, decribed in:
> +  sound/ti,j721e-cpb-audio.txt
> +
> +  The audio support on the Infotainment Expansion Board consists of McASP0
> +  connected to two pcm3168a codecs with dedicated set of serializers to each.
> +  The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.
> +
> +  In order to support 48KHz and 44.1KHz family of sampling rates the parent clock
> +  for AUDIO_REFCLK0 needs to be changed between PLL4 (for 48KHz) and PLL15 (for
> +  44.1KHz). The same PLLs are used for McASP0's AUXCLK clock via different
> +  HSDIVIDER.
> +
> +  Note: the same PLL4 and PLL15 is used by the audio support on the CPB!
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,j721e-cpb-ivi-audio
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  ti,cpb-mcasp:
> +    description: phandle to McASP10
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,cpb-codec:
> +    description: phandle to the pcm3168a codec used on the CPB
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,ivi-mcasp:
> +    description: phandle to McASP9
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,ivi-codec-a:
> +    description: phandle to the pcm3168a-A codec on the expansion board
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,ivi-codec-b:
> +    description: phandle to the pcm3168a-B codec on the expansion board
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  clocks:
> +    items:
> +      - description: PLL4 clock
> +      - description: PLL15 clock
> +      - description: McASP10 auxclk clock
> +      - description: PLL4_HSDIV0 parent for McASP10 auxclk (for 48KHz)
> +      - description: PLL15_HSDIV0 parent for McASP10 auxclk (for 44.1KHz)
> +      - description: AUDIO_REFCLK2 clock
> +      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK2 clock (for 48KHz)
> +      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK2 clock (for 44.1KHz)
> +      - description: McASP0 auxclk clock
> +      - description: PLL4_HSDIV0 parent for McASP0 auxclk (for 48KHz)
> +      - description: PLL15_HSDIV0 parent for McASP0 auxclk (for 44.1KHz)
> +      - description: AUDIO_REFCLK0 clock
> +      - description: PLL4_HSDIV2 parent for AUDIO_REFCLK0 clock (for 48KHz)
> +      - description: PLL15_HSDIV2 parent for AUDIO_REFCLK0 clock (for 44.1KHz)
> +
> +  clock-names:
> +    items:
> +      - const: pll4
> +      - const: pll15
> +      - const: cpb-mcasp
> +      - const: cpb-mcasp-48000
> +      - const: cpb-mcasp-44100
> +      - const: audio-refclk2
> +      - const: audio-refclk2-48000
> +      - const: audio-refclk2-44100
> +      - const: ivi-mcasp
> +      - const: ivi-mcasp-48000
> +      - const: ivi-mcasp-44100
> +      - const: audio-refclk0
> +      - const: audio-refclk0-48000
> +      - const: audio-refclk0-44100
> +
> +required:
> +  - compatible
> +  - model
> +  - ti,cpb-mcasp
> +  - ti,cpb-codec
> +  - ti,ivi-mcasp
> +  - ti,ivi-codec-a
> +  - ti,ivi-codec-b
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    sound {
> +        compatible = "ti,j721e-cpb-ivi-audio";
> +        model = "j721e-cpb-ivi";
> +
> +        status = "okay";
> +
> +        ti,cpb-mcasp = <&mcasp10>;
> +        ti,cpb-codec = <&pcm3168a_1>;
> +
> +        ti,ivi-mcasp = <&mcasp0>;
> +        ti,ivi-codec-a = <&pcm3168a_a>;
> +        ti,ivi-codec-b = <&pcm3168a_b>;
> +
> +        clocks = <&pll4>, <&pll15>,
> +                 <&k3_clks 184 1>,
> +                 <&k3_clks 184 2>, <&k3_clks 184 4>,
> +                 <&k3_clks 157 371>,
> +                 <&k3_clks 157 400>, <&k3_clks 157 401>,
> +                 <&k3_clks 174 1>,
> +                 <&k3_clks 174 2>, <&k3_clks 174 4>,
> +                 <&k3_clks 157 301>,
> +                 <&k3_clks 157 330>, <&k3_clks 157 331>;
> +        clock-names = "pll4", "pll15",
> +                      "cpb-mcasp",
> +                      "cpb-mcasp-48000", "cpb-mcasp-44100",
> +                      "audio-refclk2",
> +                      "audio-refclk2-48000", "audio-refclk2-44100",
> +                      "ivi-mcasp",
> +                      "ivi-mcasp-48000", "ivi-mcasp-44100",
> +                      "audio-refclk0",
> +                      "audio-refclk0-48000", "audio-refclk0-44100";
> +    };
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
