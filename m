Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B99C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B12C206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597840724;
	bh=o6oAq5rdwXJGBY7absMrQoUVEMTp6AQnDKmBdmKpvYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tCnfOQEOk6M5cOnx3XUc7HppTXxcpZpFo+VwOo/vyr1WluKE2O6AE64SoHyvJazqy
	 LeP8Ge/8VB6nslM+aEtn6a3A6kSgXWELisIRZgvM+jg+C/WIhz9YE4G+5CwfwG+ze9
	 6ANk5ehrlRRd9iaxJkzT0/Qrt82h5HrkNTpcKRNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHSMim convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:38:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgHSMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:38:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id t15so17919484edq.13;
        Wed, 19 Aug 2020 05:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OgF6KuIao9WPy46nrzSCTjGwopx5gRHI8y6lu7j2ODw=;
        b=dyljRXXQQiLV+h5rTErPWndjYjMg0zwKVPbP2WJJBPYLE88X+qCasBhpr/QOYK/+cu
         juQoE6CKaVVGn5HEvEdhShc4JE9JCTD3pVpHRpz891lteGWh6IZ+LXxs1zx5P6IDolZE
         bZQkFehS4ovE8o90SseCy9OGHZtoDeLpoBCYYlC33MSBBL8OAMuPjYxUthIP6QBTYwSG
         vG3/SAe8qzx92moMTkpx9tUqjS6YvSO4PNF6mvnqmTnQeR6uk6WkVCM94EJgA6u35+eX
         4jCykFZlIES3wQ5YOhpNe+lh/Jluf3S9jx8aHBqRbRdz6RXGWxFxHF7vZkIZvyYeD4hh
         Z/0g==
X-Gm-Message-State: AOAM533nyizA7RzNqDzcFQ3mx0uG63SW9IYIv9lQVoflQ3RHuXt7Yodf
        RVPFJJaJ+IgUMqxqL+3YEJ0=
X-Google-Smtp-Source: ABdhPJws9xl2go6RnKhQEFh0nadcI8QbVB8Hz0YflxX08ma8DBW/qvMmKBNk0kHUr8G1NWNLmlPPEw==
X-Received: by 2002:aa7:d585:: with SMTP id r5mr23821644edq.30.1597840717548;
        Wed, 19 Aug 2020 05:38:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g18sm18466179ejf.20.2020.08.19.05.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:38:36 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:38:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Message-ID: <20200819123834.GB18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123226eucas1p16c9b90330d957344f99f6ee461190085@eucas1p1.samsung.com>
 <20200819123208.12337-2-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-2-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:01PM +0200, Łukasz Stelmach wrote:
> Fix issues with DMA transfers bigger than 512 on Exynos3250.

Fix, but how? With proper explanation this should go to CC-stable.

Best regards,
Krzysztof

> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index cf67ea60dc0e..fb5e2ba4b6b9 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -678,11 +678,11 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
>  		sdd->state &= ~RXBUSY;
>  		sdd->state &= ~TXBUSY;
>  
> -		s3c64xx_enable_datapath(sdd, xfer, use_dma);
> -
>  		/* Start the signals */
>  		s3c64xx_spi_set_cs(spi, true);
>  
> +		s3c64xx_enable_datapath(sdd, xfer, use_dma);
> +
>  		spin_unlock_irqrestore(&sdd->lock, flags);
>  
>  		if (use_dma)
> -- 
> 2.26.2
> 
