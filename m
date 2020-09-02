Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C214C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16263207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgIBPyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgIBPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:54:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6B6101E;
        Wed,  2 Sep 2020 08:54:21 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503B43F66F;
        Wed,  2 Sep 2020 08:54:19 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] clk: rockchip: Use clk_hw_register_composite
 instead of clk_register_composite calls
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     huangtao@rock-chips.com, xf@rock-chips.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org, xxx@rock-chips.com
References: <20200902064847.18881-1-zhangqing@rock-chips.com>
 <20200902064847.18881-2-zhangqing@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <862531c8-9d10-ae3e-e12a-f1ba0ed66d61@arm.com>
Date:   Wed, 2 Sep 2020 16:54:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902064847.18881-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-02 07:48, Elaine Zhang wrote:
> clk_hw_register_composite it's already exported.
> Preparation for compilation of rK common clock drivers into modules.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-half-divider.c | 12 +++++----
>   drivers/clk/rockchip/clk.c              | 35 ++++++++++++++-----------
>   2 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
> index b333fc28c94b..35db0651ea1d 100644
> --- a/drivers/clk/rockchip/clk-half-divider.c
> +++ b/drivers/clk/rockchip/clk-half-divider.c
> @@ -166,6 +166,7 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
>   					  unsigned long flags,
>   					  spinlock_t *lock)
>   {
> +	struct clk_hw *hw;
>   	struct clk *clk;
>   	struct clk_mux *mux = NULL;
>   	struct clk_gate *gate = NULL;
> @@ -212,12 +213,13 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
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
>   
> +	clk = hw->clk;
>   	return clk;

Nit: there's really no point keeping the "clk" variable here, you could 
simply "return hw->clk" if registration succeeds - note that you also 
need the rest of the logic from clk_register_composite() to check that 
"hw" isn't an error value.

>   err_div:
>   	kfree(gate);
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 546e810c3560..2cfebfb61814 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -43,6 +43,7 @@ static struct clk *rockchip_clk_register_branch(const char *name,
>   		u8 gate_shift, u8 gate_flags, unsigned long flags,
>   		spinlock_t *lock)
>   {
> +	struct clk_hw *hw;
>   	struct clk *clk;
>   	struct clk_mux *mux = NULL;
>   	struct clk_gate *gate = NULL;
> @@ -100,12 +101,12 @@ static struct clk *rockchip_clk_register_branch(const char *name,
>   						: &clk_divider_ops;
>   	}
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     mux ? &mux->hw : NULL, mux_ops,
> -				     div ? &div->hw : NULL, div_ops,
> -				     gate ? &gate->hw : NULL, gate_ops,
> -				     flags);
> -
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       mux ? &mux->hw : NULL, mux_ops,
> +				       div ? &div->hw : NULL, div_ops,
> +				       gate ? &gate->hw : NULL, gate_ops,
> +				       flags);
> +	clk = hw->clk;
>   	if (IS_ERR(clk)) {

Similar to above, this is totally broken - you need to rework all the 
error handling in terms of "hw" rather than "clk" - dereferencing an 
ERR_PTR value does not yield another ERR_PTR value, it yields a crash ;)

Robin.

>   		ret = PTR_ERR(clk);
>   		goto err_composite;
> @@ -214,6 +215,7 @@ static struct clk *rockchip_clk_register_frac_branch(
>   		unsigned long flags, struct rockchip_clk_branch *child,
>   		spinlock_t *lock)
>   {
> +	struct clk_hw *hw;
>   	struct rockchip_clk_frac *frac;
>   	struct clk *clk;
>   	struct clk_gate *gate = NULL;
> @@ -255,11 +257,12 @@ static struct clk *rockchip_clk_register_frac_branch(
>   	div->approximation = rockchip_fractional_approximation;
>   	div_ops = &clk_fractional_divider_ops;
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     NULL, NULL,
> -				     &div->hw, div_ops,
> -				     gate ? &gate->hw : NULL, gate_ops,
> -				     flags | CLK_SET_RATE_UNGATE);
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       NULL, NULL,
> +				       &div->hw, div_ops,
> +				       gate ? &gate->hw : NULL, gate_ops,
> +				       flags | CLK_SET_RATE_UNGATE);
> +	clk = hw->clk;
>   	if (IS_ERR(clk)) {
>   		kfree(frac);
>   		return clk;
> @@ -320,6 +323,7 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
>   		int gate_offset, u8 gate_shift, u8 gate_flags,
>   		unsigned long flags, spinlock_t *lock)
>   {
> +	struct clk_hw *hw;
>   	struct clk *clk;
>   	struct clk_gate *gate = NULL;
>   	struct clk_fixed_factor *fix = NULL;
> @@ -349,10 +353,11 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
>   	fix->mult = mult;
>   	fix->div = div;
>   
> -	clk = clk_register_composite(NULL, name, parent_names, num_parents,
> -				     NULL, NULL,
> -				     &fix->hw, &clk_fixed_factor_ops,
> -				     &gate->hw, &clk_gate_ops, flags);
> +	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
> +				       NULL, NULL,
> +				       &fix->hw, &clk_fixed_factor_ops,
> +				       &gate->hw, &clk_gate_ops, flags);
> +	clk = hw->clk;
>   	if (IS_ERR(clk)) {
>   		kfree(fix);
>   		kfree(gate);
> 
