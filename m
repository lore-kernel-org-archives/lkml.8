Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEDF20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYqSa8L/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgENJSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:18:21 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AADC061A0C;
        Thu, 14 May 2020 02:18:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j2so31609ilr.5;
        Thu, 14 May 2020 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydoBtyjQkZ71HME1rY9/L3edxtQ8UTZXOUoGaJuGgqs=;
        b=ZYqSa8L/3MIGZtdjLm0uDEAUX9qw4WfHyEd/Xw3RGOzYb1CkiCmu64wr9INtmjvKAv
         emNDZI8PC9mqxdaFO/x+7iDPFrRBkDTofku3oFwDsonyzK71UUmM/f2Ph34IYVB1ePui
         TRYJEkf6+HZ5dpJwh+khw4qEqdRQ1Yz4UtEMkaULjMFHZPky5finqqVyz2JPi5d/Mocq
         Ga+oJmmuDjPRydwsVFRhLCydvb7MAqHM/hyGTEJ+1CxinGcEilDhOARv4nY1Mia/4k5g
         0CjcHoE1TsdomFZGSZaCa096y7nxhGm4PrO3r+27z96mUV9fH7IfZq7KcSOXdK64+inC
         4q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydoBtyjQkZ71HME1rY9/L3edxtQ8UTZXOUoGaJuGgqs=;
        b=XgmuF3P3HSIQdiZq5nvGM4PC5volrhSK+Q/k92hEYAGIVfZRHAnpWUgxmfRp6au2Oh
         0dvouz+a3Y4fsC1JkBUpzl6BvgeLT0zTf6g4kZWOwcx7O876cxfa2IuxYkwoo6TlOE36
         t3Y+DLdSfRm3khn8hWL33GiDSWAf1QRc3gD9UBNRt4bRESkQOHX9OMmU5qbHm1BUEwW7
         qzQdeBSptNF2Qc0WTYa3X9o+MzY4q4iLDcDGQ87k6XLWqYo/Bo+p9/xWEegp6xXyMKof
         Fumtlfqmp/NkRD280Fh7GmZEEOrThMXZcqrdM9tqv1Q9SIL/UI20FGJm2/m+QAXvdzkQ
         K01w==
X-Gm-Message-State: AOAM533o0QBL2hhJZzYJ6TnpB9MJdY90kVxfQ7jEDSuewK2GTFNS5XmE
        j6d27Znb8zQac4sNanHXbKObRJPzt8eIuwnJ3Xw=
X-Google-Smtp-Source: ABdhPJx7BSQgQE4F6HtJZDnTuhUIhxQY0EfiByegZhfXtsPPqB/OWed28lLtaW/x8ef7ztWZ46mbWs3Tdl5vZCAZRP0=
X-Received: by 2002:a92:3556:: with SMTP id c83mr3346133ila.218.1589447900002;
 Thu, 14 May 2020 02:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com> <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
In-Reply-To: <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 14 May 2020 17:17:42 +0800
Message-ID: <CAL9mu0JZdgJ0yjULUHkXzU0CyKeMi0dcA1L7PxPiZucpuuyQ9Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding with ili9341
 on stm32429-disco board
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
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

Hi, Linus,

thanks for reviewing.

On Thu, May 14, 2020 at 4:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, May 12, 2020 at 9:04 AM <dillon.minfei@gmail.com> wrote:
>
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > Enable the ltdc & ili9341 on stm32429-disco board.
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
>
> This mostly looks good but...
>
> > +&spi5 {
> > +       status = "okay";
> > +       pinctrl-0 = <&spi5_pins>;
> > +       pinctrl-names = "default";
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +       cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
> > +       dmas = <&dma2 3 2 0x400 0x0>,
> > +              <&dma2 4 2 0x400 0x0>;
> > +       dma-names = "rx", "tx";
>
> These DMA assignments seem to be SoC things and should
> rather be in the DTS(I) file where &spi5 is defined, right?
> stm32f429.dtsi I suppose?
>
> It is likely the same no matter which device is using spi5.
>
> Yours,
> Linus Walleij

Yes, the dma assignments can be moved to stm32f429.dtsi file.
i will change it.

thanks.

best regards.

dillon,
