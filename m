Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4744D246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCBJrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:47:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54127 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:47:32 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j8hfc-0000Ng-4Q; Mon, 02 Mar 2020 10:47:28 +0100
Subject: Re: [PATCH V3 3/4] mailbox: imx: add SCU MU support
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, robh+dt@kernel.org
Cc:     aisheng.dong@nxp.com, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <1582692043-683-1-git-send-email-peng.fan@nxp.com>
 <1582692043-683-4-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <df1a4174-1632-717c-0d24-8812c1cdc1d2@pengutronix.de>
Date:   Mon, 2 Mar 2020 10:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582692043-683-4-git-send-email-peng.fan@nxp.com>
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

On 26.02.20 05:40, peng.fan@nxp.com wrote:
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
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>   Added scu type tx/rx and SCU MU type
> 
>   drivers/mailbox/imx-mailbox.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 901a3431fdb5..41664a64c5fd 100644
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
> @@ -38,11 +39,17 @@ enum imx_mu_chan_type {
>   
>   enum imx_mu_type {
>   	IMX_MU_TYPE_GENERIC,
> +	IMX_MU_TYPE_SCU,
>   };
>   
>   struct imx_mu_priv;
>   struct imx_mu_con_priv;
>   
> +struct imx_sc_rpc_msg_max {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 data[7];
> +} __packed __aligned(4);;
> +
>   struct imx_mu_dcfg {
>   	enum imx_mu_type type;
>   	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
> @@ -141,6 +148,48 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
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

please add sanity check if msg->hdr.size can be handled by this driver version.

> +		for (i = 0; i < msg->hdr.size; i++) {
> +			imx_mu_write(priv, *arg++,
> +				     priv->dcfg->xTR[i % 4]);
> +		}
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

please add sanity check. the message size should not be higher then sizeof(msg)

> +	for (i = 1; i < msg.hdr.size; i++)
> +		*data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
> +
> +	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);

Please do not forget to handle properly new msg size in your rx_callback. In previous 
implementation the message size was 4byte.

> +	mbox_chan_received_data(cp->chan, (void *)&msg);
> +
> +	return 0;
> +}
> +
>   static void imx_mu_txdb_tasklet(unsigned long data)
>   {
>   	struct imx_mu_con_priv *cp = (struct imx_mu_con_priv *)data;
> @@ -274,6 +323,7 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>   				       const struct of_phandle_args *sp)
>   {
>   	u32 type, idx, chan;
> +	struct imx_mu_priv *priv = to_imx_mu_priv(mbox);
>   
>   	if (sp->args_count != 2) {
>   		dev_err(mbox->dev, "Invalid argument count %d\n", sp->args_count);
> @@ -284,7 +334,9 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>   	idx = sp->args[1]; /* index */
>   	chan = type * 4 + idx;
>   
> -	if (chan >= mbox->num_chans) {
> +	if (chan >= mbox->num_chans ||
> +	    (priv->dcfg->type == IMX_MU_TYPE_SCU &&
> +	     type < IMX_MU_TYPE_TXDB && idx > 0)) {

We need this check since mbox->num_chans do not reflects new reality. Now we have only 2 
channels. One RX and one TX. No idea if we need doorbell channels for SCU. If doorbells 
are not supported, it is better to add a separate imx_mu_xlate for SCU

and add SCU specific channel init in probe in addition to:
         for (i = 0; i < IMX_MU_CHANS; i++) { 

                 struct imx_mu_con_priv *cp = &priv->con_priv[i]; 

 

                 cp->idx = i % 4; 

                 cp->type = i >> 2; 

                 cp->chan = &priv->mbox_chans[i]; 

                 priv->mbox_chans[i].con_priv = cp; 

                 snprintf(cp->irq_desc, sizeof(cp->irq_desc), 

                          "imx_mu_chan[%i-%i]", cp->type, cp->idx); 

         }

There is no need to init unsupported channels. Please pack it in separate function

>   		dev_err(mbox->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n", chan, type, idx);
>   		return ERR_PTR(-EINVAL);
>   	}
> @@ -401,9 +453,20 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>   	.xCR	= 0x64,
>   };
>   
> +static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
> +	.type	= IMX_MU_TYPE_SCU,
> +	.tx	= imx_mu_scu_tx,
> +	.rx	= imx_mu_scu_rx,
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
