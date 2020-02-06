Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB7C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AEE21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581021997;
	bh=RIXzSC/Yx6TSAl43hZuBU3X4Fmg/LdplpGCerMtOYEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1P6mOmhRSgVKP4YmCbhu3Z7hXKDEowRIEWajW4/+0DjCSH0QqaCIHDRh/o4xvVOVx
	 rbd/9QRRRW6+M/VhU+VNPoZdG58SwsY4yEPmufPxx3ntBrBaUWXLLhoxUdKLPg1vQt
	 M8XPpHKnD1S2IYNNR2b9KC8cIcJee3fS6q6XCHDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBFUqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:46:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34089 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgBFUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:46:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so655852pjq.1;
        Thu, 06 Feb 2020 12:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+JpCejRz9cTdKzvN/s1Lqz/r+3bLOvKPVHP2ixVIjaA=;
        b=mVWTbWIJa+9uidc0xClrpGq9nebOy0fSzasU8gzahG9t41Yn4VFswlgqSbhU5hj6rd
         Ik1hXM3UrpI6Ageki0wRLXtXr/w2zWiv8nvcZ1qnK6YzaTtDffuxvFyek3aIKQJoeYwH
         s2ihrvUJh4y/xB9GD/Z11gWOqEIwwTPtp69Rwb8PV2eK/GjDk1pJmZdJ5VAAF+hTW9LJ
         PB3kzlEZgeUTI5qY1X9mf6v7J0u7JwFNKmfZQuGKaRLmL4dnWRxptCezKnSa5a7BQ5E7
         uUlpkGOANciVIccMdRUS3uMg7DNLJnOMHMuF4Ll+rmmmLUwyDYBpI9YAuK01dVTA+PJW
         J/mQ==
X-Gm-Message-State: APjAAAWe+rYTGAk6zO/sy77vc4uvnmEfNP0yeQwuHW7wxKaCKKBOtBP2
        TEFJMvI7YdqInvEjeKKX3w==
X-Google-Smtp-Source: APXvYqwbC73hm+Agme/rCp48d6/0xYRA1eDWiKJsCgthOldvBiGk6RxTKAWpaJjx1M145Mgn2+p7Ag==
X-Received: by 2002:a17:902:504:: with SMTP id 4mr5425237plf.276.1581021989698;
        Thu, 06 Feb 2020 12:46:29 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id g7sm288861pfq.33.2020.02.06.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:29 -0800 (PST)
Received: (nullmailer pid 9682 invoked by uid 1000);
        Thu, 06 Feb 2020 18:21:25 -0000
Date:   Thu, 6 Feb 2020 18:21:25 +0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: stm32: convert sai to json-schema
Message-ID: <20200206182125.GA23274@bogus>
References: <20200130135040.22575-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130135040.22575-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 02:50:40PM +0100, Olivier Moysan wrote:
> Convert the STM32 SAI bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../bindings/sound/st,stm32-sai.txt           | 107 ----------
>  .../bindings/sound/st,stm32-sai.yaml          | 193 ++++++++++++++++++
>  2 files changed, 193 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml


> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> new file mode 100644
> index 000000000000..33dca007fc86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> @@ -0,0 +1,193 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/st,stm32-sai.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Serial Audio Interface (SAI)
> +
> +maintainers:
> +  - Olivier Moysan <olivier.moysan@st.com>
> +
> +description:
> +  The SAI interface (Serial Audio Interface) offers a wide set of audio
> +  protocols as I2S standards, LSB or MSB-justified, PCM/DSP, TDM, and AC'97.
> +  The SAI contains two independent audio sub-blocks. Each sub-block has
> +  its own clock generator and I/O lines controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stm32f4-sai
> +      - st,stm32h7-sai
> +
> +  reg:
> +    items:
> +      - description: Base address and size of SAI common register set.
> +      - description: Base address and size of SAI identification register set.
> +    minItems: 1
> +    maxItems: 2
> +
> +  ranges:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: pclk feeds the peripheral bus interface.
> +      - description: x8k, SAI parent clock for sampling rates multiple of 8kHz.
> +      - description: x11k, SAI parent clock for sampling rates multiple of 11.025kHz.
> +
> +  clock-names:
> +    items:
> +      enum: [ pclk, x8k, x11k ]
> +    minItems: 3
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +
> +patternProperties:
> +  "^audio-controller@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Two subnodes corresponding to SAI sub-block instances A et B
> +      can be defined. Subnode can be omitted for unsused sub-block.
> +
> +    properties:
> +      compatible:
> +        description: Compatible for SAI sub-block A or B.
> +        enum:
> +          - st,stm32-sai-sub-a
> +          - st,stm32-sai-sub-b

pattern: 'st,stm32-sai-sub-[ab]'

> +
> +      "#sound-dai-cells":
> +        const: 0
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        items:
> +          - description: sai_ck clock feeding the internal clock generator.
> +          - description: MCLK clock from a SAI set as master clock provider.
> +        minItems: 1
> +        maxItems: 2
> +
> +      clock-names:
> +        items:
> +          - const: sai_ck
> +          - const: MCLK
> +        minItems: 1
> +        maxItems: 2
> +
> +      dmas:
> +        items:
> +          - description: SAI sub-block is configured as a capture DAI.
> +          - description: SAI sub-block is configured as a playback DAI.
> +        minItems: 1
> +        maxItems: 1

This is defining that dmas has 2 entries, but then limits it to the 1st 
entry only.

> +
> +      dma-names:
> +        items:
> +          - enum: [ rx, tx ]
> +
> +      st,sync:
> +        description:
> +          Configure the SAI sub-block as slave of another SAI sub-block.
> +          By default SAI sub-block is in asynchronous mode.
> +          Must contain the phandle and index of the SAI sub-block providing
> +          the synchronization.
> +        allOf:
> +          - $ref: /schemas/types.yaml#definitions/phandle-array
> +          - maxItems: 1
> +
> +      st,iec60958:
> +        description:
> +          If set, support S/PDIF IEC6958 protocol for playback.
> +          IEC60958 protocol is not available for capture.
> +          By default, custom protocol is assumed, meaning that protocol is
> +          configured according to protocol defined in related DAI link node,
> +          such as i2s, left justified, right justified, dsp and pdm protocols.
> +        allOf:
> +          - $ref: /schemas/types.yaml#definitions/flag
> +
> +      "#clock-cells":
> +        description: Configure the SAI device as master clock provider.
> +        const: 0
> +
> +    required:
> +      - compatible
> +      - "#sound-dai-cells"
> +      - reg
> +      - clocks
> +      - clock-names
> +      - dmas
> +      - dma-names

       additionalProperties: false.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32f4-sai
> +
> +  - then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            enum: [ x8k, x11k ]

Define the order.

> +          minItems: 2
> +          maxItems: 2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    sai1: sai@4400a000 {
> +      compatible = "st,stm32h7-sai";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0 0x4400a000 0x400>;
> +      reg = <0x4400a000 0x4>, <0x4400a3f0 0x10>;
> +      interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&rcc SAI1>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
> +      clock-names = "pclk", "x8k", "x11k";
> +      resets = <&rcc SAI1_R>;
> +
> +      sai1a: audio-controller@4400a004 {
> +        compatible = "st,stm32-sai-sub-a";
> +        #sound-dai-cells = <0>;
> +        reg = <0x4 0x1c>;
> +        clocks = <&rcc SAI1_K>;
> +        clock-names = "sai_ck";
> +        dmas = <&dmamux1 87 0x400 0x01>;
> +        dma-names = "tx";
> +      };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
