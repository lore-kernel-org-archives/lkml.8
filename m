Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD23C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38421217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCCHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:54:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgCCHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:54:31 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1j92Nn-0003u7-2P; Tue, 03 Mar 2020 08:54:27 +0100
Subject: Re: [PATCH V5 1/4] dt-bindings: mailbox: imx-mu: add SCU MU support
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com
Cc:     aisheng.dong@nxp.com, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <1583221359-9285-1-git-send-email-peng.fan@nxp.com>
 <1583221359-9285-2-git-send-email-peng.fan@nxp.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <6f793db4-d4af-1cfa-4039-144e0ef20d28@pengutronix.de>
Date:   Tue, 3 Mar 2020 08:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583221359-9285-2-git-send-email-peng.fan@nxp.com>
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
> i.MX8/8X SCU MU is dedicated for communication between SCU
> and Cortex-A cores from hardware design, it could not be reused
> for other purpose. To use SCU MU more effectivly, add "fsl,imx8-scu-mu"
> compatile to support fast IPC.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
> 
> V5:
>   None
> V4:
>   None
> V3:
>   New patch
> 
>   Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> index 9c43357c5924..31486c9f6443 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> @@ -23,6 +23,8 @@ Required properties:
>   		be included together with SoC specific compatible.
>   		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
>   		compatible to support it.
> +		To communicate with i.MX8 SCU, "fsl,imx8-mu-scu" could be
> +		used for fast IPC
>   - reg :		Should contain the registers location and length
>   - interrupts :	Interrupt number. The interrupt specifier format depends
>   		on the interrupt controller parent.
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
