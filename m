Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F8C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC0620774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgDMMxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:53:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53805 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgDMMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:53:16 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jNyaK-000653-7Y; Mon, 13 Apr 2020 14:53:08 +0200
Received: from [IPv6:2a03:f580:87bc:d400:84b3:5dad:f81:bb88] (unknown [IPv6:2a03:f580:87bc:d400:84b3:5dad:f81:bb88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C4C7A4E18CC;
        Mon, 13 Apr 2020 12:52:59 +0000 (UTC)
Subject: Re: [PATCH] mailbox: imx: Support runtime PM
To:     Anson Huang <Anson.Huang@nxp.com>, jassisinghbrar@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
References: <1586780730-6117-1-git-send-email-Anson.Huang@nxp.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXz
Message-ID: <eb0eae78-35e9-1496-0869-94b48270f544@pengutronix.de>
Date:   Mon, 13 Apr 2020 14:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1586780730-6117-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 2:25 PM, Anson Huang wrote:
> Some power hungry sub-systems like VPU has its own MUs which also
> use mailbox driver, current mailbox driver uses platform driver
> model and MU's power will be ON after driver probed and left ON
> there, it may cause the whole sub-system can NOT enter lower power
> mode, take VPU driver for example, it has runtime PM support, but
> due to its MU always ON, the VPU sub-system will be always ON and
> consume many power during kernel idle.
> 
> To save power in kernel idle, mailbox driver needs to support
> runtime PM in order to power off MU when it is unused. However,
> the runtime suspend/resume can ONLY be implemented in mailbox's
> .shutdown/.startup callback, so its consumer needs to call
> mbox_request_channel()/mbox_free_channel() in consumer driver's
> runtime PM callback, then the MU's power will be ON/OFF along with
> consumer's runtime PM status.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 7906624..97bf0ac 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -12,6 +12,7 @@
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
>  #define IMX_MU_xSR_GIPn(x)	BIT(28 + (3 - (x)))
> @@ -287,6 +288,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  	struct imx_mu_con_priv *cp = chan->con_priv;
>  	int ret;
>  
> +	pm_runtime_get_sync(priv->dev);
>  	if (cp->type == IMX_MU_TYPE_TXDB) {
>  		/* Tx doorbell don't have ACK support */
>  		tasklet_init(&cp->txdb_tasklet, imx_mu_txdb_tasklet,
> @@ -323,6 +325,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
>  
>  	if (cp->type == IMX_MU_TYPE_TXDB) {
>  		tasklet_kill(&cp->txdb_tasklet);
> +		pm_runtime_put_sync(priv->dev);
>  		return;
>  	}
>  
> @@ -341,6 +344,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
>  	}
>  
>  	free_irq(priv->irq, chan);
> +	pm_runtime_put_sync(priv->dev);
>  }
>  
>  static const struct mbox_chan_ops imx_mu_ops = {
> @@ -508,7 +512,27 @@ static int imx_mu_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	return devm_mbox_controller_register(dev, &priv->mbox);
> +	ret = devm_mbox_controller_register(dev, &priv->mbox);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +

First registering at the system and then setting up the power management
looks racy. Don't know if this is serialized by some other means.

> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		goto disable_runtime_pm;
> +	}
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		goto disable_runtime_pm;
> +
> +	return 0;

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
