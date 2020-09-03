Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBEC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EA6207EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgICKKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:10:19 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:45428 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgICKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:05 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 0C342CDE;
        Thu,  3 Sep 2020 18:02:13 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22906T140609283335936S1599127332451858_;
        Thu, 03 Sep 2020 18:02:13 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <acb947cc9ab6943b38928a7b5e18ddf0>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 1/6] clk: rockchip: Use clk_hw_register_composite
 instead of clk_register_composite calls
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
 <20200903063147.10237-2-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <6cf65d7c-adff-5a56-f836-0affd68fbfe2@rock-chips.com>
Date:   Thu, 3 Sep 2020 18:02:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903063147.10237-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

On 2020/9/3 下午2:31, Elaine Zhang wrote:
> clk_hw_register_composite it's already exported.
> Preparation for compilation of rK common clock drivers into modules.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-half-divider.c | 18 ++++----
>   drivers/clk/rockchip/clk.c              | 58 ++++++++++++-------------
>   2 files changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
> index b333fc28c94b..e97fd3dfbae7 100644
> --- a/drivers/clk/rockchip/clk-half-divider.c
> +++ b/drivers/clk/rockchip/clk-half-divider.c
> @@ -166,7 +166,7 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
>   					  unsigned long flags,
>   					  spinlock_t *lock)
>   {
> -	struct clk *clk;
> +	struct clk_hw *hw;
>   	struct clk_mux *mux = NULL;
>   	struct clk_gate *gate = NULL;
>   	struct clk_divider *div = NULL;
> @@ -212,16 +212,18 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
>   		div_ops = &clk_half_divider_ops;
>   	}
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     mux ? &mux->hw : NULL, mux_ops,
> -				     div ? &div->hw : NULL, div_ops,
> -				     gate ? &gate->hw : NULL, gate_ops,
> -				     flags);
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       mux ? &mux->hw : NULL, mux_ops,
> +				       div ? &div->hw : NULL, div_ops,
> +				       gate ? &gate->hw : NULL, gate_ops,
> +				       flags);
> +	if (IS_ERR(hw))
> +		goto err_div;
>   
> -	return clk;
> +	return hw->clk;
>   err_div:
>   	kfree(gate);
>   err_gate:
>   	kfree(mux);
> -	return ERR_PTR(-ENOMEM);
> +	return ERR_CAST(hw);
>   }
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 546e810c3560..b51f320e5733 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -43,7 +43,7 @@ static struct clk *rockchip_clk_register_branch(const char *name,
>   		u8 gate_shift, u8 gate_flags, unsigned long flags,
>   		spinlock_t *lock)
>   {
> -	struct clk *clk;
> +	struct clk_hw *hw;
>   	struct clk_mux *mux = NULL;
>   	struct clk_gate *gate = NULL;
>   	struct clk_divider *div = NULL;
> @@ -100,25 +100,22 @@ static struct clk *rockchip_clk_register_branch(const char *name,
>   						: &clk_divider_ops;
>   	}
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     mux ? &mux->hw : NULL, mux_ops,
> -				     div ? &div->hw : NULL, div_ops,
> -				     gate ? &gate->hw : NULL, gate_ops,
> -				     flags);
> -
> -	if (IS_ERR(clk)) {
> -		ret = PTR_ERR(clk);
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       mux ? &mux->hw : NULL, mux_ops,
> +				       div ? &div->hw : NULL, div_ops,
> +				       gate ? &gate->hw : NULL, gate_ops,
> +				       flags);
> +	if (IS_ERR(hw))
>   		goto err_composite;
> -	}
>   
> -	return clk;
> +	return hw->clk;
>   err_composite:
>   	kfree(div);
>   err_div:
>   	kfree(gate);
>   err_gate:
>   	kfree(mux);
> -	return ERR_PTR(ret);
> +	return ERR_CAST(hw);
>   }
>   
>   struct rockchip_clk_frac {
> @@ -214,8 +211,8 @@ static struct clk *rockchip_clk_register_frac_branch(
>   		unsigned long flags, struct rockchip_clk_branch *child,
>   		spinlock_t *lock)
>   {
> +	struct clk_hw *hw;
>   	struct rockchip_clk_frac *frac;
> -	struct clk *clk;
>   	struct clk_gate *gate = NULL;
>   	struct clk_fractional_divider *div = NULL;
>   	const struct clk_ops *div_ops = NULL, *gate_ops = NULL;
> @@ -255,14 +252,14 @@ static struct clk *rockchip_clk_register_frac_branch(
>   	div->approximation = rockchip_fractional_approximation;
>   	div_ops = &clk_fractional_divider_ops;
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     NULL, NULL,
> -				     &div->hw, div_ops,
> -				     gate ? &gate->hw : NULL, gate_ops,
> -				     flags | CLK_SET_RATE_UNGATE);
> -	if (IS_ERR(clk)) {
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       NULL, NULL,
> +				       &div->hw, div_ops,
> +				       gate ? &gate->hw : NULL, gate_ops,
> +				       flags | CLK_SET_RATE_UNGATE);
> +	if (IS_ERR(hw)) {
>   		kfree(frac);
> -		return clk;
> +		return ERR_CAST(hw);
>   	}
>   
>   	if (child) {
> @@ -292,7 +289,7 @@ static struct clk *rockchip_clk_register_frac_branch(
>   		mux_clk = clk_register(NULL, &frac_mux->hw);
>   		if (IS_ERR(mux_clk)) {
>   			kfree(frac);
> -			return clk;
> +			return mux_clk;
>   		}
>   
>   		rockchip_clk_add_lookup(ctx, mux_clk, child->id);
> @@ -301,7 +298,7 @@ static struct clk *rockchip_clk_register_frac_branch(
>   		if (frac->mux_frac_idx >= 0) {
>   			pr_debug("%s: found fractional parent in mux at pos %d\n",
>   				 __func__, frac->mux_frac_idx);
> -			ret = clk_notifier_register(clk, &frac->clk_nb);
> +			ret = clk_notifier_register(hw->clk, &frac->clk_nb);
>   			if (ret)
>   				pr_err("%s: failed to register clock notifier for %s\n",
>   						__func__, name);
> @@ -311,7 +308,7 @@ static struct clk *rockchip_clk_register_frac_branch(
>   		}
>   	}
>   
> -	return clk;
> +	return hw->clk;
>   }
>   
>   static struct clk *rockchip_clk_register_factor_branch(const char *name,
> @@ -320,7 +317,7 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
>   		int gate_offset, u8 gate_shift, u8 gate_flags,
>   		unsigned long flags, spinlock_t *lock)
>   {
> -	struct clk *clk;
> +	struct clk_hw *hw;
>   	struct clk_gate *gate = NULL;
>   	struct clk_fixed_factor *fix = NULL;
>   
> @@ -349,16 +346,17 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
>   	fix->mult = mult;
>   	fix->div = div;
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     NULL, NULL,
> -				     &fix->hw, &clk_fixed_factor_ops,
> -				     &gate->hw, &clk_gate_ops, flags);
> -	if (IS_ERR(clk)) {
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       NULL, NULL,
> +				       &fix->hw, &clk_fixed_factor_ops,
> +				       &gate->hw, &clk_gate_ops, flags);
> +	if (IS_ERR(hw)) {
>   		kfree(fix);
>   		kfree(gate);
> +		return ERR_CAST(hw);
>   	}
>   
> -	return clk;
> +	return hw->clk;
>   }
>   
>   struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,

This looks good to me, so

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,

- Kever



