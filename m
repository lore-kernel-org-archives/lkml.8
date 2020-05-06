Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD1C47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62372073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgEFJ0x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728797AbgEFJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:26:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DB4C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:26:48 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jWGK6-0000MM-3k; Wed, 06 May 2020 11:26:38 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jWGK5-0004UU-P0; Wed, 06 May 2020 11:26:37 +0200
Message-ID: <8b33b8fe9d12470743384773be0953851845e11f.camel@pengutronix.de>
Subject: Re: [PATCH v2 23/91] reset: simple: Add reset callback
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
Date:   Wed, 06 May 2020 11:26:37 +0200
In-Reply-To: <31e3daec5d5b703bd87ef9d77e353589daf6fa3e.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
         <31e3daec5d5b703bd87ef9d77e353589daf6fa3e.1587742492.git-series.maxime@cerno.tech>
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

On Fri, 2020-04-24 at 17:34 +0200, Maxime Ripard wrote:
> The reset-simple code lacks a reset callback that is still pretty easy to
> implement. The only real thing to consider is the delay needed for a device
> to be reset, so let's expose that as part of the reset-simple driver data.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/reset/reset-simple.c       | 24 ++++++++++++++++++++++++
>  include/linux/reset/reset-simple.h |  6 ++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index c854aa351640..602ed972b0a9 100644
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
> @@ -63,6 +64,28 @@ static int reset_simple_deassert(struct reset_controller_dev *rcdev,
>  	return reset_simple_update(rcdev, id, false);
>  }
>  
> +static int reset_simple_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct reset_simple_data *data = to_reset_simple_data(rcdev);
> +	int ret;
> +
> +	if (!data->reset_us)
> +		return -ENOTSUPP;
> +
> +	ret = reset_simple_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(data->reset_us, data->reset_us * 2);
> +
> +	ret = reset_simple_deassert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Just
	return reset_simple_deassert(rcdev, id);
here.

> +}
> +
>  static int reset_simple_status(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> @@ -80,6 +103,7 @@ static int reset_simple_status(struct reset_controller_dev *rcdev,
>  const struct reset_control_ops reset_simple_ops = {
>  	.assert		= reset_simple_assert,
>  	.deassert	= reset_simple_deassert,
> +	.reset		= reset_simple_reset,
>  	.status		= reset_simple_status,
>  };
>  EXPORT_SYMBOL_GPL(reset_simple_ops);
> diff --git a/include/linux/reset/reset-simple.h b/include/linux/reset/reset-simple.h
> index 08ccb25a55e6..5eb83625a495 100644
> --- a/include/linux/reset/reset-simple.h
> +++ b/include/linux/reset/reset-simple.h
> @@ -27,6 +27,11 @@
>   * @status_active_low: if true, bits read back as cleared while the reset is
>   *                     asserted. Otherwise, bits read back as set while the
>   *                     reset is asserted.
> + * @reset_us: Minimum delay in microseconds needed that needs to be
> + *            waited for between an assert and a deassert to reset the
> + *            device. If multiple consumers with different delay
> + *            requirements are connected to this controller, it must
> + *            be the largest minimum delay.

Please mention that 0 does not meen 0 µs delay, but unknown and thus
reset callback not supported.

With these two issues fixed
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
