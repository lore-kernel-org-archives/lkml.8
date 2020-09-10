Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46591206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V8DXfUsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgIJVt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgIJL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:57:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B9C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 04:47:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so6339346wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wo/ei2g9rW6q98xzjbksaUTXUEUPUpxBRJLIvG2EJEI=;
        b=V8DXfUsl3/O9RFa6Kt8FZiVgEsU+cPbXPGvErSEXylYLGtf8vNgVKs2aL8TwuOmHIZ
         pKg74l6cVLxuhiM5KPERT+9oWlx6v5C9uNcRIitc7sV74sNHiE4Uc+wHtGGhc4URtkD8
         O9YhTrvTh0/PXwxkJY/9Kb+2Hm4lhBHvJ7ML4mwLdqzZlLCI+4izL4VnhjAcbMg5Hqb/
         gRoQSNIRzVFjPsoREM7VVNOnRV/tX8brxekDCMihsc08TtU+h5kGY1e4ejXm78ious5x
         ktJV+kLs9QeSgM5LZlJCw5Vj3JaHDjvls2EhXrEHsIU1KV/+0PYAVjbS1hw/rMuJLR6S
         DQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wo/ei2g9rW6q98xzjbksaUTXUEUPUpxBRJLIvG2EJEI=;
        b=eyuy75yyQJNvv7i+CBIKd4YuYnzl1dM/KVKmmtfFUpc2vB/qCkn+CPIuJ4hFFar/1O
         dwCUD2Z2/NaR/SUcxhKqpJzUzVx2uZ9r0PKAwXVKcU1n+OsMpY+YwY26EMzBWK93qL5f
         gNn8KH7yMI4EXNl9JURCbWzvR6iI2JC1HPwpLyEY4nH6okK3tAOMG2w4MZc5hgPWlQP/
         u10zgcVxrZWyWHXzJJsesA6dm1mrQbojlrV3FL9Zw+8Ts6JhcQ9PnoJrPNyI1jV1vLN9
         PSRuY2ApQfeQ8oJfpkme2z2KSg48ANxJLbGElNiOq9kd8VuebdNl/Rq3jTi4LSZChAg6
         DVaA==
X-Gm-Message-State: AOAM531snGMVfGwKOGYj/giTO0gp2jzSOIwyIHT6YirklgxvIBh5UiYi
        d1si7B72VLFxek1I6ujo7+aSwrtFxVn8uCIO
X-Google-Smtp-Source: ABdhPJy3pmcd7xjnyUGG33YgJsmJHLs8qAYr9VD6TxHzeLv+0tyHV/D+3PLH2rsKF8BFXrE+lI6JtA==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr8193455wrn.333.1599738450689;
        Thu, 10 Sep 2020 04:47:30 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id e18sm10167243wra.36.2020.09.10.04.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 04:47:29 -0700 (PDT)
Subject: Re: [PATCH 3/4] clk: meson: axg: add Video Clocks
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200907093810.6585-1-narmstrong@baylibre.com>
 <20200907093810.6585-4-narmstrong@baylibre.com>
 <1jy2li9bym.fsf@starbuckisacylon.baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <6132edc1-0256-8eca-d5fd-8870aed5bb60@baylibre.com>
Date:   Thu, 10 Sep 2020 13:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1jy2li9bym.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/09/2020 12:13, Jerome Brunet wrote:
> 
> On Mon 07 Sep 2020 at 11:38, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
>> Add the Video Clocks present on the Amlogic AXg SoCs.
>>
>> The AXG only has a single ENCL CTS clock and even if VCLK exist along VCLK2,
>> only VCLK2 is used since it clocks the MIPI DSI IP directly.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/clk/meson/axg.c | 774 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/clk/meson/axg.h |  21 +-
>>  2 files changed, 794 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
>> index 13fc0006f63d..2550616c14b0 100644
>> --- a/drivers/clk/meson/axg.c
>> +++ b/drivers/clk/meson/axg.c
>> @@ -1026,6 +1026,704 @@ static struct clk_regmap axg_sd_emmc_c_clk0 = {
>>  	},
>>  };
>>  
>> +/* VPU Clock */
>> +
>> +static const struct clk_hw *axg_vpu_parent_hws[] = {
>> +	&axg_fclk_div4.hw,
>> +	&axg_fclk_div3.hw,
>> +	&axg_fclk_div5.hw,
>> +	&axg_fclk_div7.hw,
>> +};
>> +
>> +static struct clk_regmap axg_vpu_0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		/*
>> +		 * bits 9:10 selects from 4 possible parents:
>> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
>> +		 */
> 
> These comments (and the same bellow) are not very useful

Ok, these are copy/paste from gxbb.c and g12a.c, I wonder why these are now useless.

> 
>> +		.parent_hws = axg_vpu_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_vpu_parent_hws),
> 
> Could you add a comment here explaining why parenting needs to be
> manually controlled ?

Ditto, this was already explained for GXBB & G12A.
The VPU clock needs a specific clock parenting defined in DT to
achieve the frequency used by the vendor.

> 
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vpu_0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_0_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vpu_0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_0_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> 
> Why is UNUSED required ?

It's UNUSED until we have a mechanism to keep a clock enabled until the proper
module is loaded, and it was already discussed for GXBB & G12A.

> 
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vpu_1_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_1_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		/*
>> +		 * bits 25:26 selects from 4 possible parents:
>> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
>> +		 */
>> +		.parent_hws = axg_vpu_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_vpu_parent_hws),
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vpu_1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_1_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vpu_1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_1_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vpu = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VPU_CLK_CNTL,
>> +		.mask = 1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu",
>> +		.ops = &clk_regmap_mux_ops,
>> +		/*
>> +		 * bit 31 selects from 2 possible parents:
>> +		 * vpu_0 or vpu_1
>> +		 */
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vpu_0.hw,
>> +			&axg_vpu_1.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> +	},
>> +};
>> +
>> +/* VAPB Clock */
>> +
>> +static const struct clk_hw *axg_vapb_parent_hws[] = {
>> +	&axg_fclk_div4.hw,
>> +	&axg_fclk_div3.hw,
>> +	&axg_fclk_div5.hw,
>> +	&axg_fclk_div7.hw,
>> +};
> 
> This is the same as the vpu table. Could they share a single table ?

Yes, will do

> 
>> +
>> +static struct clk_regmap axg_vapb_0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		/*
>> +		 * bits 9:10 selects from 4 possible parents:
>> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
>> +		 */
>> +		.parent_hws = axg_vapb_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_vapb_parent_hws),
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb_0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vapb_0_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb_0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vapb_0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vapb_0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb_1_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_1_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		/*
>> +		 * bits 25:26 selects from 4 possible parents:
>> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
>> +		 */
>> +		.parent_hws = axg_vapb_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_vapb_parent_hws),
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb_1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vapb_1_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb_1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vapb_1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vapb_1_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.mask = 1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		/*
>> +		 * bit 31 selects from 2 possible parents:
>> +		 * vapb_0 or vapb_1
>> +		 */
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vapb_0.hw,
>> +			&axg_vapb_1.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vapb = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VAPBCLK_CNTL,
>> +		.bit_idx = 30,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vapb",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vapb_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +/* Video Clocks */
>> +
>> +static const struct clk_hw *axg_vclk_parent_hws[] = {
>> +	&axg_gp0_pll.hw,
>> +	&axg_fclk_div4.hw,
>> +	&axg_fclk_div3.hw,
>> +	&axg_fclk_div5.hw,
>> +	&axg_fclk_div2.hw,
>> +	&axg_fclk_div7.hw,
>> +	&axg_mpll1.hw,
>> +};
>> +
>> +static struct clk_regmap axg_vclk_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.mask = 0x7,
>> +		.shift = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = axg_vclk_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_vclk_parent_hws),
>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +	},
> 
> Why is NOCACHE ? Is there something poking behind CCF back ? if yes, why
> is this required ?

I'm surprised you ask this since the situation hasn't changed since I pushed the
video clock for GXBB, then G12A.

The switch to CCF for the VPU is still planned, but until now I was unable to allocate enough
time for this huge rework.

Since I'm the single DRM driver contributor and lacking any other reviewers, I must deal
with new features & bugfixing before moving to CCF.

The clock situation is far from perfect, and I'd also like it to be solved at some point.

I'll add the same explanation I gave for GXBB in https://lkml.kernel.org/r/1541516257-16157-5-git-send-email-narmstrong@baylibre.com

> 
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.mask = 0x7,
>> +		.shift = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = axg_vclk_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_vclk_parent_hws),
>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_input = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_DIV,
>> +		.bit_idx = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_input",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_input = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_DIV,
>> +		.bit_idx = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_input",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VID_CLK_DIV,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk_input.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_GET_RATE_NOCACHE,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = HHI_VIID_CLK_DIV,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk2_input.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_GET_RATE_NOCACHE,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.bit_idx = 19,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.bit_idx = 19,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_div1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_div2_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div2_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_div4_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.bit_idx = 2,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div4_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_div6_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.bit_idx = 3,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div6_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk_div12_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL,
>> +		.bit_idx = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div12_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_div1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_div2_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div2_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_div4_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.bit_idx = 2,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div4_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_div6_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.bit_idx = 3,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div6_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_vclk2_div12_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VIID_CLK_CNTL,
>> +		.bit_idx = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div12_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk_div2 = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div2",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk_div2_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk_div4 = {
>> +	.mult = 1,
>> +	.div = 4,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div4",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk_div4_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk_div6 = {
>> +	.mult = 1,
>> +	.div = 6,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div6",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk_div6_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk_div12 = {
>> +	.mult = 1,
>> +	.div = 12,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div12",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk_div12_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk2_div2 = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div2",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk2_div2_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk2_div4 = {
>> +	.mult = 1,
>> +	.div = 4,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div4",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk2_div4_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk2_div6 = {
>> +	.mult = 1,
>> +	.div = 6,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div6",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk2_div6_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor axg_vclk2_div12 = {
>> +	.mult = 1,
>> +	.div = 12,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div12",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_vclk2_div12_en.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *axg_cts_parent_hws[] = {
>> +	&axg_vclk_div1.hw,
>> +	&axg_vclk_div2.hw,
>> +	&axg_vclk_div4.hw,
>> +	&axg_vclk_div6.hw,
>> +	&axg_vclk_div12.hw,
>> +	&axg_vclk2_div1.hw,
>> +	&axg_vclk2_div2.hw,
>> +	&axg_vclk2_div4.hw,
>> +	&axg_vclk2_div6.hw,
>> +	&axg_vclk2_div12.hw,
>> +};
>> +
>> +static struct clk_regmap axg_cts_encl_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = HHI_VIID_CLK_DIV,
>> +		.mask = 0xf,
>> +		.shift = 12,
>> +		.table = mux_table_cts_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cts_encl_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = axg_cts_parent_hws,
>> +		.num_parents = ARRAY_SIZE(axg_cts_parent_hws),
>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>> +	},
>> +};
>> +
>> +static struct clk_regmap axg_cts_encl = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = HHI_VID_CLK_CNTL2,
>> +		.bit_idx = 3,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "cts_encl",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&axg_cts_encl_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> +	},
>> +};
>> +
>>  static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
>>  				    9, 10, 11, 13, 14, };
>>  static const struct clk_parent_data gen_clk_parent_data[] = {
>> @@ -1246,6 +1944,49 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>>  		[CLKID_HIFI_PLL_DCO]		= &axg_hifi_pll_dco.hw,
>>  		[CLKID_PCIE_PLL_DCO]		= &axg_pcie_pll_dco.hw,
>>  		[CLKID_PCIE_PLL_OD]		= &axg_pcie_pll_od.hw,
>> +		[CLKID_VPU_0_DIV]		= &axg_vpu_0_div.hw,
>> +		[CLKID_VPU_0_SEL]		= &axg_vpu_0_sel.hw,
>> +		[CLKID_VPU_0]			= &axg_vpu_0.hw,
>> +		[CLKID_VPU_1_DIV]		= &axg_vpu_1_div.hw,
>> +		[CLKID_VPU_1_SEL]		= &axg_vpu_1_sel.hw,
>> +		[CLKID_VPU_1]			= &axg_vpu_1.hw,
>> +		[CLKID_VPU]			= &axg_vpu.hw,
>> +		[CLKID_VAPB_0_DIV]		= &axg_vapb_0_div.hw,
>> +		[CLKID_VAPB_0_SEL]		= &axg_vapb_0_sel.hw,
>> +		[CLKID_VAPB_0]			= &axg_vapb_0.hw,
>> +		[CLKID_VAPB_1_DIV]		= &axg_vapb_1_div.hw,
>> +		[CLKID_VAPB_1_SEL]		= &axg_vapb_1_sel.hw,
>> +		[CLKID_VAPB_1]			= &axg_vapb_1.hw,
>> +		[CLKID_VAPB_SEL]		= &axg_vapb_sel.hw,
>> +		[CLKID_VAPB]			= &axg_vapb.hw,
>> +		[CLKID_VCLK]			= &axg_vclk.hw,
>> +		[CLKID_VCLK2]			= &axg_vclk2.hw,
>> +		[CLKID_VCLK_SEL]		= &axg_vclk_sel.hw,
>> +		[CLKID_VCLK2_SEL]		= &axg_vclk2_sel.hw,
>> +		[CLKID_VCLK_INPUT]		= &axg_vclk_input.hw,
>> +		[CLKID_VCLK2_INPUT]		= &axg_vclk2_input.hw,
>> +		[CLKID_VCLK_DIV]		= &axg_vclk_div.hw,
>> +		[CLKID_VCLK2_DIV]		= &axg_vclk2_div.hw,
>> +		[CLKID_VCLK_DIV2_EN]		= &axg_vclk_div2_en.hw,
>> +		[CLKID_VCLK_DIV4_EN]		= &axg_vclk_div4_en.hw,
>> +		[CLKID_VCLK_DIV6_EN]		= &axg_vclk_div6_en.hw,
>> +		[CLKID_VCLK_DIV12_EN]		= &axg_vclk_div12_en.hw,
>> +		[CLKID_VCLK2_DIV2_EN]		= &axg_vclk2_div2_en.hw,
>> +		[CLKID_VCLK2_DIV4_EN]		= &axg_vclk2_div4_en.hw,
>> +		[CLKID_VCLK2_DIV6_EN]		= &axg_vclk2_div6_en.hw,
>> +		[CLKID_VCLK2_DIV12_EN]		= &axg_vclk2_div12_en.hw,
>> +		[CLKID_VCLK_DIV1]		= &axg_vclk_div1.hw,
>> +		[CLKID_VCLK_DIV2]		= &axg_vclk_div2.hw,
>> +		[CLKID_VCLK_DIV4]		= &axg_vclk_div4.hw,
>> +		[CLKID_VCLK_DIV6]		= &axg_vclk_div6.hw,
>> +		[CLKID_VCLK_DIV12]		= &axg_vclk_div12.hw,
>> +		[CLKID_VCLK2_DIV1]		= &axg_vclk2_div1.hw,
>> +		[CLKID_VCLK2_DIV2]		= &axg_vclk2_div2.hw,
>> +		[CLKID_VCLK2_DIV4]		= &axg_vclk2_div4.hw,
>> +		[CLKID_VCLK2_DIV6]		= &axg_vclk2_div6.hw,
>> +		[CLKID_VCLK2_DIV12]		= &axg_vclk2_div12.hw,
>> +		[CLKID_CTS_ENCL_SEL]		= &axg_cts_encl_sel.hw,
>> +		[CLKID_CTS_ENCL]		= &axg_cts_encl.hw,
>>  		[NR_CLKS]			= NULL,
>>  	},
>>  	.num = NR_CLKS,
>> @@ -1341,6 +2082,39 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>>  	&axg_hifi_pll_dco,
>>  	&axg_pcie_pll_dco,
>>  	&axg_pcie_pll_od,
>> +	&axg_vpu_0_div,
>> +	&axg_vpu_0_sel,
>> +	&axg_vpu_0,
>> +	&axg_vpu_1_div,
>> +	&axg_vpu_1_sel,
>> +	&axg_vpu_1,
>> +	&axg_vpu,
>> +	&axg_vapb_0_div,
>> +	&axg_vapb_0_sel,
>> +	&axg_vapb_0,
>> +	&axg_vapb_1_div,
>> +	&axg_vapb_1_sel,
>> +	&axg_vapb_1,
>> +	&axg_vapb_sel,
>> +	&axg_vapb,
>> +	&axg_vclk,
>> +	&axg_vclk2,
>> +	&axg_vclk_sel,
>> +	&axg_vclk2_sel,
>> +	&axg_vclk_input,
>> +	&axg_vclk2_input,
>> +	&axg_vclk_div,
>> +	&axg_vclk2_div,
>> +	&axg_vclk_div2_en,
>> +	&axg_vclk_div4_en,
>> +	&axg_vclk_div6_en,
>> +	&axg_vclk_div12_en,
>> +	&axg_vclk2_div2_en,
>> +	&axg_vclk2_div4_en,
>> +	&axg_vclk2_div6_en,
>> +	&axg_vclk2_div12_en,
>> +	&axg_cts_encl_sel,
>> +	&axg_cts_encl,
>>  };
>>  
>>  static const struct meson_eeclkc_data axg_clkc_data = {
>> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
>> index 0431dabac629..a8787b394a47 100644
>> --- a/drivers/clk/meson/axg.h
>> +++ b/drivers/clk/meson/axg.h
>> @@ -139,8 +139,27 @@
>>  #define CLKID_HIFI_PLL_DCO			88
>>  #define CLKID_PCIE_PLL_DCO			89
>>  #define CLKID_PCIE_PLL_OD			90
>> +#define CLKID_VPU_0_DIV				91
>> +#define CLKID_VPU_1_DIV				94
>> +#define CLKID_VAPB_0_DIV			98
>> +#define CLKID_VAPB_1_DIV			101
>> +#define CLKID_VCLK_SEL				108
>> +#define CLKID_VCLK2_SEL				109
>> +#define CLKID_VCLK_INPUT			110
>> +#define CLKID_VCLK2_INPUT			111
>> +#define CLKID_VCLK_DIV				112
>> +#define CLKID_VCLK2_DIV				113
>> +#define CLKID_VCLK_DIV2_EN			114
>> +#define CLKID_VCLK_DIV4_EN			115
>> +#define CLKID_VCLK_DIV6_EN			116
>> +#define CLKID_VCLK_DIV12_EN			117
>> +#define CLKID_VCLK2_DIV2_EN			118
>> +#define CLKID_VCLK2_DIV4_EN			119
>> +#define CLKID_VCLK2_DIV6_EN			120
>> +#define CLKID_VCLK2_DIV12_EN			121
>> +#define CLKID_CTS_ENCL_SEL			132
>>  
>> -#define NR_CLKS					91
>> +#define NR_CLKS					134
>>  
>>  /* include the CLKIDs that have been made part of the DT binding */
>>  #include <dt-bindings/clock/axg-clkc.h>
> 
> Overall, there is quite an heavy use of CLK_IGNORE_USED and
> CLK_GET_RATE_NOCACHE which seems to indicate that something else is
> poking around in the clocks registers
> 
> Details about why it should be done this way, and not through CCF API,
> should be provided.
>
Thanks,
Neil
