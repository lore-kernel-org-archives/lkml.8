Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5417FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DDB21475
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590776319;
	bh=1b4bb97LhzSOsW7+JOQITPVqOIwAaUZp/Er1QR+YYx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ol07ih5n5Umh2jKMPDXcomyuT95EAwdvHzfBPhMq6jhin6f4gAebt3pBQEpvNEf/E
	 0Qerj2C82tMOUgIuJO0IY5Jw+vOIyuoxn1dHTbx2aa6gvny5dLC2QtaqIkt4AAwgkU
	 9Y+tZo9jHcc4d6KGG8J5dthbknQTmMCMtmxtgyxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgE2SSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:18:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40617 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:18:38 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so331431iow.7;
        Fri, 29 May 2020 11:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Zt0XlCRbQEAA6WM2kGlK/C6ChZT4zLq85OJJjGFn0o=;
        b=GJivFlvt3y6X7Vmb7ySyS1RMdvuw9+XzYALE6D+fOmcSHUK919fhVEa0IeSQv/4hqD
         GACCMTwki/BZhun10i6Y9KQUCE4+xVmtipL4r/yiQ2O4/19DG/i4IrzSJKV9Xx9/SoEg
         9e75ZfDUpznNycrYhvMB5APH99KFC6pN3Wv4T9WsUnlfP6+m1GL10wpR7wAubptJ+S+R
         8uKTELPH+e55MnaM/uR4fJfg/LrrShOwkuWlWL/d7FyZdPk8i6Jhi5OzL5G62d1FNGU+
         ebIxfCnnBqc277dxkNEuoo60IkT22ek0eOwen9/2YJ7OrtcwHvnF78deTo4FEuh2ytq+
         PvGw==
X-Gm-Message-State: AOAM532ZUn+RVrASnXFSGniLtbswcN3YqkRxJauvDVg8592Fe4nKLoWS
        KWmVyEAijrAf9/Ab9yO4Hw==
X-Google-Smtp-Source: ABdhPJzNDQewkud68OMi7ffyblEdKBffzwXmj7DJAvdOeqGXbabXJygx2EyHsLyuZVGswit2+zLTxg==
X-Received: by 2002:a6b:5c19:: with SMTP id z25mr7597825ioh.119.1590776315569;
        Fri, 29 May 2020 11:18:35 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j63sm1246230ilg.50.2020.05.29.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 11:18:34 -0700 (PDT)
Received: (nullmailer pid 2691280 invoked by uid 1000);
        Fri, 29 May 2020 18:18:33 -0000
Date:   Fri, 29 May 2020 12:18:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 104/105] dt-bindings: display: vc4: hdmi: Add BCM2711
 HDMI controllers bindings
Message-ID: <20200529181833.GA2685451@bogus>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <e85e24a494a3ff41177c94673ced0f4280b6a0ee.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e85e24a494a3ff41177c94673ced0f4280b6a0ee.1590594512.git-series.maxime@cerno.tech>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:49:14PM +0200, Maxime Ripard wrote:
> The HDMI controllers found in the BCM2711 SoC need some adjustments to the
> bindings, especially since the registers have been shuffled around in more
> register ranges.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> new file mode 100644
> index 000000000000..6091fe3d315b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license...

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/brcm,bcm2711-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2711 HDMI Controller Device Tree Bindings
> +
> +maintainers:
> +  - Eric Anholt <eric@anholt.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2711-hdmi0
> +      - brcm,bcm2711-hdmi1

What's the difference between the 2 blocks? 

> +
> +  reg:
> +    items:
> +      - description: HDMI controller register range
> +      - description: DVP register range
> +      - description: HDMI PHY register range
> +      - description: Rate Manager register range
> +      - description: Packet RAM register range
> +      - description: Metadata RAM register range
> +      - description: CSC register range
> +      - description: CEC register range
> +      - description: HD register range
> +
> +  reg-names:
> +    items:
> +      - const: hdmi
> +      - const: dvp
> +      - const: phy
> +      - const: rm
> +      - const: packet
> +      - const: metadata
> +      - const: csc
> +      - const: cec
> +      - const: hd
> +
> +  clocks:
> +    description: The HDMI state machine clock
> +
> +  clock-names:
> +    const: hdmi
> +
> +  ddc:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      Phandle of the I2C controller used for DDC EDID probing

Goes in the connector.

And isn't the standard name ddc-i2c-bus?

> +
> +  hpd-gpios:
> +    description: >
> +      The GPIO pin for the HDMI hotplug detect (if it doesn't appear
> +      as an interrupt/status bit in the HDMI controller itself)

Goes in the connector.

> +
> +  dmas:
> +    maxItems: 1
> +    description: >
> +      Should contain one entry pointing to the DMA channel used to
> +      transfer audio data.
> +
> +  dma-names:
> +    const: audio-rx
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - resets
> +  - ddc
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdmi0: hdmi@7ef00700 {
> +        compatible = "brcm,bcm2711-hdmi0";
> +        reg = <0x7ef00700 0x300>,
> +              <0x7ef00300 0x200>,
> +              <0x7ef00f00 0x80>,
> +              <0x7ef00f80 0x80>,
> +              <0x7ef01b00 0x200>,
> +              <0x7ef01f00 0x400>,
> +              <0x7ef00200 0x80>,
> +              <0x7ef04300 0x100>,
> +              <0x7ef20000 0x100>;
> +        reg-names = "hdmi",
> +                    "dvp",
> +                    "phy",
> +                    "rm",
> +                    "packet",
> +                    "metadata",
> +                    "csc",
> +                    "cec",
> +                    "hd";
> +        clocks = <&firmware_clocks 13>;
> +        clock-names = "hdmi";
> +        resets = <&dvp 0>;
> +        ddc = <&ddc0>;
> +    };
> +
> +...
> -- 
> git-series 0.9.1
