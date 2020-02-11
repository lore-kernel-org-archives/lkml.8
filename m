Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDA1C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3272214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581444805;
	bh=3riax90X3cB1LTgwegasbmXkNo83BsShz5HQj87AsSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FzW0QVzcv8CAJLIaLix9+j2+YuE3OHxwvuJYcKyW5cjXYIb47lsRd6VMk8M8hwZnB
	 i+BPtQV9irGaZdqyEZdmXzhuTcCuuB4Kv3JqWvPaHq5iHekhAodZbTfvj9+QcCGn61
	 NoIBN4JKRPemoaeFO5yAIC1um1UnzMfLIqGwDsZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgBKSNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbgBKSNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:13:24 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9525D20848;
        Tue, 11 Feb 2020 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581444803;
        bh=3riax90X3cB1LTgwegasbmXkNo83BsShz5HQj87AsSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vKBQdf7sq8abEa5O+/jfAR/LrlO09VRq0Z8A4pR8a4/sVqTwKbBjz0b+jF4mKUjJz
         cbaIxk3EQNVW6V0EEQQtrPeEUrmfiWllfOzuhSsW7m9ur/R0BZ0zlVs25gOQg+kvxl
         W33tqbKqHX0dSPBeI6mowsfPGrsH3gclSmBnKwmI=
Received: by mail-qk1-f181.google.com with SMTP id z19so7970084qkj.5;
        Tue, 11 Feb 2020 10:13:23 -0800 (PST)
X-Gm-Message-State: APjAAAWG3QoKc+KzhcdfRy/wKBv0TJ2tG6+7dqEUajKaolfEUHHLwY+c
        ZLROSV2rixCO2iSyFLcyMB30ZELotSYPEYho5g==
X-Google-Smtp-Source: APXvYqwRNNy+ur96m7q6c3i3fkxvIT/TIzcSWdajVPSiLV011854FY1lIs7P3ivinO4cTTgIv5XuOleMFRvHINxetz0=
X-Received: by 2002:a37:6042:: with SMTP id u63mr6765137qkb.119.1581444802651;
 Tue, 11 Feb 2020 10:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20200130135040.22575-1-olivier.moysan@st.com> <20200206182125.GA23274@bogus>
 <843b9213-99c0-ec9f-bde6-4745a9cb6221@st.com>
In-Reply-To: <843b9213-99c0-ec9f-bde6-4745a9cb6221@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Feb 2020 12:13:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJECUKkvZ1rt=4p5sMku3id973drEqLDvMZp8Fr+wx9tA@mail.gmail.com>
Message-ID: <CAL_JsqJECUKkvZ1rt=4p5sMku3id973drEqLDvMZp8Fr+wx9tA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: stm32: convert sai to json-schema
To:     Olivier MOYSAN <olivier.moysan@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 7:42 AM Olivier MOYSAN <olivier.moysan@st.com> wrote:
>
> Hi Rob,
>
> On 2/6/20 7:21 PM, Rob Herring wrote:
> > On Thu, Jan 30, 2020 at 02:50:40PM +0100, Olivier Moysan wrote:
> >> Convert the STM32 SAI bindings to DT schema format using json-schema.
> >>
> >> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> >> ---
> >>   .../bindings/sound/st,stm32-sai.txt           | 107 ----------
> >>   .../bindings/sound/st,stm32-sai.yaml          | 193 ++++++++++++++++++
> >>   2 files changed, 193 insertions(+), 107 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
> >>   create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> >
> >> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> >> new file mode 100644
> >> index 000000000000..33dca007fc86
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> >> @@ -0,0 +1,193 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/sound/st,stm32-sai.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: STMicroelectronics STM32 Serial Audio Interface (SAI)
> >> +
> >> +maintainers:
> >> +  - Olivier Moysan <olivier.moysan@st.com>
> >> +
> >> +description:
> >> +  The SAI interface (Serial Audio Interface) offers a wide set of audio
> >> +  protocols as I2S standards, LSB or MSB-justified, PCM/DSP, TDM, and AC'97.
> >> +  The SAI contains two independent audio sub-blocks. Each sub-block has
> >> +  its own clock generator and I/O lines controller.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - st,stm32f4-sai
> >> +      - st,stm32h7-sai
> >> +
> >> +  reg:
> >> +    items:
> >> +      - description: Base address and size of SAI common register set.
> >> +      - description: Base address and size of SAI identification register set.
> >> +    minItems: 1
> >> +    maxItems: 2
> >> +
> >> +  ranges:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  resets:
> >> +    maxItems: 1
> >> +
> >> +  "#address-cells":
> >> +    const: 1
> >> +
> >> +  "#size-cells":
> >> +    const: 1
> >> +
> >> +  clocks:
> >> +    items:
> >> +      - description: pclk feeds the peripheral bus interface.
> >> +      - description: x8k, SAI parent clock for sampling rates multiple of 8kHz.
> >> +      - description: x11k, SAI parent clock for sampling rates multiple of 11.025kHz.
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      enum: [ pclk, x8k, x11k ]
> >> +    minItems: 3
> >> +    maxItems: 3
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - ranges
> >> +  - "#address-cells"
> >> +  - "#size-cells"
> >> +  - clocks
> >> +  - clock-names
> >> +
> >> +patternProperties:
> >> +  "^audio-controller@[0-9a-f]+$":
> >> +    type: object
> >> +    description:
> >> +      Two subnodes corresponding to SAI sub-block instances A et B
> >> +      can be defined. Subnode can be omitted for unsused sub-block.
> >> +
> >> +    properties:
> >> +      compatible:
> >> +        description: Compatible for SAI sub-block A or B.
> >> +        enum:
> >> +          - st,stm32-sai-sub-a
> >> +          - st,stm32-sai-sub-b
> > pattern: 'st,stm32-sai-sub-[ab]'
> I will change this in v2
> >> +
> >> +      "#sound-dai-cells":
> >> +        const: 0
> >> +
> >> +      reg:
> >> +        maxItems: 1
> >> +
> >> +      clocks:
> >> +        items:
> >> +          - description: sai_ck clock feeding the internal clock generator.
> >> +          - description: MCLK clock from a SAI set as master clock provider.
> >> +        minItems: 1
> >> +        maxItems: 2
> >> +
> >> +      clock-names:
> >> +        items:
> >> +          - const: sai_ck
> >> +          - const: MCLK
> >> +        minItems: 1
> >> +        maxItems: 2
> >> +
> >> +      dmas:
> >> +        items:
> >> +          - description: SAI sub-block is configured as a capture DAI.
> >> +          - description: SAI sub-block is configured as a playback DAI.
> >> +        minItems: 1
> >> +        maxItems: 1
> > This is defining that dmas has 2 entries, but then limits it to the 1st
> > entry only.
> dma can be either "rx" or "tx", but not both.
> Maybe, the following syntax is more appropriate:
>
>        dmas:
>          maxItems: 1
>
>        dma-names:
>          description: |
>            rx: SAI sub-block is configured as a capture DAI.
>            tx: SAI sub-block is configured as a playback DAI.
>          items:
>            - enum: [ rx, tx ]

Yes, but for a single entry you can drop 'items'.

>
> >> +
> >> +      dma-names:
> >> +        items:
> >> +          - enum: [ rx, tx ]
> >> +
> >> +      st,sync:
> >> +        description:
> >> +          Configure the SAI sub-block as slave of another SAI sub-block.
> >> +          By default SAI sub-block is in asynchronous mode.
> >> +          Must contain the phandle and index of the SAI sub-block providing
> >> +          the synchronization.
> >> +        allOf:
> >> +          - $ref: /schemas/types.yaml#definitions/phandle-array
> >> +          - maxItems: 1
> >> +
> >> +      st,iec60958:
> >> +        description:
> >> +          If set, support S/PDIF IEC6958 protocol for playback.
> >> +          IEC60958 protocol is not available for capture.
> >> +          By default, custom protocol is assumed, meaning that protocol is
> >> +          configured according to protocol defined in related DAI link node,
> >> +          such as i2s, left justified, right justified, dsp and pdm protocols.
> >> +        allOf:
> >> +          - $ref: /schemas/types.yaml#definitions/flag
> >> +
> >> +      "#clock-cells":
> >> +        description: Configure the SAI device as master clock provider.
> >> +        const: 0
> >> +
> >> +    required:
> >> +      - compatible
> >> +      - "#sound-dai-cells"
> >> +      - reg
> >> +      - clocks
> >> +      - clock-names
> >> +      - dmas
> >> +      - dma-names
> >         additionalProperties: false.
> >
> >> +
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: st,stm32f4-sai
> >> +
> >> +  - then:
> >> +      properties:
> >> +        clocks:
> >> +          minItems: 2
> >> +          maxItems: 2
> >> +
> >> +        clock-names:
> >> +          items:
> >> +            enum: [ x8k, x11k ]
> > Define the order.
> >
> Do you mean, adding in clocks property  :
>            items:
>              - description: x8k, SAI parent clock for sampling rates
> multiple of 8kHz.
>              - description: x11k, SAI parent clock for sampling rates
> multiple of 11.025kHz.

That too, but for clocks you need:

clock-names:
  items:
    - const: x8k
    - const: x11k

> But, it seems to me that this is redundant with previous definition of
> clocks property.

It's not because it's clocks in different positions.

Rob
