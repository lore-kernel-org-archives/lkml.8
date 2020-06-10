Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58609C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB21206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgFJOJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:09:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41571 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729621AbgFJOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:09:33 -0400
Received: (qmail 12849 invoked by uid 1000); 10 Jun 2020 10:09:32 -0400
Date:   Wed, 10 Jun 2020 10:09:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: ohci-sm501: Add missed iounmap() in remove
Message-ID: <20200610140932.GA11727@rowland.harvard.edu>
References: <20200610024844.3628408-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610024844.3628408-1-hslester96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:48:44AM +0800, Chuhong Yuan wrote:
> This driver misses calling iounmap() in remove to undo the ioremap()
> called in probe.
> Add the missed call to fix it.
> 
> Fixes: f54aab6ebcec ("usb: ohci-sm501 driver")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/usb/host/ohci-sm501.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
> index cff965240327..b91d50da6127 100644
> --- a/drivers/usb/host/ohci-sm501.c
> +++ b/drivers/usb/host/ohci-sm501.c
> @@ -191,6 +191,7 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
>  	struct resource	*mem;
>  
>  	usb_remove_hcd(hcd);
> +	iounmap(hcd->regs);
>  	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>  	usb_put_hcd(hcd);
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -- 
> 2.26.2

Acked-by: Alan Stern <stern@rowland.harvard.edu>
