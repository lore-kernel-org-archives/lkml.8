Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B6E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WUrOemiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIJLyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgIJLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:48:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC30C06179E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 04:48:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so5329764wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AmAGywHirHn0r2yJef6QNyKdISk4UVa4mh9V3SDcfyg=;
        b=WUrOemiB/VuYnvfdzYGBQ79D1GuLWTsony5Mz32J0slI6rtz+ISEUrWFJc2/ggRA4X
         ip2R94iQNVRtI2Ewso4q0pGaSx8dHqJ0j7isHI82OFwCe4pAX5IO6BCWoaNU1qk7dN7h
         P0U9Xl/ewJhHPMfOcOKW6Xx/GHwdKUYw7tQbPqDTFYS7Qay4S568L7JpKqdb5ltl1okB
         JwWCfzSy7M2HaUeSGPIzya9BdvcZdRPLEivtkcN/0aT28gDzeuhHZ5VbOI+Weth+BtzC
         xMmQR5J8ZZhTpfinkwrHbPFexwt0FdU7Bkb6rO8MSItWpPo3l0NqD0Jg6WtgxQ7JySUO
         +huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AmAGywHirHn0r2yJef6QNyKdISk4UVa4mh9V3SDcfyg=;
        b=RKfYjflilDsHO4BFMdMbjsA/gj0HMaLQFhUutBHYbJ8+Byly2ThI2fFeXlyUaxT02y
         b3ytJ4L+Szrsv2Q98E3+evc5m1c1r5zLkEJJ3kFiKFh+/h7UWEbGJq+xRjAH6wDd2Uzf
         tTgZ4XdqglYIZRI79DHb1NoU0JDSG5X3Js2GZwP9lZF/roE2UwnFYYaZjFVH4rN9A1Xl
         NCfCVvW4WUX5wYt54n/sDo2MhYRypkl9OLTr2fd+l2Q008Jw0p1Jx33a5SqAWENH2XR8
         sU7iKIC8L6+aTnrd4zID+tR0V1vkrm/x/KmaD4IFoiH7sDLuW+3XuRIx45JMmlKo9iOF
         5mmg==
X-Gm-Message-State: AOAM533AG+hGXbuHDyTrxr1v82lmTXoWyGzt2S4Jkowf+6lKhdWByoAt
        rB0BKNIWbiwAuo+kXlx/JGyICsG89DE/dJCd
X-Google-Smtp-Source: ABdhPJzgHNYqP9dbHFtOsfSdiX5YTMsU/8tdpvoYDzQhJtwMElcKCfrGaUYN9CgHfGPSDgGCgF3ngw==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr7988933wme.179.1599738507754;
        Thu, 10 Sep 2020 04:48:27 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id 70sm3466431wme.15.2020.09.10.04.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 04:48:27 -0700 (PDT)
Subject: Re: [PATCH 4/4] clk: meson: axg: add MIPI DSI Host clock
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200907093810.6585-1-narmstrong@baylibre.com>
 <20200907093810.6585-5-narmstrong@baylibre.com>
 <1jwo129btu.fsf@starbuckisacylon.baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <8e7bb5fe-4332-6983-bb64-612cc7ae8256@baylibre.com>
Date:   Thu, 10 Sep 2020 13:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1jwo129btu.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2020 12:15, Jerome Brunet wrote:
> 
> On Mon 07 Sep 2020 at 11:38, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
>> This adds the MIPI DSI Host clock, used to measure the signal timings (ENC VSYNC or
>> DW-MIPI-DSI eDPI timings).
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/clk/meson/axg.c | 66 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/axg.h |  4 ++-
>>  2 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
>> index 2550616c14b0..0094ca6388d8 100644
>> --- a/drivers/clk/meson/axg.c
>> +++ b/drivers/clk/meson/axg.c
>> @@ -1724,6 +1724,66 @@ static struct clk_regmap axg_cts_encl = {
>>  	},
>>  };
>>  
>> +/* MIPI DSI Host Clock */
>> +
>> +static const struct clk_parent_data axg_vdin_meas_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .hw = &axg_fclk_div4.hw },
>> +	{ .hw = &axg_fclk_div3.hw },
>> +	{ .hw = &axg_fclk_div5.hw },
>> +	{ },
>> +	{ },
> 
> As you've done in other patches, I'd prefer if you used an index table
> instead of having empty entries.
> 
>> +	{ .hw = &axg_fclk_div2.hw },
>> +	{ .hw = &axg_fclk_div7.hw },
>> +};

OK, will do

>> +
>> +static struct clk_regmap axg_vdin_meas_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VDIN_MEAS_CLK_CNTL,
>> +		.mask = 0x7,
>> +		.shift = 21,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vdin_meas_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = axg_vdin_meas_parent_data,
>> +		.num_parents = ARRAY_SIZE(axg_vdin_meas_parent_data),
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
> 
> A comment about why manual control is required would be nice.

This is a typo, will remove.

> 
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vdin_meas_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VDIN_MEAS_CLK_CNTL,
>> +		.shift = 12,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vdin_meas_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vdin_meas_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vdin_meas = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VDIN_MEAS_CLK_CNTL,
>> +		.bit_idx = 20,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdin_meas",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vdin_meas_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>>  static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
>>  				    9, 10, 11, 13, 14, };
>>  static const struct clk_parent_data gen_clk_parent_data[] = {
>> @@ -1987,6 +2047,9 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>>  		[CLKID_VCLK2_DIV12]		= &axg_vclk2_div12.hw,
>>  		[CLKID_CTS_ENCL_SEL]		= &axg_cts_encl_sel.hw,
>>  		[CLKID_CTS_ENCL]		= &axg_cts_encl.hw,
>> +		[CLKID_VDIN_MEAS_SEL]		= &axg_vdin_meas_sel.hw,
>> +		[CLKID_VDIN_MEAS_DIV]		= &axg_vdin_meas_div.hw,
>> +		[CLKID_VDIN_MEAS]		= &axg_vdin_meas.hw,
>>  		[NR_CLKS]			= NULL,
>>  	},
>>  	.num = NR_CLKS,
>> @@ -2115,6 +2178,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>>  	&axg_vclk2_div12_en,
>>  	&axg_cts_encl_sel,
>>  	&axg_cts_encl,
>> +	&axg_vdin_meas_sel,
>> +	&axg_vdin_meas_div,
>> +	&axg_vdin_meas,
>>  };
>>  
>>  static const struct meson_eeclkc_data axg_clkc_data = {
>> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
>> index a8787b394a47..481b307ea3cb 100644
>> --- a/drivers/clk/meson/axg.h
>> +++ b/drivers/clk/meson/axg.h
>> @@ -158,8 +158,10 @@
>>  #define CLKID_VCLK2_DIV6_EN			120
>>  #define CLKID_VCLK2_DIV12_EN			121
>>  #define CLKID_CTS_ENCL_SEL			132
>> +#define CLKID_VDIN_MEAS_SEL			134
>> +#define CLKID_VDIN_MEAS_DIV			135
>>  
>> -#define NR_CLKS					134
>> +#define NR_CLKS					137
>>  
>>  /* include the CLKIDs that have been made part of the DT binding */
>>  #include <dt-bindings/clock/axg-clkc.h>
> 

