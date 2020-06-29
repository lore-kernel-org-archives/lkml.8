Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3FD2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459185;
	bh=K/E+tH6zEvXjyQ1suexQYQF8pVMxBHhkigunJTOHRoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fI7B11BfPjVU1LmKUyNoRKp0VBIdLkJQYO9TpWTbuU6wuNY9KExfEPJAWYHE0epx1
	 d71YeOWGXlQvGvmG8uVUTRJrpD1q2TH3J6c3dsnu16U69HYRei5VNBHhAVoTgSqJwT
	 zoMSDmI61zeOD5wskOStlm9bP7kPgaRNRZkVOUJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgF2TdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbgF2Tcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1DC02F002
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:43:27 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so9213409lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YSrvY7ndQQ0VwYyPuUYQZgjUMOLCrC7/BsK3Jg70uiA=;
        b=EpQ/dIMdwCYLaRtO5Nv/wtgebffrzaIRTec6A8uPQLjJiTw/a0L6udd4vIUrBW/z2H
         PKCbFthfmiv7Xjf6wHm9W0BRiKErd/U9vpsYfZ67IDu3GUd40sBdcFjxzKsivxfBxVKU
         WB1qHSJxp7J+10CQOjX9GZu/5VL3waWRuX1AIDwExBLoLpiVMBp2GL5nRpHUcKFAhkyk
         tdzJO2JOH+JYflIsWbFApZv+CzvsLEhffvN/Gp1DQFiIitTPIfn0m+mew6jcbk9ot3AU
         zhQuNLaLtFGF7c5VWjYKEV3mhKLmtdJTdjcz9rsF8wf15Wp1rEg9R8w1FqAU3xPrfUks
         mvbw==
X-Gm-Message-State: AOAM5328u0KiphH9u5eeKetW+I2wb03wZYoKwZ+BkhL4+2FIyTnVak+C
        HvlZJkJT40PWNpb7tUYU4Ok=
X-Google-Smtp-Source: ABdhPJxlXL/WPQmHiWHBUnNiCTuuoYT2K4kdoHBsIw1V5XczaXf3Hns3BgilQStZ/HVmyNueCKOooQ==
X-Received: by 2002:ac2:518c:: with SMTP id u12mr9295373lfi.91.1593441806019;
        Mon, 29 Jun 2020 07:43:26 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v19sm2858051lfi.65.2020.06.29.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:43:25 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jpv0H-0005HB-DZ; Mon, 29 Jun 2020 16:43:25 +0200
Date:   Mon, 29 Jun 2020 16:43:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Johan Hovold <johan@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when
 allocating register offset/mask
Message-ID: <20200629144325.GV3334@localhost>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org>
 <20200629130644.GU3334@localhost>
 <20200629140137.GK177734@dell>
 <CADBw62r_tkGEr9kHpojAi+fJ+qUqbsc-DQgG1TUAwOdbDXTgNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBw62r_tkGEr9kHpojAi+fJ+qUqbsc-DQgG1TUAwOdbDXTgNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:35:06PM +0800, Baolin Wang wrote:
> On Mon, Jun 29, 2020 at 10:01 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Mon, 29 Jun 2020, Johan Hovold wrote:
> >
> > > On Mon, Jun 29, 2020 at 01:32:14PM +0100, Lee Jones wrote:
> > > > Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
> > > > dividing 0 by anything is still 0, there is no need to re-assign
> > > > ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.
> > > >
> > > > This fixes the following W=1 warning:
> > > >
> > > >  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
> > > >
> > > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/mfd/sprd-sc27xx-spi.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > > index c305e941e435c..694a7d429ccff 100644
> > > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > > @@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
> > > >             return -ENOMEM;
> > > >
> > > >     ddata->irq_chip.irqs = ddata->irqs;
> > > > -   for (i = 0; i < pdata->num_irqs; i++) {
> > > > +   for (i = 1; i < pdata->num_irqs; i++) {
> > > >             ddata->irqs[i].reg_offset = i / pdata->num_irqs;
> > > >             ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
> > > >     }
> > >
> > > This doesn't look right either.
> > >
> > > First, the loop is never executed if num_irqs is zero.
> >
> > The point of the patch is that 0 entries are never processed.

So what's the problem? There's no division by zero here.

And what compiler are you using, Lee? Seems broken.

> > > Second, the current code looks bogus too as reg_offset is always set to
> > > zero and mask to BIT(i)...
> 
> Now the result is correct, since all PMIC irq mask bits are in one
> register now, which means the reg_offset is always 0 can work well.
> But I think the logics still can be improved if our PMIC irq numbers
> are larger than 32 in future.

The code is still bogus as pointed out above. Why do you bother to
divide by num_irqs at all?

And what have you guys been smoking? ;)

Johan
