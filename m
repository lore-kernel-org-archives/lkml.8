Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3592EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0210F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598311483;
	bh=Qre3ThT/+e1rSJX969UERkChhiUJFQvZRK41YX8uwro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MQBeSprxIWvy03X1RpMWjWLG0bV2meO3m4aU6u/M1iCclqh8csPsLLgPAWkwadA35
	 48gxR1WXpNnQ/TK5nUBqzbtX2jefmFps4huAaScumi4xe2Nz/cEapAN2YxfQ0WpzUg
	 87sJwHC7z67nHEbnnv/wlJt6OAf5PikDxOV91+i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHXXYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:24:42 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39253 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:24:41 -0400
Received: by mail-il1-f195.google.com with SMTP id f12so8837729ils.6;
        Mon, 24 Aug 2020 16:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JwCY8rswka2evtE21QF7ein3AFgooZR8ofb7Ek5G2oQ=;
        b=hnmOt0f8Sf4ZLsXp3NS0YE01QMyIUnHFl8QO/p4VTcsCrQEAiYfDU4fOpOBGqscqQD
         9Q5d9KnXo//QJn1oQBAq4tVvz8VAMTdY3eFImrNjhW+QkmPk8VcqElDBIW5TWPPr/GnF
         Tapgl090S8AZmUjfGNg9KUjqGbh2OlsBrV+sbdPLl6EhkziS4izczzS1pLF+iYXBbCz3
         dVwzGyF3RwkZtZOy8Iq5Zg6zzPvAF5qgOPPlnzS8zZOn6Lpt6/ORltZkhLFkqsoar+XN
         dQS/GYrr/WMoSZBPZmWt97AcYVrR95Rj0Xi6ZHjH+mhaZaWPAFwu9dvjkZV3eogFXyR2
         ZCog==
X-Gm-Message-State: AOAM532Z1kR5nybnZ9eBpDHtxQIIbj52XJE8zwBZnfWZ0ghQeazMEBpX
        B6Fsa5WUBSnrtPdImuzhJQ==
X-Google-Smtp-Source: ABdhPJx7LtfsqA1qY3DyB66QRPALZplHC090bvD6c3U46iI9qD4WKEflLmoQC5seq1+YwsA9qyvLjA==
X-Received: by 2002:a92:a188:: with SMTP id b8mr7329457ill.81.1598311480006;
        Mon, 24 Aug 2020 16:24:40 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a16sm8105572ilp.23.2020.08.24.16.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:24:39 -0700 (PDT)
Received: (nullmailer pid 3530535 invoked by uid 1000);
        Mon, 24 Aug 2020 23:24:38 -0000
Date:   Mon, 24 Aug 2020 17:24:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: i3c: Describe Silvaco master binding
Message-ID: <20200824232438.GA3525200@bogus>
References: <20200812141312.3331-1-miquel.raynal@bootlin.com>
 <20200812141312.3331-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812141312.3331-2-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 04:13:10PM +0200, Miquel Raynal wrote:
> Silvaco provide a dual-role I3C master.
> 
> Description is rather simple: it needs a register mapping, three
> clocks and an interrupt.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes in v2:
> * Updated Rob's tool and fixed the mistake reported.
> * Updated the vendor prefix.
> 
>  .../bindings/i3c/silvaco,i3c-master.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> new file mode 100644
> index 000000000000..63731e8a9068
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silvaco I3C master
> +
> +maintainers:
> +  - Conor Culhane <conor.culhane@silvaco.com>
> +
> +properties:
> +  compatible:
> +    const: silvaco,i3c-master
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: |
> +      There are three clocks:
> +        pclk:     System clock
> +        fast_clk: Fast clock (for the bus)
> +        slow_clk: Slow clock (for other events)

You basically say this in the schema... If you want some description, do 
it in 'clocks':

clocks:
  items:
    - description: ...
    - description: ...
    - description: ...

> +
> +    items:
> +      - const: pclk
> +      - const: fast_clk
> +      - const: slow_clk
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks

additionalProperties: false

And that will point out some errors in the example.

> +
> +examples:
> +  - |
> +    i3c-master@a0000000 {
> +        compatible = "silvaco,i3c-master";
> +        clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
> +        clock-names = "pclk", "fast_clk", "slow_clk";
> +        interrupt-parent = <&gic>;
> +        interrupts = <0 89 4>;
> +        reg = <0xa0000000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> -- 
> 2.20.1
> 
