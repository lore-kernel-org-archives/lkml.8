Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F3C2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQJ04 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:26:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:26:56 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlULK-0006ra-BH; Wed, 17 Jun 2020 11:26:50 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlULJ-0001vg-97; Wed, 17 Jun 2020 11:26:49 +0200
Message-ID: <1f5f27d0d5321b3c9a1aed79877a2fd1f2aac6e3.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 17 Jun 2020 11:26:49 +0200
In-Reply-To: <20200616184542.3504965-3-noltari@gmail.com>
References: <20200616184542.3504965-1-noltari@gmail.com>
         <20200616184542.3504965-3-noltari@gmail.com>
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

Hi Álvaro,

On Tue, 2020-06-16 at 20:45 +0200, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v3: introduce changes suggested by Florian:
>   - Add support for device mode.
>  v2: introduce changes suggested by Florian:
>   - Drop OF dependency (use device_get_match_data).
>   - Drop __initconst from variant tables.
>   - Use devm_clk_get_optional.
> 
>  drivers/phy/broadcom/Kconfig            |   9 +
>  drivers/phy/broadcom/Makefile           |   1 +
>  drivers/phy/broadcom/phy-bcm63xx-usbh.c | 456 ++++++++++++++++++++++++
>  3 files changed, 466 insertions(+)
>  create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c
> 
[...]
> diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> new file mode 100644
> index 000000000000..584807205166
> --- /dev/null
> +++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> @@ -0,0 +1,456 @@
[...]
> +	usbh->reset = devm_reset_control_get(dev, NULL);

Please use devm_reset_control_get_exclusive() instead when requesting
exclusive reset controls.

> +	if (IS_ERR(usbh->reset)) {
> +		if (PTR_ERR(usbh->reset) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(usbh->reset);
> +	}

regards
Philipp
