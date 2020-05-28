Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AD720721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590674738;
	bh=y1z9dlJ3EhIXj2RWA0vbMrF2xmkbQlAPyyia0RW25Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q2ADrnYnlzTvkwqO/miLpu9TZaANQwkTVtnbw4lcYs7KmVj7VLxJTMBKdXRgCVRYX
	 6Pmd+vlDgCIRyWg1Vta64fGgb6rgw0X9ytUrf9JrSWUEXouLnJS95JdCnXkjT86OIm
	 o4aO2ZBbww4ZnBd+xf19BWBFH0y08QV7bIKZZOmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbgE1OFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:05:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42301 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390596AbgE1OF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:05:29 -0400
Received: by mail-io1-f66.google.com with SMTP id d5so20567626ios.9;
        Thu, 28 May 2020 07:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SLMEy6Ytljxjg8a2KXQ/FizRno8giPzwlWNr4nIvO0E=;
        b=Y1QmPcCNT+4dpmz3ep3znCua571UqhZRq6K2HRWcArhtge1giNZ+gbPZwOExXiDkqY
         qctOyP9SO9n5kYruKrBy4Zkv1rUvCSluZzSHeM8RyesSp1Lnrtgu83cTa8auVFuCGOJc
         KxuGkkN3XQ9XBRiTF6UolmKrkXaM1yBQ2ItrCRFa3g3iojQqVZJBdUNEGVcroxx10R9h
         aHssLK3ZDEBOaFTobfEQiDN0BVC6f2/tFGB74eOLes2ONauX8eToETQIA7xQJ8ntNb+b
         Z8pvoB+IWLZ/bOJuH+AvVdyuADaoOroCO8t8VtFU2wSJoGZs7tmnPrQIfWCZBIQ5D249
         vH7w==
X-Gm-Message-State: AOAM530EuzDKDZD7WotmrwWn2UIvZ1BbbIZH6J0Wawoh5crDG138XEs+
        9MPH6Pu3dKMukhsCHSODmA==
X-Google-Smtp-Source: ABdhPJzoX/OrRJgrF0RLFSzW9vlhDIhoXc7lQcsFo+49D/RYaTtv2OthkVdqcft8AlGIdyG+p7PixA==
X-Received: by 2002:a5d:9dd2:: with SMTP id 18mr2468310ioo.196.1590674728083;
        Thu, 28 May 2020 07:05:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n27sm3317522ild.76.2020.05.28.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:05:26 -0700 (PDT)
Received: (nullmailer pid 4173461 invoked by uid 1000);
        Thu, 28 May 2020 14:05:25 -0000
Date:   Thu, 28 May 2020 08:05:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: tlv320adcx140: Add GPI config
 property
Message-ID: <20200528140525.GA4166160@bogus>
References: <20200526200917.10385-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526200917.10385-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:09:16PM -0500, Dan Murphy wrote:
> Add an array property that configures the General Purpose Input (GPI)
> register.  The device has 4 GPI pins and each pin can be configured in 1
> of 7 different ways.

Dan seems to have trouble running get_maintainers.pl and Cc'ing the DT 
list. Running 'make dt_binding_check' also seems to be a problem. Now 
linux-next has these warnings:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:0: 4 is greater than the maximum of 1
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:1: 5 is greater than the maximum of 1
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:2: 6 is greater than the maximum of 1
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:3: 7 is greater than the maximum of 1

Please send a fix.

> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/sound/tlv320adcx140.yaml         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> index daa6cc0e031b..e8a69b1c7ca9 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> +++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> @@ -86,6 +86,32 @@ properties:
>            maximum: 1
>          default: [0, 0, 0, 0]
>  
> +  ti,gpi-config:
> +    description: |
> +       Defines the configuration for the general purpose input pins (GPI).
> +       The array is defined as <GPI1 GPI2 GPI3 GPI4>.
> +
> +       0 - (default) disabled
> +       1 - GPIX is configured as a general-purpose input (GPI)
> +       2 - GPIX is configured as a master clock input (MCLK)
> +       3 - GPIX is configured as an ASI input for daisy-chain (SDIN)
> +       4 - GPIX is configured as a PDM data input for channel 1 and channel
> +            (PDMDIN1)
> +       5 - GPIX is configured as a PDM data input for channel 3 and channel
> +            (PDMDIN2)
> +       6 - GPIX is configured as a PDM data input for channel 5 and channel
> +            (PDMDIN3)
> +       7 - GPIX is configured as a PDM data input for channel 7 and channel
> +            (PDMDIN4)
> +
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 4
> +        items:
> +          maximum: 1

I believe you want '7' here.

> +        default: [0, 0, 0, 0]
> +
>  required:
>    - compatible
>    - reg
> @@ -101,6 +127,7 @@ examples:
>          reg = <0x4c>;
>          ti,mic-bias-source = <6>;
>          ti,pdm-edge-select = <0 1 0 1>;
> +        ti,gpi-config = <4 5 6 7>;
>          reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
>        };
>      };
> -- 
> 2.26.2
> 
