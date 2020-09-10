Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4718C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8027820719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nY/GFWKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgIJFeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgIJFeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:34:05 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FCBC061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:34:02 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so5023334edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60m4hlTxGIMTHH9zDLpW2r5D85YdOPl2w4joQJnWmwA=;
        b=nY/GFWKyeBX/RUFO9u1oe4hlkrj2e2sOr59SOi/XTYi5toZj9oU+PlC3yWoAwPOFN2
         5i8xIU1YcBt2bAXr6Jp03/gOrEuZTChoV6Eg6JR+z8Bb75FlyvBxuquNU7tXif2hK8k0
         bJKTYNsTwz5EUDsp6fTOQJvRuIvC1csiVVvzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60m4hlTxGIMTHH9zDLpW2r5D85YdOPl2w4joQJnWmwA=;
        b=lYtDvgAgmeS/g/2aodkQP/Tlkf6igLbtucGIG9aGcFpUjWVE6JxBOP3oT9X2/ppSiQ
         wORmnaMLDD+ap4isC6rplo4znpwkr2CyM3+aQsdivV9If72iuYePJy08ZpYSD4hH6CRh
         zSoQ5kvUOlAfYYx4Xm2IQ+CiAMB3k656vxb9pjyHZaMOE0IRc6nxI3HvdNlybsVI/yv5
         U+gJlmUO+duqU5FQFGGv/f0IThtMRfK9aMKXVXY0rhVuj9MUPFAJYVU1b5MEi7fWeKwj
         2CIdbNv+O8jk/ZZsF21c/X9rFJjphkvKx/DytJZfBuJR2nwgyR4jfuiT6age2fNpGSan
         pY1g==
X-Gm-Message-State: AOAM533GyiPVyHbhEcE8i91r07KUW0ypo2dUZgIA0Rs1ZkVSmR0z7oPU
        OHDQ1GOYknrurotbuJCDL4c3G5nDIzlzaYV4jX3B/w==
X-Google-Smtp-Source: ABdhPJxZWL/a+FakIDHKml1deb33cHOcCk+94TvMWao3/i9x9TyStla5QSTT3ONizI1t9/7Icb72n5sslJD4sHHnvic=
X-Received: by 2002:a50:fe0f:: with SMTP id f15mr7513034edt.235.1599716040960;
 Wed, 09 Sep 2020 22:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200909081422.2412795-1-pihsun@chromium.org> <dd5a6b8b-71dc-ce54-1f0d-7fa6b1dd6248@gmail.com>
In-Reply-To: <dd5a6b8b-71dc-ce54-1f0d-7fa6b1dd6248@gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 10 Sep 2020 13:33:24 +0800
Message-ID: <CANdKZ0dAWG7CyNF9064+WBC_7q8M=S6=Q30TFz9fpgd4YbOsOw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8183-kukui: add scp node
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 4:58 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 09/09/2020 10:14, Pi-Hsun Shih wrote:
> > Add scp node to mt8183-kukui
> >
> > Fixes: 0d5e41709f76 ("arm64: dts: mt8183: add scp node")
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > ---
> >
> > Change since v1:
> > * Add Fixes tag.
> >
> > ---
> >   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 30 +++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index f0a070535b34..85f7c33ba446 100644
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
>
> Do we expect other boards to have a different memory reservation? I can see that
> EVB and Kukui uses the same. If not, we should add the node in mt8183.dtsi instead.
>
> Regards,
> Matthias

All our current boards use the same memory reservation, but it's still
possible for future boards based on mt8183 to use different SCP memory
size, so I feel this should still be left out of mt8183.dtsi.

>
> >       max98357a: codec0 {
> >               compatible = "maxim,max98357a";
> >               sdmode-gpios = <&pio 175 0>;
> > @@ -524,6 +536,13 @@ pins_clk {
> >               };
> >       };
> >
> > +     scp_pins: scp {
> > +             pins_scp_uart {
> > +                     pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
> > +                              <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
> > +             };
> > +     };
> > +
> >       spi0_pins: spi0 {
> >               pins_spi{
> >                       pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
> > @@ -651,6 +670,17 @@ pins_wifi_wakeup {
> >       };
> >   };
> >
> > +&scp {
> > +     status = "okay";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&scp_pins>;
> > +
> > +     cros_ec {
> > +             compatible = "google,cros-ec-rpmsg";
> > +             mtk,rpmsg-name = "cros-ec-rpmsg";
> > +     };
> > +};
> > +
> >   &soc_data {
> >       status = "okay";
> >   };
> >
