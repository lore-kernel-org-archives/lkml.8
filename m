Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3006207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596041981;
	bh=crrIbsFPAeg/uDmn1xaqGi5GLnaItxGMCDzVYTWGaOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HrWBFia+EMtUopendxBOYhLASk0vHabPZtUHUq0sEFq+7EiRCZyB1oLTot4OsQVYA
	 YtciQmBd8R0tdRUVoaDikj/PawpjY9ZeKyzemk2cWoNeixaCoEqiMSbz+JJdTgZpxK
	 59N88EAh1F72jl2A1bTSV4kfR+GjRmgcj8cOf8mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgG2Q7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Q7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:59:40 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 530F02075F;
        Wed, 29 Jul 2020 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596041979;
        bh=crrIbsFPAeg/uDmn1xaqGi5GLnaItxGMCDzVYTWGaOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TrBKJ+2ct2wSEBci01nnKlcB/LLkbiQMjc75ofEwvttNh5QwB/wRsg3SOiEig226s
         tAXspfSry7MbMWd5vFFWhReJrNb5rzyLD2G2G3RKcxJnhBcUM8APB4SbvRVMrRImMX
         RhNs/lqnOTU79s2afAmJohsxXOfcf6/Ynl8j6MSA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k0pQX-00Fztd-IY; Wed, 29 Jul 2020 17:59:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jul 2020 17:59:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] irqchip/imx-intmux: Fix irqdata regs save in
 imx_intmux_runtime_suspend()
In-Reply-To: <20200729155849.33919-1-weiyongjun1@huawei.com>
References: <20200729155849.33919-1-weiyongjun1@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <46666de74c4b03142524f514ea64ddad@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: weiyongjun1@huawei.com, hulkci@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, shawnguo@kernel.org, s.hauer@pengutronix.de, qiangqing.zhang@nxp.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-29 16:58, Wei Yongjun wrote:
> Gcc report warning as follows:
> 
> drivers/irqchip/irq-imx-intmux.c:316:29: warning:
>  variable 'irqchip_data' set but not used [-Wunused-but-set-variable]
>   316 |  struct intmux_irqchip_data irqchip_data;
>       |                             ^~~~~~~~~~~~
> 
> irqdata regs is stored to this variable on the stack in
> imx_intmux_runtime_suspend(), which means a nop. this commit
> fix to save regs to the right place.
> 
> Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime
> power management")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/irqchip/irq-imx-intmux.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-imx-intmux.c 
> b/drivers/irqchip/irq-imx-intmux.c
> index 4c9e40d193d6..e35b7b09c3ab 100644
> --- a/drivers/irqchip/irq-imx-intmux.c
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -313,12 +313,12 @@ static int imx_intmux_remove(struct 
> platform_device *pdev)
>  static int imx_intmux_runtime_suspend(struct device *dev)
>  {
>  	struct intmux_data *data = dev_get_drvdata(dev);
> -	struct intmux_irqchip_data irqchip_data;
> +	struct intmux_irqchip_data *irqchip_data;
>  	int i;
> 
>  	for (i = 0; i < data->channum; i++) {
> -		irqchip_data = data->irqchip_data[i];
> -		irqchip_data.saved_reg = readl_relaxed(data->regs + CHANIER(i));
> +		irqchip_data = &data->irqchip_data[i];
> +		irqchip_data->saved_reg = readl_relaxed(data->regs + CHANIER(i));
>  	}
> 
>  	clk_disable_unprepare(data->ipg_clk);
> @@ -329,7 +329,7 @@ static int imx_intmux_runtime_suspend(struct device 
> *dev)
>  static int imx_intmux_runtime_resume(struct device *dev)
>  {
>  	struct intmux_data *data = dev_get_drvdata(dev);
> -	struct intmux_irqchip_data irqchip_data;
> +	struct intmux_irqchip_data *irqchip_data;
>  	int ret, i;
> 
>  	ret = clk_prepare_enable(data->ipg_clk);
> @@ -339,8 +339,8 @@ static int imx_intmux_runtime_resume(struct device 
> *dev)
>  	}
> 
>  	for (i = 0; i < data->channum; i++) {
> -		irqchip_data = data->irqchip_data[i];
> -		writel_relaxed(irqchip_data.saved_reg, data->regs + CHANIER(i));
> +		irqchip_data = &data->irqchip_data[i];
> +		writel_relaxed(irqchip_data->saved_reg, data->regs + CHANIER(i));
>  	}
> 
>  	return 0;

Amazing. Thanks for fixing this.

Johakim: I guess this was never tested, was it?

         M.
-- 
Jazz is not dead. It just smells funny...
