Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B48C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D641D22B48
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgCCH7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:59:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59405 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCCH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:59:40 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j92Sl-0004bR-Fx; Tue, 03 Mar 2020 08:59:35 +0100
Subject: Re: [PATCH V5 4/4] firmware: imx-scu: Support one TX and one RX
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com
Cc:     aisheng.dong@nxp.com, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
 <1583221359-9285-5-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <4dc08efe-294b-5741-11d7-ae9e1e585d3d@pengutronix.de>
Date:   Tue, 3 Mar 2020 08:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583221359-9285-5-git-send-email-peng.fan@nxp.com>
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
> Current imx-scu requires four TX and four RX to communicate with
> SCU. This is low efficient and causes lots of mailbox interrupts.
> 
> With imx-mailbox driver could support one TX to use all four transmit
> registers and one RX to use all four receive registers, imx-scu
> could use one TX and one RX.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This driver should be review by some one else.

> ---
> V5:
>   None
> V4:
>   None
> V3:
>   Check mbox fsl,imx8-mu-scu for fast_ipc
> 
>   drivers/firmware/imx/imx-scu.c | 54 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index f71eaa5bf52d..e94a5585b698 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -38,6 +38,7 @@ struct imx_sc_ipc {
>   	struct device *dev;
>   	struct mutex lock;
>   	struct completion done;
> +	bool fast_ipc;
>   
>   	/* temporarily store the SCU msg */
>   	u32 *msg;
> @@ -115,6 +116,7 @@ static void imx_scu_rx_callback(struct mbox_client *c, void *msg)
>   	struct imx_sc_ipc *sc_ipc = sc_chan->sc_ipc;
>   	struct imx_sc_rpc_msg *hdr;
>   	u32 *data = msg;
> +	int i;
>   
>   	if (!sc_ipc->msg) {
>   		dev_warn(sc_ipc->dev, "unexpected rx idx %d 0x%08x, ignore!\n",
> @@ -122,6 +124,19 @@ static void imx_scu_rx_callback(struct mbox_client *c, void *msg)
>   		return;
>   	}
>   
> +	if (sc_ipc->fast_ipc) {
> +		hdr = msg;
> +		sc_ipc->rx_size = hdr->size;
> +		sc_ipc->msg[0] = *data++;
> +
> +		for (i = 1; i < sc_ipc->rx_size; i++)
> +			sc_ipc->msg[i] = *data++;
> +
> +		complete(&sc_ipc->done);
> +
> +		return;
> +	}
> +
>   	if (sc_chan->idx == 0) {
>   		hdr = msg;
>   		sc_ipc->rx_size = hdr->size;
> @@ -147,6 +162,7 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
>   	struct imx_sc_chan *sc_chan;
>   	u32 *data = msg;
>   	int ret;
> +	int size;
>   	int i;
>   
>   	/* Check size */
> @@ -156,7 +172,8 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
>   	dev_dbg(sc_ipc->dev, "RPC SVC %u FUNC %u SIZE %u\n", hdr->svc,
>   		hdr->func, hdr->size);
>   
> -	for (i = 0; i < hdr->size; i++) {
> +	size = sc_ipc->fast_ipc ? 1 : hdr->size;
> +	for (i = 0; i < size; i++) {
>   		sc_chan = &sc_ipc->chans[i % 4];
>   
>   		/*
> @@ -168,8 +185,10 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
>   		 * Wait for tx_done before every send to ensure that no
>   		 * queueing happens at the mailbox channel level.
>   		 */
> -		wait_for_completion(&sc_chan->tx_done);
> -		reinit_completion(&sc_chan->tx_done);
> +		if (!sc_ipc->fast_ipc) {
> +			wait_for_completion(&sc_chan->tx_done);
> +			reinit_completion(&sc_chan->tx_done);
> +		}
>   
>   		ret = mbox_send_message(sc_chan->ch, &data[i]);
>   		if (ret < 0)
> @@ -246,6 +265,8 @@ static int imx_scu_probe(struct platform_device *pdev)
>   	struct imx_sc_chan *sc_chan;
>   	struct mbox_client *cl;
>   	char *chan_name;
> +	struct of_phandle_args args;
> +	int num_channel;
>   	int ret;
>   	int i;
>   
> @@ -253,11 +274,20 @@ static int imx_scu_probe(struct platform_device *pdev)
>   	if (!sc_ipc)
>   		return -ENOMEM;
>   
> -	for (i = 0; i < SCU_MU_CHAN_NUM; i++) {
> -		if (i < 4)
> +	ret = of_parse_phandle_with_args(pdev->dev.of_node, "mboxes",
> +					 "#mbox-cells", 0, &args);
> +	if (ret)
> +		return ret;
> +
> +	sc_ipc->fast_ipc = of_device_is_compatible(args.np, "fsl,imx8-mu-scu");
> +
> +	num_channel = sc_ipc->fast_ipc ? 2 : SCU_MU_CHAN_NUM;
> +	for (i = 0; i < num_channel; i++) {
> +		if (i < num_channel / 2)
>   			chan_name = kasprintf(GFP_KERNEL, "tx%d", i);
>   		else
> -			chan_name = kasprintf(GFP_KERNEL, "rx%d", i - 4);
> +			chan_name = kasprintf(GFP_KERNEL, "rx%d",
> +					      i - num_channel / 2);
>   
>   		if (!chan_name)
>   			return -ENOMEM;
> @@ -269,13 +299,15 @@ static int imx_scu_probe(struct platform_device *pdev)
>   		cl->knows_txdone = true;
>   		cl->rx_callback = imx_scu_rx_callback;
>   
> -		/* Initial tx_done completion as "done" */
> -		cl->tx_done = imx_scu_tx_done;
> -		init_completion(&sc_chan->tx_done);
> -		complete(&sc_chan->tx_done);
> +		if (!sc_ipc->fast_ipc) {
> +			/* Initial tx_done completion as "done" */
> +			cl->tx_done = imx_scu_tx_done;
> +			init_completion(&sc_chan->tx_done);
> +			complete(&sc_chan->tx_done);
> +		}
>   
>   		sc_chan->sc_ipc = sc_ipc;
> -		sc_chan->idx = i % 4;
> +		sc_chan->idx = i % (num_channel / 2);
>   		sc_chan->ch = mbox_request_channel_byname(cl, chan_name);
>   		if (IS_ERR(sc_chan->ch)) {
>   			ret = PTR_ERR(sc_chan->ch);
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
