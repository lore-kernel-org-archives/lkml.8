Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1665FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E834820702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBG+Yvvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgGAOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgGAOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:09:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CDC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 07:09:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so19984470lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/P3F3XEPXIiHBtprCyJGmIkmTTIjneNamDkMb/+IKY=;
        b=IBG+YvvbuNPKZx2AedrFTn56DnNjAVZWf6WQa+RjBf1mdVwCqjoRe0EOWxf2ZsoKNQ
         b3hN7uxRdo5X8H/WxKRrWNv4IyQKZwMoGr//UG1BFvD4G80WjJOuxFI0S8bxutB3aBRl
         0/x5mSLjtl4ALH8xL/qo+ZuHm23MTE7a2MYUMiRAg/rYpwUXAIxp59VbVjZJG/Hg96Sn
         hEzhJrOi4WgvPeIsoPcSEAEswQ7oN1c+jfCtzg2mmXxV5FSYwIaFA8bEm8UDPlzSbyMJ
         aadoEpZuQ0drFWEe4DVzI5jCEAc/lkkdTwT+Hos/7mwpPZM6Hkqr1Z1EvfYJ5dWXx569
         LKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/P3F3XEPXIiHBtprCyJGmIkmTTIjneNamDkMb/+IKY=;
        b=Eis4Zc4zco8+w0PDCv2tqj4k7YITZJgqfGeIuIe9XW9llfZQxrbAMiZW06rKldK9zg
         9TzuJ0WEiOgjsOQ4BYT12ByM9V5xct+AC70alIuOIki8g4SKFQSpJgwcFJkUXGauVQwg
         PkK+g/qt29Nbz327o6SBpPpNpv42NJFt3qC1bX6FkVRXFhK8wUFZK4+0h2hWGhCC1wuB
         kbpcjE7s/b2HV9gmlyBEkvEFuzrMbselHy8lyBBb8WSy1fr/J7HQZ609lvTBUd1VQ/hb
         tQx/4oNyMEbLAQ3Snw1ZOR248FzwDXtbJHQ4/l8Jrifu8rzHmlowGvLZXcOgdmKGH8cw
         7bZw==
X-Gm-Message-State: AOAM5310PhvMc00ciQVblCGaOd3iTmOM0RsN4CfD2JJeq3bdnrIQC+sa
        s7/lBTMMRLuNNOH80gRAE0CRQmhIBRuBtAIGQdA=
X-Google-Smtp-Source: ABdhPJwcM1s4ggfKptzs/9JApOUZ0JUdrDWPQACOb1X4/rZXWo3OKR82bDwC6Vo02IG5t16TWFBovu0WWwtuG2WL0yA=
X-Received: by 2002:a2e:82c8:: with SMTP id n8mr13197066ljh.123.1593612545107;
 Wed, 01 Jul 2020 07:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org> <20200701091518.GW1179328@dell>
In-Reply-To: <20200701091518.GW1179328@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 1 Jul 2020 22:10:19 +0800
Message-ID: <CADBw62pFb6aEegTRXS3Y9DeJDTrW4mSHND4nw4p8Qtv-Yk+SNg@mail.gmail.com>
Subject: Re: [PATCH] mfd: sprd-sc27xx-spi: Fix-up bogus IRQ register offset
 and mask setting
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 5:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> 'i / pdata->num_irqs' always equates to 0 and 'BIT(i % pdata->num_irqs)'
> always ends up being BIT(i) here, so make that clearer in the code.  If
> the code base needs to support more than 32 IRQs in the future, this will
> have to be reworked, but lets just keep it simple for as long as we can.
>
> This fixes the following W=1 warning:
>
>  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Suggested-by: Baolin Wang <baolin.wang7@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

>
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index c305e941e435c..4a1a61e1a86ea 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -251,10 +251,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
>                 return -ENOMEM;
>
>         ddata->irq_chip.irqs = ddata->irqs;
> -       for (i = 0; i < pdata->num_irqs; i++) {
> -               ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> -               ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> -       }
> +       for (i = 0; i < pdata->num_irqs; i++)
> +               ddata->irqs[i].mask = BIT(i);
>
>         ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
>                                        IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,



-- 
Baolin Wang
