Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89763C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3F12074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="conjEMDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFJGqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFJGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:46:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770BC03E96B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 23:46:36 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so898342otv.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yin6o44RA9C2iY1zjLC7qjeyYuw8En/EwnMzkJfVbHA=;
        b=conjEMDdAu75471GYPOyD9ApfoQNcdTFD9u5fvVioxjXdiCBsEB+nmD8Z4w1ni5NPq
         p7/iun/lO83U7rEO6kET9GTPXj4KA38CjGV466+SVDXTidx3UmZTldHMfCYp6AQg43Uo
         rN/HEqG0rgkZQhoklfs8sI4eYaJqYh0RzM7uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yin6o44RA9C2iY1zjLC7qjeyYuw8En/EwnMzkJfVbHA=;
        b=mpFn78fXv9F6ifvF2R2QexfJ+EWm20ZGx+K7TEwA8jIQ1zBAUOMPxWD+iy0hq8iF8T
         Uz+NegJTVL5YxtitIozUmrSPcwmyc6m21Dfptpg4JV/sO9ziI+OFXcBKj22Xinm6IVYN
         YMnP+87LkoTcmFzW+D2958Duo0f7kpXG+E5Vi+2oGssjbqnWMsiHKF7zDxLSq5tr0eRD
         xay/sN3z/hr8aToZbOAm2brN52pJ20QGmnlVKd9br9a/SsJTOhaSW+A/wnoJSomfv++K
         eOhJOXzHICxqm7rxE7oNt2xfEKAvNsLZCawSl7giVqVf92zjyjVOuPUU++oSK5Z/rfc1
         ehwQ==
X-Gm-Message-State: AOAM531iZcKsU44KVpjMBEodlStm+Pz3JXO7+ZyeWHGbmYxZPTaq3lxx
        qAs/YwAhhpjiZcs2budQfrdMZuaFr6Y=
X-Google-Smtp-Source: ABdhPJyF3P3R5HLcqq1kVBVA9T3Rcw3qLh5ieoLFVD2EE3kWOoZVkMGkVBLNVyKDY97p1eU1VVi4HQ==
X-Received: by 2002:a9d:d24:: with SMTP id 33mr1487227oti.26.1591771593487;
        Tue, 09 Jun 2020 23:46:33 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id z9sm2709015otk.74.2020.06.09.23.46.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:46:32 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id v13so887353otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 23:46:31 -0700 (PDT)
X-Received: by 2002:a05:6830:242e:: with SMTP id k14mr1533456ots.36.1591771590799;
 Tue, 09 Jun 2020 23:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
 <1590826218-23653-2-git-send-email-yong.wu@mediatek.com> <20200609212102.GA1416099@bogus>
In-Reply-To: <20200609212102.GA1416099@bogus>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 10 Jun 2020 15:46:18 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXdbEgWtOx_b5ab3hOTdyPPaGDQ2kA21pLjoLE-2sjuTg@mail.gmail.com>
Message-ID: <CAPBb6MXdbEgWtOx_b5ab3hOTdyPPaGDQ2kA21pLjoLE-2sjuTg@mail.gmail.com>
Subject: Re: [PATCH v4 01/17] media: dt-binding: mtk-vcodec: Separating
 mtk-vcodec encode node.
To:     Rob Herring <robh@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        ming-fan.chen@mediatek.com, eizan@chromium.org,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 6:21 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, May 30, 2020 at 04:10:02PM +0800, Yong Wu wrote:
> > From: Maoguang Meng <maoguang.meng@mediatek.com>
> >
> > Update binding document since the avc and vp8 hardware encoder in
> > mt8173 are now separated. Separate "mediatek,mt8173-vcodec-enc" to
> > "mediatek,mt8173-vcodec-vp8-enc" and "mediatek,mt8173-vcodec-avc-enc".
>
> The h/w suddenly split in 2? You are breaking compatibility. Up to the
> Mediatek maintainers to decide if that's okay, but you need to state you
> are breaking compatibility (here and in the driver) and why that is
> okay.

In my understanding there is no real hardware using the old bindings
at the moment, and the split is indeed a reflection of the actual
hardware layout. Tiffany, can you give your acked-by if this change is
ok with you?

>
> >
> > This is a preparing patch for smi cleaning up "mediatek,larb".
> >
> > Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../devicetree/bindings/media/mediatek-vcodec.txt  | 58 ++++++++++++----------
> >  1 file changed, 31 insertions(+), 27 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > index 8093335..1023740 100644
> > --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > @@ -4,7 +4,9 @@ Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
> >  supports high resolution encoding and decoding functionalities.
> >
> >  Required properties:
> > -- compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
> > +- compatible : must be one of the following string:
> > +  "mediatek,mt8173-vcodec-vp8-enc" for mt8173 vp8 encoder.
> > +  "mediatek,mt8173-vcodec-avc-enc" for mt8173 avc encoder.
> >    "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
> >    "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
> >  - reg : Physical base address of the video codec registers and length of
> > @@ -13,10 +15,11 @@ Required properties:
> >  - mediatek,larb : must contain the local arbiters in the current Socs.
> >  - clocks : list of clock specifiers, corresponding to entries in
> >    the clock-names property.
> > -- clock-names: encoder must contain "venc_sel_src", "venc_sel",,
> > -  "venc_lt_sel_src", "venc_lt_sel", decoder must contain "vcodecpll",
> > -  "univpll_d2", "clk_cci400_sel", "vdec_sel", "vdecpll", "vencpll",
> > -  "venc_lt_sel", "vdec_bus_clk_src".
> > +- clock-names:
> > +   avc venc must contain "venc_sel";
> > +   vp8 venc must contain "venc_lt_sel";
> > +   decoder  must contain "vcodecpll", "univpll_d2", "clk_cci400_sel",
> > +   "vdec_sel", "vdecpll", "vencpll", "venc_lt_sel", "vdec_bus_clk_src".
> >  - iommus : should point to the respective IOMMU block with master port as
> >    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> >    for details.
> > @@ -80,14 +83,10 @@ vcodec_dec: vcodec@16000000 {
> >      assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
> >    };
> >
> > -  vcodec_enc: vcodec@18002000 {
> > -    compatible = "mediatek,mt8173-vcodec-enc";
> > -    reg = <0 0x18002000 0 0x1000>,    /*VENC_SYS*/
> > -          <0 0x19002000 0 0x1000>;    /*VENC_LT_SYS*/
> > -    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>,
> > -              <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
> > -    mediatek,larb = <&larb3>,
> > -                 <&larb5>;
> > +vcodec_enc: vcodec@18002000 {
> > +    compatible = "mediatek,mt8173-vcodec-avc-enc";
> > +    reg = <0 0x18002000 0 0x1000>;
> > +    interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
> >      iommus = <&iommu M4U_PORT_VENC_RCPU>,
> >               <&iommu M4U_PORT_VENC_REC>,
> >               <&iommu M4U_PORT_VENC_BSDMA>,
> > @@ -98,8 +97,20 @@ vcodec_dec: vcodec@16000000 {
> >               <&iommu M4U_PORT_VENC_REF_LUMA>,
> >               <&iommu M4U_PORT_VENC_REF_CHROMA>,
> >               <&iommu M4U_PORT_VENC_NBM_RDMA>,
> > -             <&iommu M4U_PORT_VENC_NBM_WDMA>,
> > -             <&iommu M4U_PORT_VENC_RCPU_SET2>,
> > +             <&iommu M4U_PORT_VENC_NBM_WDMA>;
> > +    mediatek,larb = <&larb3>;
> > +    mediatek,vpu = <&vpu>;
> > +    clocks = <&topckgen CLK_TOP_VENC_SEL>;
> > +    clock-names = "venc_sel";
> > +    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> > +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> > +  };
> > +
> > +vcodec_enc_lt: vcodec@19002000 {
> > +    compatible = "mediatek,mt8173-vcodec-vp8-enc";
> > +    reg =  <0 0x19002000 0 0x1000>;  /* VENC_LT_SYS */
> > +    interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_LOW>;
> > +    iommus = <&iommu M4U_PORT_VENC_RCPU_SET2>,
> >               <&iommu M4U_PORT_VENC_REC_FRM_SET2>,
> >               <&iommu M4U_PORT_VENC_BSDMA_SET2>,
> >               <&iommu M4U_PORT_VENC_SV_COMA_SET2>,
> > @@ -108,17 +119,10 @@ vcodec_dec: vcodec@16000000 {
> >               <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
> >               <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
> >               <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
> > +    mediatek,larb = <&larb5>;
> >      mediatek,vpu = <&vpu>;
> > -    clocks = <&topckgen CLK_TOP_VENCPLL_D2>,
> > -             <&topckgen CLK_TOP_VENC_SEL>,
> > -             <&topckgen CLK_TOP_UNIVPLL1_D2>,
> > -             <&topckgen CLK_TOP_VENC_LT_SEL>;
> > -    clock-names = "venc_sel_src",
> > -                  "venc_sel",
> > -                  "venc_lt_sel_src",
> > -                  "venc_lt_sel";
> > -    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
> > -                      <&topckgen CLK_TOP_VENC_LT_SEL>;
> > -    assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
> > -                             <&topckgen CLK_TOP_UNIVPLL1_D2>;
> > +    clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> > +    clock-names = "venc_lt_sel";
> > +    assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
> > +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
> >    };
> > --
> > 1.9.1
