Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F742C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581642076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgHDHQI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:16:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:16:07 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k2rB5-0005Db-KK; Tue, 04 Aug 2020 09:16:03 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k2rB5-0006F3-0K; Tue, 04 Aug 2020 09:16:03 +0200
Message-ID: <ce70cee90b5d9ecd7b52f6785159553732b9ae06.camel@pengutronix.de>
Subject: Re: [v2,4/6] reset-controller: ti: introduce a new reset handler
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Crystal Guo <crystal.guo@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        seiya.wang@mediatek.com, stanley.chu@mediatek.com,
        yingjoe.chen@mediatek.com, fan.chen@mediatek.com,
        yong.liang@mediatek.com, Suman Anna <s-anna@ti.com>,
        "Andrew F. Davis" <afd@ti.com>
Date:   Tue, 04 Aug 2020 09:16:02 +0200
In-Reply-To: <20200803061511.29555-5-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-5-crystal.guo@mediatek.com>
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

On Mon, 2020-08-03 at 14:15 +0800, Crystal Guo wrote:
> Add ti_syscon_reset() to integrate assert and deassert together.
> If some modules need do serialized assert and deassert operations
> to reset itself, reset_control_reset can be called for convenience.
> 
> Change-Id: I9046992b115a46f3594de57fa89c6a2de9957d49
> ---
>  drivers/reset/reset-ti-syscon.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> index a2635c21db7f..1c74bcb9a6c3 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -56,6 +56,7 @@ struct ti_syscon_reset_data {
>  	struct regmap *regmap;
>  	struct ti_syscon_reset_control *controls;
>  	unsigned int nr_controls;
> +	bool assert_deassert_together;
>  };
>  
>  #define to_ti_syscon_reset_data(rcdev)	\
> @@ -158,10 +159,24 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
>  		!(control->flags & STATUS_SET);
>  }
>  
> +static int ti_syscon_reset(struct reset_controller_dev *rcdev,
> +			  unsigned long id)
> +{
> +	struct ti_syscon_reset_data *data = to_ti_syscon_reset_data(rcdev);
> +
> +	if (data->assert_deassert_together) {
> +		ti_syscon_reset_assert(rcdev, id);
> +		return ti_syscon_reset_deassert(rcdev, id);

Even if your hardware engineers guarantee that no delays are necessary
between assert and deassert for any peripheral used with your reset
controller that may use this function, this is not generic.

I wonder if it would be better to define a minimum delay similarly to
reset-simple [1].

[1] https://lore.kernel.org/lkml/be2cecb2654e68385561a15df7967c7723d5531d.1590594512.git-series.maxime@cerno.tech/

> +	} else {
> +		return -ENOTSUPP;
> +	}
> +}
> +
>  static const struct reset_control_ops ti_syscon_reset_ops = {
>  	.assert		= ti_syscon_reset_assert,
>  	.deassert	= ti_syscon_reset_deassert,
>  	.status		= ti_syscon_reset_status,
> +	.reset		= ti_syscon_reset,
>  };
>  
>  static int ti_syscon_reset_probe(struct platform_device *pdev)
> @@ -204,6 +219,11 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>  		controls[i].flags = be32_to_cpup(list++);
>  	}
>  
> +	if (of_property_read_bool(np, "assert-deassert-together"))
> +		data->assert_deassert_together = true;
> +	else
> +		data->assert_deassert_together = false;
> +

This could just be assigned directly, but as said above, I think it
might be better to have a reset-duration-us property or similar.

regards
Philipp
