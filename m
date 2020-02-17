Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585BC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174220836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBQIVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:21:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35885 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgBQIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:21:35 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j3bel-0004Hv-EW; Mon, 17 Feb 2020 09:21:31 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1j3bek-000263-TX; Mon, 17 Feb 2020 09:21:30 +0100
Date:   Mon, 17 Feb 2020 09:21:30 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, peng.fan@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        festevam@gmail.com
Subject: Re: [PATCH 2/2] arm64: dts: imx8mq-evk: add phy-reset-gpios for fec1
Message-ID: <20200217082130.7ckiqwodumqvynla@pengutronix.de>
References: <20200214192750.20845-1-alifer.wsdm@gmail.com>
 <20200214192750.20845-2-alifer.wsdm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214192750.20845-2-alifer.wsdm@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:20:54 up 93 days, 23:39, 104 users,  load average: 0.43, 0.28,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alifer,

On 20-02-14 16:27, Alifer Moraes wrote:
> imx8mq-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.
> 
> Describe it in the device tree, following phy's datasheet reset duration of 10ms.
> 
> Tested booting via NFS.
> 
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index c36685916683..a49e2bf8afe5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -110,6 +110,8 @@
>  	pinctrl-0 = <&pinctrl_fec1>;
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
> +	phy-reset-gpios = <&gpio1 9  GPIO_ACTIVE_LOW>;

Same here.

Regards,
  Marco

> +	phy-reset-duration = <10>;
>  	fsl,magic-packet;
>  	status = "okay";
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
