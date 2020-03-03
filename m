Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99FE215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgCCH5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:57:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCCH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:57:23 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j92Qb-0004Of-PV; Tue, 03 Mar 2020 08:57:21 +0100
Subject: Re: [PATCH V5 3/4] mailbox: imx: add SCU MU support
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
 <1583221359-9285-4-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <e67a61ab-5d2d-f0d1-2fbf-ab0173287356@pengutronix.de>
Date:   Tue, 3 Mar 2020 08:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583221359-9285-4-git-send-email-peng.fan@nxp.com>
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



On 03.03.20 08:42, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8/8X SCU MU is dedicated for communication between SCU and Cortex-A
> cores from hardware design, and could not be reused for other purpose.
> 
> Per i.MX8/8X Reference mannual, Chapter "12.9.2.3.2 Messaging Examples",
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
> To make SCU MU work,
>    - parse the size of msg.
>    - Only enable TR0/RR0 interrupt for transmit/receive message.
>    - For TX/RX, only support one TX channel and one RX channel
>    - For RX, support receive msg larger than 4 u32 words.
>    - Support 6 channels, TX0/RX0/RXDB[0-3], not support TXDB.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
> V5:
>   Code style cleanup
>   Add more debug msg
>   Drop __packed aligned
>   idx santity check in scu xlate
> 
> V4:
>   Added separate chans init and xlate function for SCU MU
>   Limit chans to TX0/RX0/RXDB[0-3], max 6 chans.
>   Santity check to msg size
> 
> V3:
>   Added scu type tx/rx and SCU MU type
> 
>   drivers/mailbox/imx-mailbox.c | 134 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 134 insertions(+)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index df6c4ecd913c..3f28c769a1c1 100644
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
> @@ -27,6 +28,8 @@
>   #define IMX_MU_xCR_GIRn(x)	BIT(16 + (3 - (x)))
>   
>   #define IMX_MU_CHANS		16
> +/* TX0/RX0/RXDB[0-3] */
> +#define IMX_MU_SCU_CHANS	6
>   #define IMX_MU_CHAN_NAME_SIZE	20
>   
>   enum imx_mu_chan_type {
> @@ -36,6 +39,11 @@ enum imx_mu_chan_type {
>   	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
>   };
>   
> +struct imx_sc_rpc_msg_max {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 data[7];
> +};
> +
>   struct imx_mu_con_priv {
>   	unsigned int		idx;
>   	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
> @@ -134,6 +142,63 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
>   	return 0;
>   }
>   
> +static int imx_mu_scu_tx(struct imx_mu_priv *priv,
> +			 struct imx_mu_con_priv *cp,
> +			 void *data)
> +{
> +	struct imx_sc_rpc_msg_max *msg = data;
> +	u32 *arg = data;
> +	int i;
> +
> +	switch (cp->type) {
> +	case IMX_MU_TYPE_TX:
> +		if (msg->hdr.size > sizeof(*msg)) {
> +			/*
> +			 * The real message size can be different to
> +			 * struct imx_sc_rpc_msg_max size
> +			 */
> +			dev_err(priv->dev, "Exceed max msg size (%li) on TX, got: %i\n", sizeof(*msg), msg->hdr.size);
> +			return -EINVAL;
> +		}
> +
> +		for (i = 0; i < msg->hdr.size; i++)
> +			imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
> +
> +		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
> +		break;
> +	default:
> +		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_mu_scu_rx(struct imx_mu_priv *priv,
> +			 struct imx_mu_con_priv *cp)
> +{
> +	struct imx_sc_rpc_msg_max msg;
> +	u32 *data = (u32 *)&msg;
> +	int i;
> +
> +	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
> +	*data++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
> +
> +	if (msg.hdr.size > sizeof(msg)) {
> +		dev_err(priv->dev, "Exceed max msg size (%li) on RX, got: %i\n",
> +			sizeof(msg), msg.hdr.size);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 1; i < msg.hdr.size; i++)
> +		*data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
> +
> +	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
> +	mbox_chan_received_data(cp->chan, (void *)&msg);
> +
> +	return 0;
> +}
> +
>   static void imx_mu_txdb_tasklet(unsigned long data)
>   {
>   	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data;
> @@ -263,6 +328,42 @@ static const struct mbox_chan_ops imx_mu_ops = {
>   	.shutdown = imx_mu_shutdown,
>   };
>   
> +static struct mbox_chan *imx_mu_scu_xlate(struct mbox_controller *mbox,
> +					  const struct of_phandle_args *sp)
> +{
> +	u32 type, idx, chan;
> +
> +	if (sp->args_count != 2) {
> +		dev_err(mbox->dev, "Invalid argument count %d\n", sp->args_count);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	type = sp->args[0]; /* channel type */
> +	idx = sp->args[1]; /* index */
> +
> +	switch (type) {
> +	case IMX_MU_TYPE_TX:
> +	case IMX_MU_TYPE_RX:
> +		if (idx != 0)
> +			dev_err(mbox->dev, "Invalid chan idx: %d\n", idx);
> +		chan = type;
> +		break;
> +	case IMX_MU_TYPE_RXDB:
> +		chan = 2 + idx;
> +		break;
> +	default:
> +		dev_err(mbox->dev, "Invalid chan type: %d\n", type);
> +		return NULL;
> +	}
> +
> +	if (chan >= mbox->num_chans) {
> +		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return &mbox->chans[chan];
> +}
> +
>   static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>   				       const struct of_phandle_args *sp)
>   {
> @@ -310,6 +411,28 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
>   	imx_mu_write(priv, 0, priv->dcfg->xCR);
>   }
>   
> +static void imx_mu_init_scu(struct imx_mu_priv *priv)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < IMX_MU_SCU_CHANS; i++) {
> +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
> +
> +		cp->idx = i < 2 ? 0 : i - 2;
> +		cp->type = i < 2 ? i : IMX_MU_TYPE_RXDB;
> +		cp->chan = &priv->mbox_chans[i];
> +		priv->mbox_chans[i].con_priv = cp;
> +		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> +			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
> +	}
> +
> +	priv->mbox.num_chans = IMX_MU_SCU_CHANS;
> +	priv->mbox.of_xlate = imx_mu_scu_xlate;
> +
> +	/* Set default MU configuration */
> +	imx_mu_write(priv, 0, priv->dcfg->xCR);
> +}
> +
>   static int imx_mu_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -396,9 +519,20 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>   	.xCR	= 0x64,
>   };
>   
> +static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
> +	.tx	= imx_mu_scu_tx,
> +	.rx	= imx_mu_scu_rx,
> +	.init	= imx_mu_init_scu,
> +	.xTR	= {0x0, 0x4, 0x8, 0xc},
> +	.xRR	= {0x10, 0x14, 0x18, 0x1c},
> +	.xSR	= 0x20,
> +	.xCR	= 0x24,
> +};
> +
>   static const struct of_device_id imx_mu_dt_ids[] = {
>   	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
>   	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
> +	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
