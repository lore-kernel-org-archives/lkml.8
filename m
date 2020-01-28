Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D2C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26063207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgA1P2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:28:49 -0500
Received: from foss.arm.com ([217.140.110.172]:59464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgA1P2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:28:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 286EB31B;
        Tue, 28 Jan 2020 07:28:48 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3383F68E;
        Tue, 28 Jan 2020 07:28:46 -0800 (PST)
Subject: Re: [PATCH 1/3] clk: rockchip: convert rk3399 pll type to use
 readl_poll_timeout
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        mturquette@baylibre.com, zhangqing@rock-chips.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
References: <20200128100204.1318450-1-heiko@sntech.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8001dbb-ebbc-ebe3-d1db-c75d3888fd38@arm.com>
Date:   Tue, 28 Jan 2020 15:28:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128100204.1318450-1-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 10:02 am, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Instead of open coding the polling of the lock status, use the
> handy readl_poll_timeout for this. As the pll locking is normally
> blazingly fast and we don't want to incur additional delays, we're
> not doing any sleeps similar to for example the imx clk-pllv4
> and define a very safe but still short timeout of 1ms.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>   drivers/clk/rockchip/clk-pll.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 198417d56300..43c9fd0086a2 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -585,19 +585,18 @@ static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
>   static int rockchip_rk3399_pll_wait_lock(struct rockchip_clk_pll *pll)
>   {
>   	u32 pllcon;
> -	int delay = 24000000;
> +	int ret;
>   
> -	/* poll check the lock status in rk3399 xPLLCON2 */
> -	while (delay > 0) {
> -		pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(2));
> -		if (pllcon & RK3399_PLLCON2_LOCK_STATUS)
> -			return 0;
> +	/*
> +	 * Lock time typical 250, max 500 input clock cycles @24MHz
> +	 * So define a very safe maximum of 1000us, meaning 24000 cycles.
> +	 */
> +	ret = readl_poll_timeout(pll->reg_base + RK3399_PLLCON(2), pllcon,
> +				 pllcon & RK3399_PLLCON2_LOCK_STATUS, 0, 1000);

Note that the existing I/O accessor was readl_relaxed(), but using plain 
readl_poll_timeout() switches it to regular readl(). It may well not 
matter, but since it's not noted as an intentional change it seemed 
worth pointing out.

Robin.

> +	if (ret)
> +		pr_err("%s: timeout waiting for pll to lock\n", __func__);
>   
> -		delay--;
> -	}
> -
> -	pr_err("%s: timeout waiting for pll to lock\n", __func__);
> -	return -ETIMEDOUT;
> +	return ret;
>   }
>   
>   static void rockchip_rk3399_pll_get_params(struct rockchip_clk_pll *pll,
> 
