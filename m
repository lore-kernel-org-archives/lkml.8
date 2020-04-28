Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E72C83005
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15A1206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="KUUydT39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgD1C3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1C3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:29:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4BC03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:29:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so15572720lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+uGJzCGEZzpm9VH9v4SN7yHKhIbgY4iai+hN2gQwj7k=;
        b=KUUydT39YgoMICFNQ29Gp22uxFO9wPacG05nzpU8Ri9QKU1lmnF/YOVmDYkCseg/xC
         t0ZKWtHSsGC9GbJQ+F3uAWU3VXe0/3zJD17HXskl9GF4C7WRUlkVZd3o8DxCJuyzBcPt
         DOz91j6aoWByuRHWJEwfJQBGs8LkpZc2HGp6EcTf0AnRBq1saxtKg/ybeRc6pppGbtNi
         DN4ZdMeBGUfMiSwSD7WYV/JQaL/ZucoyQItg0xsDcfOjOXzVU4VFBzLx5G2vl8g1dw6C
         DZ6KimzbeEJ5gvfKL86BpvTHdedylChqwOdIZ9g2sCiMTG/tl8pQZoFzhVg42RFXHiAK
         82lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+uGJzCGEZzpm9VH9v4SN7yHKhIbgY4iai+hN2gQwj7k=;
        b=dTNpK2kCba0AUusLKd0iA06L+ot/UPLJ9BPLNt1etdhZnUPckQWj0lm6KE4Y0RpP7v
         Z8DbR77DKRpk2k0s4u3fMjag5h/jLwC6mMjBHLVi1wYR9fWA6kOJ/UZOjBfSzvbi+fn/
         KipEne5GQ02K+5BRXCNH7y1fVbkyz9Yy/HbhZrOtyfGAIaAQYNuI9RF3mIsRD4mxpQTY
         WdvGi4eVkytZD0wZvwWVHIQvs/H9Jn3z6+ChD8qd0O0gL/ZkRH2rj3U6loKk5goPKzAz
         zCNsE+re/8Otct8nmmE5BZufJrrVVU81eDTdGRionAfHk1i8l5iLdXhj0M12rkeiQNuS
         Gnjw==
X-Gm-Message-State: AGi0Pua0qE/qTlp9Lj6ZNPAesJ3NKTLq/BUExWBRxUFVe/cT491iHG22
        K3tord+IDGtyFlxd1ztmACI9CA==
X-Google-Smtp-Source: APiQypIsxF+967Us38v4D2URSli5eYkS88vfjKMguWtQBZcMphNaX0Sjm0AX+vOlPiyoT5NgY0dfWA==
X-Received: by 2002:ac2:4426:: with SMTP id w6mr17323851lfl.8.1588040945426;
        Mon, 27 Apr 2020 19:29:05 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id q24sm12683484lfc.29.2020.04.27.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 19:29:04 -0700 (PDT)
Date:   Tue, 28 Apr 2020 04:29:04 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Convert to json-schema
Message-ID: <20200428022904.GC1208690@oden.dyn.berto.se>
References: <20200427193224.29548-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427193224.29548-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2020-04-27 21:32:24 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas OS Timer (OSTM) Device Tree binding documentation to
> json-schema.
> 
> Document missing properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
> For a clean dtbs_check, this depends on "[PATCH] ARM: dts: r7s9210: Remove
> bogus clock-names from OSTM nodes"
> (https://lore.kernel.org/r/20200427192932.28967-1-geert+renesas@glider.be)
> which I intend to queue as a fix for v5.7.
> 
>  .../bindings/timer/renesas,ostm.txt           | 31 ----------
>  .../bindings/timer/renesas,ostm.yaml          | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/renesas,ostm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.txt b/Documentation/devicetree/bindings/timer/renesas,ostm.txt
> deleted file mode 100644
> index 81a78f8bcf170a82..0000000000000000
> --- a/Documentation/devicetree/bindings/timer/renesas,ostm.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* Renesas OS Timer (OSTM)
> -
> -The OSTM is a multi-channel 32-bit timer/counter with fixed clock
> -source that can operate in either interval count down timer or free-running
> -compare match mode.
> -
> -Channels are independent from each other.
> -
> -Required Properties:
> -
> -  - compatible: must be one or more of the following:
> -    - "renesas,r7s72100-ostm" for the R7S72100 (RZ/A1) OSTM
> -    - "renesas,r7s9210-ostm" for the R7S9210 (RZ/A2) OSTM
> -    - "renesas,ostm" for any OSTM
> -		This is a fallback for the above renesas,*-ostm entries
> -
> -  - reg: base address and length of the register block for a timer channel.
> -
> -  - interrupts: interrupt specifier for the timer channel.
> -
> -  - clocks: clock specifier for the timer channel.
> -
> -Example: R7S72100 (RZ/A1H) OSTM node
> -
> -	ostm0: timer@fcfec000 {
> -		compatible = "renesas,r7s72100-ostm", "renesas,ostm";
> -		reg = <0xfcfec000 0x30>;
> -		interrupts = <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
> -		clocks = <&mstp5_clks R7S72100_CLK_OSTM0>;
> -		power-domains = <&cpg_clocks>;
> -	};
> diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> new file mode 100644
> index 0000000000000000..600d47ab7d58570f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/renesas,ostm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas OS Timer (OSTM)
> +
> +maintainers:
> +  - Chris Brandt <chris.brandt@renesas.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description:
> +  The OSTM is a multi-channel 32-bit timer/counter with fixed clock source that
> +  can operate in either interval count down timer or free-running compare match
> +  mode.
> +
> +  Channels are independent from each other.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r7s72100-ostm # RZ/A1H
> +          - renesas,r7s9210-ostm  # RZ/A2M
> +      - const: renesas,ostm       # Generic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r7s72100-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ostm0: timer@fcfec000 {
> +            compatible = "renesas,r7s72100-ostm", "renesas,ostm";
> +            reg = <0xfcfec000 0x30>;
> +            interrupts = <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&mstp5_clks R7S72100_CLK_OSTM0>;
> +            power-domains = <&cpg_clocks>;
> +    };
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
