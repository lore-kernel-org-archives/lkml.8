Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3366C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEBE215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCCGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:47:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46273 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCCGrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:47:25 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j91Kr-0005ML-6Y; Tue, 03 Mar 2020 07:47:21 +0100
Subject: Re: [PATCH V4 2/4] mailbox: imx: restructure code to make easy for
 new MU
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1583200380-15623-1-git-send-email-peng.fan@nxp.com>
 <1583200380-15623-3-git-send-email-peng.fan@nxp.com>
 <f4b3384d-ee24-e254-2799-69e57625995b@pengutronix.de>
 <AM0PR04MB4481BD4CC61A8E30B8ECB68488E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <e2ba35db-d9dc-83c1-0261-867a706dd285@pengutronix.de>
Date:   Tue, 3 Mar 2020 07:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481BD4CC61A8E30B8ECB68488E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
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



On 03.03.20 07:27, Peng Fan wrote:
> Hi Oleksij,
> 
>> Subject: Re: [PATCH V4 2/4] mailbox: imx: restructure code to make easy for
>> new MU
>>
>>
>>
>> On 03.03.20 02:52, peng.fan@nxp.com wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add imx_mu_generic_tx for data send and imx_mu_generic_rx for
>>> interrupt data receive.
>>>
>>> Pack original mu chans related code into imx_mu_init_generic
>>>
>>> With these, it will be a bit easy to introduce i.MX8/8X SCU type MU
>>> dedicated to communicate with SCU.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>> V4:
>>>    Pack MU chans init to imx_mu_init_generic
>>> V3:
>>>    New patch, restructure code.
>>>
>>>    drivers/mailbox/imx-mailbox.c | 127
>> ++++++++++++++++++++++++++----------------
>>>    1 file changed, 78 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/imx-mailbox.c
>>> b/drivers/mailbox/imx-mailbox.c index 2cdcdc5f1119..e98f3550f995
>>> 100644
>>> --- a/drivers/mailbox/imx-mailbox.c
>>> +++ b/drivers/mailbox/imx-mailbox.c
>>> @@ -36,7 +36,12 @@ enum imx_mu_chan_type {
>>>    	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
>>>    };
>>>
>>> +struct imx_mu_priv;
>>> +struct imx_mu_con_priv;
>>
>> Please move imx_mu_dcfg below struct imx_mu_priv. It was my mistaked, i
>> missed this point.
> 
> That's fine.
> 
>>
>>>    struct imx_mu_dcfg {
>>> +	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void
>> *data);
>>> +	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
>>
>> please add init function here as well.
> 
> ok. I'll add as below:
> 
> int (*init)(struct imx_mu_priv *priv);
> 
>>
>>>    	u32	xTR[4];		/* Transmit Registers */
>>>    	u32	xRR[4];		/* Receive Registers */
>>>    	u32	xSR;		/* Status Register */
> [....]
> 
>>> -
>>>    	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
>>>
>>> +	imx_mu_init_generic(priv);
>>
>> please use priv->dcfg->init(priv);
> 
> I assume you agree the code I packed in imx_mu_init_generic.

yes

> I just need to assign init = imx_mu_init_generic; And use priv->dcfg->init(priv),
> right?

right.

> Thanks,
> Peng.
> 
>>
>>> +
>>>    	spin_lock_init(&priv->xcr_lock);
>>>
>>>    	priv->mbox.dev = dev;
>>>    	priv->mbox.ops = &imx_mu_ops;
>>>    	priv->mbox.chans = priv->mbox_chans;
>>> -	priv->mbox.num_chans = IMX_MU_CHANS;
>>> -	priv->mbox.of_xlate = imx_mu_xlate;
>>>    	priv->mbox.txdone_irq = true;
>>>
>>>    	platform_set_drvdata(pdev, priv);
>>>
>>> -	imx_mu_init_generic(priv);
>>> -
>>>    	return devm_mbox_controller_register(dev, &priv->mbox);
>>>    }
>>>
>>> @@ -367,6 +378,24 @@ static int imx_mu_remove(struct platform_device
>> *pdev)
>>>    	return 0;
>>>    }
>>>
>>> +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
>>> +	.tx	= imx_mu_generic_tx,
>>> +	.rx	= imx_mu_generic_rx,
>>> +	.xTR	= {0x0, 0x4, 0x8, 0xc},
>>> +	.xRR	= {0x10, 0x14, 0x18, 0x1c},
>>> +	.xSR	= 0x20,
>>> +	.xCR	= 0x24,
>>> +};
>>> +
>>> +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
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
>> engutronix.de%2F&amp;data=02%7C01%7Cpeng.fan%40nxp.com%7Ce59c2b
>> ea2efd47dc8fb408d7bf39f68c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
>> 0%7C0%7C637188127988825530&amp;sdata=d%2FN82zkoGy7m3yXf6Q8h9
>> OWYs0ldZlozDzPwAnOMDkI%3D&amp;reserved=0  |
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
