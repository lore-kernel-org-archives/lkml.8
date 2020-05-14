Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD64C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7243205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589468436;
	bh=XhfuoXAvGKkWFM4KU0QcEkopvO6851ddFKPESaeDxxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TTQ0Pk2cPZnT7pej+RP+DwijDNudXnUKhCrF5ifvri3K7kU87sMHYRIzAx3QOYUYi
	 uC8XrB8v84mPNKKKStD/wE7N2iH/Y1BsULfEBqdUQWVO5SDCe4huQ453q4qN8/Vq0J
	 xcXOELQArhPcvrcKSDMMqiFnlw49xCHCC3/iF9gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgENPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:00:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37341 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgENPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:00:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so2577111oto.4;
        Thu, 14 May 2020 08:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b4HeH81d7CC2pFdjz+KIc9E1a6jJhBx25lXQ9gtMpzM=;
        b=LDr0V/g7lU4mfrKVFlAzBhPfFjpnLKqUWtDGOZTQRWAcVGUaTfareZm8aCHe0TnVBZ
         KWC6IPzCkma8QwgBjPiTdVrAzP9Dox6Je/5E9sho2a/+0W9ln0I0iXKilExH9l5KlmO5
         1nxKMt6DZiAdXmQGlguq8fwZ0faOWuLa8xd65yyGJ+nxbkNHzQFQzKKPX5qzA9r7EZ1z
         sp77BNMjgsH50GHKvTtIUaLhUOkMjLJLR/x1ftHapFIi2L0mBPJbo3AtGmyTDSPcT8bR
         hq5bIuXhreruOcJQuVxRbHpM012FE0h3Xi7ME+fJhtPIR7gy09G6BRGq0K91lEvw2YFt
         4e9g==
X-Gm-Message-State: AOAM5314U7Ti1EA00J3afmsQkn3Sjb6ew76IrG+GXyFbXWJsL2iQG8Fv
        4diMEDSZ0+M5RwG5FCffkQ==
X-Google-Smtp-Source: ABdhPJzW85ZeQbTbhD2yMI5gcvb3x7Kv8qJI1H0Pl22tcfxBOiO1jCVwwbhxlPlqaQj6fzuo6pKuzg==
X-Received: by 2002:a9d:7343:: with SMTP id l3mr3559142otk.276.1589468430559;
        Thu, 14 May 2020 08:00:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u45sm818344ooi.41.2020.05.14.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:00:29 -0700 (PDT)
Received: (nullmailer pid 8677 invoked by uid 1000);
        Thu, 14 May 2020 15:00:28 -0000
Date:   Thu, 14 May 2020 10:00:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH v4 06/10] dt-bindings: mtd: update STM32 FMC2 NAND
 controller documentation
Message-ID: <20200514150028.GB28489@bogus>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <1588756279-17289-7-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588756279-17289-7-git-send-email-christophe.kerello@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:11:15AM +0200, Christophe Kerello wrote:
> These bindings can be used on SOCs where the FMC2 NAND controller is
> in standalone. In case that the FMC2 embeds 2 controllers (an external
> bus controller and a raw NAND controller), the register base and the
> clock will be defined in the parent node. It is the reason why the
> register base address and the clock are now optional.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  .../devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml   | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> index b059267..68fac1a 100644
> --- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> @@ -18,13 +18,15 @@ properties:
>  
>    reg:
>      items:
> -      - description: Registers
> +      - description: Registers (optional)

The only thing that can be optional are the last entries. You have to do 
a 'oneOf' with 6 entries and 7 entries.

And where's your new compatible string for this different h/w?

>        - description: Chip select 0 data
>        - description: Chip select 0 command
>        - description: Chip select 0 address space
>        - description: Chip select 1 data
>        - description: Chip select 1 command
>        - description: Chip select 1 address space
> +    minItems: 6
> +    maxItems: 7
>  
>    interrupts:
>      maxItems: 1
> @@ -61,7 +63,6 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - clocks
>  
>  examples:
>    - |
> @@ -77,13 +78,13 @@ examples:
>              <0x81000000 0x1000>,
>              <0x89010000 0x1000>,
>              <0x89020000 0x1000>;
> -            interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -            dmas = <&mdma1 20 0x10 0x12000a02 0x0 0x0>,
> -                   <&mdma1 20 0x10 0x12000a08 0x0 0x0>,
> -                   <&mdma1 21 0x10 0x12000a0a 0x0 0x0>;
> -            dma-names = "tx", "rx", "ecc";
> -            clocks = <&rcc FMC_K>;
> -            resets = <&rcc FMC_R>;
> +      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      dmas = <&mdma1 20 0x2 0x12000a02 0x0 0x0>,
> +             <&mdma1 20 0x2 0x12000a08 0x0 0x0>,
> +             <&mdma1 21 0x2 0x12000a0a 0x0 0x0>;
> +      dma-names = "tx", "rx", "ecc";
> +      clocks = <&rcc FMC_K>;
> +      resets = <&rcc FMC_R>;
>        #address-cells = <1>;
>        #size-cells = <0>;
>  
> -- 
> 1.9.1
> 
