Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D34C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C22E206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1ZsFxEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgGVJZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbgGVJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:25:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9A5C0619DF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:25:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so1204250wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S6Nwi+XiUVd0OOIyZo0IP6xJ55suQgOnuZqnCWRgVZw=;
        b=g1ZsFxEhiRXbNG+ztNk0WYGgRisSQvFLGa/yPUpQjUqSBDBtusq0mYFHBpClTnZlfz
         56HUtteXZqUm44MRLvY1L9j2rJ6v6PhQxzGnPS7TrogZ8ctKQ0DqEynZRzaZRUANmizK
         Ou2NqUoa7f7xz03hrMTUnLNpOuAuUUyEsS4MhQ4X0jviUtTffEi60gMVhYrzY8w3tqNV
         OFeT2GOSmEL/FljwbYGBsndvTZi0Zec9Tf9HUzj9SqZY3nudj2vUHe8Uy/S724+gp5U5
         8wXaGZFKnGxOw1Np9U+SUy5OMBrXlJaKsqQCsDkyX1k/Ub/YSrAUI0lwFha/l+QCS/AW
         kyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6Nwi+XiUVd0OOIyZo0IP6xJ55suQgOnuZqnCWRgVZw=;
        b=EctkUCHZfMbhadiVBHhMJlYJzWyXuHZgV9FHlDFgrsMVomX+WmAFcehdRKjs6DMDhg
         OHwjRsJSPyCbrUS6pXiGAAnnmX5elHqh48Rx97GLYk2u4I2OBYQVSpPtWbgXXO3twlqy
         A+lxdOc9gj3HEPlCwJKtzTMNkXSMumwb9lmbSN19RlTlNW0P3U8WG+Ip75Yzl5GN5Re8
         UtFre4+sf3c5JHMbNJaFwmzW7KTALIcYB3hYqkPw6GhQqTvUdJpGyd2gTzGTs9rU+pnl
         VPHl4mZyUI1bCB03TdNC96Ss3hnH1pebAoZ4Sh7BHcob14WXACBrYpUNEV0h7i/83ekH
         pHcA==
X-Gm-Message-State: AOAM530BBzJhYZqXr/RPXa0TUHnJxZWFYeG/HufopmP/od/jFNNgyxjJ
        4cleWb55LaIPTDESvy5L2ZF95Q==
X-Google-Smtp-Source: ABdhPJxa2U+7moUvkrSiQntHeegnCBrblh3LM+LX5eVN9hCBMBrL1WonkQ67UXjlNdOw+x5Ykmp2fA==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr32484484wra.118.1595409923974;
        Wed, 22 Jul 2020 02:25:23 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x204sm3761989wmg.2.2020.07.22.02.25.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:25:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
References: <20200721104422.369368-1-cychiang@chromium.org>
 <20200721104422.369368-2-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c270a068-c96b-63ae-a5ca-ec2081924dac@linaro.org>
Date:   Wed, 22 Jul 2020 10:25:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200721104422.369368-2-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2020 11:44, Cheng-Yi Chiang wrote:
> Add devicetree bindings documentation file for sc7180 sound card.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>   .../bindings/sound/qcom,sc7180.yaml           | 130 ++++++++++++++++++
>   1 file changed, 130 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> new file mode 100644
> index 000000000000..82f9483276eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> @@ -0,0 +1,130 @@
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
> +description:
> +  This binding describes the SC7180 sound card which uses LPASS for audio.
> +
> +definitions:
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
> +properties:
> +  compatible:
> +    contains:
> +      const: qcom,sc7180-sndcard
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source.
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  aux-dev:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the codec for headset detection


Why do we need this? You should be able to set the jack for codec 
snd_soc_component_set_jack()?


> +
> +patternProperties:
> +  "^dai-link(@[0-9]+)?$":
> +    description:
> +      Each subnode represents a dai link. Subnodes of each dai links would be
> +      cpu/codec dais.
> +
> +    type: object
> +
> +    properties:
> +      link-name:
> +        description: Indicates dai-link name and PCM stream name.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        maxItems: 1
> +
> +      reg:
> +        description: dai link address.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maxItems: 1

Why do we need this?? I have not seen the parsing code using this.


> +
> +      playback-only:
> +        description: Specify that the dai link is only for playback.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      capture-only:
> +        description: Specify that the dai link is only for capture.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +

Are these because the cpu/codec dais are single directional?

If so you can extend snd_soc_dai_link_set_capabilities() and use this 
function.


--srini

> +      cpu:
> +        $ref: "#/definitions/dai"
> +
> +      codec:
> +        $ref: "#/definitions/dai"
> +
> +    required:
> +      - link-name
> +      - reg
> +      - cpu
> +      - codec
> +
> +    additionalProperties: false
> +
> +examples:
> +
> +  - |
> +    sound {
> +        compatible = "qcom,sc7180-sndcard";
> +        model = "sc7180-snd-card";
> +
> +        audio-routing =
> +                    "Headphone Jack", "HPOL",
> +                    "Headphone Jack", "HPOR";
> +
> +        aux-dev = <&alc5682>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dai-link@0 {
> +            reg = <0>;
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
> +        dai-link@1 {
> +            reg = <1>;
> +            link-name = "MultiMedia1";
> +            playback-only;
> +            cpu {
> +                sound-dai = <&lpass_cpu 1>;
> +            };
> +
> +            codec {
> +                sound-dai = <&max98357a>;
> +            };
> +        };
> +    };
> 
