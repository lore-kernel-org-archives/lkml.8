Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA81EC47409
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68598218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581022009;
	bh=0xWsIls+HxdnXPkAokxsd8+bZVrj7fluG13Qn9cks+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MrUbZ9yWM7+f5rUGs4AYtlnqE0JpXNWMW+Joi8vw15ZKxntgEoqkOK0qy6nLmYID2
	 RdZS09XNHqJcJb5EoGEP6YDbKVdIKqjTSlkDQycHxbI/GXJ5zVcz8rdR6yfeyJIBfC
	 F21HbYpqzsWUylapo/uE8Po+bje0oDpln80Y6w+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBFUqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:46:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45194 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgBFUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:46:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so24620pls.12;
        Thu, 06 Feb 2020 12:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OOXYFIqEU+LJl0CSasuKCfoYnWm1dEiiEdMWamRXfA=;
        b=Blb3sZcBa2MsghHipinQGxFwyzfIlLmoh1E0HazvmABVP+ceUTIFwCMUV9nddZTWDN
         0ajd7HFw0vsr82D1i+6nZtdHc8kBpTIzkVLeQxORv4Ec7CqMXx7rACaIsHKhHYZaVoSk
         OIZ2ISbghr8qZpf9RPeOgXOMHfwBcjV/loC02Y758cOJ5s0bqoUnFIQ2V4AWeTrDeo+x
         /Nc94tBhO+Rwc6Ki3SqA4GgPgYu/1bq9AetXRqq8n/JFMhakycewBHA3fSKwXan3SSwC
         YCxembxCu2bFzs0TbEEt2AN4iuOJqfUPz7V3XpVLmSPlvc3WyQ5xVL12V/jA4+HE9Q8j
         JLew==
X-Gm-Message-State: APjAAAW/iO+diwbtdfHKbax/F6tyH2XX1KAFfdPpQPML7c13Oa57KR3T
        JYwWqm2t3UXg7laOnHFZNQ==
X-Google-Smtp-Source: APXvYqxMKyyGgfS4SNqE734iihQ1ZSY1xsIAJkFzRqu4B/i+hbGP+oW2VzzUFxFzAEqoHOJ1wkbqVA==
X-Received: by 2002:a17:902:7203:: with SMTP id ba3mr5720574plb.249.1581021985220;
        Thu, 06 Feb 2020 12:46:25 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id x11sm283522pfn.53.2020.02.06.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:24 -0800 (PST)
Received: (nullmailer pid 21869 invoked by uid 1000);
        Thu, 06 Feb 2020 18:10:45 -0000
Date:   Thu, 6 Feb 2020 18:10:45 +0000
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com
Subject: Re: [PATCH v2 1/9] dt-bindings: sound: tegra: add DT binding for AHUB
Message-ID: <20200206181045.GA31521@bogus>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580380422-3431-2-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:03:34PM +0530, Sameer Pujar wrote:
> Audio Hub (AHUB) comprises a collection of hardware accelerators for audio
> pre-processing and post-processing and a programmable full crossbar for
> audio routing across these accelerators. This patch adds YAML schema for DT
> binding of AHUB and few of its following components. These devices will be
> registered as ASoC components.
>  * ADMAIF
>  * I2S
>  * DMIC
>  * DSPK
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/sound/nvidia,tegra186-dspk.yaml       | 105 +++++++++++++
>  .../bindings/sound/nvidia,tegra210-admaif.yaml     | 165 +++++++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-ahub.yaml       | 130 ++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-dmic.yaml       | 105 +++++++++++++
>  .../bindings/sound/nvidia,tegra210-i2s.yaml        | 112 ++++++++++++++
>  5 files changed, 617 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
> new file mode 100644
> index 0000000..dc9fef3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0)

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra186-dspk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra186 DSPK Controller Device Tree Bindings
> +
> +description: |
> +  The Digital Speaker Controller (DSPK) can be viewed as a Pulse
> +  Density Modulation (PDM) transmitter that up-samples the input to
> +  the desired sampling rate by interpolation and then converts the
> +  over sampled Pulse Code Modulation (PCM) input to the desired 1-bit
> +  output via Delta Sigma Modulation (DSM).
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Drop 'items' for a single entry.

> +          const: nvidia,tegra186-dspk
> +      - items:
> +          - enum:
> +              - nvidia,tegra194-dspk
> +          - enum:
> +              - nvidia,tegra186-dspk

This can be a 'const'

> +
> +  reg:
> +    description: offset and length of the register set for the device.

That's every 'reg'. Drop.

> +    maxItems: 1
> +
> +  clocks:
> +    description: must contain an entry for each entry in clock-names.
> +      See ../clocks/clocks-bindings.txt for details.
> +    minItems: 1

Drop description and minItems. minItems is implied by the length of 
'items'.

> +    items:
> +      - description: Module clock
> +
> +  clock-names:
> +    description: must contain clock names for each corresponding entry in clocks.
> +      See ../clocks/clocks-bindings.txt for details.
> +    minItems: 1

ditto

> +    items:
> +      - const: dspk
> +
> +  assigned-clocks:
> +    description: list of input clocks and dividers for the audio system.
> +      See ../clocks/clock-bindings.txt for details.
> +    minItems: 1

ditto

> +    items:
> +      - description: Module clock
> +
> +  assigned-clock-parents:
> +    description: parent clock for each entry in assigned-clocks
> +      See ../clocks/clock-bindings.txt for details.
> +    minItems: 1

ditto

> +    items:
> +      - description: Parent for module clock
> +
> +  assigned-clock-rates:
> +    description: clock rate for each entry in assigned-clocks
> +      See ../clocks/clock-bindings.txt for details.

ditto

> +    items:
> +      - description: initial module clock rate
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +  sound-name-prefix:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Used as prefix for sink/source names of the component. Must be a
> +      unique string among multiple instances of the same component.
> +      The name can be "DSPK1" or "DSPKx", where x depends on the maximum

Sounds like a constraint.

> +      available instances on a Tegra SoC.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents
> +  - "#sound-dai-cells"
> +
> +examples:
> +  - |
> +    #include<dt-bindings/clock/tegra186-clock.h>
> +
> +    tegra_dspk1: dspk@2905000 {
> +        compatible = "nvidia,tegra186-dspk";
> +        reg = <0x2905000 0x100>;
> +        clocks = <&bpmp TEGRA186_CLK_DSPK1>;
> +        clock-names = "dspk";
> +        assigned-clocks = <&bpmp TEGRA186_CLK_DSPK1>;
> +        assigned-clock-parents = <&bpmp TEGRA186_CLK_PLL_A_OUT0>;
> +        assigned-clock-rates = <12288000>;
> +        #sound-dai-cells = <1>;
> +        sound-name-prefix = "DSPK1";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
> new file mode 100644
> index 0000000..a8a41ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
> @@ -0,0 +1,165 @@
> +# SPAT-License-Identifier: (GPL-2.0)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-admaif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra210 ADMAIF Device Tree Bindings
> +
> +description: |
> +  ADMAIF is the interface between ADMA and AHUB. Each ADMA channel
> +  that sends/receives data to/from AHUB must interface through an
> +  ADMAIF channel. ADMA channel sending data to AHUB pairs with ADMAIF
> +  Tx channel and ADMA channel receiving data from AHUB pairs with
> +  ADMAIF Rx channel.
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          const: nvidia,tegra210-admaif
> +      - items:
> +          const: nvidia,tegra186-admaif

These 2 can be a single enum.

> +      - items:
> +          - enum:
> +             - nvidia,tegra194-admaif
> +          - enum:
> +             - nvidia,tegra186-admaif
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas: true
> +
> +  dma-names: true
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: nvidia,tegra210-admaif
> +
> +then:
> +  properties:
> +    dmas:
> +      $ref: /schemas/types.yaml#/definitions/phandle-array

Drop. Common properties already have a type.

Plus this is wrong. A '$ref' means all other keywords are ignored (until 
we move to draft8).

> +      description:
> +        Two or more DMA channel specifiers, equally divided for Tx and Rx.
> +      minItems: 2
> +      maxItems: 20
> +    dma-names:
> +      $ref: /schemas/types.yaml#/definitions/string-array

drop

> +      description:
> +        There must be at least one channel named "tx1" for transmit and "rx1"
> +        for receive. If more channels need to be specified then "tx1",
> +        "tx2" ... "tx10" can be used. Similarly for Rx channels as well.

Sounds like constraints.


Stopping there. Similar issues on the rest...
