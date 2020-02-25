Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE62DC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6E42176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgBYGaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:30:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47879 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:30:06 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j6TjE-0005Y9-4z; Tue, 25 Feb 2020 07:30:00 +0100
Subject: Re: [PATCH V2 1/2] mailbox: imx: support SCU channel type
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com
Cc:     aisheng.dong@nxp.com, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <1582600627-28415-1-git-send-email-peng.fan@nxp.com>
 <1582600627-28415-2-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <fcd868b0-2a8b-c13e-e773-3626a1cfda32@pengutronix.de>
Date:   Tue, 25 Feb 2020 07:29:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582600627-28415-2-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25.02.20 04:17, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per i.MX8QXP Reference mannual, Chapter "12.9.2.3.2 Messaging Examples",
>   Passing short messages: Transmit register(s) can be used to pass
>   short messages from one to four words in length. For example, when
>   a four-word message is desired, only one of the registers needs to
>   have its corresponding interrupt enable bit set at the receiver side;
>   the message’s first three words are written to the registers whose
>   interrupt is masked, and the fourth word is written to the other
>   register (which triggers an interrupt at the receiver side).
> 
> i.MX8/8X SCU firmware IPC is an implementation of passing short
> messages. But current imx-mailbox driver only support one word
> message, i.MX8/8X linux side firmware has to request four TX
> and four RX to support IPC to SCU firmware. This is low efficent
> and more interrupts triggered compared with one TX and
> one RX.
> 
> To make SCU channel type work,
>    - parse the size of msg.
>    - Only enable TR0/RR0 interrupt for transmit/receive message.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/mailbox/imx-mailbox.c | 46 +++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 2cdcdc5f1119..0b4a33254114 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/firmware/imx/ipc.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -65,8 +66,14 @@ struct imx_mu_priv {
>   	int			irq;
>   
>   	bool			side_b;
> +	bool			scu;
>   };
>   
> +struct imx_sc_rpc_msg_max {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 data[7];
> +} __packed __aligned(4);;
> +
>   static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
>   	.xTR	= {0x0, 0x4, 0x8, 0xc},
>   	.xRR	= {0x10, 0x14, 0x18, 0x1c},
> @@ -123,7 +130,10 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>   	struct mbox_chan *chan = p;
>   	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>   	struct imx_mu_con_priv *cp = chan->con_priv;
> +	struct imx_sc_rpc_msg_max msg;
> +	u32 *p_msg = (u32 *)&msg;
>   	u32 val, ctrl, dat;
> +	int i;
>   
>   	ctrl = imx_mu_read(priv, priv->dcfg->xCR);
>   	val = imx_mu_read(priv, priv->dcfg->xSR);
> @@ -152,8 +162,19 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
>   		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
>   		mbox_chan_txdone(chan, 0);
>   	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
> -		dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> -		mbox_chan_received_data(chan, (void *)&dat);
> +		if (!priv->scu) {
> +			dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> +			mbox_chan_received_data(chan, (void *)&dat);
> +		} else {
> +			imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
> +			*p_msg++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
> +			for (i = 1; i < msg.hdr.size; i++) {
> +				*p_msg++ = imx_mu_read(priv,
> +						       priv->dcfg->xRR[i % 4]);
> +			}
> +			imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
> +			mbox_chan_received_data(chan, (void *)&msg);
> +		}
>   	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
>   		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
>   		mbox_chan_received_data(chan, NULL);
> @@ -169,11 +190,20 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
>   {
>   	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>   	struct imx_mu_con_priv *cp = chan->con_priv;
> +	struct imx_sc_rpc_msg_max *msg = data;
>   	u32 *arg = data;
> +	int i;
>   
>   	switch (cp->type) {
>   	case IMX_MU_TYPE_TX:
> -		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> +		if (priv->scu) {
> +			for (i = 0; i < msg->hdr.size; i++) {
> +				imx_mu_write(priv, *arg++,
> +					     priv->dcfg->xTR[i % 4]);
> +			}
> +		} else {
> +			imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> +		}
>   		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>   		break;
>   	case IMX_MU_TYPE_TXDB:
> @@ -259,6 +289,7 @@ static const struct mbox_chan_ops imx_mu_ops = {
>   static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>   				       const struct of_phandle_args *sp)
>   {
> +	struct imx_mu_priv *priv = to_imx_mu_priv(mbox);
>   	u32 type, idx, chan;
>   
>   	if (sp->args_count != 2) {
> @@ -270,7 +301,9 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>   	idx = sp->args[1]; /* index */
>   	chan = type * 4 + idx;
>   
> -	if (chan >= mbox->num_chans) {
> +	/* For TX/RX SCU, only one channel supported */
> +	if ((chan >= mbox->num_chans) ||
> +	    (priv->scu && type < 1 && idx >= 1)) {
>   		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
>   		return ERR_PTR(-EINVAL);
>   	}
> @@ -341,6 +374,11 @@ static int imx_mu_probe(struct platform_device *pdev)
>   	}
>   
>   	priv->side_b = of_property_read_bool(np, "fsl,mu-side-b");
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx-scu");

This will configure every MU on the SoC as SCU, even it is not communicating with it.

> +	if (np) {
> +		priv->scu = true;
> +		of_node_put(np);
> +	}
>   

Please take a look at drivers/remoteproc/imx_rproc.c
especially the use of struct imx_rproc_dcfg.
Introduce simialr struct in the imx-mailbox.c

It will be some thing like:
struct imx_mu_dcfg {
	unsigned int chans; /* number of supported channels */
	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
}

Define functions for generic tx/rx. And for SCU specific tx/rx. Please, add sanity check 
in to SCU specific functions. In current implementation an error on SCU side will couse 
stack corruption on Linux side.

Use compatible string (some thing like fsl,imx8-mu-scu) to detect proper metrics of new 
device.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
