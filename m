Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E628C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C0D20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctmn+yI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGPH4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgGPH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:56:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9982C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:56:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so10387957wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E3RYKNb85oZ0Zx4y7onyr244i3mIIOsmBXwDkItqE+k=;
        b=ctmn+yI/FZFifjCNYzMz9Bq9cteGr8LhZ9mVVlZ1Fug41fk3w7p/ReVoVuTtHDwyHV
         B9jbYA1ikUtXdtJzxEOhmVTJ8dYaZmDcYAIdt0i99dAaif664G3O2T42EYMdm68F75Q4
         3x0Q+AuMzzXsczEVHbUMel3NhLKq0xsjzhbUn+SAzCdPB6IGCMiTpL+IN/5/ocn7PayG
         4zQ/lGe9l1m8CqZEMl8VpRAe4W1RNOcb7vERHMDUuOtYD4YoBBCPOXHf0olaU8KeQ1hO
         0OHLpM/7XjSSiHoohK6rOoLQl4iTtSjvcNYqLgT0G4cUzdcBZZYX8n0GlBThMlpDw0Iw
         /cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E3RYKNb85oZ0Zx4y7onyr244i3mIIOsmBXwDkItqE+k=;
        b=qlzgTZci9wnwRtd0FwHh2SmnZxE1YdN/QAOuMvQuuBzgiKnPiv/5WbFDLlZGK4NR93
         vsl3SLmP1AlSs7pljydY9Ncb7KzAclKOG5IZXooHJPf0FUj1Pm/V/NEmu4Ls/dI9c6sq
         Oph/DWgezG+PlYi2o7etC+IRx3AgpCcSJcimu6zWWX/y2Ydk9VJfknYsv9QgX0kFCvmE
         bAtvNgh02xfJoFakDt4PZCfqibYaUEdh4aR3hvZksJRsOGdmQS7G8iVwMyWkj+iijvr/
         QWSaY6bKxt13ZCgHaECBzeBTwdk+CbckxutbwbRWbBZxZWr6YoTkduMIILUksOt2L1oq
         NPNQ==
X-Gm-Message-State: AOAM531Hv0cGtW8M4OHcl+WCjDM5ZEqDN05rBduspMiDfJD6L21rbLNF
        rT/4QrWCiO310kaoGdxP9Dzzfw==
X-Google-Smtp-Source: ABdhPJw3VrvtHsivvIaotZC5ddMt77keOADIJTHX4XCZZ5qFOosY50Z87c19woDUrLHGVN9dOoqKuA==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr3331097wmg.118.1594886169187;
        Thu, 16 Jul 2020 00:56:09 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id z8sm7302939wmg.39.2020.07.16.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:56:08 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:56:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 12/14] spi: spi-at91-usart: Make use of the defined
 'struct of_device_id'
Message-ID: <20200716075606.GM3165313@dell>
References: <20200715150632.409077-1-lee.jones@linaro.org>
 <20200715150632.409077-13-lee.jones@linaro.org>
 <20200715212443.GC23553@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715212443.GC23553@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Alexandre Belloni wrote:

> Hi Lee,
> 
> On 15/07/2020 16:06:30+0100, Lee Jones wrote:
> > It's there so why not use it.
> > 
> 
> Is that the correct resolution? Isn't the proper thing to do simply
> removing at91_usart_spi_dt_ids as the only way it will ever be probed is
> through drivers/mfd/at91-usart.c and I would think matching the driver
> name is enough.

I'm 50/50 on this.

Happy with whatever the authors/maintainers decide most appropriate.

> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
> >  684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
> >  | ^~~~~~~~~~~~~~~~~~~~~
> > 
> > Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/spi/spi-at91-usart.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> > index 88033422a42ae..d47a20be43ccd 100644
> > --- a/drivers/spi/spi-at91-usart.c
> > +++ b/drivers/spi/spi-at91-usart.c
> > @@ -692,6 +692,7 @@ static struct platform_driver at91_usart_spi_driver = {
> >  	.driver = {
> >  		.name = "at91_usart_spi",
> >  		.pm = &at91_usart_spi_pm_ops,
> > +		.of_match_table = at91_usart_spi_dt_ids,
> >  	},
> >  	.probe = at91_usart_spi_probe,
> >  	.remove = at91_usart_spi_remove,
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
