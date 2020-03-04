Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC63DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9721775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4vLwWcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgCDRxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:53:48 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:41720 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgCDRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:53:45 -0500
Received: by mail-il1-f169.google.com with SMTP id q13so2564293ile.8;
        Wed, 04 Mar 2020 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2CTmEA524fnfnIjgrSUvig7hPGvXP3F6DwJJOx39LI=;
        b=b4vLwWcBSQXoiv6P8h/9NTqnrSaaKGKKSUSlQrjuIYE3ksV8RhUyWlmIn36T8haYV1
         ujkMaWlZGJlstIt1iyiLp2XkLO6kOIm3vLs0PWcEXCjxskD8Eo5lmCfWs0KAb/11UkMf
         y7lRWBza6jh0/w67GDG4MfC327lyS79ML3TzVxQyDnTf2L+hZvLvtEjctkY52PDq/RTv
         jLi+UJUoIfJ9OCePABvaDJZiqRTE4yPB8Q/sX67aX35RxjUk+fvDYrLAlPtffDwO4ZYn
         ioUPtv+vawQQZmFc8AdyhG/lFWjyr3RGbJt7B3X3VBD4cFUUGO/3QkQ1Doj3+IcG+RVY
         lzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2CTmEA524fnfnIjgrSUvig7hPGvXP3F6DwJJOx39LI=;
        b=jbUMh8udfkPL2hmt0UaeYpM+1hEZOsqsNn7iYs7hyGospybiSWJkKNEVLSEWXpH+5r
         2euQRfFRBUQP8VB/IIuizyqMTdK08nQeZ584xny6tnlel6ExzgelEr/hP0lVNFYlLQOk
         cjmosNB6e5yzX4DfvWYfwwTzWv+Z3Tir05qLDYK8ED6wyo+pM+HLKAeAs1ghR3sGs7Kh
         +Wp/QQunXxhTvp7k2WAEpXgCibh2urhp+besy5CKPxTxhFN7ICQ2tdsvp1WbTD7SRi1I
         vDi+RhkulVjvwDycXBK444rmJ6sOPh/D1h+xe0n+xVQNkkjiZ/SP0wuyvrL3pAwmKE9s
         wvFA==
X-Gm-Message-State: ANhLgQ0MmgJCnQi50IYt5oHIKDTgY5AMaHett4SZ9JX4/gOsSksySiaK
        MdQf06ol+ce2yyuMXW9oNiULbqAeTAWypodoscA=
X-Google-Smtp-Source: ADFU+vsBrHpXk15htEhvGqXBvj6J95qHvJwp3T2Xq2b0NCaHDpAkmt2tXm3mV3JSmzToPkbpwxRA03OaJtQhF5VwZWw=
X-Received: by 2002:a92:3a55:: with SMTP id h82mr3860438ila.75.1583344424195;
 Wed, 04 Mar 2020 09:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20200301212019.2248-1-linux.amoon@gmail.com> <20200304081151.GA17560@pi3>
In-Reply-To: <20200304081151.GA17560@pi3>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 4 Mar 2020 23:23:33 +0530
Message-ID: <CANAwSgS11Bo=KhbspY1w=8qpSjjN8ed81s71zBB9AGczBe=wTA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Add support for suspend clk for Exynos5422 SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, 4 Mar 2020 at 13:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, Mar 01, 2020 at 09:20:15PM +0000, Anand Moon wrote:
> > Seried build and tested on linux next-20200228.
> >
> > This patch series tries to enable suspend clk using
> > exynos dwc3 driver, for this I have added new
> > compatible string "samsung,exynos5420-dwusb3"
> > so that we could add new suspend clk in addition
> > to the core clk. exynos dwc3 driver will help
> > enable/disable these clk.
>
> That's not entirely correct. You enable there SCLK which is a "special
> clock", not a "suspend clock". You use word "suspend: in multiple places
> in commits making an impression that it is about some suspend clock...
> no, there is no suspend clock.
>
Ok

> There is however a clock which driver calls suspend_clk (but it is just
> some name) and it is being enabled for entire lifetime of device (so
> also during suspend). AFAIU, this is not needed for Exynos5422 but I am
> not sure. So please convince me...
>

Yep you are absolutely correct. Yes all the CLK_SLK* are call special clk's

Earlier I had share the FSYS clk diagram for Exynos5422
[0] https://imgur.com/gallery/zAiBoyh
from the diagram I mapped the naming terminology.

CLKMUX_USBDRD300 --->CLKDIV_USBDRD300 ---> SCLK_USBDRD300 (48 MHz)
---> USBDRD30_0 (SUSPEND_CLK)
                                   |
                                   |--->CLKDIV_USBPHY300--->
SCLK_USBPHY300 (48 MHZ) ---> USBDRD30_PHY_0 (USB30_SCLK_100M |
USB20_PICO_CLKCORE)

CLKMUX_USBDRD301 --->CLKDIV_USBDRD301 ---> SCLK_USBDRD301 (48 MHz)
---> USBDRD30_1 (SUSPEND_CLK)
                                   |
                                   |--->CLKDIV_USBPHY301--->
SCLK_USBPHY301 (48 MHZ) ---> USBDRD30_PHY_1 (USB30_SCLK_100M)

SCLK_USBDRD300      USBDRD30_0             operating clock to 24 MHz
SCLK_USBDRD301      USBDRD30_PHY_0    operating clock to 24 MHz
SCLK_USBPHY300      USBPHY30_0             operating clock to 24 MHz
SCLK_USBPHY301      USBDRD30_PHY_1    operating clock to 24 Mhz

> However I have still the same questions:
> 1. What problem are you trying to solve here?
> 2. Why this is needed?

I am trying to get the USB clk to get enabled for FSYS power domain
to working efficiently.

> 3. What is fixed with this patch?

Currently locally I tried to enable the FSYS power domain for USB 3.0 / USB 2.0.
but it's not working as expected, need future study.

*Note:* For now plz discard these patches.
When I get the FSYS power domain to work correctly.
I will link with those patch which will be better for testing.

-Anand

>
> Best regards,
> Krzysztof
>
