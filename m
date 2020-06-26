Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9282C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8826120775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgFZMOe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD6C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:14:33 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jonFV-0002V8-Fz; Fri, 26 Jun 2020 14:14:29 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jonFU-0007ub-Ah; Fri, 26 Jun 2020 14:14:28 +0200
Message-ID: <485fda739c9ebd157b1552ac3d114f38b702328e.camel@pengutronix.de>
Subject: Re: [PATCH v2 4/6] dt-bindings: reset: Add binding constants for
 Actions S500 RMU
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Date:   Fri, 26 Jun 2020 14:14:28 +0200
In-Reply-To: <924885629e2797e332ae8ff9c077937d44379722.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
         <924885629e2797e332ae8ff9c077937d44379722.1592941257.git.cristian.ciocaltea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 20:47 +0300, Cristian Ciocaltea wrote:
> Add device tree binding constants for Actions Semi S500 SoC Reset
> Management Unit (RMU).
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to be merged through the clock tree, required by the following patch:
"clk: actions: Add Actions S500 SoC Reset Management Unit support".

regards
Philipp

> ---
>  .../dt-bindings/reset/actions,s500-reset.h    | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 include/dt-bindings/reset/actions,s500-reset.h
> 
> diff --git a/include/dt-bindings/reset/actions,s500-reset.h b/include/dt-bindings/reset/actions,s500-reset.h
> new file mode 100644
> index 000000000000..f5d94176d10b
> --- /dev/null
> +++ b/include/dt-bindings/reset/actions,s500-reset.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Device Tree binding constants for Actions Semi S500 Reset Management Unit
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_ACTIONS_S500_RESET_H
> +#define __DT_BINDINGS_ACTIONS_S500_RESET_H
> +
> +#define RESET_DMAC				0
> +#define RESET_NORIF				1
> +#define RESET_DDR				2
> +#define RESET_NANDC				3
> +#define RESET_SD0				4
> +#define RESET_SD1				5
> +#define RESET_PCM1				6
> +#define RESET_DE				7
> +#define RESET_LCD				8
> +#define RESET_SD2				9
> +#define RESET_DSI				10
> +#define RESET_CSI				11
> +#define RESET_BISP				12
> +#define RESET_KEY				13
> +#define RESET_GPIO				14
> +#define RESET_AUDIO				15
> +#define RESET_PCM0				16
> +#define RESET_VDE				17
> +#define RESET_VCE				18
> +#define RESET_GPU3D				19
> +#define RESET_NIC301				20
> +#define RESET_LENS				21
> +#define RESET_PERIPHRESET			22
> +#define RESET_USB2_0				23
> +#define RESET_TVOUT				24
> +#define RESET_HDMI				25
> +#define RESET_HDCP2TX				26
> +#define RESET_UART6				27
> +#define RESET_UART0				28
> +#define RESET_UART1				29
> +#define RESET_UART2				30
> +#define RESET_SPI0				31
> +#define RESET_SPI1				32
> +#define RESET_SPI2				33
> +#define RESET_SPI3				34
> +#define RESET_I2C0				35
> +#define RESET_I2C1				36
> +#define RESET_USB3				37
> +#define RESET_UART3				38
> +#define RESET_UART4				39
> +#define RESET_UART5				40
> +#define RESET_I2C2				41
> +#define RESET_I2C3				42
> +#define RESET_ETHERNET				43
> +#define RESET_CHIPID				44
> +#define RESET_USB2_1				45
> +#define RESET_WD0RESET				46
> +#define RESET_WD1RESET				47
> +#define RESET_WD2RESET				48
> +#define RESET_WD3RESET				49
> +#define RESET_DBG0RESET				50
> +#define RESET_DBG1RESET				51
> +#define RESET_DBG2RESET				52
> +#define RESET_DBG3RESET				53
> +
> +#endif /* __DT_BINDINGS_ACTIONS_S500_RESET_H */
