Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B51C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD817206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgGHPef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:34:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbgGHPee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:34:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB04B1FB;
        Wed,  8 Jul 2020 08:34:33 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75EEA3F237;
        Wed,  8 Jul 2020 08:34:32 -0700 (PDT)
Subject: Re: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200708144528.20465-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <074d8691-2d88-4520-1e43-8c7eb5b82680@arm.com>
Date:   Wed, 8 Jul 2020 16:34:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708144528.20465-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 15:45, Johan Jonker wrote:
> The rk3328 uart2 port is used as boot console and to debug.
> During the boot pclk_uart2 is disabled by a clk_disable_unused
> initcall. Fix the uart2 function by marking pclk_uart2
> as critical on rk3328. Also add sclk_uart2 as that is needed
> for the same DT node.

Hmm, given that those are named in the DT as the "baudclk" and
"apb_pclk" that dw8250_probe() explicitly claims, they really
shouldn't be unused :/

On my RK3328 box they appear to be prepared and enabled OK:

[robin@nemulon-9 ~]$ sudo grep uart2 /sys/kernel/debug/clk/clk_summary
    sclk_uart2                        1        1        0    24000000          0     0  50000
                   pclk_uart2         1        1        0    75000000          0     0  50000
...

Robin.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   drivers/clk/rockchip/clk-rk3328.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
> index c186a1985..cb7749cb7 100644
> --- a/drivers/clk/rockchip/clk-rk3328.c
> +++ b/drivers/clk/rockchip/clk-rk3328.c
> @@ -875,6 +875,8 @@ static const char *const rk3328_critical_clocks[] __initconst = {
>   	"aclk_gmac_niu",
>   	"pclk_gmac_niu",
>   	"pclk_phy_niu",
> +	"pclk_uart2",
> +	"sclk_uart2",
>   };
>   
>   static void __init rk3328_clk_init(struct device_node *np)
> 
