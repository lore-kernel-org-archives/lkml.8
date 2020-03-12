Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF090C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE860206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584044591;
	bh=lK+DbZu+ysfioTaOjQp7MwFz+Cg7MyJVUs9MvHtpsk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rFjTtc8NYtNNEjSJUU0l3VnTO3ZnrGg/4e9hBMImw974skH5fFhGPY5ixoSFV4PSX
	 U8QdXbrSXQI7a4qqU4cIFxYAN4NeHTwnyE0Dofnal8h6uhWXJVCont1WwBMcuZyZwS
	 z2KpAxeeYOV40xPy4IJAeyy5fG7rA7/21p2hDp8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCLUXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:23:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45466 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:23:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id e9so507381otr.12;
        Thu, 12 Mar 2020 13:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edf5TR5CVR3TN5pRGNKw9mhGgcBOLphtKYRyAygi4sY=;
        b=QQhr5uZJGjtNzJQYLqDEl5pPyg0tHdFHW7T2iP3nu1ZyBt5N8WJSjwG19AZKXo4aH6
         aFAwJdzS3taS4F3XYCJZLmIRBpNyexkZfEXpE7kjv1klKLjIV3q7rzQfI1aJIPJvR273
         evvPtNtkKZOxp/cgBMlU4TNHoNP2mDy3kzeZCSvYV4gKL4NYx/ZsA4eYSjIn+hiJrdx2
         oaiLEG83faoHIka9fDLHGNMPP6xRjey8EfQ32ZvW+5BACTJCRNHDwbBmbknWsR7nIw1F
         sEUPRDeMfPhboSUiczs6srj7cI7OMlTKz49zin/uZaJ1Z7KeTJHX9qhkq9SEgj5yADf2
         uM8w==
X-Gm-Message-State: ANhLgQ1JjwX81rUjeCFNAvb94FGxWc52q8WUwCe0LiJdBFkr/1sMXGql
        kQX4XyG60kDYLoftHpDaYn6+DdE=
X-Google-Smtp-Source: ADFU+vvOQCNhP9ZLDZQxkhEt/jrr6BlY7/vHQ5vgiZhlBHGBv/gpom62mtJzEUMw2/nTR4mZwAQuMA==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr7677326otl.366.1584044588129;
        Thu, 12 Mar 2020 13:23:08 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm12789082otl.60.2020.03.12.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:23:07 -0700 (PDT)
Received: (nullmailer pid 10568 invoked by uid 1000);
        Thu, 12 Mar 2020 20:23:06 -0000
Date:   Thu, 12 Mar 2020 15:23:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com,
        broonie@kernel.org, linux-imx@nxp.com, devicetree@vger.kernel.org,
        Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        ranjani.sridharan@linux.intel.com, liam.r.girdwood@linux.intel.com,
        sound-open-firmware@alsa-project.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Add FSL CPU DAI bindings
Message-ID: <20200312202306.GA18767@bogus>
References: <20200306111353.12906-1-daniel.baluta@oss.nxp.com>
 <20200306111353.12906-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306111353.12906-2-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 01:13:52PM +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Add dt bindings for he Generic FSL CPU DAI.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,dai.yaml    | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,dai.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,dai.yaml b/Documentation/devicetree/bindings/sound/fsl,dai.yaml
> new file mode 100644
> index 000000000000..e6426af67d30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,dai.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,dai.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic CPU FSL DAI driver for resource management

Bindings are for h/w devices, not drivers.

> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +description: |
> +  On platforms with a DSP we need to split the resource handling between
> +  Application Processor (AP) and DSP. On platforms where the DSP doesn't
> +  have an easy access to resources, the AP will take care of
> +  configuring them. Resources handled by this generic driver are: clocks,
> +  power domains, pinctrl.

The DT should define a DSP node with resources that are part of the 
DSP. What setup the AP has to do should be implied by the compatible 
string and possibly what resources are described.

Or maybe the audio portion of the DSP is a child node...

> +
> +properties:
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - fsl,esai-dai
> +      - fsl,sai-dai

Not very specific. There's only 2 versions of the DSP and ways it is 
integrated?

> +
> +  clocks:
> +    oneOf:
> +      - items: # for ESAI
> +          - description: Core clock used to access registers.
> +          - description: ESAI baud clock for ESAI controller used to derive
> +                         HCK, SCK and FS.
> +          - description: The system clock derived from ahb clock used to derive
> +                         HCK, SCK and FS.
> +          - description: SPBA clock is required when ESAI is placed as a bus
> +                         slave of the SP Bus and when two or more bus masters
> +                         (CPU, DMA or DSP) try to access it. This property is
> +                         optional depending on SoC design.
> +      - items: # for SAI
> +          - description: Bus clock for accessing registers
> +          - description: Master clock 0 for providing bit clock and frame clock
> +          - description: Master clock 1 for providing bit clock and frame clock
> +          - description: Master clock 2 for providing bit clock and frame clock
> +          - description: Master clock 3 for providing bit clock and frame clock
> +
> +  clock-names:
> +    oneOf:
> +      - items: # for ESAI
> +          - const: core
> +          - const: extal
> +          - const: fsys
> +          - const: spba
> +      - items: # for SAI
> +          - const: bus
> +          - const: mclk0
> +          - const: mclk1
> +          - const: mclk2
> +          - const: mclk3
> +
> +  pinctrl-0:
> +    description: Should specify pin control groups used for this controller.
> +
> +  pinctrl-names:
> +    const: default

pinctrl properties are implicitly allowed an don't have to be listed 
here.

> +
> +  power-domains:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Don't need a type.

> +    description:
> +      List of phandles and PM domain specifiers, as defined by bindings of the
> +      PM domain provider.

Don't need to re-define common properties.

You do need to say how many power domains (maxItems: 1?).

> +
> +  fsl,dai-index:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Physical DAI index, must match the index from topology file

Sorry, we don't do indexes in DT.

What's a topology file?

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - fsl,dai-index
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-clock.h>
> +    esai0_port: esai-port {
> +         #sound-dai-cells = <0>;
> +        compatible = "fsl,esai-dai";
> +
> +        fsl,dai-index = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_esai0>;
> +
> +        clocks = <&esai0_lpcg 1>, <&esai0_lpcg 0>,  <&esai0_lpcg 1>,
> +            <&clk_dummy>;
> +        clock-names = "core", "extal", "fsys", "spba";
> +    };
> -- 
> 2.17.1
> 
