Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28129C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEF820872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdNYH+h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgH1OCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH1OAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:00:42 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20382C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:00:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so1448036ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpinBUuKFwanae5hZ9+GsFmSPe7o+4reyxCKGT+ja5s=;
        b=pdNYH+h1GmeQ9fLGwIJanYIbb510jIkD7kW2meqEVSM5rwTJRvVtduJxlg1HRNuWPM
         OJzEQRp5MhIAwxCg2chf7VjZ9Qsnf7LrWWyLmLmqQEffPQlGVjxIZXeZu/WlL76pdw9Z
         pN/ZsabbeaqSv+CCSyo1Avig2NVg6zceoVqGwG63sAQ2Bstkrdx3sTnXBiZL+m6kz6X5
         fdOclQby1zOd0GQ6gWXMuoZf70UEbdxHPWv24ARpMAg6JapBvYE+41GI0wSpPb+Zk2fm
         AmRMponyt7WsWIHvenEcM9LKzm5HnCO/73HrfxCphYJZaq8XWw6+XCHHNnQB8ISgNqba
         J7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpinBUuKFwanae5hZ9+GsFmSPe7o+4reyxCKGT+ja5s=;
        b=ebdeVcTQKJ08JKtzlRQ2fUMhB2+w+R/afWju/r5PoDSBNImgDqR2Obqz/XjoOyUf1w
         gYiGZyey16xpFY5ZQQiGTvlNave+F4jwyLo+STBY20ebSwF3reNc7IseU3kFCN8m7eGj
         NVq2n+E+hldDcChOGdo0prs8Bkupqexu8GdO5Bnma7BLEo8K7ffvYLavYurLlfQSdy1S
         u3EpYBW+B7eviyIkD4iGXbvPZlmQHFzWy3Ky4e86QXnNtLTRei+JI2Y1Bl7qGfIfT6De
         VWTkCGLvexM25WVBKgpjzDuCytmszkpNlSRin0EtH7vUQVUoPaE734oBcJeSTu1iltnJ
         KpiA==
X-Gm-Message-State: AOAM530rJLzYNXCcKIa8UzpF3seh9iuiIHaUkomOWT8wDq9IA+4Jrz+Y
        spF9Q/cOUWixC75RS80QQjeXiSUAvRQTmjaT2ZnrDw==
X-Google-Smtp-Source: ABdhPJwHSGiAZyzHlD41R4r6UG5OM6T7dS4SiDyVDpCTwNm77h9zuuu8QPg34MEBcJFowkGqZTWBFbVPm6ypV84qpWM=
X-Received: by 2002:a2e:558:: with SMTP id 85mr983462ljf.293.1598623240088;
 Fri, 28 Aug 2020 07:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200812202018.49046-1-alcooperx@gmail.com> <20200812202018.49046-2-alcooperx@gmail.com>
In-Reply-To: <20200812202018.49046-2-alcooperx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:00:29 +0200
Message-ID: <CACRpkdZVde024_CCwmKBY_zVzfcq7=A1+t=8nEe1ei8+_Le51A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add support for Broadcom USB pin map driver
To:     Al Cooper <alcooperx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:20 PM Al Cooper <alcooperx@gmail.com> wrote:

> Add DT bindings for the Broadcom USB pin map driver. This driver allows
> some USB input and output signals to be mapped to any GPIO instead
> of the normal dedicated pins to/from the XHCI controller.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
(...)
> +title: Broadcom USB pin map Controller Device Tree Bindings
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +
> +properties:
> +  compatible:
> +      items:
> +          - const: brcm,usb-pinmap
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Must be defined if any out-gpios are specified.
> +
> +  in-gpios:
> +    description: Array of one or more GPIO pins used for input signals.
> +
> +  in-names:
> +    description: Array of input signal names, one per gpio in in-gpios.
> +
> +  in-masks:
> +    description: Array of enable and mask pairs, one per gpio in-gpios.
> +
> +  out-gpios:
> +    description: Array of one or more GPIO pins used for output signals.
> +
> +  out-names:
> +    description: Array of output signal names, one per gpio in out-gpios.
> +
> +  out-masks:
> +    description: Array of enable, value, changed and clear masks, one
> +      per gpio in out-gpios.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb_pinmap: usb-pinmap@22000d0 {
> +        compatible = "brcm,usb-pinmap";
> +        reg = <0x22000d0 0x4>;
> +        in-gpios = <&gpio 18 0>, <&gpio 19 0>;
> +        in-names = "VBUS", "PWRFLT";
> +        in-masks = <0x8000 0x40000 0x10000 0x80000>;
> +        out-gpios = <&gpio 20 0>;
> +        out-names = "PWRON";
> +        out-masks = <0x20000 0x800000 0x400000 0x200000>;
> +        interrupts = <0x0 0xb2 0x4>;
> +    };

Wow look at that.

This looks very much like Geert's just invented GPIO aggregator.
But in hardware!

See:
drivers/gpio/gpio-aggregator.c

I think Geert is intending to add bindings to the aggregator, and
while I do think this should be its own driver (in drivers/usb) these
bindings and whatever Geert want to use for the aggregator
should certainly be the same.

Geert what do you think?

Here is the actual driver:
https://lore.kernel.org/linux-usb/20200812202018.49046-3-alcooperx@gmail.com/

Yours,
Linus Walleij
