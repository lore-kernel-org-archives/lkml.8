Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F7C3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73212072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgCFGrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:47:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38475 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgCFGrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:47:25 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA6lW-0003vq-Eu; Fri, 06 Mar 2020 07:47:22 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA6lV-0001nm-0S; Fri, 06 Mar 2020 07:47:21 +0100
Date:   Fri, 6 Mar 2020 07:47:20 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx25-pinfunc: add config for kpp rows 4 to 7
Message-ID: <20200306064720.i2ekoorkwf7y57x4@pengutronix.de>
References: <20200305212623.5601-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305212623.5601-1-martin@kaiser.cx>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:26:24PM +0100, Martin Kaiser wrote:
> i.MX25's Keypad Port (KPP) can be used with a key pad matrix of up to
> 8 x 8 keys. Add pin configurations for rows 4 to 7.
> 
> The new defines have been tested on an out-of-tree board.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  arch/arm/boot/dts/imx25-pinfunc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
> index b5a12412440e..111bfdcbe552 100644
> --- a/arch/arm/boot/dts/imx25-pinfunc.h
> +++ b/arch/arm/boot/dts/imx25-pinfunc.h
> @@ -255,10 +255,12 @@
>  
>  #define MX25_PAD_LD12__LD12			0x0f8 0x2f0 0x000 0x00 0x000
>  #define MX25_PAD_LD12__CSPI2_MOSI		0x0f8 0x2f0 0x4a0 0x02 0x000
> +#define MX25_PAD_LD12__KPP_ROW6			0x0f8 0x2f0 0x544 0x04 0x000
>  #define MX25_PAD_LD12__FEC_RDATA3		0x0f8 0x2f0 0x510 0x05 0x001
>  
>  #define MX25_PAD_LD13__LD13			0x0fc 0x2f4 0x000 0x00 0x000
>  #define MX25_PAD_LD13__CSPI2_MISO		0x0fc 0x2f4 0x49c 0x02 0x000
> +#define MX25_PAD_LD13__KPP_ROW7			0x0fc 0x2f4 0x548 0x04 0x000
>  #define MX25_PAD_LD13__FEC_TDATA2		0x0fc 0x2f4 0x000 0x05 0x000

>  #define MX25_PAD_LD14__LD14			0x100 0x2f8 0x000 0x00 0x000
> @@ -516,9 +518,11 @@
>  
>  #define MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x1d8 0x3d0 0x000 0x00 0x000
>  #define MX25_PAD_FEC_TX_EN__GPIO_3_9		0x1d8 0x3d0 0x000 0x05 0x000
> +#define MX25_PAD_FEC_TX_EN__KPP_ROW4		0x1d8 0x3d0 0x53c 0x06 0x000
>  
>  #define MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x1dc 0x3d4 0x000 0x00 0x000
>  #define MX25_PAD_FEC_RDATA0__GPIO_3_10		0x1dc 0x3d4 0x000 0x05 0x000
> +#define MX25_PAD_FEC_RDATA0__KPP_ROW5 		0x1dc 0x3d4 0x540 0x06 0x000
>  
>  #define MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x1e0 0x3d8 0x000 0x00 0x000

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
