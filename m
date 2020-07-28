Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A98C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C973206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgG1NwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgG1Nv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:51:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD32C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:51:59 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0Q1M-0001Bd-9I; Tue, 28 Jul 2020 15:51:56 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0Q1L-000321-BG; Tue, 28 Jul 2020 15:51:55 +0200
Date:   Tue, 28 Jul 2020 15:51:55 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: dts: imx7: add QSPI
Message-ID: <20200728135155.aqz3xkcwpgqmvzro@pengutronix.de>
References: <20200728112814.14158-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728112814.14158-1-matthias.schiffer@ew.tq-group.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:40:55 up 256 days,  4:59, 253 users,  load average: 0.05, 0.16,
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

Hi Matthias,

thanks for the patch.

On 20-07-28 13:28, Matthias Schiffer wrote:
> In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS, add the
> QSPI controller to imx7s.dtsi.
> 
> Based-on-patch-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 1cfaf410aa43..e45683e61593 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -1162,6 +1162,19 @@
>  				status = "disabled";
>  			};
>  
> +			qspi1: spi@30bb0000 {

Are there more controllers and why not using "qspi@30bb0000" as node
name?

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx7d-qspi";
> +				reg = <0x30bb0000 0x10000>, <0x60000000 0x10000000>;
> +				reg-names = "QuadSPI", "QuadSPI-memory";

The node should begin with compatible, reg, reg-names properties.
Pls check the current .dtsi file for examples.

> +				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks IMX7D_QSPI_ROOT_CLK>,
> +					<&clks IMX7D_QSPI_ROOT_CLK>;
> +				clock-names = "qspi_en", "qspi";
> +				status = "disabled";
> +			};
> +
>  			sdma: sdma@30bd0000 {
>  				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
>  				reg = <0x30bd0000 0x10000>;

Regards,
  Marco
