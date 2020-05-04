Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18418C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7FE206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC0Oig/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEDK5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:57:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2C8C061A0E;
        Mon,  4 May 2020 03:57:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so7920976wmj.1;
        Mon, 04 May 2020 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wa5WiCb9TEfNBJdjqXOuNtc/EWG1LBgXWPOn2VDgW3c=;
        b=OC0Oig/8p1pqe6Npie+Z3tLPK0YEEKOjNLDYcZH+Eei1Q1Jau92N2IIZaovS0dvqe3
         AIVqVnvRLI5LQECLxmgrKjx5oNKZjv25SWD8rfkdeXH2Ho/A9oKYq/Cc/fFADYMS5E8q
         d7V85Q6JXDhsFLyOsxf+3D97Oj9GTM3E+iV695GaIcoBpcS7X6cKFK//3DcoYtDJ1dAA
         bB1E6IPqdTM7qHGg8l8OBB/1S/NZlm2N7XvVwf4blNrJpfD3SOOPUj5ZGbjQar+40caZ
         qou4bYadPbj779ARQ+/NffLLG3oRemD8cR7R3EYTp6AaHH4tFDmeeIk6pmVHZsW1/i2h
         VXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wa5WiCb9TEfNBJdjqXOuNtc/EWG1LBgXWPOn2VDgW3c=;
        b=hzeTOlj2/bJXay4AUiXuhmHwSZNzlpdhAQ/WZ0lY/t6NUF5qRS+RSt/akn4cCrj7gP
         SMgfsoXIaAIGPR0pJrRi5I59+yxHsLkf3nNRQlMsRo/W0HDWJxbRVf/OzydXHDxZ6Vqk
         VjAAPw8dFph023y1Iu7bH8mTT75sYbJhzbApQyOh5xpd8XoYANC4sxCts3g3aXIVDhu0
         y3aoNuq09l2fI5dk5hpBL1C5hneac8CUP4INbJU2/CHtO76rVdnIh5es1f4YZKZX+Muw
         ywXfcWFVDmxorQ0qe7zT0CcCZrbqX73EoPe3xkwjQFLkQdBpQgKeTYl6GfFpPVK3pMtA
         /c4w==
X-Gm-Message-State: AGi0PuaeeNQJs6sqQr9lg1splPGcmXQ971ovPSU4cImjLSpcazrMXrbd
        C0KTQYYJe6kW4tWU/oDe7oQRq4ZF20AyNc75oi0=
X-Google-Smtp-Source: APiQypLqWxs9smL4/H4j2LkvDhC+HNcMjptT98h06tKklq/lvJxELX6C+aKZcpkjEaQMIP9E4GnKbgGSyCkX+f2KiWE=
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr15099067wmc.83.1588589835503;
 Mon, 04 May 2020 03:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com> <20200502114752.1048500-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200502114752.1048500-3-martin.blumenstingl@googlemail.com>
From:   hex dump <hexdump0815@gmail.com>
Date:   Mon, 4 May 2020 12:57:01 +0200
Message-ID: <CAKTihDUSbnCyqrH3eBU89h9vae3FoAUm9k1j=4s21A=VviyN1A@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: phy: meson8b-usb2: Add compatible string
 for Meson8m2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 1:48 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The USB2 PHY on Meson8m2 is identical to the one on Meson8b but
> different to the one on Meson8. The only known difference is that Meson8
> does not set the ACA_ENABLE bit while Meson8b and Meson8m2 do.
> Add an explicit compatible string for Meson8m2 so those differences can
> be taken care of.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Tested-by: hexdump <hexdump0815@googlemail.com>

> ---
>  .../devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml        | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
> index c2fe8c08d99e..1d402e055045 100644
> --- a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
> @@ -16,6 +16,7 @@ properties:
>            - enum:
>              - amlogic,meson8-usb2-phy
>              - amlogic,meson8b-usb2-phy
> +            - amlogic,meson8m2-usb2-phy
>            - const: amlogic,meson-mx-usb2-phy
>        - const: amlogic,meson-gxbb-usb2-phy
>
> --
> 2.26.2
>
