Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62988C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463232088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590608614;
	bh=4wdMukm7FX9uZ4g4EqljFZ8rTJmv44qaJKOH24r7Kww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o2Yx5mmlwFnJkgQi5wP3Umj99tIjjjo8P+/uwChv2vGFgqBcUU5ZUz4jRLfKuMBJg
	 zmdO1BkDc1vY2wXt3ilk/tNtYZp63wKxeohRudwAZQkKbqW5czxTtZt+ZFjpKHHMaV
	 XXeVLSg/ueSJZMlPR019kNKREgsjTaSXOPJU3HBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgE0Tnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:43:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38078 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:43:33 -0400
Received: by mail-io1-f65.google.com with SMTP id d7so27477532ioq.5;
        Wed, 27 May 2020 12:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=72FqlkoBMcBMsbtB42lLe/tS7QEE3zxHLTamPHOBW3s=;
        b=hmGE9p3Hli9oXZaKgROylEAncaDqIHC/bDYk+HyjkraCI9KkwdAXWwwsnPk9LrbGvf
         4eiKaRTuDXi9iRtunsDhKybIpu7KLuTmnYAKg+3j8C8tRHZoRyFCcw8LUNSQlf/N+T9v
         cq2C+RIOTWHftFmR7S+L5bDYpsffC2cD8x0hpAnakvwAH+Evg1SBuwV2LAbltm+OXGbY
         JfdmxU17jOx+6nnglaoHRGgJ6DxQ5HHj6CkqHVmNwp3b+Z4IhCOBpbCMuKRO0xsqbFGK
         MNszKoPYu5Im3Z51EYTndYXUbR3zi1G3FV5mwwXPtPgB2W5RB9dIC9snTfiS393uDTOK
         C5vQ==
X-Gm-Message-State: AOAM533JeZ+qvh0CSV6U/T+yQLzdmZHY9zbmQz2vZR78lbKnbFNUwiZm
        zxhcSfe8kKCZnL6cNsrvnaZgGag=
X-Google-Smtp-Source: ABdhPJxNMhyiJ2CgkBOjcCOJj2IdqdC8i/z23G/v6QVNlUw/KC+3ylT/YKSkxdFPIKnL78PCU9hWVw==
X-Received: by 2002:a02:cc56:: with SMTP id i22mr291353jaq.31.1590608612031;
        Wed, 27 May 2020 12:43:32 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l6sm1577459ioh.32.2020.05.27.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:43:30 -0700 (PDT)
Received: (nullmailer pid 2617131 invoked by uid 1000);
        Wed, 27 May 2020 19:43:29 -0000
Date:   Wed, 27 May 2020 13:43:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     cw00.choi@samsung.com, lee.jones@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        myungjoo.ham@samsung.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 4/7] mfd: arizona: Move binding over to dtschema
Message-ID: <20200527194329.GA2608641@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:57:17AM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Removed a couple more redundant descriptions
> 
> Thanks,
> Charles
> 
>  Documentation/devicetree/bindings/mfd/arizona.txt  | 101 -------
>  .../devicetree/bindings/mfd/wlf,arizona.yaml       | 289 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +-
>  3 files changed, 293 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml


> diff --git a/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
> new file mode 100644
> index 0000000000000..14b6aac64a7e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
> @@ -0,0 +1,289 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/wlf,arizona.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  These devices are audio SoCs with extensive digital capabilities and a
> +  range of analogue I/O.
> +
> +allOf:
> +  - $ref: /schemas/sound/wlf,arizona.yaml#
> +  - $ref: /schemas/regulator/wlf,arizona.yaml#
> +  - $ref: /schemas/extcon/wlf,arizona.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - cirrus,cs47l24
> +              - wlf,wm1831
> +    then:
> +      required:
> +        - DCVDD-supply
> +        - MICVDD-supply
> +    else:
> +      properties:
> +        LDOVDD-supply:
> +          description:
> +            Digital power supply, used internally to generate DCVDD when
> +            internally supplied.
> +          $ref: /schemas/types.yaml#/definitions/phandle

Don't need a type. *-supply has one already.

I'll fix up when applying.

Rob
