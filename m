Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF423C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8949220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgBXNGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:06:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40303 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:06:44 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j6DRa-0008Nf-79; Mon, 24 Feb 2020 14:06:42 +0100
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: imx-mu: add fsl,scu property
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, leonard.crestez@nxp.com
Cc:     aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        hongxing.zhu@nxp.com, m.felsch@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
 <1582546474-21721-2-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <ad6b8ee4-f5c5-dc44-b06e-d265101ce5ad@pengutronix.de>
Date:   Mon, 24 Feb 2020 14:06:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582546474-21721-2-git-send-email-peng.fan@nxp.com>
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

Hi Peng,

On 24.02.20 13:14, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add fsl,scu property, this needs to be enabled for SCU channel type.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index 9c43357c5924..5b502bcf7122 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -45,6 +45,7 @@ Optional properties:
>   -------------------
>   - clocks :	phandle to the input clock.
>   - fsl,mu-side-b : Should be set for side B MU.
> +- fsl,scu: Support i.MX8/8X SCU channel type

Hm.. what you are doing is a "link aggregation" with round-robin scheduling:
https://en.wikipedia.org/wiki/Link_aggregation

I would be happy if we can define a generic mailbox property for this.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
