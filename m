Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F445C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183BF20899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbgFXFFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:05:11 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57470 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbgFXFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:05:10 -0400
Received: from [192.168.42.210] ([93.22.36.33])
        by mwinf5d80 with ME
        id ut57220020iu85p03t5767; Wed, 24 Jun 2020 07:05:08 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Jun 2020 07:05:08 +0200
X-ME-IP: 93.22.36.33
Subject: Re: [PATCH 5.7 318/477] pinctrl: freescale: imx: Use devm_of_iomap()
 to avoid a resource leak in case of error in imx_pinctrl_probe()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
References: <20200623195407.572062007@linuxfoundation.org>
 <20200623195422.561156018@linuxfoundation.org>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <154ad406-02a0-8f37-4a47-a49b6c90da5d@wanadoo.fr>
Date:   Wed, 24 Jun 2020 07:05:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623195422.561156018@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one must NOT be included. It generates a regression.
This should be removed from 5.4 as well.

See 13f2d25b951f139064ec2dd53c0c7ebdf8d8007e.

There is also a thread on ML about it. I couldn't find it right away, 
but I'm sure that Dan will be quicker than me for finding it, if needed ;-).

CJ

Le 23/06/2020 à 21:55, Greg Kroah-Hartman a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> [ Upstream commit ba403242615c2c99e27af7984b1650771a2cc2c9 ]
>
> Use 'devm_of_iomap()' instead 'of_iomap()' to avoid a resource leak in
> case of error.
>
> Update the error handling code accordingly.
>
> Fixes: 26d8cde5260b ("pinctrl: freescale: imx: add shared input select reg support")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lore.kernel.org/r/20200602200626.677981-1-christophe.jaillet@wanadoo.fr
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/pinctrl/freescale/pinctrl-imx.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 1f81569c7ae3b..cb7e0f08d2cf4 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -824,12 +824,13 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>   				return -EINVAL;
>   			}
>   
> -			ipctl->input_sel_base = of_iomap(np, 0);
> +			ipctl->input_sel_base = devm_of_iomap(&pdev->dev, np,
> +							      0, NULL);
>   			of_node_put(np);
> -			if (!ipctl->input_sel_base) {
> +			if (IS_ERR(ipctl->input_sel_base)) {
>   				dev_err(&pdev->dev,
>   					"iomuxc input select base address not found\n");
> -				return -ENOMEM;
> +				return PTR_ERR(ipctl->input_sel_base);
>   			}
>   		}
>   	}
