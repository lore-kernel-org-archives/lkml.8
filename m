Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BB220728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQy57Gtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgENNIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENNIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:08:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1112C061A0C;
        Thu, 14 May 2020 06:08:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so1064720iow.8;
        Thu, 14 May 2020 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxjLQAmlgCmIbW66ttakmR+UHsu55ZGYYjiNgQ7pD60=;
        b=HQy57GttiwVxh24sQLfeiQngcOiErLC6lrc6A6arkVum1pGd0PXCrQaHvOCK4hPNEV
         b/059ZwlWVA1AS8FK1q2/gCJIeug5/mReyn6myQQGKj7Nqz7CVRv86DNFSRbqqL9jNJu
         tITMdAKorHxeF7YvlIBXB8sc7+tzC2Jw9Tf81bsZ6FJbcXdDfUt6nlqKXBjb5tQmn5MB
         gsR5CUzH/zKAUZsVkX976vv3QKAm1v8PnXFZ2eAaurKTEVbK4xwSxyYq0RD28bfWf5Cm
         c7yPr6SgCzeFtV1ZHtYdDrrDUR4DC+KkcElHzh4hDhUaeG4VHhyQV+JNQPmJwrKZiy5d
         Dj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxjLQAmlgCmIbW66ttakmR+UHsu55ZGYYjiNgQ7pD60=;
        b=uDIITVugJ18J9MzAI1K+7uH1u3m1je5J4rJ+RkFXN/vQGs5ORJGQUAdFRVwL8CvoUo
         s9W/PI70ZJjjQr+sk9hHXil6NBfoDeOuhRIzULjy5811CxksvyX+qQPt1UI3UffBzwV4
         JkoyDMsEIy1/isXnh9zp8w70brsnypgRgsR6tmU+hlBpeCGRGS7Cph9lmNAt6t+J3ZQJ
         0BfH8CDTbQtNf6yaLQP0QJRlDC7NxkgvnL6yMlud9w/f7MQOvtukjSfz5B+lRRte3ycS
         WgZRFzVvlwfUSyHRGIc4RWHgBLS0WGIP8iJP3HooxRQDYXXv8XU1ea48WK86PWVCJXAq
         E4vQ==
X-Gm-Message-State: AOAM533KS1NSUVIvgJ/r7+LxyfLkzvAIGEZ5mnRVXLJv9oYeMQapcr2P
        jTmstuOgHgN7+KYVy4ztAmw536EefhUULf30/n8=
X-Google-Smtp-Source: ABdhPJxFXm/snfV7f+PaeEk0/JpSTrHSkPZMuSqd6hBKK/zxQapVp8rf2U8UIu+qvc9Q33J56Hi8hFlnpuvp0XR2Wlk=
X-Received: by 2002:a5d:8b8e:: with SMTP id p14mr3979084iol.110.1589461696306;
 Thu, 14 May 2020 06:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
 <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com> <a4ebd7cd-5756-0683-135f-0f96be8a4a7b@st.com>
In-Reply-To: <a4ebd7cd-5756-0683-135f-0f96be8a4a7b@st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 14 May 2020 21:07:40 +0800
Message-ID: <CAL9mu0Jt_xwo5pJfcx6G3grBuOaxLXvakpEjiB4gV3=bkiq2fg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding with ili9341
 on stm32429-disco board
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Thu, May 14, 2020 at 8:53 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
>
>
> On 5/14/20 10:24 AM, Linus Walleij wrote:
> > On Tue, May 12, 2020 at 9:04 AM <dillon.minfei@gmail.com> wrote:
> >
> >> From: dillon min <dillon.minfei@gmail.com>
> >>
> >> Enable the ltdc & ili9341 on stm32429-disco board.
> >>
> >> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> >
> > This mostly looks good but...
> >
> >> +&spi5 {
> >> +       status = "okay";
> >> +       pinctrl-0 = <&spi5_pins>;
> >> +       pinctrl-names = "default";
> >> +       #address-cells = <1>;
> >> +       #size-cells = <0>;
> >> +       cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
> >> +       dmas = <&dma2 3 2 0x400 0x0>,
> >> +              <&dma2 4 2 0x400 0x0>;
> >> +       dma-names = "rx", "tx";
> >
> > These DMA assignments seem to be SoC things and should
> > rather be in the DTS(I) file where &spi5 is defined, right?
> > stm32f429.dtsi I suppose?
>
> I agree with Linus, DMA have to be defined in SoC dtsi. And if a board
> doesn't want to use it, we use the "delete-property".
Yes, will move to Soc dtsi in next submits.

i'm working on write a v4l2-m2m driver for dma2d of stm32 to support
pixel conversion
alpha blending between foreground and background graphics.

as you know, some soc's engineer trying to add this function to drm system.

do you know st's planning about soc's hardware accelerator driver on stm32mp?
such as chrom-art, will add to drm subsystem via ioctl to access, or to v4l2,

thanks.

>
> >
> > It is likely the same no matter which device is using spi5.
> >
> > Yours,
> > Linus Walleij
> >
