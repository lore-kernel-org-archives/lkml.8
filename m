Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD589C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC9620A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEHNtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:49:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45823 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726904AbgEHNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:49:22 -0400
Received: (qmail 20457 invoked by uid 500); 8 May 2020 09:49:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2020 09:49:19 -0400
Date:   Fri, 8 May 2020 09:49:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Tang Bin <tangbin@cmss.chinamobile.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] USB: EHCI: ehci-mv: Fix unused assignment in mv_ehci_probe()
In-Reply-To: <20200508114409.12704-1-tangbin@cmss.chinamobile.com>
Message-ID: <Pine.LNX.4.44L0.2005080948560.19653-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020, Tang Bin wrote:

> Delete unused initialized value, because 'retval' will be assigined
> by the function mv_ehci_enable().

This should also mention the extra blank line that the patch removes.

Alan Stern

> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ehci-mv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index bd4f6ef53..1c079953e 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
> @@ -108,7 +108,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
>  	struct ehci_hcd *ehci;
>  	struct ehci_hcd_mv *ehci_mv;
>  	struct resource *r;
> -	int retval = -ENODEV;
> +	int retval;
>  	u32 offset;
>  
>  	if (usb_disabled())
> @@ -142,8 +142,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
>  		goto err_put_hcd;
>  	}
>  
> -
> -
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ehci_mv->base = devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(ehci_mv->base)) {
> 

