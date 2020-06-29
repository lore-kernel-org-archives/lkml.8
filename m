Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC66C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9129F2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyHDUEEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgF2Ssb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbgF2Sro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E9C02E2C6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:01:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so16653259wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=542naEdYkdwVfUzvqH+aC9YM376E3GIWXppavzrS/u4=;
        b=EyHDUEEFWn9yVK28+Hgzis259S8xuw43nD/Kg+npWsOctFyY7oszfTuquPbZFQ1HHB
         EmW7Y2DjQ10Tg3SaXiSTTKfal6ejUHL/zlDla+u4Q3sAaEiUFUs6aE15BAKMSQOMF6tv
         rSu60mDOxCvQUXYI2e9dLCkt08apIBll62dI5E+LmBDdvifni3ou19LQmKPUqkblwvyn
         8x3deH+l1r/KOiSleREKnrsG1ahqQmGmmon/NyVU2TbKlc3/Z3wb2oAmWRUAB5EhF60m
         05qGxt60rv/QALyEDWgxPxLT6rfA/ngDjNYC/RYmu1dYKbQ2RzskINX3fE7a0Csk0UFn
         tgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=542naEdYkdwVfUzvqH+aC9YM376E3GIWXppavzrS/u4=;
        b=BGK7gjlPCkXh6R4LJq9JsGaIF+drgOpau6xQmuYq3hR+vgDXlUtu4aoyQyElT0++MC
         jZUpgojEP+NmoN9sZKsG0U4F/8i8BCaJKd4bFJtOnMyNCdgvL5JnxXuiHS1q6hZjW1M2
         L15cdHn+F7LrM2rccUrC4oBF9ZkosftWFMs9HBRcUduGoqIuCWp431LOjvH4ME/QYTq6
         zY8en3r+h2/O5SJ++RYOLhbkaBTPGvN3O1DWijSLknPES/846GAELBLWEngH9wiL5HDT
         JDRyYXyEXYeIVtf/bI2wHwUbutRHV08YJPP+1prIJk7ZQ8zuL7mLTZIor+8aG/VqwAm8
         bjPw==
X-Gm-Message-State: AOAM533VXEl2XvvBdMsPOwWP5aZN/JxerCd7jpKhJsygBAGi5kc+t9Ia
        SgUwUOqbbMjuIRFavCewIDcmBQ==
X-Google-Smtp-Source: ABdhPJyPSo9CxDFKlpX0USRTe74IGxi3ZCgTem7f2aHVNbKECSpsX/29GQmLi6yCxzm/QN24uf/aUw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr18374864wrx.219.1593439299864;
        Mon, 29 Jun 2020 07:01:39 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o1sm52473800wrw.20.2020.06.29.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:01:39 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:01:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when
 allocating register offset/mask
Message-ID: <20200629140137.GK177734@dell>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org>
 <20200629130644.GU3334@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629130644.GU3334@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Johan Hovold wrote:

> On Mon, Jun 29, 2020 at 01:32:14PM +0100, Lee Jones wrote:
> > Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
> > dividing 0 by anything is still 0, there is no need to re-assign
> > ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.
> > 
> > This fixes the following W=1 warning:
> > 
> >  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
> > 
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/sprd-sc27xx-spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > index c305e941e435c..694a7d429ccff 100644
> > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > @@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
> >  		return -ENOMEM;
> >  
> >  	ddata->irq_chip.irqs = ddata->irqs;
> > -	for (i = 0; i < pdata->num_irqs; i++) {
> > +	for (i = 1; i < pdata->num_irqs; i++) {
> >  		ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> >  		ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> >  	}
> 
> This doesn't look right either.
> 
> First, the loop is never executed if num_irqs is zero.

The point of the patch is that 0 entries are never processed.

However, what I appear to have overlooked is that BIT(0 % x) is not 0,
it's 1.

> Second, the current code looks bogus too as reg_offset is always set to
> zero and mask to BIT(i)...

Heh.  I wonder if/how this was tested.

I'm going to wait to hear from the authors before attempting to fix
this again.

Baolin, Could you please clarify this for us please?

--
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
