Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D30C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5583208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mXoKTmtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgH1QT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgH1QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:19:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62160C061233
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:19:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so1655007edk.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9miOxm+aIgmI4U/EZeLaBrPMImCENn/aVpH1jwVAMM=;
        b=mXoKTmtBEQaBLnbOaGgnDqEY21MoTjb4zLDwbfSPeu9T0RfXPnHTskn/ZTaGUKOzOo
         cXbunuKwGz0pe1Ri4Su4Y/IV8L9Baeh8v70y8Q+HJmXP1ZQvHfPM4Lw/iw23jATefjMR
         HpQJM6shS/3snq/Q+XjQW0FIv7i3HEtR0unH+YHsDHsQ2s6+0AgEfdPfy9fgnd0S1lQe
         sj9+VBQxXHQwF4AXPh3pB6Byf6weRnbzqc/O83O/pKBzAFMzmgrPlL8u/Pk0WyJ7a7jv
         d4noUTHi3Z7iKCDKLP4kF4mNg4XMukhWKLGw7u+T76YijHmnCk0b4upjuhigrDhzIsWm
         HuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9miOxm+aIgmI4U/EZeLaBrPMImCENn/aVpH1jwVAMM=;
        b=mFG8kuYCsJcCRNlziu9/lbqV75oh4a9s3tnhyG5HBT+wsibj//1VdlyHT5dQfG2nVf
         q6ekL/5lXbk8S5xYlf+xHdTJXAQFC9P7tzPCrmOEo4O6fO4CT8/vQBY8rUwG1Cd5xueU
         Hdg/3YaNzmx6+quLeGvcapO0G3vqKGkKXysw194Bd6+8MLKvnjZB3oMIJs1ip+a+RwAC
         NzuPFF9kwcwrBz+S2o3yrHa/jrWT4ISeZADi2oDcUMkIaMabMya0PjUcJ9K7DIcGLm2y
         S5nE8PkZFSBo2pauzgxyRb13zz6ajtBq4utQoLy76qYaeXCpd8MoxPNrFDKOVQ8cDANJ
         +lcA==
X-Gm-Message-State: AOAM533UCwZUBzDoGhT3yJ++kMBiJh69On2lnwcZA09X5m31HDq7Gb87
        1EJUaDPr+6UMMyZQHIreyutJy7rLcQIn99BIptByvQ==
X-Google-Smtp-Source: ABdhPJx3CC1M5iADxDSXg8vc1XdLze/rbzJvK5cKSC231pYOCXnpX4r3v9HiYpmN/HeAzqJPCVyqZVKgfCUhOi8Y3cQ=
X-Received: by 2002:a05:6402:342:: with SMTP id r2mr2734843edw.353.1598631592180;
 Fri, 28 Aug 2020 09:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200828073024.32585-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200828073024.32585-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 28 Aug 2020 18:19:41 +0200
Message-ID: <CAMpxmJXVU2hsaH_WpLKoUR==MuNObbBJ1zT+HPaJN8iOoQ0JXQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: gpio: renesas,rcar-gpio: Add r8a774e1 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 9:30 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document Renesas RZ/G2H (R8A774E1) GPIO blocks compatibility within the
> relevant dt-bindings. R8A774E1 GPIO module is identical to R-Car Gen3
> family.
>
> No driver change is needed due to the fallback compatible value
> "renesas,rcar-gen3-gpio".
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Hi All,
>
> This patch is part of series [1] (patch 6/9), rest of the patches have
> been acked/queued.
>
> [1] https://lkml.org/lkml/2020/7/13/1275
>
> Cheers,
> Prabhakar
>
> v1->v2
> * Rebased the patch on 5.9-rc1 (YAML conversion)
> * Updated commit description
> * Restored acks from Geert and Rob
> ---
>  Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml b/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
> index 3ad229307bd5..5026662e4508 100644
> --- a/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
> @@ -37,6 +37,7 @@ properties:
>                - renesas,gpio-r8a774a1     # RZ/G2M
>                - renesas,gpio-r8a774b1     # RZ/G2N
>                - renesas,gpio-r8a774c0     # RZ/G2E
> +              - renesas,gpio-r8a774e1     # RZ/G2H
>                - renesas,gpio-r8a7795      # R-Car H3
>                - renesas,gpio-r8a7796      # R-Car M3-W
>                - renesas,gpio-r8a77961     # R-Car M3-W+
> --
> 2.17.1
>

Queued for v5.10, thanks!

Bartosz
