Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A888C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D01621D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kYYtjn4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIKJnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIKJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:43:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736DFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:43:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b6so10329734iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNzl7xSh7GeYDHs6F5Ee65tcB8SqNtnecrQQkoWodP0=;
        b=kYYtjn4J6Wg5q1cke3GsLsCSOoUQNBxGd/bYFJ65ZjZzFRei0UT3FxD5Z1/2fTN5c2
         sup6bN9bMyISt6qdA8xiEak/Iaor27vcznZQ2oe5rwYHes77LXMtCrDfSqJKY1Kmq2wV
         tK2wDoOsfpJfNH19YLo6Kua3O9Mxzid9qqAG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNzl7xSh7GeYDHs6F5Ee65tcB8SqNtnecrQQkoWodP0=;
        b=IrWeURE9U/ZssCNHn6FyP1DVlCrKjkA+fPezLJ2iJGBM8D2nxE6HO89ykXCyWjgbPO
         gX9OV5dbKHaQIjMQhCzBnh6kNOdVUoSpKNDL6O5b88zMCcxULAYmPEcx1mIYaFipMcmQ
         ZTlj/0j3UdtuFvAxjo1qh1RKd4RFbGgV0adJpQTm36VB2omi5bkPStTMvRDAyGP/yMRX
         fXh0muUZRWDzBg1uW6e9qS5szxxtLnbmDU14/iaXuCr2XmFwvVtidKlgu6wxR+I2bm3h
         LA6uSBPdIAEOJSFV9FJGv8K1f/1RjjUN4+veiqhPwnNkyBjWzxSqhJq4Y77OB1jwhkyL
         0twQ==
X-Gm-Message-State: AOAM532TmLxBeo/j01MR4YCzXIndycS86Nv3PB0KLt3DimFbyZwfYDHj
        JhEpBKQJeW9z9H6BWiGigJ6hr41V9Q+Nl0nZJ2z1Hw==
X-Google-Smtp-Source: ABdhPJzoiPOjS7GczBk4qpUIiLCY5BgKwWxC1Z2daUO/hLybds7C4dJoOq5cRA1EXajuX3+ksvlemLAahJbJaPldn9Y=
X-Received: by 2002:a05:6638:1643:: with SMTP id a3mr1105122jat.4.1599817412402;
 Fri, 11 Sep 2020 02:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084304.3429494-1-hsinyi@chromium.org> <9ca1b7c0-9fec-27b7-ae08-c00613c3004c@gmail.com>
 <CAJMQK-g+pPR6ZrSJHPPcR9Tqw_4QjuMyUqML-RoPOjfnYZ=YGA@mail.gmail.com>
In-Reply-To: <CAJMQK-g+pPR6ZrSJHPPcR9Tqw_4QjuMyUqML-RoPOjfnYZ=YGA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 11 Sep 2020 17:43:06 +0800
Message-ID: <CAJMQK-gOqTJGgbY3XjOM112vyDQVKKOD3k2XEnJwji2b1TJhRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8173: Set uart to mmio32 iotype
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 9:40 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Thu, Sep 10, 2020 at 6:25 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> > Hi,
> >
> > On 10/09/2020 10:43, Hsin-Yi Wang wrote:
> > > Set uart iotype to mmio32 to make earlycon work with stdout-path.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > >   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > index 5e046f9d48ce9..ca6ea71f5f435 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > > @@ -613,6 +613,8 @@ uart0: serial@11002000 {
> > >                       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> > >                       clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
> > >                       clock-names = "baud", "bus";
> > > +                     reg-io-width = <4>;
> >
> > Why do we need that, we have
> > device->port.iotype = UPIO_MEM32;
> > in early_mtk8250_setup(). That should do the job already.
> >
> >
>
> But if we don't change in dts, we would see
> [    0.000000] earlycon: mtk8250 at MMIO 0x0000000011002000 (options '115200n8')
> instead of
> [    0.000000] earlycon: mtk8250 at MMIO32 0x0000000011002000 (options
> '115200n8')
>
> Perhaps we should move the pr_info part in earlycon_init() after
> match->setup(). Since setup may change iotype. What do you think?
>

The series is sent here: https://lore.kernel.org/patchwork/patch/1304227/

Thanks.
