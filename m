Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A359C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DC92076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597251317;
	bh=+Qq0r3tZBpXH6/hyJ9N4U7WQyG0GUKKaknsYk9p7VTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wdM8H+rKWQqqlB1YbbF9mt2JFrpU+xehDEZKmh8PpvoTQ3GNAPU95l2eZVuuvbgzu
	 Kxn4lZsPbnDOE0HhQBG8EFCf/bQVJm6F2YDoFmzUvBfBmN7Pwsw65x2sMrev5L5saQ
	 uVBTklse4eR/ZdI8HNIR1FlvcybPRzW2HjqIbZbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHLQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:55:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41874 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:55:09 -0400
Received: by mail-io1-f67.google.com with SMTP id g19so3535069ioh.8;
        Wed, 12 Aug 2020 09:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnKPv+qr/0SKiO3J0pJxrPNLJqM+U78LQKFRagi2BS8=;
        b=W1hYnLkSXMsfW64lgGhp2VN9bUv+079Ih4IkLphG0jJ8sV2Ie3NpXMUacYO9bgYj9w
         glKILNvJ8ZxqjUIXQgzYfWsCUz8rZqbCT0FJaBVQ3rsO2rpMZXWMGQjkDsLWge0tdMgC
         Txg6eczopNwOpnH2Z+SlAZJyMq1/ha3Iglct2XS++Rx6pXctFUEbFJ7R8oOxb3CYGS/B
         XF6xZAtQ3pTq8NyOJSPFhwHdngu/7Ssw6jKoV/3PqOA54BNjxZfY7C4R3lpOAU/O3vjw
         lhT5kMTCWeg+uaU7VdkAmtfHxEYzjZXoHf7Zw/87OgxoYNfa0bWh51U0ErrLUIaLf5Wf
         Gq+g==
X-Gm-Message-State: AOAM5315w+uXU/ytLKJoLSQWRqXeo3CpdFt1WT0bXWL0bP3mg4BWBW0V
        cVqMQtafpAiqUgOk8/kIyg==
X-Google-Smtp-Source: ABdhPJwYwyFOnVugtnOVfg8AgmEVYg3C6rf+Hwcjg8rs7FalCUYOI3v0RNnferAdv8WDFYik34UcAQ==
X-Received: by 2002:a6b:7e41:: with SMTP id k1mr718192ioq.130.1597251308230;
        Wed, 12 Aug 2020 09:55:08 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a9sm1236374iol.9.2020.08.12.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:55:07 -0700 (PDT)
Received: (nullmailer pid 2363799 invoked by uid 1000);
        Wed, 12 Aug 2020 16:55:04 -0000
Date:   Wed, 12 Aug 2020 10:55:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND v7, PATCH 1/7] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
Message-ID: <20200812165504.GA2361465@bogus>
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
 <1596855231-5782-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596855231-5782-2-git-send-email-yongqiang.niu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 10:53:45AM +0800, Yongqiang Niu wrote:
> rdma fifo size may be different even in same SOC, add this
> property to the corresponding rdma
> 
> Change-Id: I67635ec7f3f59cf4cbc7737285e5e28ff0ab71c9
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index b91e709..e6bbe32 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -66,6 +66,11 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>    for details.
>  
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same SOC, add this

mediatek,rdma-fifo-size

What's the range/set of valid values?

> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +
>  Examples:
>  
>  mmsys: clock-controller@14000000 {
> @@ -207,3 +212,12 @@ od@14023000 {
>  	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>  	clocks = <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +rdma1: rdma@1400c000 {

Does a new property really need a whole new example?

> +	compatible = "mediatek,mt8183-disp-rdma";
> +	reg = <0 0x1400c000 0 0x1000>;
> +	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +	mediatek,rdma_fifo_size = <2048>;
> +};
> -- 
> 1.8.1.1.dirty
