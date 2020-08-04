Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9866CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB0822B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHDHDp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:03:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C67C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:03:45 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k2qz4-0003zv-69; Tue, 04 Aug 2020 09:03:38 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k2qz1-0004be-32; Tue, 04 Aug 2020 09:03:35 +0200
Message-ID: <3413ca889fcef11c6dafe1d6b135e1887d84a6e4.camel@pengutronix.de>
Subject: Re: [v2,5/6] reset-controller: ti: Introduce force-update method
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Crystal Guo <crystal.guo@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        seiya.wang@mediatek.com, stanley.chu@mediatek.com,
        yingjoe.chen@mediatek.com, fan.chen@mediatek.com,
        yong.liang@mediatek.com, Suman Anna <s-anna@ti.com>,
        "Andrew F. Davis" <afd@ti.com>
Date:   Tue, 04 Aug 2020 09:03:35 +0200
In-Reply-To: <20200803061511.29555-6-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-6-crystal.guo@mediatek.com>
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

Hi Crystal,

On Mon, 2020-08-03 at 14:15 +0800, Crystal Guo wrote:
> Introduce force-update method for assert and deassert interface,
> which force the write operation in case the read already happens
> to return the correct value.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>

Added Suman and Andrew for confirmation: I think writing unconditionally
can't break any existing user. Just changing to regmap_write_bits()
instead of adding the update-force property as in v1 should be fine.

regards
Philipp

> ---
>  drivers/reset/reset-ti-syscon.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> index 1c74bcb9a6c3..f4baf78afd14 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -57,6 +57,7 @@ struct ti_syscon_reset_data {
>  	struct ti_syscon_reset_control *controls;
>  	unsigned int nr_controls;
>  	bool assert_deassert_together;
> +	bool update_force;
>  };
>  
>  #define to_ti_syscon_reset_data(rcdev)	\
> @@ -90,7 +91,10 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
>  	mask = BIT(control->assert_bit);
>  	value = (control->flags & ASSERT_SET) ? mask : 0x0;
>  
> -	return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
> +	if (data->update_force)
> +		return regmap_write_bits(data->regmap, control->assert_offset, mask, value);
> +	else
> +		return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
>  }
>  
>  /**
> @@ -121,7 +125,10 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
>  	mask = BIT(control->deassert_bit);
>  	value = (control->flags & DEASSERT_SET) ? mask : 0x0;
>  
> -	return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
> +	if (data->update_force)
> +		return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
> +	else
> +		return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
>  }
>  
>  /**
> @@ -223,6 +230,10 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>  		data->assert_deassert_together = true;
>  	else
>  		data->assert_deassert_together = false;
> +	if (of_property_read_bool(np, "update-force"))
> +		data->update_force = true;
> +	else
> +		data->update_force = false;
>  
>  	data->rcdev.ops = &ti_syscon_reset_ops;
>  	data->rcdev.owner = THIS_MODULE;
> -- 
> 2.18.0
