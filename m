Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92F6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B202065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RnuIM8yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgGWEzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:55:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33554 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:55:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06N4tGFF100708;
        Wed, 22 Jul 2020 23:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595480116;
        bh=rpNwQq9lC3T1Dre9HoiV7i/DThnnJKNPj+RZsO8vmyI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RnuIM8ybVrR5TUDTUyRDzJk2GAjx4LvKVEVS0yNjUCtk5WA1Ftn8poFMGS+sgRJp4
         odrlyuauuYf8ix2xjK2CPilSOcA3CvJNOqZssYCA6WxlcI4bNGTDQfrSua5Wetc91j
         9gWZ6ZCo8y4EtgMqy8kz0dRoSMtUxlafw1UmN+Gw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N4tGi2001938;
        Wed, 22 Jul 2020 23:55:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 23:55:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 23:55:15 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N4tCDa101766;
        Wed, 22 Jul 2020 23:55:13 -0500
Subject: Re: [PATCH v4 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>, <nsekhar@ti.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
 <1594968633-12535-3-git-send-email-sjakhade@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <de1f7ebe-ce34-c5a3-a911-acd9e27280fc@ti.com>
Date:   Thu, 23 Jul 2020 10:25:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594968633-12535-3-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 12:20 PM, Swapnil Jakhade wrote:
> Use generic PHY framework function phy_set_attrs() to set number
> of lanes and maximum link rate supported by PHY.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 7116127358ee..af81707ff0c6 100644
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
> +			phy_set_attrs(gphy, torrent_attr);
>  		} else {
>  			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
>  			ret = -ENOTSUPP;
> 
