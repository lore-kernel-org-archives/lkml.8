Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C16C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D999220756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHKFqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgHKFqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:46:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6ECC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:46:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1k5N79-00049r-Vq; Tue, 11 Aug 2020 07:46:24 +0200
Subject: Re: [PATCH 1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify
 error handling
To:     Anson Huang <Anson.Huang@nxp.com>, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
References: <1597119905-7341-1-git-send-email-Anson.Huang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <178e532c-723c-75da-6c24-fd3a720843fb@pengutronix.de>
Date:   Tue, 11 Aug 2020 07:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1597119905-7341-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8/11/20 6:25 AM, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/irqchip/irq-imx-intmux.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
> index e35b7b0..2f51ec9 100644
> --- a/drivers/irqchip/irq-imx-intmux.c
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -226,12 +226,10 @@ static int imx_intmux_probe(struct platform_device *pdev)
>  	}
>  
>  	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(data->ipg_clk)) {
> -		ret = PTR_ERR(data->ipg_clk);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(data->ipg_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->ipg_clk),
> +				     "failed to get ipg clk: %ld\n",
> +				     PTR_ERR(data->ipg_clk));

Haven't used dev_err_probe myself yet, but the function does

	if (err != -EPROBE_DEFER) {
		dev_err(dev, "error %d: %pV", err, &vaf);

so your message would become

	"error %d: failed to get ipg clk: %d\n"

printing the same error code twice. If so, you should drop the second.

Cheers
Ahmad

>  
>  	data->channum = channum;
>  	raw_spin_lock_init(&data->lock);
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
