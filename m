Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D291C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAA120863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCCHz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:55:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:55:28 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j92Ol-00047R-Fo; Tue, 03 Mar 2020 08:55:27 +0100
Subject: Re: [PATCH V5 2/4] mailbox: imx: restructure code to make easy for
 new MU
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
 <1583221359-9285-3-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <5fef0bc5-368e-f777-2d41-3fb54f9527cb@pengutronix.de>
Date:   Tue, 3 Mar 2020 08:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583221359-9285-3-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.03.20 08:42, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add imx_mu_generic_tx for data send and imx_mu_generic_rx for interrupt
> data receive.
> 
> Pack original mu chans related code into imx_mu_init_generic
> 
> Add tx/rx/init hooks into imx_mu_dcfg
> 
> With these, it will be a bit easy to introduce i.MX8/8X SCU type
> MU dedicated to communicate with SCU.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
> V5:
>   imx_mu_dcfg moved to below imx_mu_priv
>   Add init hooks
> 
> V4:
>   Pack MU chans init to imx_mu_init_generic
> V3:
>   New patch, restructure code.
> 
>   drivers/mailbox/imx-mailbox.c | 137 +++++++++++++++++++++++++-----------------
>   1 file changed, 83 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 2cdcdc5f1119..df6c4ecd913c 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -36,13 +36,6 @@ enum imx_mu_chan_type {
>   	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
>   };
>   
> -struct imx_mu_dcfg {
> -	u32	xTR[4];		/* Transmit Registers */
> -	u32	xRR[4];		/* Receive Registers */
> -	u32	xSR;		/* Status Register */
> -	u32	xCR;		/* Control Register */
> -};
> -
>   struct imx_mu_con_priv {
>   	unsigned int		idx;
>   	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
> @@ -67,18 +60,14 @@ struct imx_mu_priv {
>   	bool			side_b;
>   };
>   
> -static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
> -	.xTR	= {0x0, 0x4, 0x8, 0xc},
> -	.xRR	= {0x10, 0x14, 0x18, 0x1c},
> -	.xSR	= 0x20,
> -	.xCR	= 0x24,
> -};
> -
> -static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
> -	.xTR	= {0x20, 0x24, 0x28, 0x2c},
> -	.xRR	= {0x40, 0x44, 0x48, 0x4c},
> -	.xSR	= 0x60,
> -	.xCR	= 0x64,
> +struct imx_mu_dcfg {
> +	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
> +	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
> +	void (*init)(struct imx_mu_priv *priv);
> +	u32	xTR[4];		/* Transmit Registers */
> +	u32	xRR[4];		/* Receive Registers */
> +	u32	xSR;		/* Status Register */
> +	u32	xCR;		/* Control Register */
>   };
>   
>   static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
> @@ -111,6 +100,40 @@ static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
>   	return val;
>   }
>   
> +static int imx_mu_generic_tx(struct imx_mu_priv *priv,
> +			     struct imx_mu_con_priv *cp,
> +			     void *data)
> +{
> +	u32 *arg = data;
> +
> +	switch (cp->type) {
> +	case IMX_MU_TYPE_TX:
> +		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
> +		break;
> +	case IMX_MU_TYPE_TXDB:
> +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIRn(cp->idx), 0);
> +		tasklet_schedule(&cp->txdb_tasklet);
> +		break;
> +	default:
> +		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_mu_generic_rx(struct imx_mu_priv *priv,
> +			     struct imx_mu_con_priv *cp)
> +{
> +	u32 dat;
> +
> +	dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> +	mbox_chan_received_data(cp->chan, (void *)&dat);
> +
> +	return 0;
> +}
> +
>   static void imx_mu_txdb_tasklet(unsigned long data)
>   {
>   	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data;
> @@ -123,7 +146,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>   	struct mbox_chan *chan = p;
>   	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>   	struct imx_mu_con_priv *cp = chan->con_priv;
> -	u32 val, ctrl, dat;
> +	u32 val, ctrl;
>   
>   	ctrl = imx_mu_read(priv, priv->dcfg->xCR);
>   	val = imx_mu_read(priv, priv->dcfg->xSR);
> @@ -152,8 +175,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>   		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
>   		mbox_chan_txdone(chan, 0);
>   	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
> -		dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> -		mbox_chan_received_data(chan, (void *)&dat);
> +		priv->dcfg->rx(priv, cp);
>   	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
>   		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
>   		mbox_chan_received_data(chan, NULL);
> @@ -169,23 +191,8 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
>   {
>   	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>   	struct imx_mu_con_priv *cp = chan->con_priv;
> -	u32 *arg = data;
> -
> -	switch (cp->type) {
> -	case IMX_MU_TYPE_TX:
> -		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> -		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
> -		break;
> -	case IMX_MU_TYPE_TXDB:
> -		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIRn(cp->idx), 0);
> -		tasklet_schedule(&cp->txdb_tasklet);
> -		break;
> -	default:
> -		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
> -		return -EINVAL;
> -	}
>   
> -	return 0;
> +	return priv->dcfg->tx(priv, cp, data);
>   }
>   
>   static int imx_mu_startup(struct mbox_chan *chan)
> @@ -280,6 +287,22 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>   
>   static void imx_mu_init_generic(struct imx_mu_priv *priv)
>   {
> +	unsigned int i;
> +
> +	for (i = 0; i < IMX_MU_CHANS; i++) {
> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
> +
> +		cp->idx = i % 4;
> +		cp->type = i >> 2;
> +		cp->chan = &priv->mbox_chans[i];
> +		priv->mbox_chans[i].con_priv = cp;
> +		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> +			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
> +	}
> +
> +	priv->mbox.num_chans = IMX_MU_CHANS;
> +	priv->mbox.of_xlate = imx_mu_xlate;
> +
>   	if (priv->side_b)
>   		return;
>   
> @@ -293,7 +316,6 @@ static int imx_mu_probe(struct platform_device *pdev)
>   	struct device_node *np = dev->of_node;
>   	struct imx_mu_priv *priv;
>   	const struct imx_mu_dcfg *dcfg;
> -	unsigned int i;
>   	int ret;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -329,32 +351,19 @@ static int imx_mu_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	for (i = 0; i < IMX_MU_CHANS; i++) {
> -		struct imx_mu_con_priv *cp = &priv->con_priv[i];
> -
> -		cp->idx = i % 4;
> -		cp->type = i >> 2;
> -		cp->chan = &priv->mbox_chans[i];
> -		priv->mbox_chans[i].con_priv = cp;
> -		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> -			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
> -	}
> -
>   	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
>   
> +	priv->dcfg->init(priv);
> +
>   	spin_lock_init(&priv->xcr_lock);
>   
>   	priv->mbox.dev = dev;
>   	priv->mbox.ops = &imx_mu_ops;
>   	priv->mbox.chans = priv->mbox_chans;
> -	priv->mbox.num_chans = IMX_MU_CHANS;
> -	priv->mbox.of_xlate = imx_mu_xlate;
>   	priv->mbox.txdone_irq = true;
>   
>   	platform_set_drvdata(pdev, priv);
>   
> -	imx_mu_init_generic(priv);
> -
>   	return devm_mbox_controller_register(dev, &priv->mbox);
>   }
>   
> @@ -367,6 +376,26 @@ static int imx_mu_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
> +	.tx	= imx_mu_generic_tx,
> +	.rx	= imx_mu_generic_rx,
> +	.init	= imx_mu_init_generic,
> +	.xTR	= {0x0, 0x4, 0x8, 0xc},
> +	.xRR	= {0x10, 0x14, 0x18, 0x1c},
> +	.xSR	= 0x20,
> +	.xCR	= 0x24,
> +};
> +
> +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
> +	.tx	= imx_mu_generic_tx,
> +	.rx	= imx_mu_generic_rx,
> +	.init	= imx_mu_init_generic,
> +	.xTR	= {0x20, 0x24, 0x28, 0x2c},
> +	.xRR	= {0x40, 0x44, 0x48, 0x4c},
> +	.xSR	= 0x60,
> +	.xCR	= 0x64,
> +};
> +
>   static const struct of_device_id imx_mu_dt_ids[] = {
>   	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
>   	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
