Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AACC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD320207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347722;
	bh=Ou+jjvUyuR84E0nD0cuzGVRFTtpu/V8BPsbx3zPHbF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNXFfxnvmzUiFW2Wn35gjyK6VOwYi0e8Omv4wHjEO5JTgHaKlLVsfUKmtPNlvtCFM
	 NQZdPerYFDwRs4SjsFVZSBfVywX5rnVhoPEFb5q/sgE6YVmlh6dWN7LWT2LbSOWK1k
	 Dptts7OCYFQJwSzyDSHRNB2JjD/T7zpibX2rTiEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgGUQIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:08:41 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43534 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGUQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:08:41 -0400
Received: by mail-il1-f193.google.com with SMTP id i18so16882111ilk.10;
        Tue, 21 Jul 2020 09:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjMXsxzFtaUreC3kbfmAv2v7/+I+dvMTekAmMNypevk=;
        b=PIucpEwHCivJUKxO8ttX7BRqJM2YlKkxcz8cgnae43wQwXph8+cJmaxcdWMRLtHJ5Q
         DL3kTYE/ork9cAlyLD8JNDIfx0tG1AjLGfXZ7vuKecI/Azmhcc3hun7FntYoqO4y0IFi
         ESVWV46vwkYKURbTssOcYhJ+MwKXz4Lgu2s2i+EqzLcOkOi2cg5+AFOqb15OIHkB6atn
         hWq4X62ET++alHdtUAqIWVqCsvnl2+YIefP0yCd2h7M5LrJwMkP2DF+URQCVoJzWz5xM
         Fg6dYEtFcTOHMlPbXxZ8C9FDGaByPlzdQzrOqNC//tjmvww08vXELYRtQHCEKvgDmgB2
         I7Dw==
X-Gm-Message-State: AOAM532n5QdRFxVlpdEmHuVrStFeLEucxX2Zmr2x+UK3gWW/v4+sFmHY
        p7xEFmS5Z0YxZaFhY8QyIw==
X-Google-Smtp-Source: ABdhPJxyPY8gF2PcuZ6eVWiD1brwqr9E0n8BNki5/DOpSqJmzQt+fWfHePbEhzQUUPcEn1kQu2A6BA==
X-Received: by 2002:a92:dc0f:: with SMTP id t15mr26156619iln.218.1595347719975;
        Tue, 21 Jul 2020 09:08:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c25sm10733962ioi.13.2020.07.21.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:08:38 -0700 (PDT)
Received: (nullmailer pid 386158 invoked by uid 1000);
        Tue, 21 Jul 2020 16:08:35 -0000
Date:   Tue, 21 Jul 2020 10:08:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [PATCH for v5.9] ARM: dts: Replace HTTP links with HTTPS ones
Message-ID: <20200721160835.GA386106@bogus>
References: <20200719152722.59701-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719152722.59701-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 17:27:22 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/devicetree/bindings/arm/xen.txt                 | 2 +-
>  Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt     | 2 +-
>  .../devicetree/bindings/memory-controllers/ti-aemif.txt       | 4 ++--
>  .../bindings/memory-controllers/ti-da8xx-ddrctl.txt           | 2 +-
>  Documentation/devicetree/bindings/usb/gr-udc.txt              | 2 +-
>  Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml  | 2 +-
>  Documentation/devicetree/bindings/usb/usb-device.txt          | 2 +-
>  Documentation/devicetree/booting-without-of.txt               | 2 +-
>  arch/arm/boot/dts/keystone.dtsi                               | 2 +-
>  arch/arm/boot/dts/tps6507x.dtsi                               | 4 ++--
>  arch/arm/boot/dts/tps65217.dtsi                               | 4 ++--
>  arch/arm/boot/dts/tps65910.dtsi                               | 4 ++--
>  arch/arm/boot/dts/twl4030.dtsi                                | 2 +-
>  arch/arm/boot/dts/twl6030.dtsi                                | 4 ++--
>  include/dt-bindings/pinctrl/dra.h                             | 2 +-
>  include/dt-bindings/pinctrl/keystone.h                        | 2 +-
>  16 files changed, 21 insertions(+), 21 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
