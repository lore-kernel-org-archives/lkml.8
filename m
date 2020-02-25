Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115DC35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AE92176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582655054;
	bh=yNlfOmQR9+nRAaGFNlH/Ji35iqnG0we1hXWVC5J6quo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKp45TdDxtzw7mkr5IrHPssUt9fQP8SSG0lImasjpK1INJ7Z7Dv3une+j+0OZDBl/
	 hfcThJkrp3Vu7pC4jvxFKk2DrCcM8wD4NcJW7hsxC45cUniACV0o8R65GPlND21hx2
	 spQnj5cwYZq3njezsccXV59zOP1S8HotTN9B3SpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgBYSYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:24:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39784 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBYSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:24:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so262881oij.6;
        Tue, 25 Feb 2020 10:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyUEcnd6mf3xDLs58H/+znKVsIUHaN8BT7T15bn5I/4=;
        b=eAtzbSrvXHIlj+DIXE5B+cX9N1ysawIUYTjdEbHQca6Zf4J55Mj5rdHaLUbso4WIte
         OHNqE1DJBJ+jm9Hgr8TELLP+/jzCfpaYlMmAWQ0Bz1p6f+bjZ9qjrwOBVDtShaCCVIjF
         8pYD4CHtj7PrNRwsLrWMhSEtiBxFedkbngN4UyKt8a2d0DILztME+V2jW9CzuZCotcUO
         +Wk8Kt49QJhF7clzotAHLZ1CI5YTtiVu/BzCd67AvLIia+S/Y5JR8Xl1A+s9Fhpm8weF
         RtjeLr5mk5L04qgsTHhpl4qpJNew2axJ+FnbnlcvbqLLVjY1WTmj7IODjDWXOfy59ftF
         NJBw==
X-Gm-Message-State: APjAAAUejYKEP4qpg3/o+bd/gxbUJVLfO+vrhiNhBnHxldLWqr8aS0FF
        ++uNXLCB6JEUQqRw3SWQqg==
X-Google-Smtp-Source: APXvYqy2YFi/Z/AQYaFr+0YJAOKBBXw2YKbb14sGV3IuzdQIEB+ZE6Mmn4i6K3FgKLi1IMdYd8+R/w==
X-Received: by 2002:a05:6808:251:: with SMTP id m17mr190704oie.15.1582655052039;
        Tue, 25 Feb 2020 10:24:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm5572706oie.18.2020.02.25.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:24:11 -0800 (PST)
Received: (nullmailer pid 14462 invoked by uid 1000);
        Tue, 25 Feb 2020 18:24:10 -0000
Date:   Tue, 25 Feb 2020 12:24:10 -0600
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
Subject: Re: [PATCH 88/89] dt-bindings: display: vc4: hdmi: Add BCM2711 HDMI
 controllers bindings
Message-ID: <20200225182410.GA7661@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <4c21dda4f0b73977de1e54d408d7bf6bf3b6d238.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c21dda4f0b73977de1e54d408d7bf6bf3b6d238.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:07:30AM +0100, Maxime Ripard wrote:
> The HDMI controllers found in the BCM2711 SoC need some adjustments to the
> bindings, especially since the registers have been shuffled around in more
> register ranges.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 109 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
> index 52b3cdac0bdf..a9d24e1cf684 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
> @@ -11,24 +11,58 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: brcm,bcm2835-hdmi
> +    enum:
> +      - brcm,bcm2835-hdmi
> +      - brcm,bcm2711-hdmi0
> +      - brcm,bcm2711-hdmi1
>  
>    reg:
> +    oneOf:
> +      - items:
> +        - description: HDMI register range
> +        - description: HD register range
> +
> +      - items:
> +        - description: HDMI controller register range
> +        - description: DVP register range
> +        - description: HDMI PHY register range
> +        - description: Rate Manager register range
> +        - description: Packet RAM register range
> +        - description: Metadata RAM register range
> +        - description: CSC register range
> +        - description: CEC register range
> +        - description: HD register range
> +
> +  reg-names:
>      items:
> -      - description: HDMI register range
> -      - description: HD register range
> +      - const: hdmi
> +      - const: dvp
> +      - const: phy
> +      - const: rm
> +      - const: packet
> +      - const: metadata
> +      - const: csc
> +      - const: cec
> +      - const: hd

Don't you want 'hd' 2nd or need to define the 2 entry case separately?

Really, I think this should be 2 files. All but interrupts and ddc have 
a difference.

>  
>    interrupts:
>      minItems: 2
>  
>    clocks:
> -    items:
> -      - description: The pixel clock
> -      - description: The HDMI state machine clock
> +    oneOf:
> +      - items:
> +        - description: The pixel clock
> +        - description: The HDMI state machine clock
> +
> +      - items:
> +        - description: The HDMI state machine clock
>  
>    clock-names:
> -    items:
> -      - const: pixel
> +    oneOf:
> +      - items:
> +        - const: pixel
> +        - const: hdmi
> +
>        - const: hdmi
>  
>    ddc:
> @@ -51,15 +85,54 @@ properties:
>    dma-names:
>      const: audio-rx
>  
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> -  - interrupts
>    - clocks
>    - ddc
>  
>  additionalProperties: false
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - brcm,bcm2711-hdmi0
> +          - brcm,bcm2711-hdmi1
> +
> +then:
> +  properties:
> +    reg:
> +      minItems: 9
> +
> +    clocks:
> +      maxItems: 1
> +
> +    clock-names:
> +      maxItems: 1
> +
> +  required:
> +    - reg-names
> +    - resets
> +
> +else:
> +  properties:
> +    reg:
> +      maxItems: 2
> +
> +    clocks:
> +      minItems: 2
> +
> +    clock-names:
> +      minItems: 2
> +
> +  required:
> +    - interrupts
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/bcm2835.h>
> @@ -77,4 +150,31 @@ examples:
>          clock-names = "pixel", "hdmi";
>      };
>  
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
>  ...
> -- 
> git-series 0.9.1
