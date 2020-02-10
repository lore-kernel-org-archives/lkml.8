Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE3C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E7722525
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBJGKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:10:54 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:49295 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgBJGKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:10:54 -0500
Received: from [10.7.0.4] (10.28.11.250) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server id 15.1.1591.10; Mon, 10 Feb 2020 14:11:25 +0800
From:   Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v7 2/5] clk: meson: add support for A1 PLL clock ops
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200120034937.128600-1-jian.hu@amlogic.com>
 <20200120034937.128600-3-jian.hu@amlogic.com>
 <1jftfq7ir8.fsf@starbuckisacylon.baylibre.com>
Message-ID: <ce7d406e-b5bd-44c8-84fb-5edd3b3ffbce@amlogic.com>
Date:   Mon, 10 Feb 2020 14:11:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1jftfq7ir8.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.11.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

Thanks for your suggestions.

On 2020/2/4 18:24, Jerome Brunet wrote:
> 
> On Mon 20 Jan 2020 at 04:49, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Compared with the previous SoCs, self-adaption current module
>> is newly added for A1, and there is no reset parm except the
>> fixed pll. In A1 PLL, the PLL enable sequence is different, using
>> the new power-on sequence to enable the PLL.
> 
> Things are getting clearer thanks to Martin's suggestions and I can
> understand what your driver is doing now
> 
> However, I still have a problem with the fact that 2 different pll types
> are getting intertwined in this driver. Parameters mandatory to one is
> made optional to the other. Nothing clearly shows which needs what and
> the combinatorial are quickly growing.
> 
> Apparently the only real difference is in enable/disable, So I would
> prefer if the a1 had dedicated function for these ops.
> 
> I suppose you'll have to submit clk_hw_enable() and clk_hw_disable()
> to the framework to call the appropriate ops dependind on the SoC.
> 
I am confused here.
What does clk_hw_is_enabled/clk_hw_enable/clk_hw_disable use here?

clk_hw_is_enabled is intend to check a parm's existence? But 
clk_hw_is_enabled which is existed in CCF to check a PLL is locked or
not. Maybe I understand wrong about your suggestions.

Could you list a example for clk_hw_enable and clk_hw_disable function 
implementation?
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 47 +++++++++++++++++++++++++++++++------
>>   drivers/clk/meson/clk-pll.h |  2 ++
>>   2 files changed, 42 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index ddb1e5634739..10926291440f 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -283,10 +283,14 @@ static void meson_clk_pll_init(struct clk_hw *hw)
>>   	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>>   
>>   	if (pll->init_count) {
>> -		meson_parm_write(clk->map, &pll->rst, 1);
>> +		if (MESON_PARM_APPLICABLE(&pll->rst))
>> +			meson_parm_write(clk->map, &pll->rst, 1);
>> +
> 
> replace by
>          enabled = clk_hw_is_enabled(hw)
>          if (enabled)
>             clk_hw_disable(hw)
> 
clk_hw_is_enabled here is used to check 'pll->rst'?
>>   		regmap_multi_reg_write(clk->map, pll->init_regs,
>>   				       pll->init_count);
>> -		meson_parm_write(clk->map, &pll->rst, 0);
>> +
>> +		if (MESON_PARM_APPLICABLE(&pll->rst))
>> +			meson_parm_write(clk->map, &pll->rst, 0);
> 
>         /* restore if necessary */
>         if (enabled)
>            clk_hw_enable(hw)
> 
>>   	}
>>   }
>>   
>> @@ -295,8 +299,11 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
>>   	struct clk_regmap *clk = to_clk_regmap(hw);
>>   	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>>   
>> -	if (meson_parm_read(clk->map, &pll->rst) ||
>> -	    !meson_parm_read(clk->map, &pll->en) ||
>> +	if (MESON_PARM_APPLICABLE(&pll->rst) &&
>> +	    meson_parm_read(clk->map, &pll->rst))
>> +		return 0;
>> +
>> +	if (!meson_parm_read(clk->map, &pll->en) ||
>>   	    !meson_parm_read(clk->map, &pll->l))
>>   		return 0;
> 
> I suppose the pll can't be locked if it was in reset, so we could drop
> the check on `rst` entirely to simplify the function
> 
OK, I will drop 'rst' check.
>>   
>> @@ -323,13 +330,34 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>   		return 0;
>>   
>>   	/* Make sure the pll is in reset */
>> -	meson_parm_write(clk->map, &pll->rst, 1);
>> +	if (MESON_PARM_APPLICABLE(&pll->rst))
>> +		meson_parm_write(clk->map, &pll->rst, 1);
>>   
>>   	/* Enable the pll */
>>   	meson_parm_write(clk->map, &pll->en, 1);
>>   
>>   	/* Take the pll out reset */
>> -	meson_parm_write(clk->map, &pll->rst, 0);
>> +	if (MESON_PARM_APPLICABLE(&pll->rst))
>> +		meson_parm_write(clk->map, &pll->rst, 0);
>> +
>> +	/*
>> +	 * Compared with the previous SoCs, self-adaption current module
>> +	 * is newly added for A1, keep the new power-on sequence to enable the
>> +	 * PLL. The sequence is:
>> +	 * 1. enable the pll, delay for 10us
>> +	 * 2. enable the pll self-adaption current module, delay for 40us
>> +	 * 3. enable the lock detect module
>> +	 */
>> +	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>> +		udelay(10);
>> +		meson_parm_write(clk->map, &pll->current_en, 1);
>> +		udelay(40);
>> +	};
>> +
>> +	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>> +		meson_parm_write(clk->map, &pll->l_detect, 1);
>> +		meson_parm_write(clk->map, &pll->l_detect, 0);
>> +	}
>>   
>>   	if (meson_clk_pll_wait_lock(hw))
>>   		return -EIO;
>> @@ -343,10 +371,15 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
>>   	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>>   
>>   	/* Put the pll is in reset */
>> -	meson_parm_write(clk->map, &pll->rst, 1);
>> +	if (MESON_PARM_APPLICABLE(&pll->rst))
>> +		meson_parm_write(clk->map, &pll->rst, 1);
>>   
>>   	/* Disable the pll */
>>   	meson_parm_write(clk->map, &pll->en, 0);
>> +
>> +	/* Disable PLL internal self-adaption current module */
>> +	if (MESON_PARM_APPLICABLE(&pll->current_en))
>> +		meson_parm_write(clk->map, &pll->current_en, 0);
>>   }
> 
> With the above clarified, it should be easy to properly split the
> functions between the legacy type and the a1 type.
> 
> You'll need to update meson_clk_pll_set_rate() to call
>   - clk_hw_is_enabled()
>   - clk_hw_enable() and clk_hw_disable() (again, you'll need to add
>   those in the framework first)
> 
>>   
>>   static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>> index 367efd0f6410..a2228c0fdce5 100644
>> --- a/drivers/clk/meson/clk-pll.h
>> +++ b/drivers/clk/meson/clk-pll.h
>> @@ -36,6 +36,8 @@ struct meson_clk_pll_data {
>>   	struct parm frac;
>>   	struct parm l;
>>   	struct parm rst;
>> +	struct parm current_en;
>> +	struct parm l_detect;
>>   	const struct reg_sequence *init_regs;
>>   	unsigned int init_count;
>>   	const struct pll_params_table *table;
> 
> .
> 
