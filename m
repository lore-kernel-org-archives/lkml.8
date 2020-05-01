Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF2FC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7972820787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588363635;
	bh=2uziUSHJmNqySrfaFlykT76ZKo5dSuMGro2/1PoILRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zYMPCGTc3AUJvIDkfSb289ki+JJDeTxChAd4S9R2I7/tTI5BvnrUvaU9cqawVctqp
	 SYUXaEz8KkojgW0HkEBmFW/Ly9Axk1AP//ddiQevwbLSA9rN8lqb52d2Iz61+oNqPE
	 GX4FetObCuYkaXWUZ1sP2zaUpFszyrogAOUHPKQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEAUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:07:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35147 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:07:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id o7so762968oif.2;
        Fri, 01 May 2020 13:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OZmL6pHrV2p1Bxgz7svMOgmRRS5pUlroNV1WaQOUaxQ=;
        b=TqaDUxvN7jdrlMbeeDthdMVRQpzt9OWMSbELaGlMGv6KQOU1KKH/0ji6H3eVg0s48j
         Rc12LZP5SbFjjLKuXCTeOmcDTLaCIP9A5a7lsTwgGKrNCbvNqTkb/LjbJNd8b67/gUND
         8LAErhoBfAPgXA9umUXJMzvLKAhFa1++wMQ9MgjhVtnM+NCPq4qou8Qps1uxdZRNERyv
         4DhuZZZcvwoyz20MEZBXVnnROZyH602ZE7gt2UineZD6pOB85Fuc7VLpKc8/XepYhL1P
         TptiFhKOHfz7cC4JQ1mgabbGqoJP+XWb1dtRfZU5fORlgQ7kZtGLLJRI8sQvCIKDDtIA
         dRTA==
X-Gm-Message-State: AGi0PuY5iEK78XQWh6bMwq/nRn/49LfkXvmrqnjSyDtFurxBYHTFp0/P
        HDDjJEDTJaCTFRstkqSafQ==
X-Google-Smtp-Source: APiQypLUn2+MduxPj4oNeoQvxlzltP4rKeE6pd1r2NWqUGvaeJ2zkquejlimjcK5+QvQvNQFomWbBw==
X-Received: by 2002:aca:4a45:: with SMTP id x66mr970859oia.48.1588363632490;
        Fri, 01 May 2020 13:07:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a27sm1077844oos.37.2020.05.01.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:07:05 -0700 (PDT)
Received: (nullmailer pid 7973 invoked by uid 1000);
        Fri, 01 May 2020 20:06:52 -0000
Date:   Fri, 1 May 2020 15:06:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: ak4613: switch to yaml base
 Documentation
Message-ID: <20200501200652.GA13287@bogus>
References: <87imhtv2mh.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imhtv2mh.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:17:43PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/sound/ak4613.txt      | 27 --------
>  .../devicetree/bindings/sound/ak4613.yaml     | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4613.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4613.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
> deleted file mode 100644
> index 49a2e74fd9cb..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak4613.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -AK4613 I2C transmitter
> -
> -This device supports I2C mode only.
> -
> -Required properties:
> -
> -- compatible : "asahi-kasei,ak4613"
> -- reg : The chip select number on the I2C bus
> -
> -Optional properties:
> -- asahi-kasei,in1-single-end	: Boolean. Indicate input / output pins are single-ended.
> -- asahi-kasei,in2-single-end	  rather than differential.
> -- asahi-kasei,out1-single-end
> -- asahi-kasei,out2-single-end
> -- asahi-kasei,out3-single-end
> -- asahi-kasei,out4-single-end
> -- asahi-kasei,out5-single-end
> -- asahi-kasei,out6-single-end
> -
> -Example:
> -
> -&i2c {
> -	ak4613: ak4613@10 {
> -		compatible = "asahi-kasei,ak4613";
> -		reg = <0x10>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ak4613.yaml b/Documentation/devicetree/bindings/sound/ak4613.yaml
> new file mode 100644
> index 000000000000..b5929239505e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak4613.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ak4613.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK4613 I2C transmitter Device Tree Bindings
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +properties:
> +  compatible:
> +    const: asahi-kasei,ak4613
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  # for OF-graph
> +  port:
> +    $ref: "audio-graph-card.yaml#definitions/port"
> +  ports:
> +    $ref: "audio-graph-card.yaml#definitions/ports"

There was no indication any of this applied on the old binding.

I'd rather not get into these arbitrary custom definitions. I think the 
above file probably needs to be split between the card and codec 
schemas. Then in each codec you have just:

allOf:
  - $ref: audio-codec.yaml#

A codec binding should work whether the codec is part of a simple-card 
or graph-card.

> +
> +# use patternProperties to avoid naming "xxx,yyy" issue

What's the issue other than you need a 'description'?

We need to fix it rather than find holes in the meta-schema.

> +patternProperties:
> +  "^asahi-kasei,in1-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,in2-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out1-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out2-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out3-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out4-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out5-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out6-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag

Though you could make these an actual pattern: in[1-2] and out[1-6]

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        ak4613: ak4613@10 {

audio-codec@10

> +            compatible = "asahi-kasei,ak4613";
> +            reg = <0x10>;
> +        };
> +    };
> -- 
> 2.17.1
> 
