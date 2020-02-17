Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1BDC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2174E20726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgBQIgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:36:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59739 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgBQIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:36:04 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j3bsk-0006Rp-QC; Mon, 17 Feb 2020 09:35:58 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j3bsk-0007Zl-CU; Mon, 17 Feb 2020 09:35:58 +0100
Date:   Mon, 17 Feb 2020 09:35:58 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 4/7] ARM: dts: imx6sx-sabreauto: Use new pin names
 with DCE/DTE for UART pins
Message-ID: <20200217083558.k5cpg6fokuo35ztv@pengutronix.de>
References: <1581743758-4475-1-git-send-email-Anson.Huang@nxp.com>
 <1581743758-4475-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581743758-4475-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 01:15:55PM +0800, Anson Huang wrote:
> Use new pin names containing DCE/DTE for UART RX/TX/RTS/CTS pins, this
> is to distinguish the DCE/DTE functions.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 315044c..8259244 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -229,8 +229,8 @@
>  
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
> -			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
> -			MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1
> +			MX6SX_PAD_GPIO1_IO04__UART1_DCE_TX		0x1b0b1
> +			MX6SX_PAD_GPIO1_IO05__UART1_DCE_RX		0x1b0b1

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
