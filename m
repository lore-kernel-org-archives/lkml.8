Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3EB206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgGIBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:40:03 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:58194 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGIBkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:40:03 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 21:40:02 EDT
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id A14ADF1B;
        Thu,  9 Jul 2020 09:32:06 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14852T139810280818432S1594258325506381_;
        Thu, 09 Jul 2020 09:32:06 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c13d51af5d7d2fabafb533b54b30220b>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200708144528.20465-1-jbx6244@gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <2f58b9df-9bcd-5639-65cc-306a6d36b310@rock-chips.com>
Date:   Thu, 9 Jul 2020 09:32:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708144528.20465-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/7/8 下午10:45, Johan Jonker 写道:
> The rk3328 uart2 port is used as boot console and to debug.
> During the boot pclk_uart2 is disabled by a clk_disable_unused
> initcall. Fix the uart2 function by marking pclk_uart2
> as critical on rk3328. Also add sclk_uart2 as that is needed
> for the same DT node.
>
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

Not need to mark the uart2 as critical clocks, the uart clk will enabled 
by uart driver probe(dw8250_probe()).

For your question,  Please check the uart2 dts node "status = okay".

Or You can send me the complete log, I check the status of uart2.

>   static void __init rk3328_clk_init(struct device_node *np)


