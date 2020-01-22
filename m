Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0962EC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D546F24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uBtieWXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAVJPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:15:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42224 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:15:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00M9FMLM122955;
        Wed, 22 Jan 2020 03:15:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579684522;
        bh=p6TXy9D8Jj5ZMAsUl92rse85KpLnXYI0D7il7xeObjo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uBtieWXwbpXSnRK/R3juokz75ZF07c3mFcuNzH5xfgGKpgBJPYDmetcojC/2gI9gN
         0VOEXTfL2++aG1uTJbYPyywW3QlkZZVZYsgZZaJUD4mknt6vWvHEYL0OY/TgmX2SW2
         Ngi7YqDlsI0/rO0y0n5xfRIm29JqCAdjoS1cC6wk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M9FM9x030906;
        Wed, 22 Jan 2020 03:15:22 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 03:15:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 03:15:22 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M9FJa9046831;
        Wed, 22 Jan 2020 03:15:19 -0600
Subject: Re: [PATCH 2/2] drm/bridge: Add tc358768 driver
To:     Andrzej Hajda <a.hajda@samsung.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <narmstrong@baylibre.com>
CC:     <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>
References: <20191217101506.18910-1-peter.ujfalusi@ti.com>
 <CGME20191217101520epcas1p4a2bdee0cab0c11670b74fbe9e9397835@epcas1p4.samsung.com>
 <20191217101506.18910-3-peter.ujfalusi@ti.com>
 <35d664fe-8091-2744-abf2-69828ebf1148@samsung.com>
 <14306079-500d-09ca-df94-4cf72c43f858@ti.com>
 <cdc941c5-681f-962b-7f99-ebfda6aaaa91@samsung.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e8774c16-c34c-adf8-fee5-17323dcd95bf@ti.com>
Date:   Wed, 22 Jan 2020 11:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cdc941c5-681f-962b-7f99-ebfda6aaaa91@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On 22/01/2020 10.46, Andrzej Hajda wrote:
>>>> +struct tc358768_priv {
>>>> +	struct device *dev;
>>>> +	struct regmap *regmap;
>>>> +	struct gpio_desc *reset_gpio;
>>>> +	struct regulator_bulk_data supplies[ARRAY_SIZE(tc358768_supplies)];
>>>> +	struct clk *refclk;
>>>> +
>>>> +	struct mipi_dsi_host dsi_host;
>>>> +	struct drm_bridge bridge;
>>>> +	struct tc358768_dsi_output output;
>>>
>>> Since tc358768_dsi_output is used only here, you can define it here as
>>> well, up to you.
>> I think I have done it like this to avoid thinking about prefixes for
>> what is under the tc358768_dsi_output.
>> I'll take a look if it will look better unpacked here.
> 
> I though rather about in-place anonymous struct definition:
> 
> +    struct tc358768_dsi_output {
> +        struct mipi_dsi_device *dev;
> +        struct drm_panel *panel;
> +        struct drm_bridge *bridge;
> +    } output;
> 
> But, as I said - up to you.

I see. I think I will keep how it was. They are in proximity, so easy to
check.

>>>> +
>>>> +	refclk = clk_get_rate(priv->refclk);
>>>> +
>>>> +	best_diff = UINT_MAX;
>>>> +	best_pll = 0;
>>>> +	best_prd = 0;
>>>> +	best_fbd = 0;
>>>> +
>>>> +	for (prd = 0; prd < 16; ++prd) {
>>>> +		u32 divisor = (prd + 1) * (1 << frs);
>>>> +		u32 fbd;
>>>> +
>>>> +		for (fbd = 0; fbd < 512; ++fbd) {
>>>> +			u32 pll, diff;
>>>> +
>>>> +			pll = (u32)div_u64((u64)refclk * (fbd + 1), divisor);
>>>> +
>>>> +			if (pll >= max_pll || pll < min_pll)
>>>> +				continue;
>>>> +
>>>> +			diff = max(pll, target_pll) - min(pll, target_pll);
>>>> +
>>>> +			if (diff < best_diff) {
>>>> +				best_diff = diff;
>>>> +				best_pll = pll;
>>>> +				best_prd = prd;
>>>> +				best_fbd = fbd;
>>>> +			}
>>>> +
>>>> +			if (best_diff == 0)
>>>> +				break;
>>>> +		}
>>>> +
>>>> +		if (best_diff == 0)
>>>> +			break;
>>> why another check here?
>> To break out from the top for() loop also in case exact match has been
>> found.
> 
> 
> Ahh, OK. So maybe you should put "if (diff == 0) goto found" inside "if
> (diff < best_diff)" block, in such case goto is not considered harmful
> :), and is more readable.

Exactly my thoughts ;)

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
