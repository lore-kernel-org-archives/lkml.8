Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8BCC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97E721739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbgCDMDa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:03:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbgCDMD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:03:29 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9SkE-00046M-B3; Wed, 04 Mar 2020 13:03:22 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9SkB-0006zp-D7; Wed, 04 Mar 2020 13:03:19 +0100
Message-ID: <a2878b95da2afaeb0eac1a8f2f1991ef5ff9cace.camel@pengutronix.de>
Subject: Re: [PATCH 25/89] reset: simple: Add reset callback
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Date:   Wed, 04 Mar 2020 13:03:19 +0100
In-Reply-To: <e7e2c84206f2cc8c0cb36cd734226f73f3331198.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <e7e2c84206f2cc8c0cb36cd734226f73f3331198.1582533919.git-series.maxime@cerno.tech>
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

Hi Maxime,

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> The reset-simple code lacks a reset callback that is still pretty easy to
> implement. The only real thing to consider is the delay needed for a device
> to be reset, so let's expose that as part of the reset-simple driver data.
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

This shoulod be done in such a way that simple reset drivers which do
not set the reset delay continue to return -ENOTSUPP from
reset_control_reset().

> ---
>  drivers/reset/reset-simple.c       | 21 +++++++++++++++++++++
>  include/linux/reset/reset-simple.h |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index c854aa351640..7a8c56512ae9 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -11,6 +11,7 @@
>   * Maxime Ripard <maxime.ripard@free-electrons.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -63,6 +64,25 @@ static int reset_simple_deassert(struct reset_controller_dev *rcdev,
>  	return reset_simple_update(rcdev, id, false);
>  }
>  
> +static int reset_simple_reset(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct reset_simple_data *data = to_reset_simple_data(rcdev);
> +	int ret;

You could just return -ENOTSUPP here if data->reset_ms == 0.

> +	ret = reset_simple_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	mdelay(data->reset_ms);

Have you considered specifying the delay in microseconds instead?
That would allow to use usleep_range() for shorter delays.

> +	ret = reset_simple_deassert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int reset_simple_status(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> @@ -80,6 +100,7 @@ static int reset_simple_status(struct reset_controller_dev *rcdev,
>  const struct reset_control_ops reset_simple_ops = {
>  	.assert		= reset_simple_assert,
>  	.deassert	= reset_simple_deassert,
> +	.reset		= reset_simple_reset,
>  	.status		= reset_simple_status,
>  };
>  EXPORT_SYMBOL_GPL(reset_simple_ops);
> diff --git a/include/linux/reset/reset-simple.h b/include/linux/reset/reset-simple.h
> index 08ccb25a55e6..a5887f6cbe50 100644
> --- a/include/linux/reset/reset-simple.h
> +++ b/include/linux/reset/reset-simple.h
> @@ -27,6 +27,9 @@
>   * @status_active_low: if true, bits read back as cleared while the reset is
>   *                     asserted. Otherwise, bits read back as set while the
>   *                     reset is asserted.
> + * @reset_ms: Minimum delay in milliseconds needed that needs to be
> + *            waited for between an assert and a deassert to reset the
> + *            device.

If multiple consumers with different delay requirements are connected to
this reset controllers, this must the largest minimum delay. Could you
add mention for this in the comment?

regards
Philipp
