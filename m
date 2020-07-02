Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10977C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEB32088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgGBN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:26:10 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48151 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729257AbgGBN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:26:06 -0400
Received: (qmail 586630 invoked by uid 1000); 2 Jul 2020 09:26:05 -0400
Date:   Thu, 2 Jul 2020 09:26:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        mylene.josserand@collabora.com,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>
Subject: Re: [PATCH] usb: host: ohci-platform: Disable ohci for rk3288
Message-ID: <20200702132605.GA586616@rowland.harvard.edu>
References: <20200702090504.36670-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702090504.36670-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 02:35:04PM +0530, Jagan Teki wrote:
> rk3288 has usb host0 ohci controller but doesn't actually work 
> on real hardware but it works with new revision chip rk3288w.
> 
> So, disable ohci for rk3288.
> 
> For rk3288w chips the compatible update code is handled by bootloader.
> 
> Cc: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note:
> - U-Boot patch for compatible update
> https://patchwork.ozlabs.org/project/uboot/patch/20200702084820.35942-1-jagan@amarulasolutions.com/
> 
>  drivers/usb/host/ohci-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 7addfc2cbadc..24655ed6a7e0 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -96,7 +96,7 @@ static int ohci_platform_probe(struct platform_device *dev)
>  	struct ohci_hcd *ohci;
>  	int err, irq, clk = 0;
>  
> -	if (usb_disabled())
> +	if (usb_disabled() || of_machine_is_compatible("rockchip,rk3288"))
>  		return -ENODEV;
>  
>  	/*
> -- 
> 2.25.1

Acked-by: Alan Stern <stern@rowland.harvard.edu>
