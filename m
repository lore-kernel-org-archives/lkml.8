Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED6F206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGHUYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:24:15 -0400
Received: from foss.arm.com ([217.140.110.172]:35762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGHUYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C6E21FB;
        Wed,  8 Jul 2020 13:24:14 -0700 (PDT)
Received: from bogus (unknown [10.37.8.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32C033F66E;
        Wed,  8 Jul 2020 13:24:12 -0700 (PDT)
Date:   Wed, 8 Jul 2020 21:24:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Message-ID: <20200708202349.GA31671@bogus>
References: <20200708110725.18017-1-sudeep.holla@arm.com>
 <20200708110725.18017-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708110725.18017-2-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:07:25PM +0100, Sudeep Holla wrote:
> Currently we are not initializing the scmi clock with discrete rates
> correctly. We fetch the min_rate and max_rate value only for clocks with
> ranges and ignore the ones with discrete rates. This will lead to wrong
> initialization of rate range when clock supports discrete rate.
> 
> Fix this by using the first and the last rate in the sorted list of the
> discrete clock rates while registering the clock.
> 
> Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
> Reported-by: Dien Pham <dien.pham.ry@renesas.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> Hi Stephen,
> 
> If you fine, I can take this via ARM SoC along with the change in firmware
> driver. But it is fine if you want to merge this independently as it should
> be fine. Let me know either way.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index c491f5de0f3f..ea65b7bf1408 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -103,6 +103,8 @@ static const struct clk_ops scmi_clk_ops = {
>  static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
>  {
>  	int ret;
> +	unsigned long min_rate, max_rate;
> +
>  	struct clk_init_data init = {
>  		.flags = CLK_GET_RATE_NOCACHE,
>  		.num_parents = 0,
> @@ -112,9 +114,23 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
> 
>  	sclk->hw.init = &init;
>  	ret = devm_clk_hw_register(dev, &sclk->hw);
> -	if (!ret)
> -		clk_hw_set_rate_range(&sclk->hw, sclk->info->range.min_rate,
> -				      sclk->info->range.max_rate);
> +	if (ret)
> +		return ret;
> +
> +	if (sclk->info->rate_discrete) {
> +		int num_rates = sclk->info->list.num_rates;
> +
> +		if (num_rates <= 0)
> +			return -EINVAL;
> +
> +		min_rate = sclk->info->list.rates[0]

I seem to have sent a version with ; missing above though I fixed but
sent the old stale version as I had written a note to you 🙁 

-- 
Regards,
Sudeep
