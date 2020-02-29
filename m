Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F422CC3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95342468A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 06:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="p7TgclhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgB2GIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 01:08:38 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:62147 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgB2GIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 01:08:37 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 01T68NIM027166;
        Sat, 29 Feb 2020 15:08:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 01T68NIM027166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582956503;
        bh=95vNS0xn/eFKDybsHRSqqk5phkc9D+D3QFZNdZ879ek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p7TgclhQ+8fSOvUZ5hHOL4QrYI4+LN7TQdECQR4jAFZMdd7nimJJApm9Sb0BWnijA
         Qx/N56OqAbDFqR6P61LJ76q998HRWy7Q6hCMGg/VkfzRMRFClBxdyxoN8BqL4qN+hZ
         mK3wLWpF4T8MPD8HvZ6Xe37Ix3ZqL4agdtB3huEVVmCo7cq9ULmJP9T3E9NP1lj4gg
         U0y/WWCqrsuFMUWWeY/M/FWsVpQVEzpfpEZaTQyiv0GZZ5zGcTzG7Akw+Iy1Hx5Bo9
         7hN6RlIMysi5N7hG8vc7nk8YCvsTpN+dYl92tmGQamEh0hRfi3qoON/rWz3mRC+Zts
         3kHMP2Uf0GIKQ==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id h5so2434959vsc.4;
        Fri, 28 Feb 2020 22:08:23 -0800 (PST)
X-Gm-Message-State: ANhLgQ3KQ1Fqq0FraK7M8LHBwTiXMIgcXagjz87REwRMV3yifih/K+Ln
        5ISrndclprIKxWGX4D8zukRjEDn8B2XCeaF7vdI=
X-Google-Smtp-Source: ADFU+vvxW8SJz2gH69lHFxo7XkMiEDpyKKnR/h+JhkIcmJrnuvfSEvmzW8wve+//6tnaLVoygUEpD2rAg1urn6bq0s4=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr4335852vsh.179.1582956502271;
 Fri, 28 Feb 2020 22:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20200228122055.17008-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200228122055.17008-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 29 Feb 2020 15:07:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzXD55UxOpVPhu=m24oPbG6gwLgq5g23Nxu=zGJLyNRA@mail.gmail.com>
Message-ID: <CAK7LNAQzXD55UxOpVPhu=m24oPbG6gwLgq5g23Nxu=zGJLyNRA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: uniphier: Add one more generic compatible
 string for I2C EEPROM
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 9:21 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 73f9de0c7f5d ("ARM: dts: uniphier: Add generic compatible string
> for I2C EEPROM") did not touch this node.
>
> Add the compatible string prefixed "atmel," so that this matches to the
> OF table.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-uniphier.


> ---
>
>  arch/arm/boot/dts/uniphier-ref-daughter.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
> index 04e60c295319..a11897669c26 100644
> --- a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
> @@ -7,7 +7,7 @@
>
>  &i2c0 {
>         eeprom@50 {
> -               compatible = "microchip,24lc128";
> +               compatible = "microchip,24lc128", "atmel,24c128";
>                 reg = <0x50>;
>                 pagesize = <64>;
>         };
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
