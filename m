Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277B4C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DCB206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="chECYSTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBAad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:30:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157AC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 17:30:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 484E9AF2;
        Wed,  2 Sep 2020 02:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599006618;
        bh=Es3Qu1HOlBQViv8yzB/gfp+XbKhgKf7hacOkeSX/P7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chECYSTIkO54mLocqXGYNY1SYjQrZ0zxnUGhoVi4p0Vg3mXTs4/SiYg/3t5icwp3j
         e+Kmee1/VfUfVOQXai2UlU5f2bMel5XRqgcC8R9h2sfYQ3a7btjGH4C0aztkcARGSJ
         yD9baILeueuXuoVc4owF6uH3ThF96LjO6EzuyxZs=
Date:   Wed, 2 Sep 2020 03:29:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, mparab@cadence.com, yamonkar@cadence.com,
        nsekhar@ti.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Message-ID: <20200902002956.GE14351@pendragon.ideasonboard.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

Thank you for the patch.

On Mon, Aug 24, 2020 at 08:28:31PM +0200, Swapnil Jakhade wrote:
> Use generic PHY framework function phy_set_attrs() to set number
> of lanes and maximum link rate supported by PHY.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 7116127358ee..eca71467c4a8 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -1710,6 +1710,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  	struct cdns_torrent_phy *cdns_phy;
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *phy_provider;
> +	struct phy_attrs torrent_attr;
>  	const struct of_device_id *match;
>  	struct cdns_torrent_data *data;
>  	struct device_node *child;
> @@ -1852,6 +1853,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  				 cdns_phy->phys[node].num_lanes,
>  				 cdns_phy->max_bit_rate / 1000,
>  				 cdns_phy->max_bit_rate % 1000);
> +
> +			torrent_attr.bus_width = cdns_phy->phys[node].num_lanes;
> +			torrent_attr.max_link_rate = cdns_phy->max_bit_rate;
> +			torrent_attr.mode = PHY_MODE_DP;
> +
> +			phy_set_attrs(gphy, &torrent_attr);

Why is this better than accessing the attributes manually as follows ?

			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
			gphy->attrs.mode = PHY_MODE_DP;

This is called in cdns_torrent_phy_probe(), before the PHY provider is
registered, so nothing can access the PHY yet. What race condition are
you trying to protect against with usage of phy_set_attrs() ?

>  		} else {
>  			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
>  			ret = -ENOTSUPP;

-- 
Regards,

Laurent Pinchart
