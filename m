Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68021C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE462081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgAMJQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:16:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:16:10 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iqvpJ-0000eB-1E; Mon, 13 Jan 2020 10:16:01 +0100
Message-ID: <a4ff0a8571895c65ed5c20abd0c332b0d92defab.camel@pengutronix.de>
Subject: Re: [PATCH v6 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Mon, 13 Jan 2020 10:15:58 +0100
In-Reply-To: <20200113051852.15996-3-samuel@sholland.org>
References: <20200113051852.15996-1-samuel@sholland.org>
         <20200113051852.15996-3-samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-12 at 23:18 -0600, Samuel Holland wrote:
> Allwinner sun6i, sun8i, sun9i, and sun50i SoCs contain a hardware
> message box used for communication between the ARM CPUs and the ARISC
> management coprocessor. This mailbox contains 8 unidirectional
> 4-message FIFOs.
> 
> Add a driver for it, so it can be used for SCPI or other communication
> protocols.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/mailbox/Kconfig        |   9 +
>  drivers/mailbox/Makefile       |   2 +
>  drivers/mailbox/sun6i-msgbox.c | 332 +++++++++++++++++++++++++++++++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 drivers/mailbox/sun6i-msgbox.c
> 
[...]
> diff --git a/drivers/mailbox/sun6i-msgbox.c b/drivers/mailbox/sun6i-msgbox.c
> new file mode 100644
> index 000000000000..15d6fd522dc5
> --- /dev/null
> +++ b/drivers/mailbox/sun6i-msgbox.c
> @@ -0,0 +1,332 @@
[...]
> +	reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(reset)) {
> +		ret = PTR_ERR(reset);
> +		dev_err(dev, "Failed to get reset control: %d\n", ret);
> +		goto err_disable_unprepare;
> +	}
> +
> +	/*
> +	 * NOTE: We rely on platform firmware to preconfigure the channel
> +	 * directions, and we share this hardware block with other firmware
> +	 * that runs concurrently with Linux (e.g. a trusted monitor).
> +	 *
> +	 * Therefore, we do *not* assert the reset line if probing fails or
> +	 * when removing the device.
> +	 */
> +	ret = reset_control_deassert(reset);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert reset: %d\n", ret);
> +		goto err_disable_unprepare;
> +	}

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

