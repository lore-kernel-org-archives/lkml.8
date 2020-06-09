Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B053420737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591737669;
	bh=4g05s1/0NJCdGzMh5XyjsEioFbdA5s59aNCJGXUsaQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iNspIEym2ttryjTLWCnJvWPhNeCUV005H8a0srMlJ4SmkwtT6RBNEwFWAWVwViZEa
	 eDia4tkcfOL0suZwWmSaYQRU8I7w9s+JMw3vjpv1wD3LLbyAQneskcT28l7bc73M6i
	 Lms0pRtLfHzerzQrI14k/KF94Bd8an4U+ny4OQAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFIVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:21:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43554 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIVVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:21:06 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so18263631iol.10;
        Tue, 09 Jun 2020 14:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWzC2J2zPBRq99zmTAamTkCvAWsJFf56m/YNmkrqhjI=;
        b=WpVQIIlGaT7GHfPy8UAw75MaI+G1k59qlcugCBcJNgUf2rcTyK4ltjDnAcwK72E65F
         1BArMFpQXlwP8+Nbddsq6fXmMzRRVHWagCZcghDabJLOtJ9AHkd/Dloif9ddeAmk1tK/
         PF7FqvPfqIy36AZOUm/pugeRTzyyUTTqz3RfroNJmeeSDFzlW4x+o26eRjkTmoEkmXZ4
         etJ27NhBTFRcnDPK19ZoE/sm9IaSJqFOvPmyJ1iLMC8d1+wDCYtib8PPevFTaZ/qXTx1
         L5He4HBm1Sz1EuugSpm0v+lvmMUM/S45eTovOcgggn1ddpoF0ZlCatLZiZzPuv6p1O1i
         /xLA==
X-Gm-Message-State: AOAM531iXnc/JTUrM+oYIjQWRK3x/GJBXbo8K80ODhufwbNtDj/9cGDC
        cJl0KuZz2GxQkDlvZRbxBTWnJPc=
X-Google-Smtp-Source: ABdhPJwnyzqbzPdYRqQxyLBKph1AldYmaBNWEcQWN9kmn6fKm8rVJxp6frtZvPtxIvPRx1BxIouxcQ==
X-Received: by 2002:a6b:39d7:: with SMTP id g206mr64811ioa.31.1591737664915;
        Tue, 09 Jun 2020 14:21:04 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m90sm10061329ilb.79.2020.06.09.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 14:21:04 -0700 (PDT)
Received: (nullmailer pid 1492410 invoked by uid 1000);
        Tue, 09 Jun 2020 21:21:02 -0000
Date:   Tue, 9 Jun 2020 15:21:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        ming-fan.chen@mediatek.com, eizan@chromium.org,
        acourbot@chromium.org, Maoguang Meng <maoguang.meng@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>
Subject: Re: [PATCH v4 01/17] media: dt-binding: mtk-vcodec: Separating
 mtk-vcodec encode node.
Message-ID: <20200609212102.GA1416099@bogus>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
 <1590826218-23653-2-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590826218-23653-2-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 04:10:02PM +0800, Yong Wu wrote:
> From: Maoguang Meng <maoguang.meng@mediatek.com>
> 
> Update binding document since the avc and vp8 hardware encoder in
> mt8173 are now separated. Separate "mediatek,mt8173-vcodec-enc" to
> "mediatek,mt8173-vcodec-vp8-enc" and "mediatek,mt8173-vcodec-avc-enc".

The h/w suddenly split in 2? You are breaking compatibility. Up to the 
Mediatek maintainers to decide if that's okay, but you need to state you 
are breaking compatibility (here and in the driver) and why that is 
okay.

> 
> This is a preparing patch for smi cleaning up "mediatek,larb".
> 
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek-vcodec.txt  | 58 ++++++++++++----------
>  1 file changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> index 8093335..1023740 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> @@ -4,7 +4,9 @@ Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
>  supports high resolution encoding and decoding functionalities.
>  
>  Required properties:
> -- compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
> +- compatible : must be one of the following string:
> +  "mediatek,mt8173-vcodec-vp8-enc" for mt8173 vp8 encoder.
> +  "mediatek,mt8173-vcodec-avc-enc" for mt8173 avc encoder.
>    "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
>    "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
>  - reg : Physical base address of the video codec registers and length of
> @@ -13,10 +15,11 @@ Required properties:
>  - mediatek,larb : must contain the local arbiters in the current Socs.
>  - clocks : list of clock specifiers, corresponding to entries in
>    the clock-names property.
> -- clock-names: encoder must contain "venc_sel_src", "venc_sel",,
> -  "venc_lt_sel_src", "venc_lt_sel", decoder must contain "vcodecpll",
> -  "univpll_d2", "clk_cci400_sel", "vdec_sel", "vdecpll", "vencpll",
> -  "venc_lt_sel", "vdec_bus_clk_src".
> +- clock-names:
> +   avc venc must contain "venc_sel";
> +   vp8 venc must contain "venc_lt_sel";
> +   decoder  must contain "vcodecpll", "univpll_d2", "clk_cci400_sel",
> +   "vdec_sel", "vdecpll", "vencpll", "venc_lt_sel", "vdec_bus_clk_src".
>  - iommus : should point to the respective IOMMU block with master port as
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>    for details.
> @@ -80,14 +83,10 @@ vcodec_dec: vcodec@16000000 {
>      assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
>    };
>  
> -  vcodec_enc: vcodec@18002000 {
> -    compatible = "mediatek,mt8173-vcodec-enc";
> -    reg = <0 0x18002000 0 0x1000>,    /*VENC_SYS*/
> -          <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
> -    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
> -		 <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
> -    mediatek,larb = <&larb3>,
> -		    <&larb5>;
> +vcodec_enc: vcodec@18002000 {
> +    compatible = "mediatek,mt8173-vcodec-avc-enc";
> +    reg = <0 0x18002000 0 0x1000>;
> +    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
>      iommus = <&iommu M4U_PORT_VENC_RCPU>,
>               <&iommu M4U_PORT_VENC_REC>,
>               <&iommu M4U_PORT_VENC_BSDMA>,
> @@ -98,8 +97,20 @@ vcodec_dec: vcodec@16000000 {
>               <&iommu M4U_PORT_VENC_REF_LUMA>,
>               <&iommu M4U_PORT_VENC_REF_CHROMA>,
>               <&iommu M4U_PORT_VENC_NBM_RDMA>,
> -             <&iommu M4U_PORT_VENC_NBM_WDMA>,
> -             <&iommu M4U_PORT_VENC_RCPU_SET2>,
> +             <&iommu M4U_PORT_VENC_NBM_WDMA>;
> +    mediatek,larb = <&larb3>;
> +    mediatek,vpu = <&vpu>;
> +    clocks = <&topckgen CLK_TOP_VENC_SEL>;
> +    clock-names = "venc_sel";
> +    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> +  };
> +
> +vcodec_enc_lt: vcodec@19002000 {
> +    compatible = "mediatek,mt8173-vcodec-vp8-enc";
> +    reg =  <0 0x19002000 0 0x1000>;	/* VENC_LT_SYS */
> +    interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
> +    iommus = <&iommu M4U_PORT_VENC_RCPU_SET2>,
>               <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
>               <&iommu M4U_PORT_VENC_BSDMA_SET2>,
>               <&iommu M4U_PORT_VENC_SV_COMA_SET2>,
> @@ -108,17 +119,10 @@ vcodec_dec: vcodec@16000000 {
>               <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
>               <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
>               <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
> +    mediatek,larb = <&larb5>;
>      mediatek,vpu = <&vpu>;
> -    clocks = <&topckgen CLK_TOP_VENCPLL_D2>,
> -             <&topckgen CLK_TOP_VENC_SEL>,
> -             <&topckgen CLK_TOP_UNIVPLL1_D2>,
> -             <&topckgen CLK_TOP_VENC_LT_SEL>;
> -    clock-names = "venc_sel_src",
> -                  "venc_sel",
> -                  "venc_lt_sel_src",
> -                  "venc_lt_sel";
> -    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
> -                      <&topckgen CLK_TOP_VENC_LT_SEL>;
> -    assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
> -                             <&topckgen CLK_TOP_UNIVPLL1_D2>;
> +    clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> +    clock-names = "venc_lt_sel";
> +    assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
>    };
> -- 
> 1.9.1
