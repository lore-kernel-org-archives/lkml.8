Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08884C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C267F20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600424;
	bh=qEito2XzI2KJ7U8hopKBoe5VU498OUbzHEEhASG9qMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KZiscAkf7ClY8kXaJtUOg8AW7WB+p2xoXtoCbVcHnS79UHdDIAP/aW067fgbYXOH/
	 /gonvWfqrL72cgzZRAi6mR4fnvV0XoXY2gtDbm0bnrKnBMnEM9R5AbplhMGKuwguip
	 v3yHf0/4dKOMXUQf/o2ccuTnY3btyplVENyIcQIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgH1HkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgH1HkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:40:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C59120776;
        Fri, 28 Aug 2020 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600422;
        bh=qEito2XzI2KJ7U8hopKBoe5VU498OUbzHEEhASG9qMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZoFaYECR/MHEhXgjcxv1+6w6Kxteul+dKGI+M4S/iRHp8iwKOljNH0tGp7QhiMgk
         RLnEGq8hCcPa9Qj4Mk1DMPf0WktlbfHZr8x69QzQTZRfhajNpvO7duQ0WjSEtSEGU6
         wC0gr6t9hy6giiUoYWdMk+2JBpNTJgZvtsj1tLtw=
Date:   Fri, 28 Aug 2020 09:40:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     jacmet@sunsite.dk, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] usb/c67x00/c67x00-drv: Fix Data Race bug
Message-ID: <20200828074035.GB942935@kroah.com>
References: <20200826144459.8245-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826144459.8245-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 08:14:59PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Currently in c67x00_drv_probe() IRQ is requested before calling
> c67x00_probe_sie() and hence if interrupt happens the reading of certain
> variables in the handler can race with initialization of the variables,
> for e.g. sie->sie_num is written in c67x00_probe_sie() and read in
>  c67x00_hcd_irq().
> Hence, this patch calls c67x00_probe_sie() before requesting IRQ in
> probe.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/usb/c67x00/c67x00-drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
> index 53838e7d4eef..2e816d5ca0eb 100644
> --- a/drivers/usb/c67x00/c67x00-drv.c
> +++ b/drivers/usb/c67x00/c67x00-drv.c
> @@ -146,6 +146,9 @@ static int c67x00_drv_probe(struct platform_device *pdev)
>  	c67x00_ll_init(c67x00);
>  	c67x00_ll_hpi_reg_init(c67x00);
>  
> +	for (i = 0; i < C67X00_SIES; i++)
> +		c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
> +
>  	ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, c67x00);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Cannot claim IRQ\n");
> @@ -158,9 +161,6 @@ static int c67x00_drv_probe(struct platform_device *pdev)
>  		goto reset_failed;
>  	}
>  
> -	for (i = 0; i < C67X00_SIES; i++)
> -		c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
> -
>  	platform_set_drvdata(pdev, c67x00);
>  
>  	return 0;

Have you tested this on hardware to verify it works properly?

thanks,

greg k-h
