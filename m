Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D925C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1F6206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595539589;
	bh=9A7uW5r74LJMN1cCC6kBYK4KHejBrBzZXNWDnA/woPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fhj/Fh2GMVphhUnOdl9VdYURGx0LZRkCgnWejd1A83PzUI6lPvJec7kcg/i5Rjk3p
	 wUYEPcETYiJ4nXKSnNk7PQHZI67Otn+28eYb4m2DjgkliZe+78n7COZsGUbTWt2f61
	 4riTLJ4hyuxIo0U+6lCIE4AXKOKTuJQRcGJZyPTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGWV02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:26:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40333 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:26:26 -0400
Received: by mail-io1-f66.google.com with SMTP id l17so7791486iok.7;
        Thu, 23 Jul 2020 14:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aio0O56TMdFYqw2UCtuk3QI7N/E8ozfzhWYeOVwX0x4=;
        b=GtwRUGsL5UBGIF3jNYv9SjoEne6H/QTv8gaNrReibfW4kIMlTJqp8/Yi9IHoq1HFnl
         OGbn/iFpCaScBg3OIjQOHHiFywPA+8OI7xaXrPpatvaYri6s7neotHz+iaL3ztxd2eFN
         w7GAqywkPXbyBrLj2keGyHNYW4IdtnWqJ01z6hXxFTml3LqQJeRldy1GJzufz17kwS68
         mictbn660NSKwntTo2eG7XUiEo02LGDnllQgPaUi2ECyDwHNR93XuO1qUrduy3dX+pTd
         EyyF3cnKlijJ3Hbro4HSWv3D0AUj4EKARA2xm454FnFmL75uX02URXZ/KyDtbjtHFu5f
         y/cg==
X-Gm-Message-State: AOAM533wn0l5tVLTeflOeCaohGlvZcQt53l6DMK+3QacHzWAGFtJ7jqr
        b7so3PkvG0+CC+1o4WFO8w==
X-Google-Smtp-Source: ABdhPJxz8jFmwfXBj5nmYZ+34dKaTVlZ/aHCHdHoiAgKX5+W1LlWTBhTOwsE6vqBfYqNJfIO6Ymhcg==
X-Received: by 2002:a05:6602:1587:: with SMTP id e7mr3179560iow.203.1595539585372;
        Thu, 23 Jul 2020 14:26:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k3sm2034542ils.8.2020.07.23.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:26:24 -0700 (PDT)
Received: (nullmailer pid 886747 invoked by uid 1000);
        Thu, 23 Jul 2020 21:26:23 -0000
Date:   Thu, 23 Jul 2020 15:26:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: convert Everest ES8316 binding to
 yaml
Message-ID: <20200723212623.GA882284@bogus>
References: <20200722180728.993812-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722180728.993812-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:07:28AM +0900, Katsuhiro Suzuki wrote:
> This patch converts Everest Semiconductor ES8316 low power audio
> CODEC binding to DT schema.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../bindings/sound/everest,es8316.txt         | 23 ---------
>  .../bindings/sound/everest,es8316.yaml        | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
> deleted file mode 100644
> index 1bf03c5f2af4..000000000000
> --- a/Documentation/devicetree/bindings/sound/everest,es8316.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Everest ES8316 audio CODEC
> -
> -This device supports both I2C and SPI.
> -
> -Required properties:
> -
> -  - compatible  : should be "everest,es8316"
> -  - reg : the I2C address of the device for I2C
> -
> -Optional properties:
> -
> -  - clocks : a list of phandle, should contain entries for clock-names
> -  - clock-names : should include as follows:
> -         "mclk" : master clock (MCLK) of the device
> -
> -Example:
> -
> -es8316: codec@11 {
> -	compatible = "everest,es8316";
> -	reg = <0x11>;
> -	clocks = <&clks 10>;
> -	clock-names = "mclk";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
> new file mode 100644
> index 000000000000..b713404dac4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Everest ES8316 audio CODEC
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

Should be someone who knows and cares about the h/w which is not Mark.

> +
> +properties:
> +  compatible:
> +    const: everest,es8316
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for master clock (MCLK)
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      es8316: codec@11 {
> +        compatible = "everest,es8316";
> +        reg = <0x11>;
> +        clocks = <&clks 10>;
> +        clock-names = "mclk";
> +        #sound-dai-cells = <0>;
> +      };
> +    };
> -- 
> 2.27.0
> 
