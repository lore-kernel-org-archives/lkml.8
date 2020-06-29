Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E21BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FD1206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465464;
	bh=2VjGLijjtJnODGSkJ1SgcA2IUwDBP0kg9dkApMQuTMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MznpqryNu9ip+KXfA3ttZpr+cPWvYDNolRt7w8pMchce5mLLgvHfgohjioQp8rUX7
	 VL+QyJowtnEarZBsnzrWxoEpdtzV8PSVTiHIzNbjTlby43BuSItNGt876RWTBptTJ+
	 8EhFBOYjzw+9YdtbVQQhznZeXFhqSxM7zURw58no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390760AbgF2VRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgF2Swv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625DC02A556
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:06:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so4699983ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWzRxTXrUasbGXUFwSr2i2nPcUT+2MUUycvRS8lYyrM=;
        b=hqb37tRcYrufOBW+bXtELSQb8eYyvV7u0oFo6Bx5fAjCfViqRn2BQVIz2frQYJdkXB
         gXpzQ5MoWm0Cu3sX93zhH3N79e3A3T0Htjl3gfeybeV0vGV0SWiy4c4HY2OIF5jIfSII
         CHaWmMFuJ1TDwImjAOscqtMLSVzUGDaIHDRDzKpofeu64bwHeZcxFo66gfPEFMTQzNCf
         1L/EZ0Uocdy4G2ludZCWovpgryyPQgRY1qUPLbk5iJXVkHMk98wg8Ul8TdMjMr/8oNVO
         Hcbl2h5puCqxc3+MftLIHIkeIs44shq1RMsHbycGOXbBsg+aXArbwiordsyLNyNi26+n
         +2NA==
X-Gm-Message-State: AOAM5339x94fU/prGU2zQFcGqf7c6tM1Yb4Z6nzxiwzoBaDP0alBL2Vz
        MilQXJlZa74jOv9hBMv4BOs=
X-Google-Smtp-Source: ABdhPJwQFKL4/TMXmQS8Je9ya6myBWYfn8LiUhyH3xk8GCLpw4qDQMLOc/6BbQ7ZvG4DSGtm/UrBtQ==
X-Received: by 2002:a2e:b55a:: with SMTP id a26mr3583999ljn.349.1593436005924;
        Mon, 29 Jun 2020 06:06:45 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f22sm7456128ljn.66.2020.06.29.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:06:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jptUi-0007Vk-Lx; Mon, 29 Jun 2020 15:06:45 +0200
Date:   Mon, 29 Jun 2020 15:06:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 4/5] mfd: sprd-sc27xx-spi: Fix divide by zero when
 allocating register offset/mask
Message-ID: <20200629130644.GU3334@localhost>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629123215.1014747-5-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:32:14PM +0100, Lee Jones wrote:
> Since ddata->irqs[] is already zeroed when allocated by devm_kcalloc() and
> dividing 0 by anything is still 0, there is no need to re-assign
> ddata->irqs[i].* values.  Instead, it should be safe to begin at 1.
> 
> This fixes the following W=1 warning:
> 
>  drivers/mfd/sprd-sc27xx-spi.c:255 sprd_pmic_probe() debug: sval_binop_unsigned: divide by zero
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index c305e941e435c..694a7d429ccff 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -251,7 +251,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	ddata->irq_chip.irqs = ddata->irqs;
> -	for (i = 0; i < pdata->num_irqs; i++) {
> +	for (i = 1; i < pdata->num_irqs; i++) {
>  		ddata->irqs[i].reg_offset = i / pdata->num_irqs;
>  		ddata->irqs[i].mask = BIT(i % pdata->num_irqs);
>  	}

This doesn't look right either.

First, the loop is never executed if num_irqs is zero.

Second, the current code looks bogus too as reg_offset is always set to
zero and mask to BIT(i)...

Johan
