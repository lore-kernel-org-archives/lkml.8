Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E41206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScyKUI9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEOJZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:25:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBF2C061A0C;
        Fri, 15 May 2020 02:25:07 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id x5so1900681ioh.6;
        Fri, 15 May 2020 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cc4MG6c747g2GpEAJm056wqMJo63ltnWhdsdBk/YjvU=;
        b=ScyKUI9YtsU9p9A901j1O1w7H7TdnTlwcnuWzKYRo3T+bqoIZc8vOQ9X95sdz82tnm
         urIdlt/GUp9Yfq/9xFWZj8mjEJR05XCX47NoY/P6Qt0R26F6a4+luq3nyePE1nmFInMi
         6BAfAKoBoWEhG6za8fIQD/VCbuJv1yUxDeWf/yoarFgULSJjRsGjQawtvMMXahIIItR+
         KspUduc8eOvKKZ1LH2ZaKUn870ew37S9JgdauJkgRN1oLquW5K4IJPZ6HqXyZzq+NGxx
         sE/WbC8Y9Ybw+RAytAcJEnTXxxp56g590pE4tr+7ttn7UIBYdlYCf8fDbzQ8qu7KV+M1
         0QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cc4MG6c747g2GpEAJm056wqMJo63ltnWhdsdBk/YjvU=;
        b=bqDRC6qrgHNSLoIbdI08eyjFl5boo4tyhw0ECAM/gjLv3SBFUvYLQT1Q6oeOK8mDQF
         vFYCcTj7UdaalLcVV249irNPwy62KRl5KYP3h+c6PhU11aZd7YPm6Ensu86n5ZU0KbZ3
         Z6ifHdWCafQlLtMIkUmct04cr9HYmuioi8RzyIDFTPXnJeDneAVno3z8uw57f1+lvU/1
         qxyErMXx/2jVTNDdGsnfJ9DaY4JisWVROayaitkswvw+q9hPLce93IKLUR75fajdehlC
         tK0SANhGl8kMBSLnUmyi7Eh9sUhy4tyvJ9g7CV9tFkiO9NomdJJ+CltV4aCvED6bX5T/
         aJpg==
X-Gm-Message-State: AOAM533Oax1RJPL989pmSnl56QH9JpauNArbUCs4Du+mf+elBJjicLrS
        2GwVfggeo80r8tWCRiWm2MmY5cTIO5sw/XS6mO4=
X-Google-Smtp-Source: ABdhPJyr7Q+WoA1oeyUp1TGmDyNR7js+O5d1aEorqbluWDehBMJqofjEnccsNnqBusTGHRHYyHOE+n76LGnfJ7BM2as=
X-Received: by 2002:a05:6638:1121:: with SMTP id f1mr2281062jar.62.1589534706577;
 Fri, 15 May 2020 02:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
 <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
 <a4ebd7cd-5756-0683-135f-0f96be8a4a7b@st.com> <CAL9mu0Jt_xwo5pJfcx6G3grBuOaxLXvakpEjiB4gV3=bkiq2fg@mail.gmail.com>
 <818b93b4-4431-8338-cd90-ed125ecac615@st.com>
In-Reply-To: <818b93b4-4431-8338-cd90-ed125ecac615@st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 15 May 2020 17:24:29 +0800
Message-ID: <CAL9mu0L6d2V5qypPfOSeMdhc=DdHkcsaF4GysNG-vfDe5npkhw@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding
 with ili9341 on stm32429-disco board
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

thanks for reply.

On Fri, May 15, 2020 at 4:31 PM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
>
> On 5/14/20 3:07 PM, dillon min wrote:
> > Hi Alexandre,
> >
> > On Thu, May 14, 2020 at 8:53 PM Alexandre Torgue
> > <alexandre.torgue@st.com> wrote:
> >>
> >>
> >> On 5/14/20 10:24 AM, Linus Walleij wrote:
> >>> On Tue, May 12, 2020 at 9:04 AM <dillon.minfei@gmail.com> wrote:
> >>>
> >>>> From: dillon min <dillon.minfei@gmail.com>
> >>>>
> >>>> Enable the ltdc & ili9341 on stm32429-disco board.
> >>>>
> >>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> >>> This mostly looks good but...
> >>>
> >>>> +&spi5 {
> >>>> +       status = "okay";
> >>>> +       pinctrl-0 = <&spi5_pins>;
> >>>> +       pinctrl-names = "default";
> >>>> +       #address-cells = <1>;
> >>>> +       #size-cells = <0>;
> >>>> +       cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
> >>>> +       dmas = <&dma2 3 2 0x400 0x0>,
> >>>> +              <&dma2 4 2 0x400 0x0>;
> >>>> +       dma-names = "rx", "tx";
> >>> These DMA assignments seem to be SoC things and should
> >>> rather be in the DTS(I) file where &spi5 is defined, right?
> >>> stm32f429.dtsi I suppose?
> >> I agree with Linus, DMA have to be defined in SoC dtsi. And if a board
> >> doesn't want to use it, we use the "delete-property".
> > Yes, will move to Soc dtsi in next submits.
> >
> > i'm working on write a v4l2-m2m driver for dma2d of stm32 to support
> > pixel conversion
> > alpha blending between foreground and background graphics.
> >
> > as you know, some soc's engineer trying to add this function to drm system.
> >
> > do you know st's planning about soc's hardware accelerator driver on stm32mp?
> > such as chrom-art, will add to drm subsystem via ioctl to access, or to v4l2,
> On stm32mp we do not plan to use chrom-art in drm or v4l2 because it
> does fit
> with userland way of working. We use the GPU to do conversion, scaling,
> blending
> and composition in only one go.
> As explain here [1] DRM subsytem it isn't a solution and v4l2-m2m isn't
> used in any
> mainline compositors like Weston or android surfaceflinger.
>
> Benjamin
>

After check stm32mp's datasheets, they don't have chrom-art ip inside. sorry for
didn't check it yet.

for stm32h7 series with chrom-art, jpeg hardware accelerator inside.
does st has plan to
setup a driver to support it ? i prefer v4l2-m2m should be easier to
implement it.
co work with dcmi, fbdev.

thanks.

best regards.

Dillon
> [1]
> https://www.phoronix.com/scan.php?page=news_item&px=Linux-DRM-No-2D-Accel-API
> >
> > thanks.
> >
> >>> It is likely the same no matter which device is using spi5.
> >>>
> >>> Yours,
> >>> Linus Walleij
> >>>
> > _______________________________________________
> > Linux-stm32 mailing list
> > Linux-stm32@st-md-mailman.stormreply.com
> > https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
