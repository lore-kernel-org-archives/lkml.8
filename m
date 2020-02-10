Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD68C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53CB208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581342979;
	bh=RDqUfZLaZ0/4Es+2SJzY7CjanaftKygtJJLIWiDLrX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jrNbz1dfUlwq4LGbOyol6Mo50MDqUyzHElUZ1UyCBlPlQvJyoxQR+Y47C+yFqpkVn
	 W1cov82Ndamozine3KKzko94G987MbAU5IyRBr94YrzEKfAB2vbdE+NcLSPK56XTVv
	 6R1Ry3GKOUIvy11Go+5DDl2+WpVePLBhy+wkqT94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBJN4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:56:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41513 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:56:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so343032eds.8;
        Mon, 10 Feb 2020 05:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ah2IHfUBmafMw70N3+IktB33GuN7dPw7FzMzjp9sBCQ=;
        b=U52Gv7StKyDJylLUx3/jcqCel/bTAcF/QmS6X+Y26snLEEKgzTlKAsqwf5kPDjcwFG
         IpGaZZMlF3hdVa2a1iwm/nfSFizTTW0aKv0dENo0V9rPNqqI5uEO/ExYcCpXwtqTjdj7
         YvK6mTUBWqUbnUX+iT0yLmIJRGwXZWZAxGtN3W9nV/83sMoiZgS/PDQVmM9alaXqIp1e
         zBvXtBhZrPzXszBrNuyiT1D1v+amBuokL+jlLPzcW/iV3EhLb0GidDduMgnXuYhKEkyk
         FTfwkFKD6K8cpvFHwa5h+iyk+8TyBJ1XFcGQDmZezc72zMTHMWfBUvdntkGw7ctjnvmT
         1PCQ==
X-Gm-Message-State: APjAAAV4o5boWbUcFiZ77bRZt4RqoAoJUik4FLLxBk2mzBy4k0e9faej
        Uyw3Uts3MGJPFbmwqmwJkaQ=
X-Google-Smtp-Source: APXvYqzd+w8QkYqy6i06rRdpA9+1r7X8JZKvCvW+NyGbGNcASqySdPBvud3O+GXM8YuMo4yZDIE1og==
X-Received: by 2002:a05:6402:1659:: with SMTP id s25mr1254917edx.219.1581342975193;
        Mon, 10 Feb 2020 05:56:15 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id f25sm45102ejx.33.2020.02.10.05.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 05:56:14 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:56:12 +0100
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
Subject: Re: [PATCHv3 0/3] Add support for suspend clk for Exynos5422 SoC
Message-ID: <20200210135612.GB2163@pi3>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210105108.1128-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:51:05AM +0000, Anand Moon wrote:
> Long time ago I tried to add suspend clk for dwc3 phy
> which was wrong appoch, see below.
> 
> [0] https://lore.kernel.org/patchwork/patch/837635/
> [1] https://lore.kernel.org/patchwork/patch/837636/
> 

You ignored parts of my review from these previous patches. I asked for
describing WHY are you doing this and WHAT problem are you trying to
solve. I asked for this multiple times. Unfortunately I cannot find the
answers to my questions in this patchset...

Best regards,
Krzysztof


> This patch series tries to enable suspend clk using 
> exynos dwc3 driver, for this I have added new 
> compatible string "samsung,exynos5420-dwusb3"
> so that we could add new suspend clk in addition
> to the core clk. exynos dwc3 driver will help
> enable/disable these clk.
> 
> -Anand
> 
> Anand Moon (3):
>   devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3
>     clocks support
>   ARM: dts: exynos: Add missing usbdrd3 suspend clk
>   usb: dwc3: exynos: Add support for Exynos5422 suspend clk
> 
>  Documentation/devicetree/bindings/usb/exynos-usb.txt | 4 +++-
>  arch/arm/boot/dts/exynos5420.dtsi                    | 8 ++++----
>  arch/arm/boot/dts/exynos54xx.dtsi                    | 4 ++--
>  drivers/usb/dwc3/dwc3-exynos.c                       | 9 +++++++++
>  4 files changed, 18 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.0
> 
