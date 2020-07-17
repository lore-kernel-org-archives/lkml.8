Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E557C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C1B2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594975321;
	bh=8hSdczxiD3J3IvIYJ/VYZ7xBQTArpVynDQqsZPq4+IE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QvhjQj/lw4x+grn1PaLj6+MHJk2O0Ls8AmKMCTGrf0/lGxTb/9b9sShxZ6gfXMpfa
	 dOhLn0uY0qwHYvsFFA79sGcJOG1DK10qSJRWcAu+BFt5Jbew8/rNeu+Ryf5nmirx+g
	 ZBaL9GEL8SBEtoEnd3kqxmnGk0zxNO2vt5OQnJ6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQIl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQIl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:41:58 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B9320691;
        Fri, 17 Jul 2020 08:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594975318;
        bh=8hSdczxiD3J3IvIYJ/VYZ7xBQTArpVynDQqsZPq4+IE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bpTTDIYNHx8pQMROgwk+7MVjHzpoSGqiRhUxak/Q54REoZBqe6Na5bJmmQyrdZ+k3
         WRcwhSe86jGcfoSj0TH+orsXYd4+V6Fza4giN790pbQbGOj22NTAFfTPQVqlk5CCYQ
         Ost0cqsfzZJUzGjixw8XEyZg2OUNb5kHF4Vsrrh8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jwLwL-00CZKZ-05; Fri, 17 Jul 2020 09:41:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jul 2020 09:41:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.or
Subject: Re: [PATCH 1/2] irqchip: imx-intmux: add system PM support
In-Reply-To: <20200716193244.31090-2-qiangqing.zhang@nxp.com>
References: <20200716193244.31090-1-qiangqing.zhang@nxp.com>
 <20200716193244.31090-2-qiangqing.zhang@nxp.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <364c4a4dc83618f937169ce07e6a6908@kernel.org>
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
> Add system PM support for intmux interrupt controller.

Care to be a little more descriptive?

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/irqchip/irq-imx-intmux.c | 59 ++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-imx-intmux.c 
> b/drivers/irqchip/irq-imx-intmux.c
> index c27577c81126..6095f76c4f0d 100644
> --- a/drivers/irqchip/irq-imx-intmux.c
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -70,6 +70,9 @@ struct intmux_data {
>  	void __iomem			*regs;
>  	struct clk			*ipg_clk;
>  	int				channum;
> +#ifdef CONFIG_PM
> +	unsigned int			*saved_reg;

Please use u32 for 32bit HW registers.

> +#endif
>  	struct intmux_irqchip_data	irqchip_data[];
>  };
> 
> @@ -232,6 +235,15 @@ static int imx_intmux_probe(struct platform_device 
> *pdev)
>  	data->channum = channum;
>  	raw_spin_lock_init(&data->lock);
> 
> +	if (IS_ENABLED(CONFIG_PM)) {
> +		/* save CHANIER register */
> +		data->saved_reg = devm_kzalloc(&pdev->dev,
> +					       sizeof(unsigned int) * channum,
> +					       GFP_KERNEL);
> +		if (!data->saved_reg)

Which isn't defined when !CONFIG_PM. The compiler is allowed to
bail here, and does (see the two kbuild failures).

> +			return -ENOMEM;
> +	}
> +
>  	ret = clk_prepare_enable(data->ipg_clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
> @@ -293,6 +305,53 @@ static int imx_intmux_remove(struct 
> platform_device *pdev)
>  	return 0;
>  }
> 
> +#ifdef CONFIG_PM
> +static void imx_intmux_save_regs(struct intmux_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < data->channum; i++)
> +		data->saved_reg[i] = readl_relaxed(data->regs + CHANIER(i));
> +}
> +
> +static void imx_intmux_restore_regs(struct intmux_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < data->channum; i++)
> +		writel_relaxed(data->saved_reg[i], data->regs + CHANIER(i));
> +}

Please move these two trivial functions into their respective callers.

> +
> +static int imx_intmux_suspend(struct device *dev)
> +{
> +	struct intmux_data *data = dev_get_drvdata(dev);
> +
> +	imx_intmux_save_regs(data);
> +	clk_disable_unprepare(data->ipg_clk);
> +
> +	return 0;
> +}
> +
> +static int imx_intmux_resume(struct device *dev)
> +{
> +	struct intmux_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +	imx_intmux_restore_regs(data);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops imx_intmux_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_intmux_suspend, imx_intmux_resume)
> +};
> +
>  static const struct of_device_id imx_intmux_id[] = {
>  	{ .compatible = "fsl,imx-intmux", },
>  	{ /* sentinel */ },

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
