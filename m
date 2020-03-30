Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B1C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3671D20786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610272;
	bh=N9SPv3Kq0vRavjJ1oGzs+0aBZeKvoatSZxjYYOOF+Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zx3Oyfkn1D+bUij0kPBEdTIyXK8t+jfWqwfVjku1O7JUV4s5F0FVx0SHg9A3jhOVx
	 +E014wKbsssj4vWQXQRGU6itkJoE00MYEsO3IJ6MHLonneKus1HSCmSavHvCZBMRAK
	 BTBjFGkjIOa6TIccoZ1T1U8LK+9/YHirSQUA+XWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgC3XRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:17:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37687 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:17:51 -0400
Received: by mail-il1-f193.google.com with SMTP id a6so17634628ilr.4;
        Mon, 30 Mar 2020 16:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTXjifd7ocglD8FboIBeR1N5hRHtq0vpT75Dg952cWQ=;
        b=IxTjHjqDhMsozwd2HNXFbYcM2Rc1oO/xdRR3vMNh187q0tjc7XmpjiX0MCC8EPQoZG
         O5+wyoD2ghu4Lq0M6/sgetwEHT69BgZrvpYWHeGVbyFlAMU4+CVPGcA2Y7wH27191HZU
         nSDqmNLZoBWA4v0e+1lus0q75C8n+CB+i+HlJcO0hM80nja2VxWCkmNbhXL469jNQxSm
         5dw8OC0VgAkhtPdULC8cDanANbJENlI970Bky5MLIyz56UX7UbNAO1Ljss56mBKWOAsk
         bn8G6FgemD2x4cki9mn2JVFQG2gQ+liB8FCxPWfh1jc4JaIjGKFOBqkzkyyN3bcX37Oh
         0Rlw==
X-Gm-Message-State: ANhLgQ2QsdVkKJUvcwYe8aTrx2XhtPMXzHE66iefGyWonNcMpW3l/2mK
        qBP+dDt4ME2CpObdnLKfgw==
X-Google-Smtp-Source: ADFU+vt94dHL8ZNH73PSwCvVDGJWSHYvQZp10YVT6AUavcgqdGX/LdcbPXO/CeDpMSVuIc6hSx48Og==
X-Received: by 2002:a92:d0c7:: with SMTP id y7mr13779079ila.56.1585610269995;
        Mon, 30 Mar 2020 16:17:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j1sm4600895iok.2.2020.03.30.16.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:17:49 -0700 (PDT)
Received: (nullmailer pid 12466 invoked by uid 1000);
        Mon, 30 Mar 2020 23:17:48 -0000
Date:   Mon, 30 Mar 2020 17:17:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: sram: convert rockchip-pmu-sram
 bindings to yaml
Message-ID: <20200330231748.GA10021@bogus>
References: <20200319161159.24548-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319161159.24548-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 05:11:58PM +0100, Johan Jonker wrote:
> Current dts files with 'rockchip-pmu-sram' compatible nodes
> are now verified with sram.yaml, although the original
> text document still exists. Merge rockchip-pmu-sram.txt
> with sram.yaml by adding it as description with an example.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Not tested with hardware.
> 
> Changed v2:
>   Merge with sram.yaml
> ---
>  .../devicetree/bindings/sram/rockchip-pmu-sram.txt       | 16 ----------------
>  Documentation/devicetree/bindings/sram/sram.yaml         | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
> 
> diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
> deleted file mode 100644
> index 6b42fda30..000000000
> --- a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Rockchip SRAM for pmu:
> -------------------------------
> -
> -The sram of pmu is used to store the function of resume from maskrom(the 1st
> -level loader). This is a common use of the "pmu-sram" because it keeps power
> -even in low power states in the system.
> -
> -Required node properties:
> -- compatible : should be "rockchip,rk3288-pmu-sram"
> -- reg : physical base address and the size of the registers window
> -
> -Example:
> -	sram@ff720000 {
> -		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
> -		reg = <0xff720000 0x1000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> index 7b83cc6c9..a9b1c2b74 100644
> --- a/Documentation/devicetree/bindings/sram/sram.yaml
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> @@ -224,6 +224,19 @@ examples:
>      };
>  
>    - |
> +    // Rockchip's rk3288 SoC uses the sram of pmu to store the function of
> +    // resume from maskrom(the 1st level loader). This is a common use of
> +    // the "pmu-sram" because it keeps power even in low power states
> +    // in the system.
> +    sram@ff720000 {
> +      compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";

You need to document the compatible.

> +      reg = <0xff720000 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0 0xff720000 0x1000>;
> +    };
> +
> +  - |
>      // Allwinner's A80 SoC uses part of the secure sram for hotplugging of the
>      // primary core (cpu0). Once the core gets powered up it checks if a magic
>      // value is set at a specific location. If it is then the BROM will jump
> -- 
> 2.11.0
> 
