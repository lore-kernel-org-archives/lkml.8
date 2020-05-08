Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F1C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDB0208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588938542;
	bh=3XIhhm1Au/xGkfcAr3Z9Yi2x3ynKKFKgs0eZV/NQRgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXgsrdiyBZ4v70BvujudVWe1f8of9ArG3axCEPJdkeIIdDiGtK1hRrnmUWnQPpd3r
	 DOjGq0d3SVLJ4Rb5CfCfkvLi8wdUKU9Up+Xsz+yuYclJBTQq2ZsHLLZ6dZDtUaikO1
	 bTamlkEspAd0wWkB9/Q4iYgGJh3Dj4i02Gz84ZYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgEHLtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgEHLtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:49:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF2D206D5;
        Fri,  8 May 2020 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588938541;
        bh=3XIhhm1Au/xGkfcAr3Z9Yi2x3ynKKFKgs0eZV/NQRgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvsvQSGYKzYmyT1GogXbnmyne0OVwyEJLMmFQZoxw8cqsVmaiMwZ18Fv/ZovqttVX
         j0NvV2MUYhdZ+6GNLpdvDNoKHYFINt4Va8mIkvXzdL8ayp5zLkcKcIuMWyXMDDgKCS
         EnLtw9BgnueLU3C+JSD/ZF9KHLqAdNlAOOMgvLuo=
Date:   Fri, 8 May 2020 13:48:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] USB: host: ehci: Add error handling in
 ehci_mxc_drv_probe()
Message-ID: <20200508114858.GA4085349@kroah.com>
References: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:44:53PM +0800, Tang Bin wrote:
> The function ehci_mxc_drv_probe() does not perform sufficient error
> checking after executing platform_get_irq(), thus fix it.
> 
> Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards")
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ehci-mxc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index a1eb5ee77..a0b42ba59 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;

<= ?
