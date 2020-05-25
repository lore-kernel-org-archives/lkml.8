Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4372073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0DVJ6z9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbgEYJOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbgEYJOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:14:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86EC08C5C1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:14:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so152724qkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mbBog8MzvKNaCFrg6v3gH2zfw8FxJzmofUMGKb8FS/g=;
        b=0DVJ6z9JKI1z7qc5wvYtWKBdWUwkPufux2KDtFjfGcSQ/HTpdUgeir5ke8EkWrN1R7
         ve3AXV7RcFUNLSFRrY/oKTXPnL+Km7rbGnfX9zVZkztjocTEWi29DoZ2fwrLU7ga1XS+
         cjuKR3w7aaZ8Dk6O99Yq1vWrMpSe/IhLTid3NgNnkJ1KlZKrzA9xFl2Nv/q9ho+2ud34
         rTsBQp9XcHO60AIHSFIeJs+r1Dtwi2Dh5oUQvXwzAFGk1eEs/QFRZ7QrzpWNsG1A1TNL
         5KCUDJ9SfSp+ljXONaUJQPltaPBLGiYWRvoO+hiUl3Fon5Kbg2JNFPnEm0PEHZpxuBr+
         Bzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mbBog8MzvKNaCFrg6v3gH2zfw8FxJzmofUMGKb8FS/g=;
        b=QujRSRoMOHB0o4phtoSygKOa3X0AWyGbGRn0Hlb3lTRS3AYZUW3IFb/fYysZY7G1ZZ
         EEzkRfTenRbwv/tdLw7euxn8U14J/hWtAzkllXUgcEuh11XkURq+Do7y/3AEtoT+Xkr/
         CEmvveldd7M/mYc9b3XpJlpsQjtvugV36E2LrkjgK8j+JZiI8IXDbdP8qntfn6snZWNF
         oqZoh33wgH2sH0upoPwy62NojJc7mV/JzynkZDJQY71N64m5+fd3j13UPTCYnGJ/G8S/
         ewoU166LqWl45LAVwvIlI+4iMqnV2nXfrsXHcjyjxHByWESahD0EFtmtQiO0omdvyUeb
         FOlQ==
X-Gm-Message-State: AOAM533SgiIvYHd+Zvsf/vYTW1qEptoAyFDG3jr3mzswcwkGuhvlvSM+
        RjzUd7QNv3ZMEsmW080PDav5/3X4hzKaELG10x1KNw==
X-Google-Smtp-Source: ABdhPJyS1j3T808bcO9YDCKIkb0LjajSrMv02m56SJgAqpdt5ZLZ2vrWGJHijMEL0lQyy0YDP+Uc8OGBFJg+HViUaeQ=
X-Received: by 2002:a37:dd6:: with SMTP id 205mr3478129qkn.323.1590398074097;
 Mon, 25 May 2020 02:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1590120740-22912-1-git-send-email-yangtiezhu@loongson.cn>
 <1590120740-22912-2-git-send-email-yangtiezhu@loongson.cn>
 <874ks7okk4.fsf@belgarion.home> <3382c1df-1429-ecd3-70b6-35bc00343608@loongson.cn>
In-Reply-To: <3382c1df-1429-ecd3-70b6-35bc00343608@loongson.cn>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 May 2020 11:14:23 +0200
Message-ID: <CAMpxmJXc5-+hj5p2GTMJR4MZX95YWpTTg5FHD79au8pdcYi6mA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: pxa: Fix return value of pxa_gpio_probe()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 23 maj 2020 o 05:25 Tiezhu Yang <yangtiezhu@loongson.cn> napisa=C5=82=
(a):
>
> On 05/23/2020 03:07 AM, Robert Jarzmik wrote:
> > Tiezhu Yang <yangtiezhu@loongson.cn> writes:
> >
> >> When call function devm_platform_ioremap_resource(), we should use IS_=
ERR()
> >> to check the return value and return PTR_ERR() if failed.
> >>
> >> Fixes: 542c25b7a209 ("drivers: gpio: pxa: use devm_platform_ioremap_re=
source()")
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>   drivers/gpio/gpio-pxa.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> >> index 1361270..0cb6600 100644
> >> --- a/drivers/gpio/gpio-pxa.c
> >> +++ b/drivers/gpio/gpio-pxa.c
> >> @@ -660,8 +660,8 @@ static int pxa_gpio_probe(struct platform_device *=
pdev)
> >>      pchip->irq1 =3D irq1;
> >>
> >>      gpio_reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> >> -    if (!gpio_reg_base)
> >> -            return -EINVAL;
> >> +    if (IS_ERR(gpio_reg_base))
> >> +            return PTR_ERR(gpio_reg_base);
> > As far as I know, devm_platform_ioremap_resource() could return NULL wh=
ich is
> > not handled by this test (unless __devm_ioremap() semantics changed sin=
ce I had
> > a look).
>
> Hi Robert,
>
> In the function __devm_ioremap_resource(), if __devm_ioremap returns NULL=
,
> it will return IOMEM_ERR_PTR(-ENOMEM).
>
> devm_platform_ioremap_resource()
>          devm_ioremap_resource()
>                  __devm_ioremap_resource()
>                         __devm_ioremap()
>
> static void __iomem *
> __devm_ioremap_resource(struct device *dev, const struct resource *res,
>              enum devm_ioremap_type type)
> {
> ...
>      dest_ptr =3D __devm_ioremap(dev, res->start, size, type);
>      if (!dest_ptr) {
>          dev_err(dev, "ioremap failed for resource %pR\n", res);
>          devm_release_mem_region(dev, res->start, size);
>          dest_ptr =3D IOMEM_ERR_PTR(-ENOMEM);
>      }
>
>      return dest_ptr;
> }
>
> And also, we can see the comment of devm_ioremap_resource():
>
> Usage example:
>
>          res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>          base =3D devm_ioremap_resource(&pdev->dev, res);
>          if (IS_ERR(base))
>                  return PTR_ERR(base);
>
> >
> > Therefore, this patch is incorrect, or rather incomplete.
>
> So I think this patch is correct, do I miss something?
>
>

Yes, this patch is correct. Applied for fixes.

Bart
