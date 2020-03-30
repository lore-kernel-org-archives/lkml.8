Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE82FC2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8020714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585597200;
	bh=RKSM/K6qKTbNRXtkVhC4q4/tipZmWkOQEDJ0CHGO8MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2X7QCb7BcTMu2OBhTA4fCKm2P4wEYqRJqzkEJOySual0/cV628+tx3axh8Qln664v
	 jcRTr4hNye2D0M3XjrHw1C/6YyFfyasXa96fd6GTwgC8XSsY4vua6+SYuCl5bKdvx1
	 OFTDz1jcsZnDu8X7IvrKr2vFaxamOXruS3scgfP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgC3Tj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:39:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41068 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgC3Tj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:39:59 -0400
Received: by mail-io1-f67.google.com with SMTP id b12so2920482ion.8;
        Mon, 30 Mar 2020 12:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=clmsQJK4BMI8m2Z/sWQrrUlWM9WX3L6ITcoHrmc1DJw=;
        b=DezW00cMQvF7/esf4lzX5Vg+OPyy18TJkFa/i6KxW0RVcOBs8eUpkMgFksL4OtaWJW
         i4AL7Pz/am/rgfcwz+ZGLYQ5NRFdcrVTp/rEgOvNBYxwOt5YorRrA6aTpcccOxXC6Fzu
         Dkd845BCk/kXrP7V0B6js9I0ElQl0URaVq76ec1MRMdh6zuNcJCtYaUL+p98gzAqmGXM
         CPB6lkOIYidwqgAdhAw1bWTqg+1gaZQOKFbnKCGFg2c41nKvkO5Ini8HFtO6bjupOm30
         K6yH1/lGEr51EHB6n+DIrgysen1UsIOfJv9pVByB7IoXiLxbdJb97iavwrT2mZhVQCy0
         eatA==
X-Gm-Message-State: ANhLgQ1KZ4O0QoSdcOoHU0cXU03NRwoNQrX5GGuv3o53Ev/6cIU6q1RM
        MnvzNSgmuILzCgZJXI+nbg==
X-Google-Smtp-Source: ADFU+vuJvWcNlXMQdJNMUkyw9q7uDOBjMSajkXwEQcU+iQ0lcBY6IAptPDeVBvzuz6t96cWWyprB8g==
X-Received: by 2002:a6b:d609:: with SMTP id w9mr12027791ioa.41.1585597196788;
        Mon, 30 Mar 2020 12:39:56 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l70sm5226774ili.81.2020.03.30.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 12:39:55 -0700 (PDT)
Received: (nullmailer pid 12120 invoked by uid 1000);
        Mon, 30 Mar 2020 19:39:53 -0000
Date:   Mon, 30 Mar 2020 13:39:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: dt-bindings: simple-card: switch to yaml base
 Documentation
Message-ID: <20200330193953.GA22908@bogus>
References: <871rpsq3bx.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rpsq3bx.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:24:50PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> This patch is assuming that "sound-dai" is already defined.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
> 	- uses maxItems for many place which were already defined.
> 	- assuming that "sound-dai" is already defined
> 	- (@.*) -> (@[0-9a-f]+)
> 
>  .../devicetree/bindings/sound/simple-card.txt | 351 -------------
>  .../bindings/sound/simple-card.yaml           | 487 ++++++++++++++++++
>  2 files changed, 487 insertions(+), 351 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.yaml

> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> new file mode 100644
> index 000000000000..cd5ea50daa22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -0,0 +1,487 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/simple-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Audio Card Driver Device Tree Bindings
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +definitions:
> +
> +  frame-master:
> +    description: Indicates dai-link frame master.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - maxItems: 1
> +
> +  bitclock-master:
> +    description: Indicates dai-link bit clock master
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - maxItems: 1
> +
> +  frame-inversion:
> +    description: dai-link uses frame clock inversion
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  bitclock-inversion:
> +    description: dai-link uses bit clock inversion
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  dai-tdm-slot-num:
> +    description: see tdm-slot.txt.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  dai-tdm-slot-width:
> +    description: see tdm-slot.txt.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  clocks:
> +    maxItems: 1

Only used in one place, just move there.

> +
> +  system-clock-frequency:
> +    description: |
> +      If a clock is specified and a multiplication factor is given with
> +      mclk-fs, the clock will be set to the calculated mclk frequency
> +      when the stream starts.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  system-clock-direction-out:
> +    description: |
> +      specifies clock direction as 'out' on initialization.
> +      It is useful for some aCPUs with fixed clocks.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  mclk-fs:
> +    description: |
> +      Multiplication factor between stream rate and codec mclk.
> +      When defined, mclk-fs property defined in dai-link sub nodes are ignored.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  aux-devs:
> +    description: |
> +      List of phandles pointing to auxiliary devices, such
> +      as amplifiers, to be added to the sound card.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  convert-rate:
> +    description: CPU to Codec rate convert.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  convert-channels:
> +    description: CPU to Codec rate channels.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  prefix:
> +    description: "device name prefix"
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  label:
> +    maxItems: 1
> +
> +  routing:
> +    description: |
> +      A list of the connections between audio components.
> +      Each entry is a pair of strings, the first being the
> +      connection's sink, the second being the connection's source.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +
> +  widgets:
> +    description: User specified audio sound widgets.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +
> +  pin-switches:
> +    description: the widget names for which pin switches must be created.
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  format:
> +    description: audio format.
> +    items:
> +      enum:
> +        - i2s
> +        - right_j
> +        - left_j
> +        - dsp_a
> +        - dsp_b
> +        - ac97
> +        - pdm
> +        - msb
> +        - lsb
> +
> +  dai:
> +    type: object
> +    properties:
> +      sound-dai:
> +        maxItems: 1
> +
> +      # common properties
> +      mclk-fs:
> +        $ref: "#/definitions/mclk-fs"
> +      prefix:
> +        $ref: "#/definitions/prefix"
> +      frame-inversion:
> +        $ref: "#/definitions/frame-inversion"
> +      bitclock-inversion:
> +        $ref: "#/definitions/bitclock-inversion"
> +      frame-master:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +      bitclock-master:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      dai-tdm-slot-num:
> +        $ref: "#/definitions/dai-tdm-slot-num"
> +      dai-tdm-slot-width:
> +        $ref: "#/definitions/dai-tdm-slot-width"
> +      clocks:
> +        $ref: "#/definitions/clocks"
> +      system-clock-frequency:
> +        $ref: "#/definitions/system-clock-frequency"
> +      system-clock-direction-out:
> +        $ref: "#/definitions/system-clock-direction-out"
> +    required:
> +      - sound-dai
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - simple-audio-card
> +        - simple-scu-audio-card
> +
> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 0
> +
> +  label:
> +    $ref: "#/definitions/label"
> +
> +  simple-audio-card,name:
> +    description: User specified audio sound card name.
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +# use patternProperties to use "#definitions/xxx"

Huh? The meta-schema gives you an error? We should fix that, not 
work-around it.

> +patternProperties:
> +  "^simple-audio-card,widgets$":
> +    $ref: "#/definitions/widgets"
> +  "^simple-audio-card,routing$":
> +    $ref: "#/definitions/routing"
> +  "^simple-audio-card,cpu(@[0-9a-f]+)?":
> +    $ref: "#/definitions/dai"
> +  "^simple-audio-card,codec(@[0-9a-f]+)?":
> +    $ref: "#/definitions/dai"
> +
> +  # common properties
> +  "^simple-audio-card,frame-master$":
> +    $ref: "#/definitions/frame-master"
> +  "^simple-audio-card,bitclock-master$":
> +    $ref: "#/definitions/bitclock-master"
> +  "^simple-audio-card,frame-inversion$":
> +    $ref: "#/definitions/frame-inversion"
> +  "^simple-audio-card,bitclock-inversion$":
> +    $ref: "#/definitions/bitclock-inversion"
> +  "^simple-audio-card,format$":
> +    $ref: "#/definitions/format"
> +  "^simple-audio-card,mclk-fs$":
> +    $ref: "#/definitions/mclk-fs"
> +  "^simple-audio-card,aux-devs$":
> +    $ref: "#/definitions/aux-devs"
> +  "^simple-audio-card,convert-rate$":
> +    $ref: "#/definitions/convert-rate"
> +  "^simple-audio-card,convert-channels$":
> +    $ref: "#/definitions/convert-channels"
> +  "^simple-audio-card,prefix$":
> +    $ref: "#/definitions/prefix"
> +  "^simple-audio-card,pin-switches$":
> +    $ref: "#/definitions/pin-switches"
> +  "^simple-audio-card,hp-det-gpio$":
> +    maxItems: 1
> +  "^simple-audio-card,mic-det-gpio$":
> +    maxItems: 1
> +
> +  "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
> +    description: |
> +      Container for dai-link level properties and the CPU and CODEC sub-nodes.
> +      This container may be omitted when the card has only one DAI link.
> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      # common properties
> +      frame-master:
> +        $ref: "#/definitions/frame-master"
> +      bitclock-master:
> +        $ref: "#/definitions/bitclock-master"
> +      frame-inversion:
> +        $ref: "#/definitions/frame-inversion"
> +      bitclock-inversion:
> +        $ref: "#/definitions/bitclock-inversion"
> +      format:
> +        $ref: "#/definitions/format"
> +      mclk-fs:
> +        $ref: "#/definitions/mclk-fs"
> +      aux-devs:
> +        $ref: "#/definitions/aux-devs"
> +      convert-rate:
> +        $ref: "#/definitions/convert-rate"
> +      convert-channels:
> +        $ref: "#/definitions/convert-channels"
> +      prefix:
> +        $ref: "#/definitions/prefix"
> +      pin-switches:
> +        $ref: "#/definitions/pin-switches"
> +      hp-det-gpio:
> +        maxItems: 1
> +      mic-det-gpio:
> +        maxItems: 1
> +
> +    patternProperties:
> +      "^cpu(@[0-9a-f]+)?":
> +        $ref: "#/definitions/dai"
> +      "^codec(@[0-9a-f]+)?":
> +        $ref: "#/definitions/dai"
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
