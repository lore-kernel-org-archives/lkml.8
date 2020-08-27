Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B74C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A24207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l05Z2XNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgH0KKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0KK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:10:29 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18186C061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:10:29 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so4139901oic.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xffebcZYdssVBz8b/QGkKBNNZIu8AR2B8ONx8ST79Rg=;
        b=l05Z2XNwo9iN0IeRxk31CvVymxJLIWzAvOT2mBoYkYYzTJymUK9sjFd12SkKSAiz38
         u4xyukMukt4+GYw0oe/HkZIXaoF182cC8VkEA3gTeGYzK3qsZWk31w38wCmo56FMGsvk
         3jdbM2vEmwhPHGW/6+wrbMhD4hzf+RrIX6lKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xffebcZYdssVBz8b/QGkKBNNZIu8AR2B8ONx8ST79Rg=;
        b=TATVNdhxk0YuOJN7bMmhcT5owa9RMY45ntsjNDsn45Fn6XLol2BDXozysGZT9vSnkO
         gLsZN2vK5BwDHR4FihLh/foLIBwGoIkozmcFYvkP2jFMiuXDRQoRIAO/JFsULEjjoEf/
         BiA54JQFBdfgkQ9z/E8DRpG7P8KpkNIo1YtQA00Hu4/lhal7tgra8aFl+aEjt0GE1qYc
         9yMIKZF8OkNdRpQ53AXvfBFMcI5c83nm6cU5UfswHS/NlqcnNV1B9rtQ9mQE4p2gjalX
         WI/ySvxBaxDZowax/IGyqO4/pkEThDVdy5lWop0b5ZtV8cYbWtSKSgR5nSBwTlbVdGRI
         stPA==
X-Gm-Message-State: AOAM531jxtfXyPIDG4LrG2C6okLkrwfGqrZ4cQ8q2flSkmrhFD3J9ZB0
        H1VaWuJFV2YdsBLIybII2jtYKzmrvRsAag==
X-Google-Smtp-Source: ABdhPJwOh34XlJWBEocdp7lQanlJmMiMkBKtl+6nZiAGns3/6D4EBxTGMhuQMk/oYeQjBFqZP729KA==
X-Received: by 2002:aca:bf09:: with SMTP id p9mr6538381oif.157.1598523027014;
        Thu, 27 Aug 2020 03:10:27 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 105sm365832oti.13.2020.08.27.03.10.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:10:25 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id m4so1097510oos.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:10:25 -0700 (PDT)
X-Received: by 2002:a4a:d62c:: with SMTP id n12mr13629175oon.38.1598523025055;
 Thu, 27 Aug 2020 03:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200821103608.2310097-1-acourbot@chromium.org>
 <20200821103608.2310097-10-acourbot@chromium.org> <02eaeace-22dd-02ea-7162-90200fe1cffe@gmail.com>
In-Reply-To: <02eaeace-22dd-02ea-7162-90200fe1cffe@gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 27 Aug 2020 19:10:13 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWZRKpg-rs7X_j3tqqsYHy=NkEMN1NdZwPS9zo-0whTJw@mail.gmail.com>
Message-ID: <CAPBb6MWZRKpg-rs7X_j3tqqsYHy=NkEMN1NdZwPS9zo-0whTJw@mail.gmail.com>
Subject: Re: [PATCH v4 09/17] arm64: dts: mt8183: add encoder node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 7:03 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 21/08/2020 12:36, Alexandre Courbot wrote:
> > Now that the MT8183 encoder driver is ready, add its DT node. Also pull
> > the iommu and scp ones, which the encoder depends upon.
>
> Please don't do that. Instead of pulling in other DT nodes, it would be handy to
> get a reference of the series this is based on.
>
> Let me try to hunt them down now :)

Sorry, I'm not sure to understand - do you mean each node should come
with its own patch? Or that all the code should be merged before
sending these nodes? The rest of this series should land into the
media tree soon, if you prefer I can resend this patch separately once
that happens.

>
> Regards,
> Matthias
>
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 10 ++++++
> >   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 12 +++++++
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 36 +++++++++++++++++++
> >   3 files changed, 58 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > index ae405bd8f06b..9e77b420eee8 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > @@ -25,6 +25,16 @@ memory@40000000 {
> >       chosen {
> >               stdout-path = "serial0:921600n8";
> >       };
> > +     reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +             scp_mem_reserved: scp_mem_region {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0 0x50000000 0 0x2900000>;
> > +                     no-map;
> > +             };
> > +     };
> >   };
> >
> >   &auxadc {
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index f0a070535b34..3c763be658da 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -90,6 +90,18 @@ pp3300_alw: regulator6 {
> >               regulator-max-microvolt = <3300000>;
> >       };
> >
> > +     reserved_memory: reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             scp_mem_reserved: scp_mem_region {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0 0x50000000 0 0x2900000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> >       max98357a: codec0 {
> >               compatible = "maxim,max98357a";
> >               sdmode-gpios = <&pio 175 0>;
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 102105871db2..8f77eea6df27 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -8,6 +8,7 @@
> >   #include <dt-bindings/clock/mt8183-clk.h>
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >   #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/memory/mt8183-larb-port.h>
> >   #include <dt-bindings/reset-controller/mt8183-resets.h>
> >   #include <dt-bindings/phy/phy.h>
> >   #include "mt8183-pinfunc.h"
> > @@ -339,6 +340,25 @@ pwrap: pwrap@1000d000 {
> >                       clock-names = "spi", "wrap";
> >               };
> >
> > +             iommu: iommu@10205000 {
> > +                     compatible = "mediatek,mt8183-m4u";
> > +                     reg = <0 0x10205000 0 0x1000>;
> > +                     interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
> > +                     #iommu-cells = <1>;
> > +             };
> > +
> > +             scp: scp@10500000 {
> > +                     compatible = "mediatek,mt8183-scp";
> > +                     reg = <0 0x10500000 0 0x80000>,
> > +                           <0 0x105c0000 0 0x19080>;
> > +                     reg-names = "sram", "cfg";
> > +                     interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&infracfg CLK_INFRA_SCPSYS>;
> > +                     clock-names = "main";
> > +                     memory-region = <&scp_mem_reserved>;
> > +                     status = "disabled";
> > +             };
> > +
> >               systimer: timer@10017000 {
> >                       compatible = "mediatek,mt8183-timer",
> >                                    "mediatek,mt6765-timer";
> > @@ -772,6 +792,22 @@ vencsys: syscon@17000000 {
> >                       #clock-cells = <1>;
> >               };
> >
> > +             vcodec_enc: vcodec@17020000 {
> > +                     compatible = "mediatek,mt8183-vcodec-enc";
> > +                     reg = <0 0x17020000 0 0x1000>;
> > +                     interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_LOW>;
> > +                     iommus = <&iommu M4U_PORT_VENC_REC>,
> > +                              <&iommu M4U_PORT_VENC_BSDMA>,
> > +                              <&iommu M4U_PORT_VENC_RD_COMV>,
> > +                              <&iommu M4U_PORT_VENC_CUR_LUMA>,
> > +                              <&iommu M4U_PORT_VENC_CUR_CHROMA>,
> > +                              <&iommu M4U_PORT_VENC_REF_LUMA>,
> > +                              <&iommu M4U_PORT_VENC_REF_CHROMA>;
> > +                     mediatek,scp = <&scp>;
> > +                     clocks = <&vencsys CLK_VENC_VENC>;
> > +                     clock-names = "MT_CG_VENC";
> > +             };
> > +
> >               ipu_conn: syscon@19000000 {
> >                       compatible = "mediatek,mt8183-ipu_conn", "syscon";
> >                       reg = <0 0x19000000 0 0x1000>;
> >
