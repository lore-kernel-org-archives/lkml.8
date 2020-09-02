Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2F206E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DXxDiC6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBXko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:40:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58268 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBXko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:40:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082NeUfk061757;
        Wed, 2 Sep 2020 18:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599090030;
        bh=BFbzFeJpfcaC6ycaf4eZClFigSVdESVAB5glK64fSDw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DXxDiC6zHHq3/4GkD5eKFXhhia0zcyCk6W9P2W7ahuO56qpqpRtTnwP4Wv3T0Irsi
         orCV1XB9pxji1b3LegMI8OO9432U5YNH0JeIZnS/7BnOPlSiwIXvRufYKvjg7FQP/A
         0Po+cNMcrA6g3+Jmh34JsJo+Gf9bdynE17JtAhzM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082NeUX1040689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 18:40:30 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 18:40:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 18:40:29 -0500
Received: from [10.250.34.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082NeTBX025309;
        Wed, 2 Sep 2020 18:40:29 -0500
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
To:     Crystal Guo <crystal.guo@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <seiya.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <fan.chen@mediatek.com>,
        <yong.liang@mediatek.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-4-crystal.guo@mediatek.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
Date:   Wed, 2 Sep 2020 18:40:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817030324.5690-4-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Crystal,

On 8/16/20 10:03 PM, Crystal Guo wrote:
> Introduce ti_syscon_reset() to integrate assert and deassert together.
> If some modules need do serialized assert and deassert operations
> to reset itself, reset_control_reset can be called for convenience.

There are multiple changes in this same patch. I think you should split this
functionality away from the change for the regmap_update_bits() to
regmap_write_bits(), similar to what you have done in your v2 Patch 4.

> 
> Such as reset-qcom-aoss.c, it integrates assert and deassert together
> by 'reset' method. MTK Socs also need this method to perform reset.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  drivers/reset/reset-ti-syscon.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> index a2635c21db7f..08289342f9af 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -15,6 +15,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -56,6 +57,7 @@ struct ti_syscon_reset_data {
>  	struct regmap *regmap;
>  	struct ti_syscon_reset_control *controls;
>  	unsigned int nr_controls;
> +	unsigned int reset_duration_us;
>  };
>  
>  #define to_ti_syscon_reset_data(rcdev)	\
> @@ -89,7 +91,7 @@ static int ti_syscon_reset_assert(struct reset_controller_dev *rcdev,
>  	mask = BIT(control->assert_bit);
>  	value = (control->flags & ASSERT_SET) ? mask : 0x0;
>  
> -	return regmap_update_bits(data->regmap, control->assert_offset, mask, value);
> +	return regmap_write_bits(data->regmap, control->assert_offset, mask, value);
>  }
>  
>  /**
> @@ -120,7 +122,7 @@ static int ti_syscon_reset_deassert(struct reset_controller_dev *rcdev,
>  	mask = BIT(control->deassert_bit);
>  	value = (control->flags & DEASSERT_SET) ? mask : 0x0;
>  
> -	return regmap_update_bits(data->regmap, control->deassert_offset, mask, value);
> +	return regmap_write_bits(data->regmap, control->deassert_offset, mask, value);
>  }
>  
>  /**
> @@ -158,9 +160,26 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
>  		!(control->flags & STATUS_SET);
>  }
>  
> +static int ti_syscon_reset(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct ti_syscon_reset_data *data = to_ti_syscon_reset_data(rcdev);
> +	int ret;
> +
> +	ret = ti_syscon_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	if (data->reset_duration_us)
> +		usleep_range(data->reset_duration_us, data->reset_duration_us * 2);
> +
> +	return ti_syscon_reset_deassert(rcdev, id);

I echo Philipp's comments [1] from your original v1 series about this. We don't
need a property to distinguish this, but you could add a flag using match data
and Mediatek compatible, and use that within this function, or optionally set
this ops based on compatible (whatever is preferred by Philipp).

regards
Suman

[1] https://patchwork.kernel.org/comment/23519193/

> +}
> +
>  static const struct reset_control_ops ti_syscon_reset_ops = {
>  	.assert		= ti_syscon_reset_assert,
>  	.deassert	= ti_syscon_reset_deassert,
> +	.reset		= ti_syscon_reset,
>  	.status		= ti_syscon_reset_status,
>  };
>  
> @@ -204,6 +223,9 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>  		controls[i].flags = be32_to_cpup(list++);
>  	}
>  
> +	of_property_read_u32(pdev->dev.of_node,	"reset-duration-us",
> +				&data->reset_duration_us);
> +
>  	data->rcdev.ops = &ti_syscon_reset_ops;
>  	data->rcdev.owner = THIS_MODULE;
>  	data->rcdev.of_node = np;
> 

