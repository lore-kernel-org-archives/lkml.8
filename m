Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E965206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595537629;
	bh=EftTCbC48jF4smaLeRLgfpq6KkfgpZYPW2rijTjCEP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qj5S0OLENYHLJgy7JbdLdXD4rexqBzyML53Iaoe8Yydtxc0U4WsWLToXLi2CMw2GC
	 NrGPRgm5o3l28cqaEEe2wwQ2cF63Ep7hi9+aPUCDXFzXpMttghL/2ad4oA8vbhpwUi
	 q9s3HEptM+P2I4hVtfRllIzeXW3p6PnEZg9H6M+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGWUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:53:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45367 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGWUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:53:47 -0400
Received: by mail-io1-f67.google.com with SMTP id e64so7696417iof.12;
        Thu, 23 Jul 2020 13:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ITHgt7Rp1pUPvPasYbFEExd3q0/gLF5DZdscQLiQgEw=;
        b=OUNkVzCSN9oe61GvhoaIMNGOMxVK+Q3M9E2jcoR3LEWe2Hx/wZPVuF/zbGewE5VRa6
         /YY2Wq6oomPndl2gb71rR5/uubobILK/rZjy2MEb1C1GAGKnXWtZBWRNHwFTbgHY2QG7
         Dz4HIl4LFD4lpt4ctOvet+++QfvTgMVJwCknwNPdPPn+d/smbjNapVnbcBFsuLKc/aVD
         6Hd/dw76mpuoslKu7vx1pitoRk0ErSXq4GDnupoxclwuro8rqDL9OqjuGtAzU2uUATsr
         qvi6WDS4Oq0eDeSJAaBiImkXm3OQrS+F/oMJ7XTjPIgsxf4RlJk25/c+MnPigcbtCbum
         vYQg==
X-Gm-Message-State: AOAM530cvrTsVISjGDQ+votVeWrV+5m07u8tb3cswx6eU6TrkCBODo2M
        R9IWZBVLpe9OjmpTFJYK2g==
X-Google-Smtp-Source: ABdhPJwu8e69Y0kSTAIspRpvODB+BldtXHqBKiEe/jpBPO0AO31cywRDT52VomisXuK/kACvFQX/aw==
X-Received: by 2002:a05:6602:2f88:: with SMTP id u8mr6878032iow.120.1595537626501;
        Thu, 23 Jul 2020 13:53:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d9sm2004036ios.33.2020.07.23.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:53:45 -0700 (PDT)
Received: (nullmailer pid 841658 invoked by uid 1000);
        Thu, 23 Jul 2020 20:53:43 -0000
Date:   Thu, 23 Jul 2020 14:53:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Huihui Wang <huihui.wang@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/2] dt-bindings: dma: mediatek: mark useless items as
 decrepted
Message-ID: <20200723205343.GA839415@bogus>
References: <20200717030203.14872-1-huihui.wang@mediatek.com>
 <20200717030203.14872-2-huihui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717030203.14872-2-huihui.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:02:03AM +0800, Huihui Wang wrote:
> From: huihui wang <huihui.wang@mediatek.com>
> 
> Because we move dma address bits config to mtk-uart-apdma.c,
> it is unnecessary to be configured in device tree.
> Update the document at the same time.
> 
> Signed-off-by: huihui wang <huihui.wang@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt        | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> index 2117db0ce4f2..926c86b21e8c 100644
> --- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> +++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> @@ -2,8 +2,9 @@
>  
>  Required properties:
>  - compatible should contain:
> -  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
> -  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +  * "mediatek,mt2712-uart-dma" for MediaTek MT2712
> +  * "mediatek,mt6577-uart-dma" for MediaTek MT6577
> +  * "mediatek,mt6779-uart-dma" for MediaTek MT6779

This looks like an unrelated change.

>  
>  - reg: The base address of the APDMA register bank.
>  
> @@ -16,13 +17,12 @@ Required properties:
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names: The APDMA clock for register accesses
>  
> -- mediatek,dma-33bits: Present if the DMA requires support
> +- mediatek,dma-33bits: Present if the DMA requires support (deprecated)
>  
>  Examples:
>  
>  	apdma: dma-controller@11000400 {
> -		compatible = "mediatek,mt2712-uart-dma",
> -			     "mediatek,mt6577-uart-dma";
> +		compatible = "mediatek,mt6779-uart-dma";
>  		reg = <0 0x11000400 0 0x80>,
>  		      <0 0x11000480 0 0x80>,
>  		      <0 0x11000500 0 0x80>,
> @@ -50,6 +50,5 @@ Examples:
>  		dma-requests = <12>;
>  		clocks = <&pericfg CLK_PERI_AP_DMA>;
>  		clock-names = "apdma";
> -		mediatek,dma-33bits;
>  		#dma-cells = <1>;
>  	};
> -- 
> 2.18.0
