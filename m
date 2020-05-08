Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C599C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5312920708
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEHN4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:56:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33481 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727879AbgEHN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:56:09 -0400
Received: (qmail 21040 invoked by uid 500); 8 May 2020 09:56:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2020 09:56:08 -0400
Date:   Fri, 8 May 2020 09:56:08 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Tang Bin <tangbin@cmss.chinamobile.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] USB: host: ehci: Use the defined variable to simplify
 code
In-Reply-To: <20200508114520.13332-1-tangbin@cmss.chinamobile.com>
Message-ID: <Pine.LNX.4.44L0.2005080952130.19653-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020, Tang Bin wrote:

> Use the defined variable "dev" to make the code cleaner. And
> delete an extra blank line.

Again, the Subject: line should say "ehci-mxc".

> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/usb/host/ehci-mxc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index c9f91e6c7..a1eb5ee77 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -56,7 +56,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
> +	hcd->regs = devm_ioremap_resource(dev, res);

As long as you're making these changes, why not also move the 
definition of dev up before the definition of pdata?  Then you could 
change the definition of pdata to:

	struct mxc_usbh_platform_data *pdata = dev_get_platdata(dev);

Alan Stern

>  	if (IS_ERR(hcd->regs)) {
>  		ret = PTR_ERR(hcd->regs);
>  		goto err_alloc;
> @@ -69,14 +69,14 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	priv = (struct ehci_mxc_priv *) ehci->priv;
>  
>  	/* enable clocks */
> -	priv->usbclk = devm_clk_get(&pdev->dev, "ipg");
> +	priv->usbclk = devm_clk_get(dev, "ipg");
>  	if (IS_ERR(priv->usbclk)) {
>  		ret = PTR_ERR(priv->usbclk);
>  		goto err_alloc;
>  	}
>  	clk_prepare_enable(priv->usbclk);
>  
> -	priv->ahbclk = devm_clk_get(&pdev->dev, "ahb");
> +	priv->ahbclk = devm_clk_get(dev, "ahb");
>  	if (IS_ERR(priv->ahbclk)) {
>  		ret = PTR_ERR(priv->ahbclk);
>  		goto err_clk_ahb;
> @@ -84,13 +84,12 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	clk_prepare_enable(priv->ahbclk);
>  
>  	/* "dr" device has its own clock on i.MX51 */
> -	priv->phyclk = devm_clk_get(&pdev->dev, "phy");
> +	priv->phyclk = devm_clk_get(dev, "phy");
>  	if (IS_ERR(priv->phyclk))
>  		priv->phyclk = NULL;
>  	if (priv->phyclk)
>  		clk_prepare_enable(priv->phyclk);
>  
> -
>  	/* call platform specific init function */
>  	if (pdata->init) {
>  		ret = pdata->init(pdev);
> 

