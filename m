Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA2FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76D42467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgA1Snj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:43:39 -0500
Received: from foss.arm.com ([217.140.110.172]:33604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgA1Sni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:43:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3784328;
        Tue, 28 Jan 2020 10:43:37 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25713F52E;
        Tue, 28 Jan 2020 10:43:36 -0800 (PST)
Subject: Re: [PATCH 1/3] clk: rockchip: convert rk3399 pll type to use
 readl_poll_timeout
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, zhangqing@rock-chips.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
References: <20200128100204.1318450-1-heiko@sntech.de>
 <f8001dbb-ebbc-ebe3-d1db-c75d3888fd38@arm.com> <12366580.SORy7UBWfn@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6349f721-60ae-b494-85c5-c1be8a669799@arm.com>
Date:   Tue, 28 Jan 2020 18:43:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <12366580.SORy7UBWfn@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 4:29 pm, Heiko Stuebner wrote:
> Am Dienstag, 28. Januar 2020, 16:28:44 CET schrieb Robin Murphy:
>> On 28/01/2020 10:02 am, Heiko Stuebner wrote:
>>> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>>>
>>> Instead of open coding the polling of the lock status, use the
>>> handy readl_poll_timeout for this. As the pll locking is normally
>>> blazingly fast and we don't want to incur additional delays, we're
>>> not doing any sleeps similar to for example the imx clk-pllv4
>>> and define a very safe but still short timeout of 1ms.
>>>
>>> Suggested-by: Stephen Boyd <sboyd@kernel.org>
>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>>> ---
>>>    drivers/clk/rockchip/clk-pll.c | 21 ++++++++++-----------
>>>    1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
>>> index 198417d56300..43c9fd0086a2 100644
>>> --- a/drivers/clk/rockchip/clk-pll.c
>>> +++ b/drivers/clk/rockchip/clk-pll.c
>>> @@ -585,19 +585,18 @@ static const struct clk_ops rockchip_rk3066_pll_clk_ops = {
>>>    static int rockchip_rk3399_pll_wait_lock(struct rockchip_clk_pll *pll)
>>>    {
>>>    	u32 pllcon;
>>> -	int delay = 24000000;
>>> +	int ret;
>>>    
>>> -	/* poll check the lock status in rk3399 xPLLCON2 */
>>> -	while (delay > 0) {
>>> -		pllcon = readl_relaxed(pll->reg_base + RK3399_PLLCON(2));
>>> -		if (pllcon & RK3399_PLLCON2_LOCK_STATUS)
>>> -			return 0;
>>> +	/*
>>> +	 * Lock time typical 250, max 500 input clock cycles @24MHz
>>> +	 * So define a very safe maximum of 1000us, meaning 24000 cycles.
>>> +	 */
>>> +	ret = readl_poll_timeout(pll->reg_base + RK3399_PLLCON(2), pllcon,
>>> +				 pllcon & RK3399_PLLCON2_LOCK_STATUS, 0, 1000);
>>
>> Note that the existing I/O accessor was readl_relaxed(), but using plain
>> readl_poll_timeout() switches it to regular readl(). It may well not
>> matter, but since it's not noted as an intentional change it seemed
>> worth pointing out.
> 
> So we end up with an additional __iormb() after each readl_relaxed call.
> So except for a small speed-penalty per iteration is there some other
> memory-barrier wirednes that could come into play? (Somehow I always
> forget the contents of Will's memory-barrier talks after a time)

For the current arm64 implementation, probably not. For 32-bit it's 
still a DSB, which might in theory generate a bunch of coherency traffic 
synchronising with all the other CPUs each time, although unless you're 
counting every last microWatt even that's unlikely to be anything to 
worry about in practice. You *could* keep consistency with 
readl_relaxed_poll_timeout() instead, but you could equally argue the 
"use regular accessors for simplicity unless there's a provable benefit 
to using relaxed ones" angle. Up to you :)

Robin.

>  From a bit of non-scientific testing, rk3328 seems to need at max 20
> iterations in the wait_lock loop for the pll to lock, when doing cpufreq
> scaling.
> 
> While interestingly px30 takes somewhere between 900 and 2000 iterations
> on the same pll type.
> [Though sleeps are not really possible anyway due to pll rates also getting
> set during of_clk_register early during boot which results in errors about
> scheduling the idle thread, so in the end it doesn't really matter]
> 
> Heiko
> 
> 
