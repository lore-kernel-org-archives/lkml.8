Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E16C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBFC2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgE2OD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:03:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41747 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2OD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:03:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id 23so2622019oiq.8;
        Fri, 29 May 2020 07:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDJ4Btq9hlxbNCcGfnKl79K6Z3PoAMkIaZIqBmoR+cM=;
        b=WeWrj+BP3yx4IWJGiqemW7wE/cv+fD96YF+aF+25HB3i7HIWBBfIXu60rdRozyeFn+
         W6Bv/FVbAcKy6/bIe9dWyIpAd5rAx5Qi4ZQFqKnUwGNdWw6AZsMp9Fym593kEr3/Y1Bh
         ugfdlAJqWFEa+7kDbSDT19RCzSLSgyU0t7Lj1dDehYSaj5gQ/6CG//dal7s/SfaNcc7Y
         QAc+SltzYb71UlDmI7rKyKUqne66HX0cEtuKyqF/PprftzhFRbuVflQ0zj4OXCxsEb4z
         /nmGCODzkHiZyNAb5QBny/ouGwxSxdI2eughW8X+FDU6831euSuQtSz35KgJORBu+MgO
         mrww==
X-Gm-Message-State: AOAM533sbv+05j4BiWOFs2mTfYnH034p+HzdhG3ogsiONkF8d6XcIKhf
        M7+SAT/HeNYSCzLp+yRDIpjlh1r8Hk55C6fpbns=
X-Google-Smtp-Source: ABdhPJxuWZmx/BcGQIQHL9kIiVbCuLv+D17s9jpKNSJyt4pYIoAZ3H0oH9tfjaD4OV5KJpPxJtLI4f36mhQ2co+tUv8=
X-Received: by 2002:aca:210a:: with SMTP id 10mr5565192oiz.153.1590761036723;
 Fri, 29 May 2020 07:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <1590611013-26029-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590611013-26029-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1590611013-26029-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 May 2020 16:03:45 +0200
Message-ID: <CAMuHMdWmasOizdsNqz+w0HzmmiAHtJY1Jv0twte671p_p6=0Rw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: r8a7742-iwg21d-q7: Enable HSUSB, USB2.0 and XHCI
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, May 27, 2020 at 10:24 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable support for HSUB, USB2.0 and xhci on iWave RZ/G1H carrier board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> +++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts

> @@ -88,6 +114,21 @@
>                 function = "sdhi2";
>                 power-source = <1800>;
>         };
> +
> +       usb0_pins: usb0 {
> +               groups = "usb0";
> +               function = "usb0";
> +       };
> +
> +       usb1_pins: usb1 {
> +               groups = "usb1";
> +               function = "usb1";
> +       };
> +
> +       usb2_pins: usb2 {
> +               groups = "usb2";
> +               function = "usb2";
> +       };
>  };

Looking at the schematics[*], I'm having a hard time making some sense
out of this.

GP5_21 (USB1_OVC) seems to be GPIO_AVB_SEL, and
GP5_22 (USB2_PWEN) is GPIO_SD1_LED?

I must be missing something?

[*] *RZ_G1H_SOM.pdf, *RZ_G1M_G1N_G1H_Q7 carrierBoard.pdf

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
