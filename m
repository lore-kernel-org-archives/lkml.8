Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99C32086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCBKFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:05:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38033 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCBKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:05:48 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j8hxG-0002Uz-6n; Mon, 02 Mar 2020 11:05:42 +0100
Subject: Re: [PATCH V3 2/4] mailbox: imx: restructure code to make easy for
 new MU
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
 <1582692043-683-3-git-send-email-peng.fan@nxp.com>
 <67ebbf3d-d6aa-17fc-5110-eead63c8232d@pengutronix.de>
 <AM0PR04MB4481E7A469C74773C387B00488E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <e0bc54a4-92e9-3089-cb0f-b46c98e327f9@pengutronix.de>
Date:   Mon, 2 Mar 2020 11:05:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481E7A469C74773C387B00488E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
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



On 02.03.20 10:58, Peng Fan wrote:
> Hi Oleksij,
> 
>> Subject: Re: [PATCH V3 2/4] mailbox: imx: restructure code to make easy for
>> new MU
>>
>> Hi Peng,
>>
>> On 26.02.20 05:40, peng.fan@nxp.com wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add imx_mu_generic_tx for data send and imx_mu_generic_rx for
>>> interrupt data receive.
>>> Add 'type' for MU type.
>>>
>>> With these, it will be a bit easy to introduce i.MX8/8X SCU type MU
>>> dedicated to communicate with SCU.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>
>>> V3:
>>>    New patch, restructure code.
>>>
>>>    drivers/mailbox/imx-mailbox.c | 100
>> ++++++++++++++++++++++++++++--------------
>>>    1 file changed, 67 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/imx-mailbox.c
>>> b/drivers/mailbox/imx-mailbox.c index 2cdcdc5f1119..901a3431fdb5
>>> 100644
>>> --- a/drivers/mailbox/imx-mailbox.c
>>> +++ b/drivers/mailbox/imx-mailbox.c
>>> @@ -36,7 +36,17 @@ enum imx_mu_chan_type {
>>>    	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
>>>    };
>>>
>>> +enum imx_mu_type {
>>> +	IMX_MU_TYPE_GENERIC,
>>> +};
>>
>> I assume this enum is not needed, see my next email
> 
> This is to just differentiate with SCU MU, ok, will check your next email.
> Then back if anything I not follow up.
> 
>>> +struct imx_mu_priv;
>>> +struct imx_mu_con_priv;
>>> +
>>>    struct imx_mu_dcfg {
>>> +	enum imx_mu_type type;
>>> +	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void
>> *data);
>>> +	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
>>>    	u32	xTR[4];		/* Transmit Registers */
>>>    	u32	xRR[4];		/* Receive Registers */
>>>    	u32	xSR;		/* Status Register */
>>> @@ -67,20 +77,6 @@ struct imx_mu_priv {
>>>    	bool			side_b;
>>>    };
>>>
>>> -static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
>>> -	.xTR	= {0x0, 0x4, 0x8, 0xc},
>>> -	.xRR	= {0x10, 0x14, 0x18, 0x1c},
>>> -	.xSR	= 0x20,
>>> -	.xCR	= 0x24,
>>> -};
>>> -
>>> -static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>>> -	.xTR	= {0x20, 0x24, 0x28, 0x2c},
>>> -	.xRR	= {0x40, 0x44, 0x48, 0x4c},
>>> -	.xSR	= 0x60,
>>> -	.xCR	= 0x64,
>>> -};
>>
>> Please, do not move it.
> 
> Ok. Then I need to add imx_mu_generic_tx prototype above the
> upper two.

Ah... this was the reason. Then please ignore my comment :)

> Thanks,
> Peng.
> 
>>
>>>    static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller
>> *mbox)
>>>    {
>>>    	return container_of(mbox, struct imx_mu_priv, mbox); @@ -111,6
>>> +107,40 @@ static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set,
>> u32 clr)
>>>    	return val;
>>>    }
>>>
>>> +static int imx_mu_generic_tx(struct imx_mu_priv *priv,
>>> +			     struct imx_mu_con_priv *cp,
>>> +			     void *data)
>>> +{
>>> +	u32 *arg = data;
>>> +
>>> +	switch (cp->type) {
>>> +	case IMX_MU_TYPE_TX:
>>> +		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
>>> +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>>> +		break;
>>> +	case IMX_MU_TYPE_TXDB:
>>> +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIRn(cp->idx), 0);
>>> +		tasklet_schedule(&cp->txdb_tasklet);
>>> +		break;
>>> +	default:
>>> +		dev_warn_ratelimited(priv->dev, "Send data on wrong channel
>> type: %d\n", cp->type);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_mu_generic_rx(struct imx_mu_priv *priv,
>>> +			     struct imx_mu_con_priv *cp)
>>> +{
>>> +	u32 dat;
>>> +
>>> +	dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
>>> +	mbox_chan_received_data(cp->chan, (void *)&dat);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static void imx_mu_txdb_tasklet(unsigned long data)
>>>    {
>>>    	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data; @@
>>> -123,7 +153,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>>>    	struct mbox_chan *chan = p;
>>>    	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>    	struct imx_mu_con_priv *cp = chan->con_priv;
>>> -	u32 val, ctrl, dat;
>>> +	u32 val, ctrl;
>>>
>>>    	ctrl = imx_mu_read(priv, priv->dcfg->xCR);
>>>    	val = imx_mu_read(priv, priv->dcfg->xSR); @@ -152,8 +182,7 @@
>>> static irqreturn_t imx_mu_isr(int irq, void *p)
>>>    		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
>>>    		mbox_chan_txdone(chan, 0);
>>>    	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
>>> -		dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
>>> -		mbox_chan_received_data(chan, (void *)&dat);
>>> +		priv->dcfg->rx(priv, cp);
>>>    	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
>>>    		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx),
>> priv->dcfg->xSR);
>>>    		mbox_chan_received_data(chan, NULL); @@ -169,23 +198,8
>> @@ static
>>> int imx_mu_send_data(struct mbox_chan *chan, void *data)
>>>    {
>>>    	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>>>    	struct imx_mu_con_priv *cp = chan->con_priv;
>>> -	u32 *arg = data;
>>> -
>>> -	switch (cp->type) {
>>> -	case IMX_MU_TYPE_TX:
>>> -		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
>>> -		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>>> -		break;
>>> -	case IMX_MU_TYPE_TXDB:
>>> -		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIRn(cp->idx), 0);
>>> -		tasklet_schedule(&cp->txdb_tasklet);
>>> -		break;
>>> -	default:
>>> -		dev_warn_ratelimited(priv->dev, "Send data on wrong channel
>> type: %d\n", cp->type);
>>> -		return -EINVAL;
>>> -	}
>>>
>>> -	return 0;
>>> +	return priv->dcfg->tx(priv, cp, data);
>>>    }
>>>
>>>    static int imx_mu_startup(struct mbox_chan *chan) @@ -367,6 +381,26
>>> @@ static int imx_mu_remove(struct platform_device *pdev)
>>>    	return 0;
>>>    }
>>>
>>> +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
>>> +	.type	= IMX_MU_TYPE_GENERIC,
>>> +	.tx	= imx_mu_generic_tx,
>>> +	.rx	= imx_mu_generic_rx,
>>> +	.xTR	= {0x0, 0x4, 0x8, 0xc},
>>> +	.xRR	= {0x10, 0x14, 0x18, 0x1c},
>>> +	.xSR	= 0x20,
>>> +	.xCR	= 0x24,
>>> +};
>>> +
>>> +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>>> +	.type	= IMX_MU_TYPE_GENERIC,
>>> +	.tx	= imx_mu_generic_tx,
>>> +	.rx	= imx_mu_generic_rx,
>>> +	.xTR	= {0x20, 0x24, 0x28, 0x2c},
>>> +	.xRR	= {0x40, 0x44, 0x48, 0x4c},
>>> +	.xSR	= 0x60,
>>> +	.xCR	= 0x64,
>>> +};
>>> +
>>>    static const struct of_device_id imx_mu_dt_ids[] = {
>>>    	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
>>>    	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
>>>
>>
>> Kind regards,
>> Oleksij Rempel
>>
>> --
>> Pengutronix e.K.                           |
>> |
>> Industrial Linux Solutions                 |
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.p
>> engutronix.de%2F&amp;data=02%7C01%7Cpeng.fan%40nxp.com%7Ccf660c
>> 3909e14128e65f08d7be898905%7C686ea1d3bc2b4c6fa92cd99c5c301635%
>> 7C0%7C0%7C637187370224967554&amp;sdata=ZdgIGuzpnhX1liQO4KmCtXx
>> jjg%2BnDJoPze4pfVXIAig%3D&amp;reserved=0  |
>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
>> |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:
>> +49-5121-206917-5555 |

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
