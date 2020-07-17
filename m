Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B16C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837192076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YooeeixG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGQPCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgGQPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:02:03 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:02:03 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id o184so5020977vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Aj8c3ItAShnnsLNIQ3E8MXZ0tu8sMgycVZ8H2IhzgY=;
        b=YooeeixG0/jkhNIRHh3/Ok41dsT/OX3z2lbp1dsvYYWgOvjgGAeQzWt4/nwPKnz3Mv
         uXq028FmcWMT8/xVvpnT5J5b/dVVSVDK5eofaCaIcodv7fnB3wrg/uKVe0+25lcrLv/3
         WamTri+dPxncC4RrX/4vmXrs97xe8dnN1V6/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Aj8c3ItAShnnsLNIQ3E8MXZ0tu8sMgycVZ8H2IhzgY=;
        b=qM/o6alGjJnTr72o7RIEbUaxi8IoR8eJCa3k2uRsq1xJVKkrLiGo8pTotICLOdk2Cl
         TrSJYas2Sg8yTFUYxfrBR6/wES9UOGJV3Y8KihghhrTgWlXEDXcDYzZOVRwUdupkgb+/
         XFh3AWeNDRc+W6yi33PrXC5C7SA1hT7Vh+BFNTm7tbgX5gydSFRPm2vRGbmgdgTH/F7Q
         Wi0mVXLW96Wc7JgvQ7sVHgGhzDUyWwUYRovA0XzhwUyw51L5yLaLp42jPy1cCd61JoFM
         MOBxKYdzP89N4sTyS1jtCH9un8kQq0iyostgpEJU7BGvDIicqf2fkyq/CA74XB3vEYdK
         WwqQ==
X-Gm-Message-State: AOAM530I5MES24QHKkCHSANCFNacO9DI/KqyEN1Capt37hnSs+EpwbFJ
        1IgfRprSyWB1+Vjpr2uXyJ6EAWf/qts=
X-Google-Smtp-Source: ABdhPJy7O+bw4zKk010n6WGdPbRnF9nzJI0NB9TjS0Y5WCQzF5oX9slC0bFwwjQttMMpqxOrO1GE0A==
X-Received: by 2002:a67:fe8e:: with SMTP id b14mr7884909vsr.133.1594998122196;
        Fri, 17 Jul 2020 08:02:02 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id v63sm1325867vkf.45.2020.07.17.08.02.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 08:02:01 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id q85so2179618vke.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:02:00 -0700 (PDT)
X-Received: by 2002:a1f:3d4a:: with SMTP id k71mr7624402vka.65.1594998119832;
 Fri, 17 Jul 2020 08:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200717120207.3471030-1-cychiang@chromium.org>
In-Reply-To: <20200717120207.3471030-1-cychiang@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jul 2020 08:01:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFayyvT-b9C3f4pXNkboH7kb7ikyi9qJxmNvowOfkjqQ@mail.gmail.com>
Message-ID: <CAD=FV=XFayyvT-b9C3f4pXNkboH7kb7ikyi9qJxmNvowOfkjqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 17, 2020 at 5:02 AM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Add devicetree bindings documentation file for sc7180 sound card.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/qcom,sc7180.yaml           | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)

A bit of a mechanical review since my audio knowledge is not strong.


>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> new file mode 100644
> index 000000000000..d60d2880d991
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
> +
> +maintainers:
> +  - Rohit kumar <rohitkr@codeaurora.org>
> +  - Cheng-Yi Chiang <cychiang@chromium.org>
> +
> +description: |
> +  This binding describes the SC7180 sound card, which uses LPASS for audio.

nit: you don't need the pipe at the end of the "description" line.
That means that newlines are important and you don't need it.


> +definitions:

I haven't yet seen much yaml using definitions like this.  It feels
like overkill for some of these properties, especially ones that are
only ever used once in the "properties:" section and are/or are really
simple.


> +  link-name:
> +    description: Indicates dai-link name and PCM stream name.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    maxItems: 1
> +
> +  dai:
> +    type: object
> +    properties:
> +      sound-dai:
> +        maxItems: 1
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: phandle array of the codec or CPU DAI
> +
> +    required:
> +      - sound-dai
> +
> +  unidirectional:
> +    description: Specify direction of unidirectional dai link.
> +                 0 for playback only. 1 for capture only.
> +    $ref: /schemas/types.yaml#/definitions/uint32

So if the property isn't there then it's _not_ unidirectional and if
it is there then this specifies the direction, right?  I almost wonder
if this should just be two boolean properties, like:

playback-only;
capture-only;

...but I guess I'd leave it to Rob and/or Mark to say what they liked
better.  In any case if you keep it how you have it then you should
use yaml to force it to be either 0 or 1 if present.


> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - qcom,sc7180-sndcard

Just:

properties:
  compatible:
    const: qcom,sc7180-sndcard



> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |-
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source.

You don't need the "|-" after the "description:".  That says newlines
are important but strip the newline from the end.


> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +patternProperties:
> +  "^dai-link-[0-9]+$":
> +    description: |
> +      Each subnode represents a dai link. Subnodes of each dai links would be
> +      cpu/codec dais.

From looking at "simple-card.yaml", I'm gonna guess that instead of
encoding the link number in the name of the node that you should
actually use a unit address and a reg in the subnodes.

...also, again your description doesn't need the "|" at the end.
Maybe <https://yaml-multiline.info/> will be useful to you?


> +    type: object
> +
> +    properties:
> +      link-name:
> +        $ref: "#/definitions/link-name"
> +
> +      unidirectional:
> +        $ref: "#/definitions/unidirectional"
> +
> +      cpu:
> +        $ref: "#/definitions/dai"
> +
> +      codec:
> +        $ref: "#/definitions/dai"
> +
> +    required:
> +      - link-name
> +      - cpu
> +      - codec
> +
> +    additionalProperties: false
> +
> +examples:
> +
> +  - |
> +    snd {

Can you use the full node name "sound" here?


> +        compatible = "qcom,sc7180-sndcard";
> +        model = "sc7180-snd-card";
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&sec_mi2s_active &sec_mi2s_dout_active
> +                     &sec_mi2s_ws_active &pri_mi2s_active
> +                     &pri_mi2s_dout_active &pri_mi2s_ws_active
> +                     &pri_mi2s_din_active &pri_mi2s_mclk_active>;

I think pinctrl is usually not in the dt examples.

...also, shouldn't the mi2s pinctrl be in the i2s nodes, not in the
overall sound node?


> +        audio-routing =
> +                    "Headphone Jack", "HPOL",
> +                    "Headphone Jack", "HPOR";
> +
> +        dai-link-0 {
> +            link-name = "MultiMedia0";
> +            cpu {
> +                sound-dai = <&lpass_cpu 0>;
> +            };
> +
> +            codec {
> +                sound-dai = <&alc5682 0>;
> +            };
> +        };
> +
> +        dai-link-1 {
> +            link-name = "MultiMedia1";
> +            unidirectional = <0>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 1>;
> +            };
> +
> +            codec {
> +                sound-dai = <&max98357a>;
> +            };
> +        };
> +    };
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>
