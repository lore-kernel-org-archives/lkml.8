Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A22C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33289208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ox24dyt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIJVae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbgIJNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:52:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:41:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so7111812ioa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTlbqLOdrEt7UPiiXLx6yUBn8+Vw9g0DGn2N0VRJHZQ=;
        b=Ox24dyt6nVjtGDGN1CPYXDGOo/2oq3U8X/r9mzO/S9lH3U3T8OSsyYjG9fjzR+qgBD
         5ugaO811qVghi5tQ9nmTEt34eIyJfKTARh95uAu2ms6P0BKuV2yCJqhhTgTpckA3wY5V
         5owBQNpU8wLydaLeTRaUOOfcne0j1r0lFOIQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTlbqLOdrEt7UPiiXLx6yUBn8+Vw9g0DGn2N0VRJHZQ=;
        b=WemHMWCdWw7KDZ8WQt/R8J2Tfonw5oGFhvJTqrbUDU8PgSaK+/cr6kq35NIWfnc12K
         FEZDP5geAc85mB5osxTsb/8M1yFvaT5rhknC1fDdmmEj0h0Kj4i3uHMHqd7ufl2rRcPZ
         uybP3wr3FPp37tTieCyOkJGxaMK7UYERjXTfnxX6dzn0OOdQDx4c5e6ALkWCKR6xPmz7
         ePXtuZeVqjb6kH5E5NISsnR8TBR6TpCG6PMvwrdMy9jKIFpiICnhQ7VDW96xePfXX2xU
         A6ztI5nM7XAY7bL0f7WFrr/C6Sk3fOhIVqsuJ4Ixe2/ANVAlyBgokwylq6poPBe303rX
         0MhA==
X-Gm-Message-State: AOAM532djq1bD0yC4r0zYr+cgwyFRv/EP992/jewU81zdpjctCKqknIz
        Ry3J56fAXuwM4brvaYjXnSnaBNfOo9TfPLCT9+u1Wc+5IclcAb6F
X-Google-Smtp-Source: ABdhPJx7rimxRz7QDx2lJr2uFaq/N7i1d6SG+0JOvjQrq9+OiBQgm/jvkZqZfSOI7yKji0+UoevlSl35L019lILyyVY=
X-Received: by 2002:a5e:930d:: with SMTP id k13mr7562170iom.40.1599745286349;
 Thu, 10 Sep 2020 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084304.3429494-1-hsinyi@chromium.org> <9ca1b7c0-9fec-27b7-ae08-c00613c3004c@gmail.com>
In-Reply-To: <9ca1b7c0-9fec-27b7-ae08-c00613c3004c@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 10 Sep 2020 21:40:59 +0800
Message-ID: <CAJMQK-g+pPR6ZrSJHPPcR9Tqw_4QjuMyUqML-RoPOjfnYZ=YGA@mail.gmail.com>
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

On Thu, Sep 10, 2020 at 6:25 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> Hi,
>
> On 10/09/2020 10:43, Hsin-Yi Wang wrote:
> > Set uart iotype to mmio32 to make earlycon work with stdout-path.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 5e046f9d48ce9..ca6ea71f5f435 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -613,6 +613,8 @@ uart0: serial@11002000 {
> >                       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> >                       clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
> >                       clock-names = "baud", "bus";
> > +                     reg-io-width = <4>;
>
> Why do we need that, we have
> device->port.iotype = UPIO_MEM32;
> in early_mtk8250_setup(). That should do the job already.
>
>

But if we don't change in dts, we would see
[    0.000000] earlycon: mtk8250 at MMIO 0x0000000011002000 (options '115200n8')
instead of
[    0.000000] earlycon: mtk8250 at MMIO32 0x0000000011002000 (options
'115200n8')

Perhaps we should move the pr_info part in earlycon_init() after
match->setup(). Since setup may change iotype. What do you think?


> > +                     reg-shift = <2>;
>
> Can't we just add
> device->port.regshift = 2;
> to early_mtk8250_setup()? I think that would be a cleaner solution. As the
> serial device is the same for all SoCs, I don't expect any regression here.
>
> CCing Eddie to correct me, if I'm wrong :)
>
> Regards,
> Matthias
>
> >                       status = "disabled";
> >               };
> >
> > @@ -623,6 +625,8 @@ uart1: serial@11003000 {
> >                       interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
> >                       clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
> >                       clock-names = "baud", "bus";
> > +                     reg-io-width = <4>;
> > +                     reg-shift = <2>;
> >                       status = "disabled";
> >               };
> >
> > @@ -633,6 +637,8 @@ uart2: serial@11004000 {
> >                       interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
> >                       clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
> >                       clock-names = "baud", "bus";
> > +                     reg-io-width = <4>;
> > +                     reg-shift = <2>;
> >                       status = "disabled";
> >               };
> >
> > @@ -643,6 +649,8 @@ uart3: serial@11005000 {
> >                       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
> >                       clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
> >                       clock-names = "baud", "bus";
> > +                     reg-io-width = <4>;
> > +                     reg-shift = <2>;
> >                       status = "disabled";
> >               };
> >
> >
