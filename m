Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31929C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B1D2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583309518;
	bh=+TTNamvFjlVpUSsKDThvge8lazOlfMCkgiABCsiTxkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vMygtedSJIyK2cHWMhgROzMZN69FxlowJnfWrVGdXJDeDYT7WNRBrhEiVAg9SmVg0
	 oEO+UX3zMAXI4ExeTjF1sA/v2PSMXCF1JFp+ULRwQTQ2Ub5Or+AIIWBUOnW3nzUAbI
	 xg3Dv0LAL66G7JZ5Av0c8zsDDgcRTCnT6saYiUtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbgCDIL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:11:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35999 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDIL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:11:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id a13so1232502edh.3;
        Wed, 04 Mar 2020 00:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bc4qmKJt/lAzS0lpfRM9DbEOWoXovtwmwwXu2IbTRzo=;
        b=EBDKff7ewYDJhiOVL0TmnEeb4mXPS2AysuCb0B1N48Cxf7gLjRGXSA1F4/2UCeIs5E
         Br69ShUoqQOA+5wnC886trhrO7f1sD6TkWli3WvWPjH0dw5iHH2IdzUlNS6IubDluIbO
         ylBEa2APcbmlqMnrJ5fW+hLE6OzNNifUEufsEF6huVMXg6+iumdVzjGGHtmH+CdITOr3
         7lMpr9xuzAgCiBgisD7EipXmAB/C210qQ9Nt4sAWPG+ldKEICaXWZHmCxaFLRd51/7fb
         4Yuz0NrGrLtRFf0UaI2hjuwL1Inwxue9Zxc72SGBwMhSMc+W9FdQJ85tnPlZdIhmsdQU
         siJA==
X-Gm-Message-State: ANhLgQ3mYWhwRcvTak0FSM2IdnuWYGl0DjrbsgPxT3gEmTNjxkslhX+H
        FAMqwvRDHepezOZWEjpH6wI=
X-Google-Smtp-Source: ADFU+vvW40T8j5meoZiNaJ/0F7CHytNOStLYgpJxQMZhhi7lUyOEErJ4auD/xDioBTEYC65TyLQkfQ==
X-Received: by 2002:a17:906:8254:: with SMTP id f20mr1508858ejx.43.1583309514196;
        Wed, 04 Mar 2020 00:11:54 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id a10sm1467746edt.50.2020.03.04.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 00:11:53 -0800 (PST)
Date:   Wed, 4 Mar 2020 09:11:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/3] Add support for suspend clk for Exynos5422 SoC
Message-ID: <20200304081151.GA17560@pi3>
References: <20200301212019.2248-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200301212019.2248-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 09:20:15PM +0000, Anand Moon wrote:
> Seried build and tested on linux next-20200228.
> 
> This patch series tries to enable suspend clk using
> exynos dwc3 driver, for this I have added new
> compatible string "samsung,exynos5420-dwusb3"
> so that we could add new suspend clk in addition
> to the core clk. exynos dwc3 driver will help
> enable/disable these clk.

That's not entirely correct. You enable there SCLK which is a "special
clock", not a "suspend clock". You use word "suspend: in multiple places
in commits making an impression that it is about some suspend clock...
no, there is no suspend clock.

There is however a clock which driver calls suspend_clk (but it is just
some name) and it is being enabled for entire lifetime of device (so
also during suspend). AFAIU, this is not needed for Exynos5422 but I am
not sure. So please convince me...

However I have still the same questions:
1. What problem are you trying to solve here?
2. Why this is needed?
3. What is fixed with this patch?

Best regards,
Krzysztof

> 
> This series PatchV2.
> --Added the clk names for exynos5420 compatible.
> --Added missing support for Exyno5410 SoC suspend clock.
> --Update the commit message to support suspend clk usages.
> 
> ---
> Long time ago I tried to add suspend clk for dwc3 phy
> which was wrong appoch, see below.
> 
> [0] https://lore.kernel.org/patchwork/patch/837635/
> [1] https://lore.kernel.org/patchwork/patch/837636/
> 
> Previous changes V3 (It was send with wrong Patch version)
> [2] https://patchwork.kernel.org/cover/11373043/
> 
> -Anand
> 
> Anand Moon (3):
>   devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3
>     clocks support
>   ARM: dts: exynos: Add missing usbdrd3 suspend clk
>   usb: dwc3: exynos: Add support for Exynos5422 suspend clk
> 
>  Documentation/devicetree/bindings/usb/exynos-usb.txt | 5 ++++-
>  arch/arm/boot/dts/exynos5410.dtsi                    | 8 ++++----
>  arch/arm/boot/dts/exynos5420.dtsi                    | 8 ++++----
>  arch/arm/boot/dts/exynos54xx.dtsi                    | 4 ++--
>  drivers/usb/dwc3/dwc3-exynos.c                       | 9 +++++++++
>  5 files changed, 23 insertions(+), 11 deletions(-)
> 
> -- 
> 2.25.1
> 
