Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED60C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F5921569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSiEliFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBLLC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:02:29 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43176 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:02:28 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so1213724qtj.10;
        Wed, 12 Feb 2020 03:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDNvyJ4Uf1sqwk9LJmGc5lWchbj3cNfBdeRqRGEkb3U=;
        b=ZSiEliFOfsvY7AIcwNmiuQxkowxuXcH5SWaJXqurWmTwL3E1aJfbL0KLC/Mmbfcev9
         gK4jQsxECK+NQD0H0xLnmdUldpOF8E94QtURnpA0mwc7TUfyXkqtUGhrkVMedTLkSCuZ
         +sHsd2jTZpxGINTZk9Pzisi4DK44CuuZcWhaNrL5UOw3uiAFj84A9BxnqW7wo/vySJ2v
         GUF/6tnVinELXmtM4qEfo/f15bWhY3aaYRCvJ9TXjFCBfcHG9hCsFEcnVsdyfuN/Bon2
         4HGM76mOnL9Z1maD19CTzyfcDLi1LzL3AQr/6gbNfk/ucLz4EY1eYCPsRdv1dU5Js6UJ
         67DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDNvyJ4Uf1sqwk9LJmGc5lWchbj3cNfBdeRqRGEkb3U=;
        b=nV2QHgCGbhOQjppKDyPfcjshj7+/GJaj+kQAr6r2Y6EejxvkU4JkIUl6NT0VCWatUw
         klMGpPSD85maDZAiZzm7Fr/NIDRDGRf3zX1sNXci2+9tgDJMpDEa+mp5iwE2QPmWuwzu
         OJ5FdlTLBAhVa0YGtWfeD5jZYq/9QXlYvMW/nYfszbXx+UYsYtCDGWj77rSVRD4Tcqe2
         GvjS4uMlaiHhCI0/ISc0J74F+DDeJ3UA+fTuKaGmplmejC9F+BuT6PBVtjl+6a+ctLvd
         khhFDrLBtaD0sqG/iJweDm+p6p2WRLJ+0hQhI1N1BHfkme41eryKmYKZoYoPDgzQOlNE
         keDg==
X-Gm-Message-State: APjAAAUGbxmlq+p9xctHwNIYwJ2eqokifdv8TwoKYvnpfSmisuowmWgU
        R/owZciaHMs7oWhmsCZi36u6V673F+yQaqZsD9E=
X-Google-Smtp-Source: APXvYqyhLj9zCgAlGXxqfvVRRoSDoHLgA6wUmmPR5oorbGxluptx9GN68Vd1Tz1ODAIa8+R4VqRi+kRgUL3L0LrFZYs=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr6474437qtp.224.1581505347334;
 Wed, 12 Feb 2020 03:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20200212104629.20272-1-johan@kernel.org>
In-Reply-To: <20200212104629.20272-1-johan@kernel.org>
From:   Oleksandr Suvorov <cryosay@gmail.com>
Date:   Wed, 12 Feb 2020 13:02:16 +0200
Message-ID: <CAGgjyvFKWKoQ-Em8n0X2nKeuQ5CZybB3ChvdWsw6c=YpqD5N3A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible properties
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:46 PM Johan Hovold <johan@kernel.org> wrote:
>
> The sram-node compatible properties have mistakingly combined the
> model-specific string with the generic "mtd-ram" string.
>
> Note that neither "cy7c1019dv33-10zsxi, mtd-ram" or
> "cy7c1019dv33-10zsxi" are used by any in-kernel driver and they are
> not present in any binding.
>
> The physmap driver will however bind to platform devices that specify
> "mtd-ram".
>
> Fixes: fc48e76489fd ("ARM: dts: imx6: Add support for Toradex Colibri iMX6 module")
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index cd075621de52..84fcc203a2e4 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -275,7 +275,7 @@ &weim {
>
>         /* SRAM on Colibri nEXT_CS0 */
>         sram@0,0 {
> -               compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
> +               compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
>                 reg = <0 0 0x00010000>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> @@ -286,7 +286,7 @@ sram@0,0 {
>
>         /* SRAM on Colibri nEXT_CS1 */
>         sram@1,0 {
> -               compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
> +               compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
>                 reg = <1 0 0x00010000>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> --
> 2.24.1
>


--
Best regards

Oleksandr Suvorov
cryosay@gmail.com
