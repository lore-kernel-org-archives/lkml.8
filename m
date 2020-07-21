Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37346C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8C92075B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595297537;
	bh=Wd+RJDtjybh53jqcmXzlsw+Ln4yJuFKK9ho7SBzI5Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a1cUzid4PqtLm6dsRMp4Sy0u3eU2hAnzkimwcYqb6PEAeSxC1+oLtD1Co9e3gmbRQ
	 lRP3E8lyjoGL/Ts/kfr3BwHef4RgDpda06QrWFuHi90FU9fRaV4nsRmata1YEtXrTH
	 iCze0KgjnYfjBr0gfPJcTW6ZePX5A2EecuFGYKAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGUCMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:12:15 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44155 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGUCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:12:14 -0400
Received: by mail-il1-f196.google.com with SMTP id h16so15079956ilj.11;
        Mon, 20 Jul 2020 19:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NQUTeffJMHXMiqbsPX2xwEkXM3c5RyktUmybjJ1stHs=;
        b=VQ32JPIkbnQ36s4c1dnXNaSICh8j8qpOERLo8ev2R982mb9TwXX7dMt1FCMDBBqfUT
         tgEW3+7aZYohXASD56Nv8F6t+4eULr/rQM8/GXsCP7UdfBCnMdbZ+lbHY/WgKbUjVHan
         9sqPtJJFy7qKH3el/TmZ7kkyo5rAVqvDcJerVt49OHYVB94AjnkkRVfxpFa80QXLRlpL
         B6DOjLQUp6lwKglhM0NbQYjcL+pmJDBpOSs/AMaR8uDX9/1IcIYBQJTBUM72fnaYpByA
         +oSOuxxMvpukgN3Ac4M43CpiuVESf2LaFxfeEIYXZp8TKuLfmDEMoQwcIeu17B8oA6E0
         zcbg==
X-Gm-Message-State: AOAM531WU26msYA6gE3RFY1MuPDFPvmzp3USnHSOlt7+UuVEMNGrrUkR
        uFYpNvFCBEldVeHLhh7kbw==
X-Google-Smtp-Source: ABdhPJzJnKhYPFFl4Fz41JdJz6qoRM9fJhj/Uf8pUDziQOo+75dmr6QMoYBHE/FV+bE8f94gH1De6g==
X-Received: by 2002:a92:a312:: with SMTP id a18mr18402751ili.308.1595297532855;
        Mon, 20 Jul 2020 19:12:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s5sm4527756ioo.29.2020.07.20.19.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:12:12 -0700 (PDT)
Received: (nullmailer pid 3389433 invoked by uid 1000);
        Tue, 21 Jul 2020 02:12:11 -0000
Date:   Mon, 20 Jul 2020 20:12:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: convert ROHM BD28623 amplifier
 binding to yaml
Message-ID: <20200721021211.GA3388250@bogus>
References: <20200714081000.177914-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714081000.177914-1-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 05:09:59PM +0900, Katsuhiro Suzuki wrote:
> This patch converts ROHM BD28623UMV class D speaker amplifier binding
> to DT schema.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../bindings/sound/rohm,bd28623.txt           | 29 ---------
>  .../bindings/sound/rohm,bd28623.yaml          | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
> deleted file mode 100644
> index d84557c2686e..000000000000
> --- a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -ROHM BD28623MUV Class D speaker amplifier for digital input
> -
> -This codec does not have any control buses such as I2C, it detect format and
> -rate of I2S signal automatically. It has two signals that can be connected
> -to GPIOs: reset and mute.
> -
> -Required properties:
> -- compatible      : should be "rohm,bd28623"
> -- #sound-dai-cells: should be 0.
> -- VCCA-supply     : regulator phandle for the VCCA supply
> -- VCCP1-supply    : regulator phandle for the VCCP1 supply
> -- VCCP2-supply    : regulator phandle for the VCCP2 supply
> -
> -Optional properties:
> -- reset-gpios     : GPIO specifier for the active low reset line
> -- mute-gpios      : GPIO specifier for the active low mute line
> -
> -Example:
> -
> -	codec {
> -		compatible = "rohm,bd28623";
> -		#sound-dai-cells = <0>;
> -
> -		VCCA-supply = <&vcc_reg>;
> -		VCCP1-supply = <&vcc_reg>;
> -		VCCP2-supply = <&vcc_reg>;
> -		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
> -		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml b/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
> new file mode 100644
> index 000000000000..acd8609252b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rohm,bd28623.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD28623MUV Class D speaker amplifier for digital input
> +
> +description:
> +  This codec does not have any control buses such as I2C, it detect
> +  format and rate of I2S signal automatically. It has two signals
> +  that can be connected to GPIOs reset and mute.
> +
> +maintainers:
> +  - Katsuhiro Suzuki <katsuhiro@katsuster.net>
> +
> +properties:
> +  compatible:
> +    const: rohm,bd28623
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  VCCA-supply:
> +    description:
> +      regulator phandle for the VCCA (for analog) power supply
> +
> +  VCCP1-supply:
> +    description:
> +      regulator phandle for the VCCP1 (for ch1) power supply
> +
> +  VCCP2-supply:
> +    description:
> +      regulator phandle for the VCCP2 (for ch2) power supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the active low reset line
> +
> +  mute-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the active low mute line
> +
> +required:
> +  - compatible
> +  - VCCA-supply
> +  - VCCP1-supply
> +  - VCCP2-supply
> +  - "#sound-dai-cells"

Needs an:

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    codec {
> +      compatible = "rohm,bd28623";
> +      #sound-dai-cells = <0>;
> +
> +      VCCA-supply = <&vcc_reg>;
> +      VCCP1-supply = <&vcc_reg>;
> +      VCCP2-supply = <&vcc_reg>;
> +      reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
> +      mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> +    };
> -- 
> 2.27.0
> 
