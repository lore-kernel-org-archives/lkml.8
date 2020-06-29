Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B28DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E179B206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="my3ZWmBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbgF2TXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732139AbgF2TWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2BC0307A3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:45:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so17013577wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M6RFYDYqKSXVITYiEJiCJyNvIh/8cppoOkzBR1lf/Bs=;
        b=my3ZWmBMP+bCFEkJOKqlXlSIimSWj2tQJFqLXD9wspUC/PoOmo34zvQ7tz7JEezZU6
         zSSaODsccUwy30lD3WpOhEDpSDNGtsbm6UcC7V/F1wTgKdSEa/b4H84NV/m79B2YZ4I0
         GwAAPAj11jo/YjCgLD3qXQiV+FJzvRbv+gnu7o6H8ZMCyztf1/18HgORZkzVIKDxnjmH
         cTm+hpNcu29IIKCRqcalb6/8LHeZlrawAdBZRXbu+IzbydLWmwK/X0ZiXNj9mY49te4R
         00p4vQMlgX2DWlp28wBmEyt1t3uZg47UykBZroKsUN7AsCzsGNBkkfvOl/1Hulw12ck0
         wk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M6RFYDYqKSXVITYiEJiCJyNvIh/8cppoOkzBR1lf/Bs=;
        b=NoIWCU0dQch0KQNHxD+jGK83JpoYYWxbnV1o1vSmAgFpcRyvuUM6k/O2k5ZB+Jn9UU
         k4LeZUNZjfy/AqzxSicnUcXvpiiM6AZQwGrTFEwhKKkVdwEitDaD0lgSsIP27GetlkrN
         qiylursbU3KDOoZ+8IX8VvhfGlFjD5XRaGSDX4QA0NjwVU5tIpRLl3HTKJQKK0lccAhC
         l49rGdj+JTg4qLIYnnAU8tAV95fCv68iNIrxZzgeg6dUa8Ahx+swAFc6+Gh8geFPE3Ss
         YgyDi4x9fTMP+DbWz3UdEqeSMc7sUKF6ddEBUbeFKIvpMpdQrEcYhajbzPasXuTr35QM
         YW3Q==
X-Gm-Message-State: AOAM531CX392+Xb4vba72qXbXV2WNH9S9+07C+fG23wZuYFksJGMukEA
        hamHOuvnEhe2w5wdk7W38tZDiQ==
X-Google-Smtp-Source: ABdhPJwlVgDj6Deyg8ldvc9Ax2DufMoYBmRY/fYIpLkc9zjDg8/qVeDEIufyWzOfNvWxUKXNbbUlmA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr18485096wrq.357.1593445545423;
        Mon, 29 Jun 2020 08:45:45 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c143sm32065643wmd.1.2020.06.29.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:45:44 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:45:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when
 allocating register offset/mask
Message-ID: <20200629154543.GN177734@dell>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org>
 <20200629130644.GU3334@localhost>
 <20200629140137.GK177734@dell>
 <CADBw62r_tkGEr9kHpojAi+fJ+qUqbsc-DQgG1TUAwOdbDXTgNQ@mail.gmail.com>
 <20200629144325.GV3334@localhost>
 <CADBw62oFcDVcQMRx+F3omCsYYGeuw+-X2zGt_tm+T5mJ6Vaqjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62oFcDVcQMRx+F3omCsYYGeuw+-X2zGt_tm+T5mJ6Vaqjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Baolin Wang wrote:

> On Mon, Jun 29, 2020 at 10:43 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 10:35:06PM +0800, Baolin Wang wrote:
> > > On Mon, Jun 29, 2020 at 10:01 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Mon, 29 Jun 2020, Johan Hovold wrote:
> > > >
> > > > > On Mon, Jun 29, 2020 at 01:32:14PM +0100, Lee Jones wrote:
> > > > > > Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
> > > > > > dividing 0 by anything is still 0, there is no need to re-assign
> > > > > > ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.
> > > > > >
> > > > > > This fixes the following W=1 warning:
> > > > > >
> > > > > >  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
> > > > > >
> > > > > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > > > > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/mfd/sprd-sc27xx-spi.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > > > > index c305e941e435c..694a7d429ccff 100644
> > > > > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > > > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > > > > @@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
> > > > > >             return -ENOMEM;
> > > > > >
> > > > > >     ddata->irq_chip.irqs = ddata->irqs;
> > > > > > -   for (i = 0; i < pdata->num_irqs; i++) {
> > > > > > +   for (i = 1; i < pdata->num_irqs; i++) {
> > > > > >             ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> > > > > >             ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> > > > > >     }
> > > > >
> > > > > This doesn't look right either.
> > > > >
> > > > > First, the loop is never executed if num_irqs is zero.
> > > >
> > > > The point of the patch is that 0 entries are never processed.
> >
> > So what's the problem? There's no division by zero here.
> >
> > And what compiler are you using, Lee? Seems broken.
> >
> > > > > Second, the current code looks bogus too as reg_offset is always set to
> > > > > zero and mask to BIT(i)...
> > >
> > > Now the result is correct, since all PMIC irq mask bits are in one
> > > register now, which means the reg_offset is always 0 can work well.
> > > But I think the logics still can be improved if our PMIC irq numbers
> > > are larger than 32 in future.
> >
> > The code is still bogus as pointed out above. Why do you bother to
> > divide by num_irqs at all?
> 
> Right, no need to divide by num_irqs, can be simplified as below. Lee,
> care to resend your patch with simplifying the code? Or you want me to
> send a patch?
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index 33336cde4724..2ed5f3a4e79c 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -250,10 +250,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
>                 return -ENOMEM;
> 
>         ddata->irq_chip.irqs = ddata->irqs;
> -       for (i = 0; i < pdata->num_irqs; i++) {
> -               ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> -               ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> -       }
> +       for (i = 0; i < pdata->num_irqs; i++)
> +               ddata->irqs[i].mask = BIT(i);

I'm happy to resend with your Suggested-by.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
