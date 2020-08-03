Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865E220678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bw8H8gOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgHCIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHCIk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:40:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F39C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:40:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so13433192wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq5+lj+HxdPKUksR7gRNmns7ju/WhDWUsP3NFKOReq8=;
        b=Bw8H8gOuWbx14/g/EG6O1Y8+gAH1srU5wsQImYaHnDeDvfgbsnQKLIlyY2i6Yk44la
         kqnaNemfWLvh+APs8IfLgZPvzxWXxtXUuHX7Ic8rW+ccSp6HA2zUh8KrW1aoQICqaqJq
         DX4cOJ6oyKiLOXjJwV24MKgUSxxNtoZN9DJvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq5+lj+HxdPKUksR7gRNmns7ju/WhDWUsP3NFKOReq8=;
        b=n0DuOo9Mlo8iNNYWJx8NCdO2299/B450j22dMZAt/tFxvdhh3usJCHwyZ1rDTh7Y6/
         IITYALrBldLDdwQHkR9C3PFkKg2A2Lj0O7DAUKxX0b/lB5CMzl2iS8H5wCXen2RZoDk/
         hHq4d67kYQyxFqXA2r0a1gPiPR2oCbfQDej2OoRw/yNy8ij5BxAQDzY+fUMz6kfNDP45
         8y0GnOhByvLZgkHAy9IljfSlA1eRgIc9lCyECY47ld0bqe+yLe6gzYKVy3hElfqd3i/j
         6W2uVpSy+8xgcWPSWmUWR2BGgIGgH2nW/9qwVTKQgzFwPgWtIwrjLxURuVYOvG8eP9MO
         3XmA==
X-Gm-Message-State: AOAM5333YgSz+jqC5/QbTzPtRMBL7n0iBDZgnICZP4BQ78CIEC7thvTv
        bq+wiZ6dmZ2zvG0ZybeJDMWlNtLCu7Fb/uHUS6Yp2SYSJh8IRA==
X-Google-Smtp-Source: ABdhPJyAahynHEVEn2oNVJMFau2e96vW5t5i5ugRhfFM5wveqNbnogUdLR+Dmsz70dO7HSAwUKUwpj9F129+6y4tr7I=
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr14528398wmh.42.1596444027706;
 Mon, 03 Aug 2020 01:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200731084023.2678931-1-cychiang@chromium.org>
 <20200731084023.2678931-2-cychiang@chromium.org> <20200731183248.GB531472@bogus>
In-Reply-To: <20200731183248.GB531472@bogus>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 3 Aug 2020 16:40:00 +0800
Message-ID: <CAFv8Nw+e=tO+720-CDXy2Fk84qxk2C2Tbrh19ngmsBRY4D1M1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:32 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jul 31, 2020 at 04:40:22PM +0800, Cheng-Yi Chiang wrote:
> > Add devicetree bindings documentation file for sc7180 sound card.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> > new file mode 100644
> > index 000000000000..ce8a5a2d9df9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> > @@ -0,0 +1,113 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
> > +
> > +maintainers:
> > +  - Rohit kumar <rohitkr@codeaurora.org>
> > +  - Cheng-Yi Chiang <cychiang@chromium.org>
> > +
> > +description:
> > +  This binding describes the SC7180 sound card which uses LPASS for audio.
> > +
> > +definitions:
>
> Please don't use 'definitions'. Either just duplicate it or you can do
> 'patternProperties'.
>
Removed dai definition in v4.
> > +
> > +  dai:
> > +    type: object
> > +    properties:
> > +      sound-dai:
> > +        maxItems: 1
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        description: phandle array of the codec or CPU DAI
>
> This is a common property. You can assume we have a common schema
> definition for it. IOW, 'sound-dai: true' is enough as it's always a
> single phandle+args.
>
In the examples I found,
Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml,
Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml
use:

      sound-dai:
        $ref: /schemas/types.yaml#/definitions/phandle
        description: phandle of the CPU DAI

Documentation/devicetree/bindings/sound/simple-card.yaml
just use

      sound-dai:
        maxItems: 1

In v4, I used 'sound-dai: true' as suggested.

But I am a bit confused about assuming there is a common schema
definition for it.
I checked the code at https://github.com/devicetree-org/dt-schema but
did not found the definition for it.
Did I miss something here ?

Thanks for the help!

> > +
> > +    required:
> > +      - sound-dai
> > +
> > +properties:
> > +  compatible:
> > +    contains:
> > +      const: qcom,sc7180-sndcard
> > +
> > +  audio-routing:
> > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > +    description:
> > +      A list of the connections between audio components. Each entry is a
> > +      pair of strings, the first being the connection's sink, the second
> > +      being the connection's source.
> > +
> > +  model:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: User specified audio sound card name
> > +
> > +  aux-dev:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle of the codec for headset detection
> > +
> > +patternProperties:
> > +  "^dai-link(@[0-9]+)?$":
> > +    description:
> > +      Each subnode represents a dai link. Subnodes of each dai links would be
> > +      cpu/codec dais.
> > +
> > +    type: object
> > +
> > +    properties:
> > +      link-name:
> > +        description: Indicates dai-link name and PCM stream name.
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        maxItems: 1
> > +
> > +      cpu:
> > +        $ref: "#/definitions/dai"
> > +
> > +      codec:
> > +        $ref: "#/definitions/dai"
> > +
> > +    required:
> > +      - link-name
> > +      - cpu
> > +      - codec
> > +
> > +    additionalProperties: false
> > +
> > +examples:
> > +
> > +  - |
> > +    sound {
> > +        compatible = "qcom,sc7180-sndcard";
> > +        model = "sc7180-snd-card";
> > +
> > +        audio-routing =
> > +                    "Headphone Jack", "HPOL",
> > +                    "Headphone Jack", "HPOR";
> > +
> > +        aux-dev = <&alc5682>;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dai-link@0 {
> > +            link-name = "MultiMedia0";
> > +            cpu {
> > +                sound-dai = <&lpass_cpu 0>;
> > +            };
> > +
> > +            codec {
> > +                sound-dai = <&alc5682 0>;
> > +            };
> > +        };
> > +
> > +        dai-link@1 {
> > +            link-name = "MultiMedia1";
> > +            cpu {
> > +                sound-dai = <&lpass_cpu 1>;
> > +            };
> > +
> > +            codec {
> > +                sound-dai = <&max98357a>;
> > +            };
> > +        };
> > +    };
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
