Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D8120720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594335854;
	bh=wGxTtySOQywGlGpNmMEAdtnIGXAXgwkUZcr7aDb3kkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I6oKYXuZhIxr3xvjse2m/Fvy9kH/NkmtJTxDBsyRcDIbgkyYV7DsxDQWYr37PDdHH
	 xZAiHNIp2QyiXofa4FpbBRkkEz9tOBj7wBZMb7ipNKmCfvuwspWtq2/ybopowOdUTa
	 M7YEJaIovQa47VOOWAarXodj780L79u7viTbRJOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGIXEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:04:13 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39997 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgGIXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:04:13 -0400
Received: by mail-il1-f193.google.com with SMTP id e18so3463849ilr.7;
        Thu, 09 Jul 2020 16:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtaAPiL9q7qGUDFYXyM+6i10yrbGLvC0ihaUk4rwR58=;
        b=IUPfvhVmpRupGSuQi0URRb7gwpepEt3tL/v+4ZAxAb7nkUgusXljh94BkMM/GNma4j
         LE5XyLYdPJ1iHJ64HYKeuLyRAD6Bu/81HaLJDLsqMtOyYYp4vB7aWMn548thGyfqndf6
         84U1r5snIHkX7yUFiBRhGg/VVfZqSureM16nQBnh0ve2TJIo/QlwgPEgQOqALm/OIIjF
         J6NM7it9AZXyQ7dMHpQgn67mE29JjprOurWj8hvDJvedd4CkzjnMBpZSalvLE3O6pWXx
         6p7Wk2cHoXsqdL40fQVoKWZxAl+tH+rLlsIJC+xlKDIxowOkSfXY/jwxBTOFMtBeKoXt
         dxXA==
X-Gm-Message-State: AOAM530uWSLvgBvD5lCj7NxKOWgRSHJ++0Cn8o1iYDtA8wC5nn0WMVbt
        5noZjc0q7NfQhGEXSL3TZkE1koV4Cg==
X-Google-Smtp-Source: ABdhPJzthpu8MazWs5NHvqwNU1OpG2+x92i5Yk1GeUgmVLRH4IDXuVNaA4PDlsQ8jAajcfUwQBEy4Q==
X-Received: by 2002:a92:da4c:: with SMTP id p12mr20547204ilq.142.1594335851875;
        Thu, 09 Jul 2020 16:04:11 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id g1sm2523394ilk.51.2020.07.09.16.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:04:11 -0700 (PDT)
Received: (nullmailer pid 1057926 invoked by uid 1000);
        Thu, 09 Jul 2020 23:04:10 -0000
Date:   Thu, 9 Jul 2020 17:04:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/12] dt-bindings: arm: Add mstar YAML schema
Message-ID: <20200709230410.GA1054276@bogus>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
 <20200616121525.1409790-6-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121525.1409790-6-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:15:18PM +0900, Daniel Palmer wrote:
> This adds some intial boards for Armv7 based mstar platforms.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../devicetree/bindings/arm/mstar.yaml        | 34 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar.yaml
> new file mode 100644
> index 000000000000..7bb91a546b5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mstar.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mstar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MStar platforms device tree bindings
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +        # infinity boards

Make a 'description:' rather than a comment. With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +        - items:
> +          - enum:
> +              - thingyjp,breadbee-crust # thingy.jp BreadBee Crust
> +              - thingyjp,breadbee-crustx # thingy.jp BreadBee Crustx
> +          - const: mstar,infinity
> +
> +        # infinity3 boards
> +        - items:
> +          - enum:
> +              - thingyjp,breadbee # thingy.jp BreadBee
> +          - const: mstar,infinity3
> +
> +        # mercury5 boards
> +        - items:
> +          - enum:
> +              - 70mai,midrived08 # 70mai midrive d08
> +          - const: mstar,mercury5
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68f21d46614c..a8640c1c50cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2117,6 +2117,13 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-pxa/mioa701.c
>  
> +ARM/MStar/Sigmastar Armv7 SoC support
> +M:	Daniel Palmer <daniel@thingy.jp>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +W:	http://linux-chenxing.org/
> +F:	Documentation/devicetree/bindings/arm/mstar.yaml
> +
>  ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
>  M:	Michael Petchkovsky <mkpetch@internode.on.net>
>  S:	Maintained
> -- 
> 2.27.0.rc0
> 
