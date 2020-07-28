Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9CC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17750207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595963926;
	bh=5nA2j1XAfVA4o/KxNUdrRB+3/K7srd69OAlSXyhEIbk=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=R7qjCO96rBlH2iNwMi6+bw5WmJeiFmWw6EJbaLg8xF5RjXHl6Og4Ey7kbkxpb1jD7
	 hsPqxNAkQNt48CtY02bDxNHnoH0RwISIsv9xu8qsraYEtA6vsKoC18YF5VkQtC0FUk
	 iWlSrrrPOwoCBVsNTt7tghLetMEGVA3eYqo91AAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbgG1TSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:18:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35243 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgG1TSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:18:44 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so17241140ilh.2;
        Tue, 28 Jul 2020 12:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9F3cWW09ioux65mfhzYBsZ9niInvkdfVsRaw2chstUk=;
        b=nxia130sMvtPYh3YfCgg8VsWcTyHNC68ExzHDoOMWnyo6gUNjeOewnOpOlAjKXcmsf
         Nxe6C8mFLQ0shTeaJ3Pe9I6wmTtj6P9sJzZuX+xDfYhIeHB9yHLpCpWjtDargokHxApm
         f0Kn+EQFUMnwc6Y9/UG7L/gZHsQqvSQSAxgW3G3AK5FUb6udbbv1BM0td42orvuFvQcj
         5z29FYcSHR8jbb44IXimwRz0ILBz2Ml8zgPcF5Qp55GA02Sl4x/EYKm5M7HUgptaNMUx
         aY3YeX81ybRsaVZAGJU/bbvxpgyPemiA8DzAJsM0ZGHnePZLBh14mU9+FqCFqQx9uCzR
         Vhqw==
X-Gm-Message-State: AOAM533C7TTX/LMWulsXEgjFeAriLjuWdj3X+jjy/3ZlELqTpZfB3KKn
        OR9COil5Zepjpc1MXaCeerREjXNtsQ==
X-Google-Smtp-Source: ABdhPJxgAfsLS4pxpTK+EOfMRrpi8C8DIImjE1iaHAQ8VK6HDfaB0TVolR+ZoRk7j95B/yGu+vrJFA==
X-Received: by 2002:a05:6e02:1021:: with SMTP id o1mr22675354ilj.182.1595963923249;
        Tue, 28 Jul 2020 12:18:43 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x88sm3755044ilk.81.2020.07.28.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:18:42 -0700 (PDT)
Received: (nullmailer pid 2783759 invoked by uid 1000);
        Tue, 28 Jul 2020 19:18:42 -0000
Date:   Tue, 28 Jul 2020 13:18:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mstar: Add binding details for
 mstar,pmsleep
Message-ID: <20200728191842.GB2778962@bogus>
References: <20200728100321.1691745-1-daniel@0x0f.com>
 <20200728100321.1691745-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728100321.1691745-2-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 07:03:13PM +0900, Daniel Palmer wrote:
> This adds a YAML description of the pmsleep node used by
> MStar/SigmaStar Armv7 SoCs.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/arm/mstar/mstar,pmsleep.yaml     | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.yaml
> new file mode 100644
> index 000000000000..ef78097a7087
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mstar/mstar,pmsleep.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 thingy.jp.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mstar/mstar,pmsleep.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MStar/SigmaStar Armv7 SoC pmsleep register region
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +description: |
> +  MStar/Sigmastar's Armv7 SoCs contain a region of registers that are
> +  in the always on domain that the vendor code calls the "pmsleep" area.
> +
> +  This area contains registers and bits for a broad range of functionality
> +  ranging from registers that control going into deep sleep to bits that
> +  turn things like the internal temperature sensor on and off.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +         - enum:
> +             - mstar,pmsleep

Needs to be SoC specific. Random collections of bits are never 
'standard' from one SoC to the next.

If your never going to have child nodes, then you can just add the 
compatible to syscon.yaml.

> +         - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmsleep: pmsleep@1c00 {
> +        compatible = "mstar,pmsleep", "syscon";
> +        reg = <0x0x1c00 0x100>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 991814ea6f76..432fcc867ed6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2140,6 +2140,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  W:	http://linux-chenxing.org/
>  F:	Documentation/devicetree/bindings/arm/mstar.yaml
> +F:	Documentation/devicetree/bindings/arm/mstar/*
>  F:	arch/arm/boot/dts/infinity*.dtsi
>  F:	arch/arm/boot/dts/mercury*.dtsi
>  F:	arch/arm/boot/dts/mstar-v7.dtsi
> -- 
> 2.27.0
> 
