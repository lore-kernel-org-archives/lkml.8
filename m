Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6670320829
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594976298;
	bh=qyjaT/u3HGLnH6NNNhd7+HIEewuHpkz+8UBG0JggC8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0a+sTPN/YGIsQdkEG+Uov7XZQM9iVLk87unkRzTJeQs9M6Lyd2gSEaX6oq43SFHak
	 9bXf5V8lL66AvOQ1F7tSuc0YXavAHv+QHisob1p5Culo0kuGsIZNcVw2Aqt1VaGn9x
	 gqWbO+gd401FioflC29KHnS9Ky542F5TcknFoSn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQI6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQI6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:58:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CF3207F5;
        Fri, 17 Jul 2020 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594976295;
        bh=qyjaT/u3HGLnH6NNNhd7+HIEewuHpkz+8UBG0JggC8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t7pyKzMBZ3JorrRyg89TUtrRGa419pprgzNxAR6iFoheJxjCO5m0izSSk5EBtaWDL
         1m83x1kxyE9O9ThsTXXLym5SPdtkzQrsCmpsOb5f4h+v40o7FLvdbuBYrtzfaD1pc6
         w00m/QT3ZH3pmHS4BL8vro5YU0ce6HUCCbFF2pYY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jwMC5-00CZYX-CG; Fri, 17 Jul 2020 09:58:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jul 2020 09:58:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.or
Subject: Re: [PATCH 2/2] irqchip: imx-intmux: add runtime PM support
In-Reply-To: <20200716193244.31090-3-qiangqing.zhang@nxp.com>
References: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
 <20200716193244.31090-3-qiangqing.zhang@nxp.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <7fa10b6173147f57034b2ed95a19ca4f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-16 20:32, Joakim Zhang wrote:
> Add runtime PM support for intmux interrupt controller.

Same as the previous patch. The changes are significant enough
that you need to write a proper change log.

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/irqchip/irq-imx-intmux.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-intmux.c 
> b/drivers/irqchip/irq-imx-intmux.c
> index 6095f76c4f0d..a631815c7bb4 100644
> --- a/drivers/irqchip/irq-imx-intmux.c
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -53,6 +53,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/spinlock.h>
> +#include <linux/pm_runtime.h>
> 
>  #define CHANIER(n)	(0x10 + (0x40 * n))
>  #define CHANIPR(n)	(0x20 + (0x40 * n))
> @@ -60,6 +61,7 @@
>  #define CHAN_MAX_NUM		0x8
> 
>  struct intmux_irqchip_data {
> +	struct irq_chip		chip;
>  	int			chanidx;
>  	int			irq;
>  	struct irq_domain	*domain;
> @@ -123,8 +125,10 @@ static struct irq_chip imx_intmux_irq_chip = {
>  static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
>  			      irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_data(irq, h->host_data);
> -	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, 
> handle_level_irq);
> +	struct intmux_irqchip_data *data = h->host_data;
> +
> +	irq_set_chip_data(irq, data);
> +	irq_set_chip_and_handler(irq, &data->chip, handle_level_irq);
> 
>  	return 0;
>  }
> @@ -244,6 +248,10 @@ static int imx_intmux_probe(struct platform_device 
> *pdev)
>  			return -ENOMEM;
>  	}
> 
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = clk_prepare_enable(data->ipg_clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
> @@ -251,6 +259,8 @@ static int imx_intmux_probe(struct platform_device 
> *pdev)
>  	}
> 
>  	for (i = 0; i < channum; i++) {
> +		data->irqchip_data[i].chip = imx_intmux_irq_chip;
> +		data->irqchip_data[i].chip.parent_device = &pdev->dev;

At some point, we will have to find a way to throw the parent_device
thing out of the irq_chip structure. This thing is a liability.
Nothing you can do about it for now though.

>  		data->irqchip_data[i].chanidx = i;
> 
>  		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
> @@ -279,6 +289,12 @@ static int imx_intmux_probe(struct platform_device 
> *pdev)
> 
>  	platform_set_drvdata(pdev, data);
> 
> +	/*
> +	 * Let pm_runtime_put() disable clock.
> +	 * If CONFIG_PM is not enabled, the clock will stay powered.
> +	 */
> +	pm_runtime_put(&pdev->dev);
> +
>  	return 0;
>  out:
>  	clk_disable_unprepare(data->ipg_clk);
> @@ -300,7 +316,7 @@ static int imx_intmux_remove(struct platform_device 
> *pdev)
>  		irq_domain_remove(data->irqchip_data[i].domain);
>  	}
> 
> -	clk_disable_unprepare(data->ipg_clk);
> +	pm_runtime_disable(&pdev->dev);
> 
>  	return 0;
>  }
> @@ -322,7 +338,7 @@ static void imx_intmux_restore_regs(struct
> intmux_data *data)
>  		writel_relaxed(data->saved_reg[i], data->regs + CHANIER(i));
>  }
> 
> -static int imx_intmux_suspend(struct device *dev)
> +static int imx_intmux_runtime_suspend(struct device *dev)
>  {
>  	struct intmux_data *data = dev_get_drvdata(dev);
> 
> @@ -332,7 +348,7 @@ static int imx_intmux_suspend(struct device *dev)
>  	return 0;
>  }
> 
> -static int imx_intmux_resume(struct device *dev)
> +static int imx_intmux_runtime_resume(struct device *dev)

You just introduced these two functions, and rename them immediately?

>  {
>  	struct intmux_data *data = dev_get_drvdata(dev);
>  	int ret;
> @@ -349,7 +365,10 @@ static int imx_intmux_resume(struct device *dev)
>  #endif
> 
>  static const struct dev_pm_ops imx_intmux_pm_ops = {
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_intmux_suspend, imx_intmux_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(imx_intmux_runtime_suspend,
> +			   imx_intmux_runtime_resume, NULL)
>  };
> 
>  static const struct of_device_id imx_intmux_id[] = {

I think you'd might as well squash the two patches together.
Splitting the two serves little purpose.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
