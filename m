Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EFFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341B12074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NfMvBfPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFPIuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFPIuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:50:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A39C03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:50:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so18457563qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RVGu6PAcvTn1Y9na/crur5lRNO3jpGTKn65gyjWomTs=;
        b=NfMvBfPgpryL2bUTBbncoUwqL6NQfkDWPPsZMFnsPS4iwUjsmMjF+0SoT6yhDi2mjj
         U04I014RrOBw9UJGfNaoriO/Beqf7rBxRpoNL6NCxVQRo3cpJSJe8sDk3n5dNnS25GDm
         VK3Zpy3MQMxWGVq/RI+L3cL4cCyW9P0n2f0LyW2ENuIp+dSuBLCq7Y4awXpYii7jiT3F
         op/ZKIRufkJMbGbaavCy2B8w6UHjY+cXdLs84t975/4XQuNMIaJjc6y2F/Tny+eI/EcF
         ME2Sd7QeAIMkvYfWdC6tcBjt2UKoipAHLNXd4V2Nehv3xwZh0IPQ7AfIIz9xmL/PTe/7
         StOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RVGu6PAcvTn1Y9na/crur5lRNO3jpGTKn65gyjWomTs=;
        b=jREodbuUkjCPag4kuV9UG3toYM7UCukH4Gr/eYmX+0AlbCiBQR3X5m1WIJRsCy7KB4
         sZsEQVW2Zdhidg6SqdAIQJ+fTsY95S4JmEDfjpFHOZwiSkfurFfS7uLrRkREPjV6fMQP
         37V2wcgfbbZOZht8Yyg0eNWacl2OXUuaN1iWawkf/e2Z0r08Hq2s6PE9bjaibl8gyqR8
         iFEPhq/+n2ykfAY401BXTcSSS7/4/wMGP/bx9ppXEGo5oekzUBaH04hMf6bDuScA/uTP
         aFOWuHKENzjSiUi3oewRM6g+MNyD/wCWUDCu2ljVbZI/AYHiqs8M4nZxLESTOMHi9Z45
         mGrg==
X-Gm-Message-State: AOAM5318Qny5r2dlVEbZG3TPvjPfGO+qOLDFgj2QEw/SUA5wUDRV9zTI
        +gCJNxdUJ+oCN0MIkhyamZvdBAGpSyUgOWJDxhAh5g==
X-Google-Smtp-Source: ABdhPJzHsHHV9iDdm3KT3PEY16dBCNueo47F4xXAfBIzQeXxnvTko9WPEtISdUCzsY8ukXzSk1Z3VzoJmSNThF7CXjw=
X-Received: by 2002:a37:aac4:: with SMTP id t187mr17406503qke.263.1592297418121;
 Tue, 16 Jun 2020 01:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592227348.git.jan.kiszka@siemens.com> <213b571eda0ac65a2605df83e60fc20a9b37070a.1592227348.git.jan.kiszka@siemens.com>
In-Reply-To: <213b571eda0ac65a2605df83e60fc20a9b37070a.1592227348.git.jan.kiszka@siemens.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 16 Jun 2020 10:50:07 +0200
Message-ID: <CAMpxmJWMfu31=tG-puG2Ca=vKiUYTEq6ASu+=CextsxC9PcHpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: gpio: pca953x: add nxp,pcal9535
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 15 cze 2020 o 15:22 Jan Kiszka <jan.kiszka@siemens.com> napisa=C5=82(=
a):
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The NXP PCAL9535 is an extended variant of the PCA9535.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Do=
cumentation/devicetree/bindings/gpio/gpio-pca953x.txt
> index dab537c20def..3126c3817e2a 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
> @@ -19,6 +19,7 @@ Required properties:
>         nxp,pca9698
>         nxp,pcal6416
>         nxp,pcal6524
> +       nxp,pcal9535
>         nxp,pcal9555a
>         maxim,max7310
>         maxim,max7312
> --
> 2.26.2
>

Patch applied with Andy's review tag.

Bart
