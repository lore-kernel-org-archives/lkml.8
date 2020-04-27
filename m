Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8619BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591D4206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587962492;
	bh=djvCbNDaA+a30AHx0Y08ssMqYTvTxFQMgnTgZsJsMTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ncoJqM6e//M/FyajX3FKIgVq13vVWJ3dJc/k4MDc7Bha5v4ArBer3q/Znhbbri9jn
	 vcRe9dF7HTGeJuqbmNsDLTGmXEj2crrZbnARldCCtCbr2uYHCwHB8tGw/jjGmZIbUY
	 2OOTxHBLZOURpP8bsoPHi1C4QQ64lyRxUZWucw6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgD0Elb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 00:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgD0Elb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 00:41:31 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6CFF206D4;
        Mon, 27 Apr 2020 04:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587962490;
        bh=djvCbNDaA+a30AHx0Y08ssMqYTvTxFQMgnTgZsJsMTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3ETmyic3zjkttIoDz+ZScSZe/jpiI7c04b/t6FqC5zMCnjbTPCk74gfQJNbom+HE
         3o8+jg15iqbfwCiZ0GJebDeXJkDZxMIkNtxTP7FxW/YWTVYh5XXKYHcwrAuGym+lJZ
         +Gbr9G7N7ZzfRezgAuk5KRXARZKAsCosL1P0ZJak=
Date:   Mon, 27 Apr 2020 10:11:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: gcc: Add GPU and NPU clocks for SM8150
Message-ID: <20200427044126.GA4625@vkoul-mobl.Dlink>
References: <20200424044311.2155917-1-vkoul@kernel.org>
 <158784184123.117437.7321952768664025415@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158784184123.117437.7321952768664025415@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-20, 12:10, Stephen Boyd wrote:
> Quoting Vinod Koul (2020-04-23 21:43:10)
> > Add the GPU and NPU clocks for SM8150. They were missed in earlier
> > addition of clock driver.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Fixes tag? That way backporters know they're missing this.

Yes it makes sense to add here, will add.

> > +/* external clocks so add BRANCH_HALT_SKIP */
> > +static struct clk_branch gcc_npu_gpll0_clk_src = {
> > +       .halt_check = BRANCH_HALT_SKIP,
> > +       .clkr = {
> > +               .enable_reg = 0x52004,
> > +               .enable_mask = BIT(18),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_npu_gpll0_clk_src",
> > +                       .parent_hws = (const struct clk_hw *[]){
> > +                               &gpll0.clkr.hw },
> > +                       .num_parents = 1,
> > +                       .flags = CLK_SET_RATE_PARENT,
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};
> > +
> > +/* external clocks so add BRANCH_HALT_SKIP */
> 
> None of these look external. The parents are all inside this driver. Why
> are we skipping the halt check?

yeah not sure why this got added here, tested and these look fine. I
will update these and send update.

Thanks for the review

-- 
~Vinod
